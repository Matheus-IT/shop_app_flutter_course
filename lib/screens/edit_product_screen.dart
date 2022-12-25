import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter_course/providers/product.dart';
import 'package:shop_app_flutter_course/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  bool _isInit = true;
  String? productId;
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _init();
    }
    _isInit = false;
  }

  void _init() {
    productId = ModalRoute.of(context)?.settings.arguments as String?;
    if (productId == null) {
      return;
    }
    final productsProvider = Provider.of<ProductProvider>(context, listen: false);
    final loadedProduct = productsProvider.findById(productId!);

    _titleController.text = loadedProduct.title;
    _priceController.text = loadedProduct.price.toString();
    _descriptionController.text = loadedProduct.description;
    _imageUrlController.text = loadedProduct.imageUrl;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
  }

  String? baseValidator(String? input) {
    if (input == null || input.isEmpty) {
      return 'Please enter a value';
    }
    return null;
  }

  String? titleValidator(String? input) {
    final result = baseValidator(input);

    if (result != null) {
      return result;
    }
    return null;
  }

  String? priceValidator(String? input) {
    final result = baseValidator(input);

    if (result != null) {
      return result;
    }

    final number = double.tryParse(input!);

    if (number == null) {
      return 'Please enter a valid number';
    }
    if (number <= 0) {
      return 'Please enter a number greater than or equal to zero';
    }
    return null;
  }

  String? descriptionValidator(String? input) {
    final result = baseValidator(input);

    if (result != null) {
      return result;
    }
    return null;
  }

  String? imageUrlValidator(String? input) {
    final result = baseValidator(input);

    if (result != null) {
      return result;
    }

    if (!input!.startsWith('http') && !input.startsWith('https')) {
      return 'Please enter a valid image URL';
    }
    return null;
  }

  void _handleSubmitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    final productsProvider = Provider.of<ProductProvider>(context, listen: false);

    setState(() => isLoading = true);

    if (productId == null) {
      // Handle creation
      final newProduct = Product(
        id: DateTime.now().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        imageUrl: _imageUrlController.text,
      );

      try {
        await productsProvider.addProduct(newProduct);
        debugPrint('Product added!');
      } catch (error) {
        _showWarningDialogErrorAddingProduct();
      }
    } else {
      await productsProvider.updateProductIfExists(productId!, {
        'title': _titleController.text,
        'price': _priceController.text,
        'description': _descriptionController.text,
        'imageUrl': _imageUrlController.text,
      });
      debugPrint('Product updated!');
    }

    setState(() => isLoading = false);
    Navigator.of(context).pop();
  }

  void _showWarningDialogErrorAddingProduct() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Something went wrong'),
        content: const Text('An error occurred when trying to add a product'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                setState(() => isLoading = false);
              },
              child: const Text('OK'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit product')),
      body: SafeArea(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Title'),
                          textInputAction: TextInputAction.next,
                          controller: _titleController,
                          validator: titleValidator,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Price'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          controller: _priceController,
                          validator: priceValidator,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Description'),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          controller: _descriptionController,
                          validator: descriptionValidator,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(top: 8, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Container(
                                child: _imageUrlController.text.isEmpty
                                    ? const Text('Enter image URL')
                                    : FittedBox(
                                        child: Image.network(
                                          _imageUrlController.text,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(labelText: 'Image URL'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: _imageUrlController,
                                onEditingComplete: () {
                                  if (imageUrlValidator(_imageUrlController.text) != null) {
                                    return;
                                  }
                                  setState(() {});
                                },
                                onFieldSubmitted: (_) => _handleSubmitForm(),
                                validator: imageUrlValidator,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            iconSize: 40,
                            icon: const Icon(Icons.save),
                            color: Theme.of(context).primaryColor,
                            onPressed: () => _handleSubmitForm(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
    );
  }
}

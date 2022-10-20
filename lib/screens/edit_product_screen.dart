import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
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

  void _handleSubmitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit product')),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                validator: titleValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: priceValidator,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
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
                        if (imageUrlValidator(_imageUrlController.text) !=
                            null) {
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

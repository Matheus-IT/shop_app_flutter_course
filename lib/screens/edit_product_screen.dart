import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _imageUrlController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit product')),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
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
                      onEditingComplete: () => setState(() {}),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

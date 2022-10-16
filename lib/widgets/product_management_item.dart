import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductManagementItem extends StatelessWidget {
  final String title;
  final String imageURL;

  const ProductManagementItem({
    required this.title,
    required this.imageURL,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        leading: CircleAvatar(backgroundImage: NetworkImage(imageURL)),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              )
            ],
          ),
        ));
  }
}

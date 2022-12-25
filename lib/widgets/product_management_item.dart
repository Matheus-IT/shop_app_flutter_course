import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter_course/app_routes.dart';
import 'package:shop_app_flutter_course/providers/products.dart';

class ProductManagementItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;

  const ProductManagementItem({
    required this.id,
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
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.editProduct,
                    arguments: id,
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<ProductProvider>(context, listen: false).deleteProductIfExists(id);
                },
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              )
            ],
          ),
        ));
  }
}

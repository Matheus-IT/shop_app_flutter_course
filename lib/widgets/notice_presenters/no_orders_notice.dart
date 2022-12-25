import 'package:flutter/material.dart';

class NoOrdersNotice extends StatelessWidget {
  const NoOrdersNotice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No orders'),
    );
  }
}

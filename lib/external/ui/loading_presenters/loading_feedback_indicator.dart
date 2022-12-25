import 'package:flutter/material.dart';

class LoadingFeedbackIndicator extends StatelessWidget {
  const LoadingFeedbackIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

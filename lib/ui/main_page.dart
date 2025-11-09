import 'package:flutter/material.dart';
import 'package:image_app/ui/Activation/activation_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _pageContent(
      context,
    );
  }

  Widget _pageContent(BuildContext context) {
    return const ActivationMainPage();
  }
}

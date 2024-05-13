import 'package:flutter/material.dart';

// use custom TabBar below for borderless TabBar
class MyTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MyTabBar({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Theme(
        data: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            surfaceVariant: Colors.transparent,
          ),
        ),
        child: child);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

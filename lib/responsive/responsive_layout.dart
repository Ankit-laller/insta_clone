import 'package:flutter/material.dart';
import 'package:insta_clone/utils/dimension.dart';
import 'package:provider/provider.dart';

import '../state_management/user_provider.dart';


class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({super.key , required this.webScreenLayout,
  required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }
  addData() async {
    UserProvier userProvider =
    Provider.of<UserProvier>(context, listen: false);
    await userProvider.refreshUser();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder:(context, constraints) {
          if(constraints.maxWidth >webScreenSize){
            return widget.webScreenLayout;
          }
          return widget.mobileScreenLayout;
        }
    );
  }
}


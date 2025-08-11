import 'package:dome_ui2/view/login_page.dart';
import 'package:dome_ui2/view/sign_up_page.dart';
import 'package:flutter/material.dart';

import '../color/color.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.currentTab});

  final int currentTab;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.currentTab,
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Container(height: statusBarHeight, color: Colors.white),
              // chừa vùng status bar để click không lỗi
              TabBar(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                labelColor: AppColor.color_enable,
                indicatorColor: AppColor.color_enable,
                indicator: const UnderlineTabIndicator(
                  insets: EdgeInsets.symmetric(horizontal: -52),
                  borderSide: BorderSide(
                    color: AppColor.color_enable,
                    width: 3,
                  ),
                ),
                unselectedLabelColor: AppColor.color_disenable,
                dividerHeight: 0,
                tabs: const [
                  Tab(child: Text("Log in", style: TextStyle(fontSize: 16))),
                  Tab(child: Text("Sign up", style: TextStyle(fontSize: 16))),
                ],
              ),
              Expanded(
                child: TabBarView(children: [LoginPage(), SignUpPage()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

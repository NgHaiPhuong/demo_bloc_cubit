import 'package:dome_ui2/core/utils/color.dart';
import 'package:dome_ui2/screen/sign_up_page.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({super.key});

  @override
  State<MyHomePage2> createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage2> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _setupPage(index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _setupPage(0);
                      _pageController.animateToPage(
                        0,
                        duration: Duration(microseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _currentPage == 0
                            ? AppColor.color_enable
                            : AppColor.color_disenable,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _setupPage(1);
                      _pageController.animateToPage(
                        1,
                        duration: Duration(microseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _currentPage == 1
                            ? AppColor.color_enable
                            : AppColor.color_disenable,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 - 32,
                    height: 2,
                    color: _currentPage == 0
                        ? AppColor.color_enable
                        : AppColor.color_disenable,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 2,
                    color: _currentPage == 1
                        ? AppColor.color_enable
                        : AppColor.color_disenable,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _setupPage(index);
        },
        children: [LoginPage(), SignUpPage()],
      ),
    );
  }
}

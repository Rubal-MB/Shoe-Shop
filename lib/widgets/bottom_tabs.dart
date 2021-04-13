import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  const BottomTabs({this.selectedTab, this.tabPressed});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1.0,
              blurRadius: 30.0,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(
            imagePath: 'assets/images/tab-home.png',
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          BottomTabBtn(
            imagePath: 'assets/images/tab-searching.png',
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          BottomTabBtn(
            imagePath: 'assets/images/tab-bookmark.png',
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
          BottomTabBtn(
            imagePath: 'assets/images/tab-logout.png',
            selected: _selectedTab == 3 ? true : false,
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onPressed;
  const BottomTabBtn({this.imagePath, this.selected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          // padding: EdgeInsets.symmetric(
          //   vertical: 22.0,
          //   horizontal: 16.0,
          // ),
          // decoration: BoxDecoration(
          //   border: Border(
          //     top: BorderSide(
          //       color: Theme.of(context).accentColor,
          //       width: 2.0,
          //     )
          //   )
          // ),
          child: Image(
            image: AssetImage(
              imagePath ?? 'assets/images/tab-home.png',
            ),
            color: _selected ? Theme.of(context).accentColor : Colors.black,
          ),
          height: 22.0,
          width: 22.0,
        ),
      ),
    );
  }
}

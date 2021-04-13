import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;

  const CustomButton(
      {this.text, this.onPressed, this.outlineBtn, this.isLoading});

  @override
  Widget build(BuildContext context) {
    final _outlineBtn = false;
    final _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65.0,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.black,
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        child: Stack(
          children: [
            Center(
              child: Visibility(
                visible: _isLoading ? false : true,
                child: Text(
                  text ?? 'Text',
                  style: TextStyle(
                    color: _outlineBtn ? Colors.black : Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

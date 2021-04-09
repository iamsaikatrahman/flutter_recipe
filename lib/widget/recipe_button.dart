import 'package:flutter/material.dart';

class RecipeButton extends StatelessWidget {
  const RecipeButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
      child: Text(
        "See Recipe",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

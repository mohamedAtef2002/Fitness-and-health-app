import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color bgColor;
  final double fontsize;
  final  FontWeight fontWeight;

  Button({required this.text ,
          required this.onPressed ,
          required this.textColor ,
          required this.bgColor,
          required this.fontsize,
          required this.fontWeight,
    });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 300,
      child: ElevatedButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
            )
        ),
        child: Text(
          text,
          style: GoogleFonts.alike(
              color: textColor,
              fontSize: fontsize ,
              fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
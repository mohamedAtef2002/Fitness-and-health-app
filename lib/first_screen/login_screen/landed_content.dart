import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingContent extends StatelessWidget {
  const LandingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            "Action Is The \n"
                "Key To Success",
            style:GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 42,
                color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Get Ready To Change Your Live.\nNever Give Up\nGreat Things Take Time. Be Patient.",
            style: GoogleFonts.oswald(fontSize: 17,color: Colors.blueGrey.shade100 ),
          )
        ],
      ),
    );
  }
}

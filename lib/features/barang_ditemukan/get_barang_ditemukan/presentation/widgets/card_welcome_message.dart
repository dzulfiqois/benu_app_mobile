import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../constant/color.dart';

class CardWelcomeMessage extends StatefulWidget {
  final bool isWelcomeMessageVisible;
  final Function hideWelcomeMessage;

  const CardWelcomeMessage({
    super.key,
    required this.isWelcomeMessageVisible,
    required this.hideWelcomeMessage,
  });

  @override
  State<CardWelcomeMessage> createState() => _CardWelcomeMessageState();
}

class _CardWelcomeMessageState extends State<CardWelcomeMessage> {
  @override
  Widget build(BuildContext context) {
    double sH = MediaQuery.of(context).size.height;
    double sW = MediaQuery.of(context).size.width;

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInBack,
      child: AnimatedOpacity(
        opacity: widget.isWelcomeMessageVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: widget.isWelcomeMessageVisible
            ? Padding(
                padding: EdgeInsets.fromLTRB(
                  sW * .02,
                  sH * .03,
                  sW * .02,
                  sH * .015,
                ),
                child: Container(
                  height: sW > 700 ? sH * .3 : sH * .2,
                  width: sW,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(sH * .02),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: sW > 700 ? 8 : 24),
                        child: SizedBox(
                          width: sW > 700 ? sW * .75 : sW,
                          child: Text(
                            'Belum Nemu adalah aplikasi pencarian barang hilang yang memudahkan anda untuk menemukan benda berharga yang hilang',
                            style: GoogleFonts.inter(
                                fontSize: sW > 700 ? sH * .04 : sH * .02,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                letterSpacing: sW > 700 ? 1 : .5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sW > 700 ? sW * .11 : sW * .06),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.hideWelcomeMessage();
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(sH * .01),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 8),
                                    child: Text(
                                      'OK',
                                      style: GoogleFonts.inter(
                                        fontSize:
                                            sW > 700 ? sH * .02 : sH * .014,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

import 'package:animated_digit/animated_digit.dart';
import 'package:dinosaur/consts.dart';
import 'package:dinosaur/models/dino_model.dart';
import 'package:dinosaur/pages/main_page.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.dino});
  final DinoModel dino;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double sliderValue = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Map<String, dynamic>> details = [
      {'text': 'LENGTH', 'value': widget.dino.detail!.length, 'suffix': ' ft'},
      {
        'text': 'WEIGHT',
        'value': widget.dino.detail!.weight,
        'suffix': ' tons'
      },
      {'text': 'SPRINT', 'value': widget.dino.detail!.length, 'suffix': ' kph'},
    ];
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.6,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -90,
                    width: 1000,
                    child: Hero(
                      tag: 'Hero1',
                      child: Container(
                        width: 265,
                        height: 265,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: widget.dino.color),
                        child: Material(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('MOST FAMOUS',
                                  style: font.copyWith(fontSize: 16)),
                              Text(widget.dino.name,
                                  style: font.copyWith(fontSize: 26))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 140,
                      width: 400,
                      decoration: BoxDecoration(
                          color: widget.dino.color,
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(70))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...List.generate(
                              details.length,
                              (index) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        details[index]['text'],
                                        style: font.copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 10),
                                      AnimatedDigitWidget(
                                        value: details[index]['value'],
                                        suffix: details[index]['suffix'],
                                        fractionDigits: 1,
                                        textStyle: font.copyWith(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ))
                        ],
                      ),
                    ),
                  ),
                  Hero(
                    tag: 'Hero2',
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                                    colors: const [white, Colors.transparent],
                                    stops: [sliderValue, sliderValue])
                                .createShader(bounds);
                          },
                          blendMode: BlendMode.modulate,
                          child: Image.asset(widget.dino.detail!.sceleton),
                        ),
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                                    colors: const [Colors.transparent, white],
                                    stops: [sliderValue, sliderValue])
                                .createShader(bounds);
                          },
                          blendMode: BlendMode.modulate,
                          child: Image.asset(widget.dino.image),
                        ),
                        SizedBox(
                          width: size.width,
                          child: Opacity(
                            opacity: 0,
                            child: Material(
                              color: Colors.transparent,
                              child: Slider(
                                value: sliderValue,
                                onChanged: (value) {
                                  setState(() {
                                    sliderValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 20,
                    top: 30,
                    right: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RotatedBox(
                          quarterTurns: 1,
                          child: Text(
                            'FUN FACT',
                            style: font.copyWith(
                                color: black.withOpacity(0.6),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 325,
                          child: Text(
                            widget.dino.detail!.fact,
                            style: font.copyWith(
                                color: black.withOpacity(0.8),
                                fontSize: 16,
                                height: 1.5),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 30,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Hero(
                              tag: 'Hero3',
                              child: CustomButton(image: 'assets/down.png'))))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

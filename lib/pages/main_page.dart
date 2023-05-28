import 'package:dinosaur/consts.dart';
import 'package:dinosaur/models/dino_model.dart';
import 'package:dinosaur/pages/detail_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  AnimationController? animationController;
  int currentDino = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
  }

  late final Animation<Offset> _offset =
      Tween<Offset>(begin: const Offset(0, 0.5), end: const Offset(0, 0))
          .animate(CurvedAnimation(
              parent: animationController!, curve: Curves.decelerate));

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Good Morning, ', style: font.copyWith(fontSize: 14)),
                Text('Emma Watson',
                    style: font.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            Image.asset(
              'assets/profile.png',
              width: 60,
              height: 60,
            )
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              bottom: 100,
              width: 1000,
              height: 1000,
              duration: const Duration(milliseconds: 1000),
              child: Hero(
                tag: 'Hero1',
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ...List.generate(
                        dinos.length,
                        (index) => AnimatedContainer(
                              width:
                                  // currentDino % dinos.length == index
                                  //     ? 1000
                                  //     :
                                  index <= currentDino % dinos.length
                                      ? 1000
                                      : 0,
                              height:
                                  //  currentDino % dinos.length == index
                                  //     ? 1000
                                  //     :
                                  index <= currentDino % dinos.length
                                      ? 1000
                                      : 0,
                              duration: const Duration(milliseconds: 1000),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: dinos[index].color),
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
                  ...List.generate(
                      dinos.length,
                      (index) => AnimatedPositioned(
                          left: currentDino % dinos.length == 4 ? 0 : null,
                          duration: const Duration(milliseconds: 1000),
                          width: currentDino % dinos.length == 4
                              ? size.width * 1.85
                              : currentDino % dinos.length == index
                                  ? size.width * 0.85
                                  : size.width * 3,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentDino++;
                              });
                              animationController!.forward(from: 0.0);
                            },
                            child: currentDino % dinos.length == index
                                ? Image.asset(
                                    dinos[index].image,
                                    fit: BoxFit.fitWidth,
                                  )
                                : const SizedBox.shrink(),
                          ))),
                ],
              ),
            ),
            Positioned(
              bottom: 180,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(
                      dinos.length,
                      (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 1000),
                            width: 7.5,
                            height: 7.5,
                            margin: EdgeInsets.only(left: index != 0 ? 3 : 0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentDino % dinos.length == index
                                    ? white
                                    : white.withOpacity(0.3)),
                          ))
                ],
              ),
            ),
            Positioned(
              top: 120,
              child: Column(
                children: [
                  Text('MOST FAMOUS', style: font.copyWith(fontSize: 16)),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    transitionBuilder: (child, animation) {
                      return SlideTransition(position: _offset, child: child);
                    },
                    child: Text(dinos[currentDino % dinos.length].name,
                        style: font.copyWith(fontSize: 36)),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 70,
              child: GestureDetector(
                onTap: () {
                  if (dinos[currentDino % dinos.length].detail != null) {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child;
                          },
                          transitionDuration:
                              const Duration(milliseconds: 1000),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return DetailPage(
                                dino: dinos[currentDino % dinos.length]);
                          },
                        ));
                  } else {
                    setState(() {
                      currentDino++;
                    });
                    animationController!.forward(from: 0.0);
                  }
                },
                child: const Hero(
                  tag: 'Hero3',
                  child: CustomButton(
                    image: 'assets/up.png',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        width: 75,
        height: 75,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: white, boxShadow: [
          BoxShadow(
              color: black.withOpacity(0.4),
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(0, 3))
        ]),
        child: Image.asset(image));
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/components/fade_animation.dart';
import 'package:todo_app/navigator/router.dart';
import 'package:todo_app/utils/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;
  bool isLogged = false;

  DateTime lastTimeSignIn;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _widthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _positionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scale2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scale2Animation = Tween<double>(begin: 1.0, end: kIsWeb ? 100.0 : 36.0)
        .animate(_scale2Controller)
      ..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          Navigator.pushNamed(context, mainTabs);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // int microsecond = DateTime.now().millisecondsSinceEpoch;
    // print(DateTime.now());
    // DateTime currentPhoneDate =
    //     DateTime.fromMillisecondsSinceEpoch(microsecond + 20000); //DateTime
    // print(currentPhoneDate);

    _widthAnimation =
        Tween<double>(begin: 80.0, end: size.width).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });

    _positionAnimation = Tween<double>(begin: 0.0, end: size.width * 0.68)
        .animate(_positionController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            hideIcon = true;
          });
          _scale2Controller.forward();
        }
      });

    return Scaffold(
      body: Container(
        // color: kPurple1Color,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeAnimation(
              delay: 1.0,
              child: Container(
                // width: 200,
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                height: size.height / 3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/group_1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const FadeAnimation(
              delay: 1.3,
              child: Text(
                'Welcome',
                style: TextStyle(
                  color: kLightBlue1Color,
                  fontSize: 40,
                  shadows: [
                    BoxShadow(
                      // spreadRadius: 4,
                      color: Colors.grey,
                      blurRadius: 5.0,
                      offset: Offset(1, 3),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            const FadeAnimation(
              delay: 1.6,
              child: Text(
                'ToDo App',
                style: TextStyle(
                  color: kLightBlue1Color,
                  fontSize: 25,
                  shadows: [
                    BoxShadow(
                      // spreadRadius: 4,
                      color: Colors.grey,
                      blurRadius: 5.0,
                      offset: Offset(1, 2),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height / 5),
            FadeAnimation(
              delay: 1.9,
              child: AnimatedBuilder(
                animation: _scaleController,
                builder: (context, child) => Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _widthController,
                      builder: (context, child) => Container(
                        width: _widthAnimation.value,
                        height: 80,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: kLightBlue1Color.withAlpha(150),
                        ),
                        child: InkWell(
                          onTap: () {
                            _scaleController.forward();
                          },
                          child: Stack(
                            children: [
                              AnimatedBuilder(
                                animation: _positionController,
                                builder: (context, child) => Positioned(
                                  left: _positionAnimation.value,
                                  child: AnimatedBuilder(
                                    animation: _scale2Animation,
                                    builder: (context, child) =>
                                        Transform.scale(
                                      scale: _scale2Animation.value,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kLightBlue1Color,
                                        ),
                                        child: hideIcon
                                            ? Container()
                                            : const Icon(
                                                Icons.arrow_forward_rounded,
                                                color: Colors.white,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

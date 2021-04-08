import "package:piton_taxi_app/core/extensions/project_context_extension.dart";
import 'package:piton_taxi_app/core/constants/text/text_constants.dart';
import 'package:piton_taxi_app/core/components/project_text.dart';
import 'package:piton_taxi_app/core/constants/enums/routes.dart';
import 'package:piton_taxi_app/core/init/project_routes.dart';
import '../../../core/constants/images/image_constants.dart';
import '../../../core/constants/app/project_animation.dart';
import '../../../core/constants/app/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController controller;
  ProjectAnimation _animation;

  @override
  void initState() {
    super.initState();
    splashMove();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.forward();
    _animation = ProjectAnimation(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: AnimatedBuilder(
            animation: _animation.splashIconAnimation,
            child: _splashBody(),
            builder: (BuildContext context, Widget child) {
              return Transform.scale(
                scale: _animation.splashIconAnimation.value,
                child: child,
              );
            }),
      ),
    );
  }

  _splashBody() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.dynamicHeight(0.4),
            child: Image.asset(ImageConstants.TAXI_ICON),
          ),
          ProjectText(text: TextConstants.SPLASH_TEXT,
            style: Theme.of(context).textTheme.headline5,
          ),
        ]);
  }

  navigatePage() {
    Navigator.of(context).pushReplacement(
        ProjectRoute.generateSlidePageRouteBuilder(Pages.LOGIN, ProjectConstants.SLOW_PAGE_TRANSITION_DURATION)
    );
  }

  splashMove() {
    return Timer(Duration(seconds: 3), navigatePage);
  }
}

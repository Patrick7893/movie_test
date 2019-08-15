import 'package:flutter/cupertino.dart';

class FadeTransitionRoute extends CupertinoPageRoute {
  FadeTransitionRoute(Widget buildWidget)
      : super(builder: (context) => buildWidget);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}

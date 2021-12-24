import 'package:flutter/material.dart';
import 'package:todo_app/navigator/router.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final Color textColor;
  final Color backgroundColor;
  final Color shadowColor;
  final String type;
  final BuildContext buildContext;

  CustomAppBar({
    Key key,
    this.title,
    this.backgroundColor,
    this.type,
    this.textColor,
    this.buildContext,
    this.shadowColor,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  void onSelected(BuildContext context, int item) {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget leading = Container();
    List<Widget> actions = [];
    Widget centerWidget = Text(
      title,
      style: TextStyle(
        color: textColor,
      ),
      textAlign: TextAlign.center,
    );

    switch (type) {
      case 'mainbar':
        centerWidget = SizedBox(
          width: size.width,
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        );
        actions.add(
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () => {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(createTaskScreen),
            },
          ),
        );
        break;
      default:
        leading = IconButton(
          icon: const Icon(
            Icons.arrow_back,
            // color: Colors.white
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        );
        break;
    }

    return AppBar(
      shadowColor: shadowColor,
      toolbarOpacity: 0.7,
      automaticallyImplyLeading: true,
      leading: leading,
      title: centerWidget,
      backgroundColor: backgroundColor,
      actions: actions,
      // titleSpacing: 0.0,
    );
  }
}

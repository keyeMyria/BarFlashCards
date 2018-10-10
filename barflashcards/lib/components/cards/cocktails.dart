import '../../config/application.dart';
import '../../helpers/color_helpers.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

class CocktailsComponent extends StatelessWidget {
  CocktailsComponent(
      {String message = "Cocktails",
      Color color = const Color(0xFFFFFFFF),
      String result})
      : this.message = message,
        this.color = color,
        this.result = result;

  final String message;
  final Color color;
  final String result;

  @override
  Widget build(BuildContext context) {
    var cocktailsWidgets = <Widget>[
      new Padding(
        padding: new EdgeInsets.only(bottom: 35.0),
        child: new Image(
            image: new AssetImage("assets/images/barflashcard_logo.png"),
            width: 200.0),
      ),
      menuButton(context, "Gin", "native"),
      menuButton(context, "Tequila", "preset-from-left"),
      menuButton(context, "Vodka", "preset-fade"),
      menuButton(context, "Whiskey", "custom"),
      new Padding(
        padding: new EdgeInsets.only(top: 65.0, left: 60.0, right: 60.0),
        child: new Center(
          child: new ConstrainedBox(
            constraints: new BoxConstraints.tightFor(height: 60.0),
            child: new RaisedButton(
              highlightColor: const Color(0x11FFFFFF),
              splashColor: const Color(0x22FFFFFF),
              child: new Text(
                "Start Over",
                style: new TextStyle(
                  color: const Color(0xAA001133),
                ),
              ),
              onPressed: () {
                tappedStartOverButton(context, "native");
              },
            ),
          ),
        ),
      )
    ];

    return new Material(
      color: color,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: cocktailsWidgets,
      ),
    );
  }
}

// helpers
Widget menuButton(BuildContext context, String title, String key) {
  return new Padding(
    padding: new EdgeInsets.all(4.0),
    child: new ConstrainedBox(
      constraints: new BoxConstraints(minHeight: 42.0),
      child: new RaisedButton(
        highlightColor: const Color(0x11FFFFFF),
        splashColor: const Color(0x22FFFFFF),
        child: new Text(
          title,
          style: new TextStyle(
            color: const Color(0xAA001133),
          ),
        ),
        onPressed: () {
          tappedFlashCardButton(context, key, title);
        },
      ),
    ),
  );
}

// actions
void tappedFlashCardButton(BuildContext context, String key, String title) {
  print('tapped flashcard -- $title -- $key');
  Application.router.navigateTo(context, "/flashcard");
}

void tappedStartOverButton(BuildContext context, String key) {
  print('tapped start over -- $key');
  Application.router.navigateTo(context, "/");
}

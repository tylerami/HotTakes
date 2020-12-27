import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameViewer extends StatefulWidget {
  @override
  _GameViewerState createState() => _GameViewerState();
}

class _GameViewerState extends State<GameViewer> {
  String yy = '';
  String mm = '';
  String dd = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Localizations(
            locale: const Locale('en', 'US'),
            delegates: <LocalizationsDelegate<dynamic>>[
              DefaultWidgetsLocalizations.delegate,
              DefaultMaterialLocalizations.delegate,
            ],
            child: Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          Form(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: TextFormField(
                                      validator: (val) =>
                                          val.isEmpty ? "Year is empty" : null,
                                      keyboardType: TextInputType.datetime,
                                      decoration:
                                          InputDecoration(hintText: 'YY*'),
                                      onChanged: (val) {
                                        setState(() => yy = val);
                                      }),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: TextFormField(
                                      keyboardType: TextInputType.datetime,
                                      validator: (val) =>
                                          val.isEmpty ? "Month is empty" : null,
                                      decoration:
                                          InputDecoration(hintText: 'MM*'),
                                      onChanged: (val) {
                                        setState(() => mm = val);
                                      }),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: TextFormField(
                                      keyboardType: TextInputType.datetime,
                                      validator: (val) =>
                                          val.isEmpty ? "Day is empty" : null,
                                      decoration:
                                          InputDecoration(hintText: 'DD*'),
                                      onChanged: (val) {
                                        setState(() => dd = val);
                                      }),
                                ),
                              ],
                            ),
                          )
                        ]))))));
  }
}

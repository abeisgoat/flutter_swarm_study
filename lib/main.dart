import 'dart:async';

import 'package:butter/MySharePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/services.dart';
import 'package:platform/platform.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Butter",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: "Butter"),
    );
  }
}

class MapStat extends StatelessWidget {
  const MapStat({Key key, this.title, this.value}) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          new Padding(
              padding: new EdgeInsets.only(bottom: 5.0, top: 3.0),
              child: new Text(
                this.value,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )),
          new Text(this.title,
              textAlign: TextAlign.center,
              style: new TextStyle(color: new Color.fromARGB(100, 0, 0, 0)))
        ]));
  }
}

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({Key key, this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    Widget data = new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
            margin: new EdgeInsets.only(left: 16.0, top: 16.0),
            child: new Icon(Icons.fastfood, color: Colors.white),
            decoration: new BoxDecoration(
                color: Colors.blue,
                borderRadius: new BorderRadius.all(new Radius.circular(100.0))),
            padding: new EdgeInsets.all(16.0)),
        new Expanded(
            child: new Container(
                margin: new EdgeInsets.only(
                    left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                        padding: new EdgeInsets.only(bottom: 8.0),
                        child: new Text(
                          name,
                          style: new TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )),
                    new Row(
                      children: <Widget>[
                        new Text("Mountain View, CA",
                            style: new TextStyle(
                                color: new Color.fromARGB(100, 0, 0, 0))),
                        new Padding(
                          padding: new EdgeInsets.only(left: 8.0),
                          child: new Icon(Icons.monetization_on,
                              color: Colors.yellow[900], size: 18.0),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(left: 4.0),
                          child: new Text("20",
                              style: new TextStyle(
                                  color: new Color.fromARGB(100, 0, 0, 0))),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(left: 12.0),
                          child: new Icon(Icons.favorite,
                              color: Colors.red, size: 18.0),
                        ),
                        new Padding(
                            padding: new EdgeInsets.only(left: 4.0),
                            child: new Text("1",
                                style: new TextStyle(
                                    color: new Color.fromARGB(100, 0, 0, 0)))),
                      ],
                    ),
                    new Text("Yesterday 1:00 PM",
                        style: new TextStyle(
                            color: new Color.fromARGB(100, 0, 0, 0))),
                    new Padding(
                        padding: new EdgeInsets.only(top: 8.0),
                        child: new RichText(
                          text: new TextSpan(
                            text: 'with ',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              new TextSpan(
                                  text: 'Jen',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue)),
                            ],
                          ),
                        )),
                    new Container(
                        width: 32.0,
                        height: 32.0,
                        margin: new EdgeInsets.only(top: 8.0),
                        decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(100.0)),
                          image: new DecorationImage(
                            image:
                                new NetworkImage("https://jpg.cool/jen.person"),
                            fit: BoxFit.cover,
                          ),
                        )),
                    new AspectRatio(
                        aspectRatio: 4 / 3,
                        child: new Container(
                            margin: new EdgeInsets.only(top: 8.0),
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(8.0)),
                              image: new DecorationImage(
                                image: new NetworkImage(
                                    "https://jpg.cool/chinese.food"),
                                fit: BoxFit.cover,
                              ),
                            )))
                  ],
                )))
      ],
    );

    Widget w = new Stack(
      children: <Widget>[
        new Positioned(
            top: 0.0,
            bottom: 0.0,
            left: 43.0,
            child: new Container(
              width: 3.0,
              decoration: new BoxDecoration(
                color: Colors.blue,
              ),
            )),
        data,
      ],
    );

    return new InkWell(child: w, onTap: () {});
//    Widget container = new Container(
//      child: new Text('$name'),
//      padding: new EdgeInsets.all(10.0),
//      margin: new EdgeInsets.only(bottom: 5.0),
//      decoration: new BoxDecoration(color: Colors.blue[100]),
//    );
//    return new GestureDetector(
//        child: container,
//        onTap: () {
////          _loadFavorite(item);
//        });
  }
}

class GoogleMapsStaticImage extends StatelessWidget {
  const GoogleMapsStaticImage({Key key, this.location}) : super(key: key);

  final String location;

  @override
  Widget build(BuildContext context) {
    String formattedLocation = location != "" ? location : "Golden Gate Bridge";
    String url =
        "https://maps.googleapis.com/maps/api/staticmap?size=900x900&maptype=terrain&center=$formattedLocation&markers=size:med%7Ccolor:blue%7C$formattedLocation&key=AIzaSyDoeCLaRze5tGBXKWdB0n9w-zpz96Q46zw";

    var map = new Container(
        margin: new EdgeInsets.only(
            top: 8.0, left: 16.0, right: 16.0, bottom: 16.0),
        height: 200.0,
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
          image: new DecorationImage(
            image: new NetworkImage(url),
            fit: BoxFit.cover,
          ),
          boxShadow: <BoxShadow>[
            new BoxShadow(
                color: new Color.fromARGB(100, 0, 0, 0), blurRadius: 2.0),
          ],
          border: new Border.all(
            color: Colors.white,
            width: 1.0,
          ),
        ));

    var background = new Container(
      height: 120.0,
      decoration: new BoxDecoration(
        color: Colors.blue,
        borderRadius: new BorderRadius.only(
            bottomRight: new Radius.elliptical(100.0, 20.0),
            bottomLeft: new Radius.elliptical(100.0, 20.0)),
      ),
    );

    var stats = new Positioned(
        left: 0.0,
        right: 0.0,
        bottom: 16.0,
        child: new Container(
            padding: new EdgeInsets.symmetric(vertical: 10.0),
            margin: new EdgeInsets.symmetric(horizontal: 16.0),
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    bottomLeft: new Radius.circular(10.0),
                    bottomRight: new Radius.circular(10.0))),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new MapStat(title: "Check-ins", value: "66"),
                new MapStat(title: "Places", value: "39"),
                new MapStat(title: "Categories", value: "19/100"),
              ],
            )));

    var stack = new Stack(
        alignment: const Alignment(0.0, -1.0),
        children: [background, map, stats]);

    return new Container(
      child: stack,
      decoration: new BoxDecoration(color: new Color.fromARGB(10, 0, 0, 0)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _query = "";
  Set _favorites = new Set();
  TextEditingController _controller = new TextEditingController(text: '');
  ScrollController _scrollController = new ScrollController();

  void _changeLink(String text) {
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 200),
    );

    setState(() {
      _query = text;
    });
  }

  void _saveFavorite() {
    int count = _favorites.length + 1;
    print("Favorting $_query");
    print("Favorites count: $count");
    setState(() {
      _favorites.add(_query);
    });
  }

  void _loadFavorite(String favorite) {
    _controller.text = favorite;

    setState(() {
      _query = favorite;
    });
  }

  void _clearFavorites() {
    setState(() {
      _favorites = new Set();
    });
  }

  _launchURL() async {
    print("Launching!");

    const platform = const MethodChannel('app.channel.shared.data');

    platform.setMethodCallHandler((MethodCall mc) {
      print(mc.method);
      if (mc.method == "log") {
        print(mc.arguments);
      }
    });

    final FirebaseUser user = await FirebaseAuth.instance.signInAnonymously();
    print(user.uid);

    FirebaseDatabase.instance.reference().child('counter').set(user.uid);
/*    var snap = await FirebaseDatabase.instance.reference().child("hello").once();
    print(snap.value);*/

    const project = "pug-pug-pug";
    var url = 'https://signin.abe.today/?uid=${user.uid}&project=$project';

    if (const LocalPlatform().isAndroid) {
      AndroidIntent intent = new AndroidIntent(
          action: 'action_view',
          data: url
      );
      await intent.launch();
    }
  }

  @override
  Widget build(BuildContext context) {
    var actions = [
      new GestureDetector(
        child: new Container(
          height: 40.0,
          width: 40.0,
          margin: new EdgeInsets.only(right: 8.0, left: 16.0),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(100.0)),
            border: new Border.all(color: Colors.white, width: 1.0),
            image: new DecorationImage(
              image: new NetworkImage("https://jpg.cool/abeisgreat"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        onTap: _launchURL,
      ),
      new Expanded(
          child: new Container(
              height: 40.0,
              decoration: new BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius:
                      new BorderRadius.all(new Radius.circular(16.0))),
              padding: new EdgeInsets.only(left: 12.0),
              margin: new EdgeInsets.only(
                left: 6.0,
              ),
              child: new Row(
                children: <Widget>[
                  new Icon(
                    Icons.search,
                    color: Colors.blue[100],
                  ),
                  new Expanded(
                      child: new Padding(
                          child: new TextField(
                            style: new TextStyle(
                              color: Colors.white,
                            ),
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                hintStyle:
                                    new TextStyle(color: Colors.blue[100])),
                            onChanged: _changeLink,
                          ),
                          padding: new EdgeInsets.only(left: 6.0)))
                ],
              ))),
      new Stack(children: <Widget>[
        new Padding(
            padding: new EdgeInsets.all(4.0),
            child: new InkWell(
              borderRadius: new BorderRadius.circular(16.0),
              child: new Padding(
                  padding: new EdgeInsets.all(12.0),
                  child: new Icon(Icons.inbox)),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new MySharePage()),
                );
              },
            )),
        new Positioned(
            right: 12.0,
            top: 14.0,
            child: new Container(
                width: 14.0,
                height: 14.0,
                decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: new BorderRadius.circular(10.0)),
                child: new Center(
                    child:
                        new Text("5", style: new TextStyle(fontSize: 10.0)))))
      ])
    ];

    var topbar = new AppBar(
      actions: <Widget>[
        new Expanded(
            child: new Row(
          children: actions,
        ))
      ],
      elevation: 0.0,
    );

    var navigation = new Container(
        height: 100.0,
        child: new Stack(
          children: <Widget>[
            new Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: new Container(
                    padding: new EdgeInsets.all(8.0),
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          new BoxShadow(
                              color: new Color.fromARGB(30, 0, 0, 0),
                              blurRadius: 3.0),
                        ]),
                    child: new Row(children: <Widget>[
                      new Expanded(
                          child: new Icon(Icons.person,
                              color: Colors.blue, size: 40.0)),
                      new Expanded(
                          child: new Icon(Icons.people,
                              color: Colors.grey, size: 40.0)),
                    ]))),
            new Center(
                child: new Container(
              height: 70.0,
              width: 70.0,
              child: new Center(
                  child: new Icon(Icons.location_on,
                      color: Colors.white, size: 36.0)),
              decoration: new BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      new BorderRadius.all(new Radius.circular(100.0)),
                  border: new Border.all(color: Colors.white, width: 6.0),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                        color: new Color.fromARGB(30, 0, 0, 0),
                        blurRadius: 3.0),
                  ]),
            ))
          ],
        ));

    var mapDisplay = GestureDetector(
        onDoubleTap: _saveFavorite,
        onLongPress: _launchURL,
        child: new GoogleMapsStaticImage(location: _query));

    var timelineTitle = new Container(
        child: new Text("Timeline",
            textAlign: TextAlign.left,
            style: new TextStyle(
                fontSize: 13.0, color: new Color.fromARGB(130, 0, 0, 0))),
        padding:
            new EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
        decoration: new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(color: new Color.fromARGB(30, 0, 0, 0)),
                top: new BorderSide(color: new Color.fromARGB(15, 0, 0, 0)))));

    var listTitle = new Row(
      children: <Widget>[
        new Container(
            height: 30.0,
            margin: new EdgeInsets.only(top: 8.0),
            padding: new EdgeInsets.only(right: 16.0),
            decoration: new BoxDecoration(
                color: new Color.fromARGB(15, 0, 0, 0),
                borderRadius: new BorderRadius.only(
                    topRight: new Radius.circular(8.0),
                    bottomRight: new Radius.circular(8.0))),
            child: new Row(
              children: <Widget>[
                new Column(children: <Widget>[
                  new Container(
                    width: 11.0,
                    height: 11.0,
                    margin:
                        new EdgeInsets.only(top: 10.0, left: 39.0, right: 12.0),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.circular(100.0)),
                  ),
                  new Container(
                      width: 3.0,
                      height: 9.0,
                      margin: new EdgeInsets.only(left: 39.0, right: 12.0),
                      decoration: new BoxDecoration(color: Colors.blue))
                ]),
                new Text("Yesterday")
              ],
            )),
      ],
    );

    var sections = [
      mapDisplay,
      timelineTitle,
      listTitle,
    ];
    var content = new RefreshIndicator(
      child: new ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        padding: new EdgeInsets.only(bottom: 58.0),
        itemCount: _favorites.length + sections.length,
        itemBuilder: (BuildContext context, int index) {
          if (index < sections.length) {
            return sections[index];
          } else {
            return new HistoryListItem(
                name: _favorites.elementAt(index - sections.length));
          }
        },
      ),
      onRefresh: () async {
        print("plz refresh...");
        await new Future.delayed(const Duration(seconds: 2));
        _clearFavorites();
        print("Refreshed!");
      },
    );

    Widget bottom = new Text("");
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      bottom = navigation;
    }

    return new Scaffold(
        appBar: topbar,
        body: new Stack(
          children: <Widget>[
            content,
            new Positioned(child: bottom, bottom: 0.0, left: 0.0, right: 0.0)
          ],
        ));
  }
}

import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map mapResponse;

  Future getData() async {
    http.Response response;
    response = await http.get(
        "http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes");

    mapResponse = json.decode(response.body);
  }

  void initState() {
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Game of Thrones"),
        ),
        body: mapResponse == null
            ? Center(
                child: Text("Wait"),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        mapResponse['name'].toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        mapResponse['type'].toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        mapResponse['language'].toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        mapResponse['status'].toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        mapResponse['premiered'].toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        mapResponse['weight'].toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        mapResponse['rating'].toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      RichText(
                        text: new TextSpan(
                          children: [
                            new TextSpan(
                              text: 'Episode Check',
                              style: new TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  launch(mapResponse['url']);
                                },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Image.network(
                          mapResponse['image']['original'],
                          height: 300,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: new TextSpan(children: [
                          new TextSpan(
                              text: 'Official site',
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  launch(mapResponse['officialSite']);
                                },
                              style: new TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500))
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Summary: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        mapResponse['summary'],
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: new TextSpan(children: [
                          new TextSpan(
                              text: 'Today Episode',
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  launch(mapResponse['_links']['self']);
                                },
                              style: new TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500))
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: new TextSpan(children: [
                          new TextSpan(
                              text: 'Previous Episode',
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  launch(
                                      mapResponse['_links']['previousepisode']);
                                },
                              style: new TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500))
                        ]),
                      ),
                    ],
                  ),
                ),
              ));
  }
}

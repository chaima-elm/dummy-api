import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/server.dart';
import 'mainn/recherche.dart';
import '../api/data.dart';
import 'mainn/home.dart';
import 'mainn/newp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int curr = 0;

  @override
  Widget build(BuildContext context) {
    final _tabs = <Widget>[
      home_posts(),
      searshLP(),
      new_post(),
    ];

    final tabs = <Tab>[
      const Tab(
        icon: Icon(
          Icons.home,
          color: Color.fromARGB(255, 20, 95, 165),
        ),
        child: Text('Home',
            style: TextStyle(
                color: Color.fromARGB(
                    255, 20, 95, 165) /*Color.fromARGB(255, 255, 176, 6)*/,
                fontWeight: FontWeight.bold)),
      ),
      const Tab(
        icon: Icon(Icons.search, color: Color.fromARGB(255, 20, 95, 165)),
        child: Text('Search',
            style: TextStyle(
                color: Color.fromARGB(255, 20, 95, 165),
                fontWeight: FontWeight.bold)),
      ),
      const Tab(
        icon: Icon(Icons.add_photo_alternate_outlined,
            color: Color.fromARGB(255, 20, 95, 165)),
        child: Text('Add',
            style: TextStyle(
                color: Color.fromARGB(255, 20, 95, 165),
                fontWeight: FontWeight.bold)),
      )
    ];

    return MaterialApp(
        title: 'Dummy API',
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                shape: const RoundedRectangleBorder(),

                title: const Text('DummyApp',
                    style: TextStyle(
                        color: Color.fromARGB(255, 20, 95,
                            165) /*Color.fromARGB(255, 211, 165, 40)*/,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                backgroundColor:
                    Colors.white, //const Color.fromARGB(255, 206, 137, 8),

                bottom: TabBar(tabs: tabs),
              ),
              body: TabBarView(children: _tabs), //_tabs[curr],
            )));
  }
}

FutureBuilder<List<Post>> home_posts() {
  return FutureBuilder(
      future: getpost(http.Client(), 0),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return HomePage(posts: snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}

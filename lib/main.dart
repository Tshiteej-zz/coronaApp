import 'package:flutter/material.dart';
import 'dart:async';
import 'User.dart';
import 'Services.dart';
import 'countryData.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.light(),
    home: UserFilterDemo(),
  ));
}

class UserFilterDemo extends StatefulWidget {
  UserFilterDemo() : super();

  final String title = "COVID-19 Data";

  @override
  UserFilterDemoState createState() => UserFilterDemoState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class UserFilterDemoState extends State<UserFilterDemo> {
  // https://jsonplaceholder.typicode.com/users

  final _debouncer = Debouncer(milliseconds: 500);
  // List<User> users = List();
  // List<User> filteredUsers = List();

  List<PageData> data = List();
  List<PageData> filteredData = List();

  @override
  void initState() {
    super.initState();
    Services.getData().then((dataFromServer) {
      // print(dataFromServer);
      setState(() {
        data = dataFromServer;
        filteredData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Filter by country name',
            ),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  filteredData = data
                      .where((u) =>
                          (u.name.toLowerCase().contains(string.toLowerCase())))
                      .toList();
                });
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              // itemCount: snapshot.data.length,
              itemCount: filteredData.length,
              itemBuilder: (BuildContext context, int index) {
                return filteredData[index].confirmed > 0
                    ? Padding(
                        padding: EdgeInsets.all(0.0),
                        child: InkWell(
                            onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SecondPage(
                                        code: filteredData[index].code,
                                      ),
                                    ),
                                  )
                                },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                              height: 120,
                              width: double.maxFinite,
                              child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Stack(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Stack(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      filteredData[index].name,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Confirmed',
                                                            style: TextStyle(
                                                                color: Colors
                                                                        .orange[
                                                                    700],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            'Recovered',
                                                            style: TextStyle(
                                                                color: Colors
                                                                        .greenAccent[
                                                                    700],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            'Deaths',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red[700],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 10, 0, 0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20),
                                                            child: Text(
                                                              filteredData[
                                                                      index]
                                                                  .confirmed
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .orange[
                                                                      700],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              filteredData[
                                                                      index]
                                                                  .recovered
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .greenAccent[
                                                                      700],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 20),
                                                            child: Text(
                                                              filteredData[
                                                                      index]
                                                                  .deaths
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red[700],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      )
                    : Padding(
                        padding: EdgeInsets.all(0.0),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

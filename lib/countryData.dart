// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryData {
  final String name;
  final String population;
  final String t_deaths;
  final String t_confirmed;
  final String deaths;
  final String confirmed;
  final String recovered;
  final String critical;
  final String death_rate;
  final String recovery_rate;

  CountryData(
      {this.name,
      this.recovery_rate,
      this.death_rate,
      this.critical,
      this.recovered,
      this.confirmed,
      this.deaths,
      this.t_confirmed,
      this.t_deaths,
      this.population});
}

// List<CountryData> res = [];

class SecondPage extends StatelessWidget {
  final String code;

  SecondPage({this.code});

  Future<List<dynamic>> getJSONData() async {
    var response = await http.get(
        // Encode the url
        Uri.encodeFull("http://corona-api.com/countries/$code"),
        // Only accept JSON response
        headers: {"Accept": "application/json"});
    var jd = jsonDecode(response.body);
    var jsonData = jd['data'];
    // for (var u in jsonData['data']) {
    var res = [];

    CountryData dat = CountryData(
        name: jsonData['name'],
        population: jsonData['population'].toString(),
        t_deaths: jsonData['today']['deaths'].toString(),
        t_confirmed: jsonData['today']['confirmed'].toString(),
        deaths: jsonData['latest_data']['deaths'].toString(),
        confirmed: jsonData['latest_data']['confirmed'].toString(),
        recovered: jsonData['latest_data']['recovered'].toString(),
        critical: jsonData['latest_data']['critical'].toString(),
        death_rate:
            jsonData['latest_data']['calculated']['death_rate'].toString(),
        recovery_rate:
            jsonData['latest_data']['calculated']['recovery_rate'].toString());
    res.add(dat);
    return res;
    // return "Successfull";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Details: ${code}"),
      ),
      body: FutureBuilder(
        future: getJSONData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(5, 100, 5, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        height: 350,
                        width: double.maxFinite,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.blueGrey[200], width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                                child: Text(
                                  "${snapshot.data[index].name}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Population',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.data[index].population,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Deaths Today',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data[index].t_deaths,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Cases confirmed Today",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data[index].t_confirmed,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Total Deaths',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data[index].deaths,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Total Confirmed Cases',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data[index].confirmed,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Total Recovered",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data[index].recovered,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Death Rate",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data[index].death_rate,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Recovery Rate",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        snapshot.data[index].recovery_rate,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

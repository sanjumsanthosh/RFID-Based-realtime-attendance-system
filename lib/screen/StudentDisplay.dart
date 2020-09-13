import 'dart:math';

import 'package:attendance/models/details.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentDisplay extends StatefulWidget {
  @override
  _StudentDisplayState createState() => _StudentDisplayState();
  bool availableInsideData(String data) {
    return createState().availableInsideData(data);
  }
}

class _StudentDisplayState extends State<StudentDisplay> {
  final List<Details> dummyValues = [
    Details(
        addno: "170075",
        dept: "AEI S5",
        name: 'Sanjay M Santhosh',
        rfid: "f1d3d79",
        rollno: "48",
        isStudent: true),
    Details(
        addno: "1700x0",
        dept: "AEI S5",
        name: 'Master Card',
        rfid: "fe8372a9",
        rollno: "00",
        isStudent: false),
    Details(
        addno: "17000x",
        dept: "AEI S5",
        name: 'Key Chain',
        rfid: "28d7c049",
        rollno: "70",
        isStudent: false),
    Details(
        addno: "170077",
        dept: "AEI S5",
        name: 'Bhadra Sajikumar',
        rfid: "478b3c79",
        rollno: "12",
        isStudent: true),
    Details(
        addno: "170100",
        dept: "AEI S5",
        name: 'Neha Sebastian',
        rfid: "3ad23b79",
        rollno: "37",
        isStudent: true),
    Details(
        addno: "170593",
        dept: "AEI S5",
        name: 'Namitha Renjit',
        rfid: "4aca3a79",
        rollno: "36",
        isStudent: true),
    Details(
        addno: "170593",
        dept: "AEI S5",
        name: 'Rohan P Antony',
        rfid: "634e3c79",
        rollno: "46",
        isStudent: true),
    Details(
        addno: "170088",
        dept: "AEI S5",
        name: 'Anavadya M S',
        rfid: "e2a33c79",
        rollno: "6",
        isStudent: true),
    Details(
        addno: "170099",
        dept: "AEI S5",
        name: 'Kartika S',
        rfid: "83ba3b79",
        rollno: "27",
        isStudent: true),
    Details(
        addno: "171159",
        dept: "AEI S5",
        name: 'Balagopal G',
        rfid: "2bbf3a79",
        rollno: "11",
        isStudent: true),
    Details(
        addno: "170600",
        dept: "AEI S5",
        name: 'Saagara M B',
        rfid: "82fdd763",
        rollno: "63",
        isStudent: true),
    Details(
        addno: "170092",
        dept: "AEI S5",
        name: 'Hari Sankar S',
        rfid: "7e613c79",
        rollno: "17",
        isStudent: true),
    Details(
        addno: "170678",
        dept: "AEI S5",
        name: 'JayaKrishnan A U',
        rfid: "99273f79",
        rollno: "18",
        isStudent: true),
    Details(
        addno: "180600",
        dept: "AEI S5",
        name: 'Adithya K R',
        rfid: "baf23d63",
        rollno: "65",
        isStudent: true),
    Details(
        addno: "170766",
        dept: "AEI S5",
        name: 'Vyshak Sirr',
        rfid: "b11b3c79",
        rollno: "58",
        isStudent: true),
        Details(
        addno: "170679",
        dept: "AEI S5",
        name: 'Gokul Krishnan',
        rfid: "ce3d79",
        rollno: "15",
        isStudent: true),
  ];

  bool classView = true;
  Details getDataFromId(String rfid) {
    Details filteredDetails = dummyValues.firstWhere((data) {
      return data.rfid == rfid;
    });
    return filteredDetails;
  }

  Details getDataFromAddNo(String addno) {
    Details filteredDetails = dummyValues.firstWhere((data) {
      return data.addno == addno;
    });
    return filteredDetails;
  }

  bool availableInsideData(String addno) {
    return dummyValues.where((data) {
          return data.addno == addno;
        }).length !=
        0;
  }

  final mainReference = FirebaseDatabase.instance.reference();

  Future<void> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged', false);
    Navigator.of(context).pushReplacementNamed('loginScreen');
  }

  var teacherInClass = false;
  var teacherid = '';
  var now = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    String uid = ModalRoute.of(context).settings.arguments;
    print('uid : ' + uid.toString());
    Details personalDetails = getDataFromAddNo(uid.toString());
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var data = mainReference.child('attendance_daily').onValue;
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                classView ? Icons.visibility : Icons.visibility_off,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  classView = !classView;
                });
              })
        ],
        leading: IconButton(
          splashColor: Colors.white24,
          icon: Icon(
            Icons.exit_to_app,
            size: 30,
          ),
          onPressed: () => logOut(),
        ),
        backgroundColor: Colors.black26,
        centerTitle: true,
        elevation: 5,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Hi ,' + personalDetails.name.split(' ')[0]),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              if (classView)
                StreamBuilder(
                    stream: mainReference.child('current_status').onValue,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        Map retreave = snapshot.data.snapshot.value;
                        print('second');
                        bool currentState = retreave[personalDetails.rfid];
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Icon(
                                    Icons.camera,
                                    size: 100,
                                    color: currentState
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Date ' +
                                            DateFormat("dd-MM-yyyy")
                                                .format(now),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      ),
                                      Text(
                                          currentState
                                              ? 'Status : IN'
                                              : 'Status : OUT',
                                          style: TextStyle(
                                            color: currentState
                                                ? Colors.green
                                                : Colors.red,
                                            fontSize: 25,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .15),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(20)),
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .15,
                            child: Text(
                              'Fetching Status ....',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ));
                      }
                    }),
              if (!classView)
                StreamBuilder(
                    stream: mainReference.child('current_status').onValue,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        Map retreave = snapshot.data.snapshot.value;
                        var teachers = dummyValues.where((data) {
                          return data.isStudent == false;
                        }).toList();
                        print('teachers : ');
                        teacherInClass = false;
                        for (var tr in teachers) {
                          print(tr.name);
                          if (retreave[tr.rfid] == true) {
                            print('tr in class');
                            print(tr.name);
                            teacherInClass = true;
                            teacherid = tr.rfid;
                          }
                        }

                        var students = retreave.values
                            .toList()
                            .where((cnt) => cnt)
                            .toList();
                        var numberOfStudentsInClass = students.length;
                        if (teacherInClass)
                          numberOfStudentsInClass = numberOfStudentsInClass - 1;
                        bool currentState = retreave[personalDetails.rfid];
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Icon(
                                    Icons.school,
                                    size: 80,
                                    color: Colors.white,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Number of Students :' +
                                            numberOfStudentsInClass.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Text(
                                          !teacherInClass
                                              ? 'No one is teaching Now'
                                              : getDataFromId(teacherid).name +
                                                  ' is taking Class',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(20)),
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .15,
                            child: Text(
                              'Fetching Status ....',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ));
                      }
                    }),
              Container(
                height: MediaQuery.of(context).size.height * .75,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                    stream: data,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        Map retreave = snapshot.data.snapshot.value;
                        var date = (retreave.keys.toList());
                        date.sort();
                        date = date.reversed.toList();
                        print(date);
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: date.length,
                          itemBuilder: (BuildContext context, int index) {
                            //index = index-1;
                            var attendance =
                                (retreave[date[index]] as Map).values;
                            attendance = attendance.where((data) {
                              return (data as String).split('%')[1] ==
                                  personalDetails.rfid;
                            });
                            List attendance_edited = attendance.toList();
                            attendance_edited.sort();
                            attendance_edited =
                                attendance_edited.reversed.toList();
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: <Widget>[
                                  Divider(
                                    color: Colors.grey[700],
                                  ),
                                  Text(
                                    'Date : ' + date[index].toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 53, 51, 51),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: min(
                                        attendance_edited.length * 60.0,
                                        MediaQuery.of(context).size.height *
                                            .65),
                                    width: double.infinity,
                                    child: attendance_edited.length > 0
                                        ? ListView.builder(
                                            itemCount: attendance.length,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              print('length');
                                              print(attendance_edited.length);
                                              return ListTile(
                                                trailing: ((attendance.length -
                                                                i +
                                                                1) %
                                                            2 ==
                                                        0)
                                                    ? Icon(
                                                        Icons.thumb_up,
                                                        color: Colors.green,
                                                      )
                                                    : Icon(
                                                        Icons.thumb_down,
                                                        color: Colors.red,
                                                      ),
                                                leading: Icon(
                                                  Icons.hdr_strong,
                                                  size: 20,
                                                  color: Colors.orange,
                                                ),
                                                title: Text(
                                                  (attendance_edited[i]
                                                          as String)
                                                      .split('%')[0],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                            },
                                          )
                                        : Center(
                                            child: Text(
                                              'no data !',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Loading.....',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            CircularProgressIndicator(),
                          ],
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

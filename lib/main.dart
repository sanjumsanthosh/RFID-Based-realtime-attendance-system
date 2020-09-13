import 'package:attendance/screen/ProfessorsDisplay.dart';
import 'package:attendance/screen/StudentDisplay.dart';
import 'package:attendance/screen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_database/firebase_database.dart';
// import './models/details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  //final SharedPreferences prefs = await SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: loginScreen(),
      routes: {
        'student': (BuildContext context) => StudentDisplay(),
        'loginScreen': (BuildContext context) => loginScreen(),
        'professor': (BuildContext context) => ProfessorsDisplay(),
      },
      //home: MyHomePage(title: 'S5 Attendance'),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
//   bool availableInsideData(String data) {
//     return createState().availableInsideData(data);
//   }
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final List<Details> dummyValues = [
//     Details(
//         addno: "170075",
//         dept: "AEI S5",
//         name: 'Sanjay M Santhosh',
//         rfid: "f1d3d79",
//         rollno: "48",
//         isStudent: true),
//     Details(
//         addno: "1700x0",
//         dept: "AEI S5",
//         name: 'Master Card',
//         rfid: "fe8372a9",
//         rollno: "00",
//         isStudent: false),
//     Details(
//         addno: "17000x",
//         dept: "AEI S5",
//         name: 'Key Chain',
//         rfid: "28d7c049",
//         rollno: "70",
//         isStudent: false),
//     Details(
//         addno: "170077",
//         dept: "AEI S5",
//         name: 'Bhadra Sajikumar',
//         rfid: "478b3c79",
//         rollno: "12",
//         isStudent: true),
//     Details(
//         addno: "170100",
//         dept: "AEI S5",
//         name: 'Neha Sebastian',
//         rfid: "3ad23b79",
//         rollno: "37",
//         isStudent: true),
//     Details(
//         addno: "170593",
//         dept: "AEI S5",
//         name: 'Namitha Renjit',
//         rfid: "4aca3a79",
//         rollno: "36",
//         isStudent: true),
//     Details(
//         addno: "170593",
//         dept: "AEI S5",
//         name: 'Rohan P Antony',
//         rfid: "634e3c79",
//         rollno: "46",
//         isStudent: true),
//     Details(
//         addno: "170088",
//         dept: "AEI S5",
//         name: 'Anavadya M S',
//         rfid: "e2a33c79",
//         rollno: "6",
//         isStudent: true),
//     Details(
//         addno: "170099",
//         dept: "AEI S5",
//         name: 'Kartika S',
//         rfid: "83ba3b79",
//         rollno: "27",
//         isStudent: true),
//     Details(
//         addno: "171159",
//         dept: "AEI S5",
//         name: 'Balagopal G',
//         rfid: "2bbf3a79",
//         rollno: "11",
//         isStudent: true),
//     Details(
//         addno: "170600",
//         dept: "AEI S5",
//         name: 'Saagara M B',
//         rfid: "82fdd763",
//         rollno: "63",
//         isStudent: true),
//     Details(
//         addno: "170092",
//         dept: "AEI S5",
//         name: 'Hari Sankar S',
//         rfid: "7e613c79",
//         rollno: "17",
//         isStudent: true),
//     Details(
//         addno: "170678",
//         dept: "AEI S5",
//         name: 'JayaKrishnan A U',
//         rfid: "99273f79",
//         rollno: "18",
//         isStudent: true),
//     Details(
//         addno: "180600",
//         dept: "AEI S5",
//         name: 'Adithya K R',
//         rfid: "baf23d63",
//         rollno: "65",
//         isStudent: true),
//     Details(
//         addno: "170766",
//         dept: "AEI S5",
//         name: 'Vyshak Sirr',
//         rfid: "b11b3c79",
//         rollno: "58",
//         isStudent: true),
//   ];

//   Details getDataFromId(String rfid) {
//     Details filteredDetails = dummyValues.firstWhere((data) {
//       return data.rfid == rfid;
//     });
//     return filteredDetails;
//   }

//   bool availableInsideData(String addno) {
//     return dummyValues.where((data) {
//           return data.addno == addno;
//         }).length !=
//         0;
//   }

//   final mainReference = FirebaseDatabase.instance.reference();

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     var data = mainReference.child('current_status').onValue;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 5,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: StreamBuilder(
//             stream: data,
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData) {
//                 Map retreave = snapshot.data.snapshot.value;
//                 print(retreave.keys.toList());
//                 return ListView.builder(
//                   itemCount: retreave.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     print(retreave.keys.toList()[index]);
//                     var itemDetails =
//                         getDataFromId(retreave.keys.toList()[index]);

//                     bool status = retreave.values.toList()[index];
//                     return Column(
//                       children: <Widget>[
//                         ListTile(
//                             leading: Text(itemDetails.rollno),
//                             title: Text(itemDetails.name),
//                             subtitle: Text(itemDetails.dept),
//                             trailing: status
//                                 ? Icon(
//                                     Icons.thumb_up,
//                                     color: Colors.green,
//                                   )
//                                 : Icon(
//                                     Icons.thumb_down,
//                                     color: Colors.red,
//                                   )),
//                         Divider(),
//                       ],
//                     );
//                   },
//                 );
//               } else {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       'Loading.....',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 20),
//                     CircularProgressIndicator(),
//                   ],

//                 );
//               }
//             }),
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

import 'package:attendance/models/details.dart';
import 'package:flutter/material.dart';
import './delayed_animation.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginScreen extends StatefulWidget {
  

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen>
    with TickerProviderStateMixin {
  final int delayedAmount = 500;
  final loginController = TextEditingController();
  double _scale;

  AnimationController _controller;


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

  bool staterun = false;
  
  @override
  void initState() {
    getState();
    
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 20,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }
  bool availableInsideData(String addno) {
    return dummyValues.where((data) {
          return data.addno == addno;
        }).length !=
        0;
  }
  bool valid = false;
  validate(context){
    bool available =
        (availableInsideData(loginController.text));
    if (!available) {
      return 'ENTER VALID ADDNO';
    }
    valid = true;
    return null;
  }
  loginFunction(context) async{
    if(valid){

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('logged', true);
      prefs.setString('uid', loginController.text);

      Details user = dummyValues.where((test){
        return test.addno == loginController.text;
      }).toList()[0];
      print('user.is studnet'+user.isStudent.toString());
      if(user.isStudent){Navigator.of(context).pushReplacementNamed('student',arguments: loginController.text);}
      else{Navigator.of(context).pushReplacementNamed('professor',arguments: loginController.text);}
      
    }
    if(status){
      Details user = dummyValues.where((test){
        return test.addno == uid;
      }).toList()[0];
      print('user.is studnet'+user.isStudent.toString());
      if(user.isStudent){Navigator.of(context).pushReplacementNamed('student',arguments: uid);}
      else{Navigator.of(context).pushReplacementNamed('professor',arguments: uid);}
      //Navigator.of(context).pushReplacementNamed('student',arguments: uid);
    }
  }

  bool status = false;
  String uid = '';
  Future<void> getState() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    status =  prefs.getBool('logged');
    if(status == null)status=false;
    uid = prefs.getString('uid');
    print('completed initializing');
    print('logged : '+status.toString());
    print('uid : '+uid.toString());
    setState(() {
      staterun = true;
    });
    print('satate run : '+staterun.toString());
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return Scaffold(
       // backgroundColor: Color(0xFF8185E2),
       backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                AvatarGlow(
                  endRadius: 90,
                  duration: Duration(seconds: 2),
                  glowColor: Colors.white24,
                  repeat: true,
                  repeatPauseDuration: Duration(seconds: 2),
                  startDelay: Duration(seconds: 1),
                  child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: FlutterLogo(
                          size: 50.0,
                        ),
                        radius: 50.0,
                      )),
                ),
                DelayedAnimation(
                  child: Text(
                    "Hi ,",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: color),
                  ),
                  delay: delayedAmount + 500,
                ),
                DelayedAnimation(
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: color),
                  ),
                  delay: delayedAmount + 1000,
                ),
                SizedBox(
                  height: 30.0,
                ),
                DelayedAnimation(
                  child: Text(
                    "S5 AEI CET",
                    style: TextStyle(fontSize: 20.0, color: color),
                  ),
                  delay: delayedAmount + 1500,
                ),
                DelayedAnimation(
                  child: Text(
                    "ATTENDANCE SYSTEM",
                    style: TextStyle(fontSize: 20.0, color: color),
                  ),
                  delay: delayedAmount + 2000,
                ),
                SizedBox(
                  height: 100.0,
                ),
                (staterun & !status)?Container(
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .33),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: loginController,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    decoration: InputDecoration(
                      
                        errorText: validate(context),
                        errorStyle: TextStyle(color: Colors.orange),
                        hintStyle:
                        
                            TextStyle(color: Colors.white, fontSize: 20),
                        border: InputBorder.none,
                        hintText: 'Enter AddNo'),
                  ),
                ):
                Container(),
                staterun?GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButtonUI,
                  ),
                ):
                Container(child: CircularProgressIndicator(),),
                SizedBox(
                  height: 50.0,
                ),
                DelayedAnimation(
                  child: Text(
                    "".toUpperCase(),
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                  delay: delayedAmount + 5000,
                ),
              ],
            ),
          ),
        )
        //  Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Text('Tap on the Below Button',style: TextStyle(color: Colors.grey[400],fontSize: 20.0),),
        //     SizedBox(
        //       height: 20.0,
        //     ),
        //      Center(

        //   ),
        //   ],

        // ),
        );
  }

  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            status?('Continue as '+uid):'Login',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8185E2),
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    loginFunction(context);
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}

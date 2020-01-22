import 'package:flutter/material.dart';
import 'spin_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpinButton',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpinButtonPage(),
    );
  }
}

class SpinButtonPage extends StatefulWidget {
  @override
  _SpinButtonPageState createState() => _SpinButtonPageState();
}

class _SpinButtonPageState extends State<SpinButtonPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  SpinWidgetSpinDirection _spinWidgetSpinDirection =
      SpinWidgetSpinDirection.left;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey key = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: Text('SpinButton'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                setState(() {
                  final RenderBox referenceBox =
                      key.currentContext.findRenderObject();
                  if (details.localPosition.dx / referenceBox.size.width >
                      0.5) {
                    _spinWidgetSpinDirection = SpinWidgetSpinDirection.right;
                  } else {
                    _spinWidgetSpinDirection = SpinWidgetSpinDirection.left;
                  }
                  _animationController.reset();
                  _animationController.forward();
                });
              },
              child: SpinWidget(
                listenable: _animationController,
                spinDirection: _spinWidgetSpinDirection,
                cornerRadius: 10,
                child: Container(
                  key: key,
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  color: Color.fromRGBO(0xFF, 0x23, 0x5D, 1.0), // Dynamo RED
                  child: RichText(
                    text: TextSpan(
                      text: 'DYNA ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 28,
                        wordSpacing: -6,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'MO', // 发电机
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

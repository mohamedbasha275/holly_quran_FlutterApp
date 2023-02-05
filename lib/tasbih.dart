import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double end = 0.01;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RotationTransition(
              turns: Tween(begin: 0.0, end: end).animate(_controller),
              //child: Icon(Icons.accessibility_new_outlined,size: 200,),
              child: Image.asset('assets/images/beads.png',width: 300,),
            ),
            SizedBox(height: 40,),
            ElevatedButton(
              child: Text("go"),
              onPressed: (){
                setState(() {
                  end +=0.01;
                });
                _controller.forward();
              },
            ),
            ElevatedButton(
              child: Text("reset"),
              onPressed: (){
                setState(() {
                  end = 0;
                });
                _controller.reset();
              },
            ),
          ],
        ),
      ),
    );
  }
}
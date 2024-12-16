// option + enter : 필요한 패키지 import 단축키

import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:velocity_x/velocity_x.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;
  late ShakeDetector detector;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this); //리스너 추가

    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        setState(() {
          _counter++;
        });
      },
      shakeThresholdGravity: 1.5,
    );
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); //리스너 제거
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                redBox(),
                Column(
                  children: [
                    redBox().box.padding(EdgeInsets.all(20)).color(Colors.blue).make(),
                    '흔들어서 카운트를 올려보세요.'
                        .text
                        .size(20)
                        .color(Colors.indigo)
                        .bold
                        .isIntrinsic
                        .makeCentered()
                        .box
                        .withRounded(value: 50)
                        .color(Colors.green)
                        .height(150)
                        .make()
                        .pSymmetric(h: 20, v: 50),
                    redBox(),
                  ],
                ),
                redBox(),
              ],
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  //option + command + m : 메서드 추출 단축키를 사용하여 같은 위젯 추출
  Widget redBox() => Container().box.green900.size(20, 20).make();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached: // 앱이 종료되지 않았지만, 이벤트를 받지 않는 상태.
        break;
      case AppLifecycleState.resumed: // 앱이 사용자와 상호작용을 할 수 있는 상태.
        detector.startListening();
        break;
      case AppLifecycleState.inactive: // 앱이 비활성화 상태.
        break;
      case AppLifecycleState.hidden: // 앱이 사용자에게 보이지 않는 상태.
        break;
      case AppLifecycleState.paused: // 앱이 사용자와 상호작용을 하지 않는 상태.
        detector.stopListening();
        break;
    }
  }
}

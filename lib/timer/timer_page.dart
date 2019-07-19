import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_background/timer/timer_bloc.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with WidgetsBindingObserver {
  TimerBloc bloc;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    bloc.didChangeLifeCycle(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<TimerBloc>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<String>(
                stream: bloc.timer,
                initialData: "0",
                builder: (context, snapshot) {
                  return Text(snapshot.data, style: TextStyle(fontSize: 50));
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                    onPressed: bloc.startCountDown, child: Text("Start")),
                FlatButton(onPressed: bloc.stopCountDown, child: Text("Stop"))
              ],
            ),
            Container(
              margin: EdgeInsets.all(40),
              child: FutureBuilder<int>(
                  future: bloc.getTimer(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && !snapshot.hasError) {
                      print(snapshot.data);
                      String timeSaved =
                          "${(snapshot.data ~/ 60).toString().padLeft(2, '0')} "
                          ": ${(snapshot.data % 60).toString().padLeft(2, '0')}";
                      return Text(timeSaved, style: TextStyle(fontSize: 20));
                    } else {
                      return Text("Nada salvo até o momento",
                          style: TextStyle(fontSize: 20));
                    }
                  }),
            ),
            FlatButton(onPressed: bloc.saveTimer, child: Text("Salvar tempo")),
            FlatButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text("Reconstruir")),
            FlatButton(onPressed: bloc.clearTimer, child: Text("Zerar"))
          ],
        ),
      ),
    );
  }
}

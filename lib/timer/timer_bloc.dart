import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_cache_store/flutter_cache_store.dart';
import 'package:timer_background/repositories/timer_repository.dart';
class TimerBloc{

  final TimerRepository timerRepository;
  Duration duration = Duration(minutes: 25);

  Timer timerCountDown;

  int milliseconds;

  BehaviorSubject<int> _timer = BehaviorSubject.seeded(0);

  TimerBloc({@required this.timerRepository});

  Observable<String> get timer => _timer.stream.transform(StreamTransformer<int, String>.fromHandlers(
    handleData: (time, sink){
      milliseconds = time * 1000;
      sink.add("${(time ~/ 60).toString().padLeft(2, '0')} "
          ": ${(time % 60).toString().padLeft(2, '0')}");
    }
  ));

  Function(int) get changeTimer => _timer.sink.add;

  void saveTimer() async{
    await timerRepository.saveTimer(_timer.value);
  }

  Future<int> getTimer() async{
    return await timerRepository.getTimer();
  }

  void startCountDown() async{
    timerCountDown = Timer.periodic(Duration(seconds: 1), (Timer t){
      changeTimer(duration.inSeconds - t.tick);
    });
//    await AndroidAlarmManager.initialize();
//    await AndroidAlarmManager.oneShot(Duration(seconds: 1), 0, runTimer);
  }

//  static void runTimer(){
//    final DateTime now = DateTime.now();
//    final int isolateId = Isolate.current.hashCode;
//    print("[$now] Hello, world! isolate=$isolateId");
//  }

  void stopCountDown(){
    timerCountDown.cancel();
    changeTimer(0);
  }
  void dispose(){
    _timer.close();
  }
}
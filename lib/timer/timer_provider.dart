import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timer_background/repositories/impl/timer_repository_impl.dart';
import 'package:timer_background/timer/timer_bloc.dart';
import 'package:provider/provider.dart';
import 'package:timer_background/timer/timer_page.dart';

class TimerProvider extends StatelessWidget {

  Future<File> getFile()async{
    return File('${(await getApplicationDocumentsDirectory()).path}/counter.txt');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: getFile(),
      builder: (context, snapshot) {
        return snapshot.hasData ?
        Provider<TimerBloc>(
          builder: (_) => TimerBloc(
              timerRepository: TimerRepositoryImpl(snapshot.data)
          ),
          dispose: (_, bloc) => bloc.dispose(),
          child: TimerPage(),
        ) : Center(child: CircularProgressIndicator());
      }
    );
  }
}

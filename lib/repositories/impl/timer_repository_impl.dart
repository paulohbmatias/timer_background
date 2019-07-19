import 'dart:io';

import 'package:timer_background/repositories/timer_repository.dart';

class TimerRepositoryImpl implements TimerRepository{

  final File _localFile;

  TimerRepositoryImpl(this._localFile);


  @override
  Future<int> getTimer() async{
    try {
      final file = _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0.
      return 0;
    }
  }

  @override
  Future<void> saveTimer(int timer) async{
    final file = _localFile;

    // Write the file.
    return file.writeAsString(timer.toString());
  }

}
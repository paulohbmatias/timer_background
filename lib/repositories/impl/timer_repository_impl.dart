import 'dart:io';

import 'package:timer_background/repositories/timer_repository.dart';

class TimerRepositoryImpl implements TimerRepository{

  final File _localFile;

  TimerRepositoryImpl(this._localFile);


  @override
  Future<int> getTimer() async{
    try {
      // Read the file.
      String contents = await _localFile.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0.
      return 0;
    }
  }

  @override
  void saveTimer(int timer){
    // Write the file.
    _localFile.writeAsString(timer.toString());
  }

  @override
  Future<void> clearTime() async{
    await _localFile.delete();
  }

}
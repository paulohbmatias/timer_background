import 'dart:io';

abstract class TimerRepository{
  final File _localFile;
  TimerRepository(this._localFile);
  void saveTimer(int timer);
  Future<int> getTimer();
  Future<void> clearTime();
}
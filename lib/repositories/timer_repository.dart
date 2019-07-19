import 'dart:io';

abstract class TimerRepository{
  final File _localFile;
  TimerRepository(this._localFile);
  Future<void> saveTimer(int timer);
  Future<int> getTimer();
}
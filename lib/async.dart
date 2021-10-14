
import 'dart:io';

void main(){
  performTask();
}

void performTask(){
  task1();
  task2();
  task3();
}

void task1(){
  String result = "Task 1 Data";
  print('Task 1 Done');
}

void task2(){
  Duration threeSeconds = Duration(seconds: 3);
  sleep(threeSeconds);
  String result = "Task 2 Data";
  print('Task 2 Done');
}

void task3(){
  String result = "Task 3 Data";
  print('Task 3 Done');
}

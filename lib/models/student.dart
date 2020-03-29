import 'dart:convert';

class Student{
  int id;
  int age;
  double rewards;
  Map<int,String> grade;
  String name;
  String parentName;
  String classTeacher;
  String bloodGroup;
  String dateOfBirth;

  Student fromMap(String value){
    var studentjson = jsonDecode(value);
    Student student=Student();
    student.id=studentjson['id'];
    student.name=studentjson['name'];
    student.parentName=studentjson['parentName'];
    student.classTeacher=studentjson['classTeacher'];
    student.grade=studentjson['grade'];
    student.bloodGroup=studentjson['bloodGroup'];
    student.dateOfBirth=studentjson['dateOfBirth'];
    student.age=studentjson['age'];
    student.rewards=studentjson['rewards'];
    return student;
  }
}
class Student {
  int id;
  int studentId;
  int age;
  double rewards;
  Map<int, String> grade;
  String name;
  String parentName;
  String classTeacher;
  String bloodGroup;
  String dateOfBirth;
  String photoUrl;

  Student(
      this.id,
      this.studentId,
      this.name,
      this.parentName,
      this.classTeacher,
      this.grade,
      this.bloodGroup,
      this.dateOfBirth,
      this.photoUrl);

  factory Student.fromMap(Map<String, dynamic> value) {
    // print(value.toString());
    Student student = Student(
        value['id'],
        value['studentId'],
        value['name'],
        value['parentName'],
        value['classTeacher'],
        value['grade'],
        value['bloodGroup'],
        value['dateOfBirth'],
        value['photoUrl']);
    // student.id=value['id'];
    // student.id=value['student_id'];
    // student.name=value['name'];
    // //student.parentName=value['parentName'];
    // //student.classTeacher=value['classTeacher'];
    // //student.grade=value['grade'];
    // student.dateOfBirth=value['date_of_birth'];
    // student.bloodGroup=value['blood_group'];
    // //student.age=value['age'];
    // //student.rewards=value['rewards'];
    // student.photoUrl=value['photo_url'];
    return student;
  }
}

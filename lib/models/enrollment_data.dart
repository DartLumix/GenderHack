class EnrollmentData {
  final String academicYear;
  final String region;
  final String gender;
  final String courseType;
  final int enrolled;

  EnrollmentData({
    required this.academicYear,
    required this.region,
    required this.gender,
    required this.courseType,
    required this.enrolled,
  });

  factory EnrollmentData.fromJson(Map<String, dynamic> json) {
    return EnrollmentData(
      academicYear: json['ANNO'] as String,
      region: json['AteneoREGIONE'] as String,
      gender: json['Genere'] as String,
      courseType: json['CorsoTIPO'] as String,
      enrolled: json['ISC'] as int,
    );
  }
}
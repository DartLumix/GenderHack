/// Represents enrollment data for university courses.
class EnrollmentData {
  /// The academic year of the enrollment record.
  final String academicYear;

  /// The region where the university is located.
  final String region;

  /// The gender of the students enrolled.
  final String gender;

  /// The type of course (e.g., Bachelor, Master).
  final String courseType;

  /// The faculty or field of study.
  final String facoulty;

  /// The number of students enrolled.
  final int enrolled;

  /// Creates an [EnrollmentData] instance.
  ///
  /// * [academicYear]: The academic year.
  /// * [region]: The region.
  /// * [gender]: The gender.
  /// * [courseType]: The course type.
  /// * [facoulty]: The faculty.
  /// * [enrolled]: The enrollment count.
  EnrollmentData({
    required this.academicYear,
    required this.region,
    required this.gender,
    required this.courseType,
    required this.facoulty,
    required this.enrolled,
  });

  /// Creates an [EnrollmentData] instance from a JSON map.
  ///
  /// Expects keys: 'ANNO', 'AteneoREGIONE', 'Genere', 'CorsoTIPO', 'DESC_FoET2013', 'ISC'.
  factory EnrollmentData.fromJson(Map<String, dynamic> json) {
    return EnrollmentData(
      academicYear: json['ANNO'] as String,
      region: json['AteneoREGIONE'] as String,
      gender: json['Genere'] as String,
      courseType: json['CorsoTIPO'] as String,
      facoulty: json['DESC_FoET2013'] as String,
      enrolled: json['ISC'] as int,
    );
  }
}

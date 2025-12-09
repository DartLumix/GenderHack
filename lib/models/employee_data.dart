class EmployeeData {
  final String department;
  final String gender;
  final String sector;
  final num count;

  EmployeeData({
    required this.department,
    required this.gender,
    required this.sector,
    required this.count,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      department: json['Discipline scientifiche'] as String,
      gender: json['Sesso'] as String,
      sector: json['Settore istituzionale'] as String,
      count: json['Osservazione'] as num,
    );
  }

  String getProperty(String propertyName) {
    if (propertyName == 'department') return department;
    return '';
  }
}
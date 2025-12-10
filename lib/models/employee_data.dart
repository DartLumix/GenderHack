/// Represents statistical data about employees in a specific department and sector.
class EmployeeData {
  /// The name of the scientific discipline or department.
  final String department;

  /// The gender category of the employees.
  final String gender;

  /// The institutional sector (e.g., Public, Private).
  final String sector;

  /// The count of employees matching the criteria.
  final num count;

  /// Creates an [EmployeeData] instance.
  ///
  /// * [department]: The scientific discipline.
  /// * [gender]: The gender.
  /// * [sector]: The institutional sector.
  /// * [count]: The number of employees.
  EmployeeData({
    required this.department,
    required this.gender,
    required this.sector,
    required this.count,
  });

  /// Creates an [EmployeeData] instance from a JSON map.
  ///
  /// Expects keys: 'Discipline scientifiche', 'Sesso', 'Settore istituzionale', 'Osservazione'.
  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      department: json['Discipline scientifiche'] as String,
      gender: json['Sesso'] as String,
      sector: json['Settore istituzionale'] as String,
      count: json['Osservazione'] as num,
    );
  }

  /// Retrieves a property value by its name.
  ///
  /// * [propertyName]: The name of the property to retrieve (currently supports 'department').
  ///
  /// Returns the property value as a string, or an empty string if not found.
  String getProperty(String propertyName) {
    if (propertyName == 'department') return department;
    return '';
  }
}

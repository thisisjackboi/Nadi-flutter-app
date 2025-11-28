enum Language {
  ENGLISH,
  ASSAMESE
}

enum GrievanceStatus {
  SUBMITTED,
  IN_REVIEW,
  ASSIGNED,
  RESOLVED
}

enum GrievanceCategory {
  ROADS,
  ELECTRICITY,
  WATER,
  SANITATION,
  CORRUPTION,
  OTHER
}

class User {
  final String phoneNumber;
  final bool isVerified;
  final String? aadhaarNumber;
  final String? name;

  User({
    required this.phoneNumber,
    required this.isVerified,
    this.aadhaarNumber,
    this.name,
  });
}

class GrievanceUpdate {
  final String date;
  final String title;
  final String description;
  final String author;

  GrievanceUpdate({
    required this.date,
    required this.title,
    required this.description,
    required this.author,
  });
}

class Grievance {
  final String id;
  final String title;
  final String description;
  final GrievanceCategory category;
  final String location;
  final GrievanceStatus status;
  final String dateSubmitted;
  final String? imageUrl;
  final bool isAnonymous;
  final List<GrievanceUpdate> updates;

  Grievance({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.status,
    required this.dateSubmitted,
    this.imageUrl,
    required this.isAnonymous,
    required this.updates,
  });
}

enum ScreenName {
  SPLASH,
  LOGIN_LANG,
  LOGIN,
  DASHBOARD,
  ALL_GRIEVANCES,
  SUBMIT,
  GRIEVANCE_DETAIL,
  PROFILE
}

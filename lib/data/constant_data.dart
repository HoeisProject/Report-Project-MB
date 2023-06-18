class ConstantApi {
  ConstantApi._();

  /// Base Url
  // static const String baseUrl = 'http://localhost:8000/api';

  /// https://stackoverflow.com/questions/55785581/socketexception-os-error-connection-refused-errno-111-in-flutter-using-djan
  /// Emulator
  // static const String baseUrl = 'http://10.0.2.2:8000';

  /// GCP
  static const String baseUrl = 'http://34.128.127.133:8000';

  static const String api = '/api';

  /// Receive Timeout
  static const Duration receiveTimeout = Duration(seconds: 10);

  /// Conection Timeout
  static const Duration connectionTimeout = Duration(seconds: 10);
}

class EndPoint {
  /// Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String logout = '/logout';
  static const String currentUser = '/current-user';

  /// Dev Tools
  static const String ping = '/ping';
  static const String pingAuthorize = '/ping-authorize';

  /// Project
  static const String project = '/project';

  /// Report
  static const String report = '/report';

  /// Report Media
  static const String reportMedia = '/report-media';

  /// Report Status
  static const String reportStatus = '/report-status';

  /// Role
  static const String role = '/role';

  /// User
  static const String user = '/user';
  static const String userVerify = '/user-verify';
  static const String userUpdateProperties = '/user/update-properties';

  /// Project Priority
  static const String projectPriority = '/project-priority';
  static const String projectPriorityCalculate = '$projectPriority/calculate';
  static const String projectPriorityTimeSpan = '$projectPriority/time-span';
  static const String projectPriorityMoneyEstimate =
      '$projectPriority/money-estimate';
  static const String projectPriorityManpower = '$projectPriority/manpower';
  static const String projectPriorityMaterialFeasibility =
      '$projectPriority/material-feasibility';

  static const Map<String, String> pro = {};
}

class ConstantApi {
  ConstantApi._();

  /// Base Url
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  /// Receive Timeout
  static const Duration receiveTimeout = Duration(seconds: 10);

  /// Conection Timeout
  static const Duration connectionTimeout = Duration(seconds: 10);
}

class ConstantEndPoint {
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
}

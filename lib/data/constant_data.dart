class ConstantApi {
  ConstantApi._();

  /// Base Url
  // static const String baseUrl = 'http://localhost:8000/api';

  /// https://stackoverflow.com/questions/55785581/socketexception-os-error-connection-refused-errno-111-in-flutter-using-djan
  static const String baseUrl = 'http://10.0.2.2:8000'; // Only Work On AVD
  // static const String baseUrl = 'http://192.168.1.5:8000'; // Only Work On AVD
  // static const String baseUrl = '192.168.1.5'; // Only Work On AVD

  static const String api = '/api';

  static const String baseUrlImage = 'http://localhost:8000';

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
}

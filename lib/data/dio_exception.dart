class DioException implements Exception {
  late String message;

  DioException.fromDioError(DioException dioException) {
    // switch (dioException.) {
    //   case DioExceptionType.cancel:
    //     message = "Request to API server was cancelled";
    //     break;
    //   case DioExceptionType.connectionTimeout:
    //     message = "Connection timeout with API server";
    //     break;
    //   case DioExceptionType.receiveTimeout:
    //     message = "Receive timeout in connection with API server";
    //     break;
    //   case DioExceptionType.badResponse:
    //     message = _handleError(
    //       dioException.response?.statusCode,
    //       dioException.response?.data,
    //     );
    //     break;
    //   case DioExceptionType.sendTimeout:
    //     message = "Send timeout in connection with API server";
    //     break;
    //   case DioException.unknown:
    //     if (dioException.message!.contains("SocketException")) {
    //       message = 'No Internet';
    //       break;
    //     }
    //     message = "Unexpected error occurred";
    //     break;
    //   default:
    //     message = "Something went wrong";
    //     break;
    // }
  }

  // String _handleError(int? statusCode, dynamic error) {
  //   switch (statusCode) {
  //     /// jwt missing / jwt malformed
  //     case 400:
  //       return 'Bad request';

  //     /// Invalid / Expire jwt
  //     case 401:
  //       return 'Unauthorized';
  //     case 403:
  //       return 'Forbidden';
  //     case 404:
  //       return error['message'];
  //     case 500:
  //       return 'Internal server error';
  //     // case 502:
  //     //   return 'Bad gateway';
  //     default:
  //       return 'Oops something went wrong';
  //   }
  // }

  @override
  String toString() => message;
}

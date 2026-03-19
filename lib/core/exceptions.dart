abstract interface class AppException implements Exception {
  final String message;

  AppException({required this.message});
}

class DeviceExcepiton implements AppException {
  @override
  final String message;

  DeviceExcepiton({required this.message});
}

class DataException implements AppException {
  @override
  final String message;

  DataException({required this.message});
}

class AuthException implements AppException {
  @override
  final String message;
  AuthException({required this.message});
}

class ServerException implements AppException {
  @override
  final String message;

  ServerException({required this.message});

  @override
  String toString() => 'ServerException(message: $message)';
}

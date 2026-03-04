abstract interface class AppException implements Exception {
  final String message;

  AppException({required this.message});
}

class DeviceExcepiton implements AppException {
  @override
  final String message;

  DeviceExcepiton({required this.message});
}

class ServerException implements AppException {
  @override
  final String message;

  ServerException({required this.message});
}

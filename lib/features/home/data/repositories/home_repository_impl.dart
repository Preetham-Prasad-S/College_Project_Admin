import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/exceptions.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/services/service.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource.dart';
import 'package:staff_app/features/home/domain/entities/college_location.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';
import 'package:staff_app/features/home/domain/entities/staff_status.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource dataSource;
  final LocationService locationService;

  HomeRepositoryImpl({required this.dataSource, required this.locationService});
  @override
  Stream<Either<AppFailure, CollegeLocation>> currentLocation() async* {
    try {
      final locationStream = locationService.getCurrentLocation();

      yield* locationStream.map((position) {
        return right(CollegeLocation.fromService(position));
      });
    } on DeviceExcepiton catch (e) {
      yield left(AppFailure(message: e.message));
    }
  }

  @override
  Future<Either<AppFailure, CollegeLocation>> getCollegeLocation() async {
    try {
      final collegeLocation = await dataSource.getCollegeLocation();

      return right(CollegeLocation.fromModel(collegeLocation));
    } on ServerException catch (e) {
      return left(AppFailure(message: e.message));
    }
  }

  @override
  Future<Either<AppFailure, StaffShift>> getStaffShift() async {
    try {
      final staffShit = await dataSource.getStaffShift();

      print(staffShit);

      return right(StaffShift.fromeModel(staffShit));
    } on ServerException catch (e) {
      return left(AppFailure(message: e.message));
    }
  }

  @override
  Future<Either<AppFailure, StaffStatus>> getStaffStatus() {
    // TODO: implement getStaffStatus
    throw UnimplementedError();
  }
}

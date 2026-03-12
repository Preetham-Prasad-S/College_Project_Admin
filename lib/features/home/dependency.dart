import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/services/geolocator_service.dart';
import 'package:staff_app/core/services/service.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource_impl.dart';
import 'package:staff_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';
import 'package:staff_app/features/home/domain/usescases/get_staff_attendance_status_usecase.dart';
import 'package:staff_app/features/home/domain/usescases/get_staff_location_usecase.dart';
import 'package:staff_app/features/home/domain/usescases/get_staff_shift_usecase.dart';
import 'package:staff_app/features/home/domain/usescases/get_attendance_percentage_usecase.dart';
import 'package:staff_app/features/home/domain/usescases/set_staff_attendance_status_usecase.dart';
import 'package:staff_app/features/home/presentation/controllers/staff_attendance_status_controller.dart';
import 'package:staff_app/features/home/presentation/controllers/staff_location_controller.dart';
import 'package:staff_app/features/home/presentation/controllers/staff_shift_controller.dart';
import 'package:staff_app/features/home/presentation/controllers/states/location_state.dart';
import 'package:staff_app/features/home/presentation/controllers/states/staff_status_state.dart';

final firebaseStoreageInstanceProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final homeDatasourceProvider = Provider<HomeDatasource>(
  (ref) => HomeDatasourceImpl(
    firebaseInstance: ref.read(firebaseStoreageInstanceProvider),
  ),
);

final geolocatorServiceProivder = Provider<LocationService>(
  (ref) => GeolocatorService(),
);

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepositoryImpl(
    dataSource: ref.read(homeDatasourceProvider),
    locationService: ref.read(geolocatorServiceProivder),
  ),
);

final getStaffShiftUsecaseProvider = Provider<GetStaffShiftUsecase>(
  (ref) => GetStaffShiftUsecase(repository: ref.read(homeRepositoryProvider)),
);

final getStaffShiftControllerProvider =
    AsyncNotifierProvider<StaffShiftController, AsyncValue<StaffShift>>(
      () => StaffShiftController(),
    );

final getStaffLocationUsecaseProvider = Provider(
  (ref) =>
      GetStaffLocationUsecase(repository: ref.read(homeRepositoryProvider)),
);

final staffAttendanceStatusControllerProvider =
    AsyncNotifierProvider<StaffAttendanceStatusController, StaffStatusState>(
      () => StaffAttendanceStatusController(),
    );

final staffLocationControllerProvider =
    StreamNotifierProvider.autoDispose<StaffLocationController, LocationState>(
      () => StaffLocationController(),
    );

final getStaffAttendanceStatusUsecaseProvider = Provider(
  (ref) => GetStaffAttendanceStatusUsecase(
    repository: ref.read(homeRepositoryProvider),
  ),
);

final setStaffAttendanceStatusUsecaseProvider = Provider(
  (ref) => SetStaffAttendanceStatusUsecase(
    repository: ref.read(homeRepositoryProvider),
  ),
);

final getWorkingDaysUsecaseProvider = Provider(
  (ref) => GetAttendancePercentageUsecase(
    repository: ref.read(homeRepositoryProvider),
  ),
);

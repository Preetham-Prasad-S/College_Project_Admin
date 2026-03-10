import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/services/geolocator_service.dart';
import 'package:staff_app/core/services/service.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource_impl.dart';
import 'package:staff_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:staff_app/features/home/domain/entities/attendance.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';
import 'package:staff_app/features/home/domain/usescases/attendance_entry_usecase.dart';
import 'package:staff_app/features/home/domain/usescases/get_staff_shift_usecase.dart';
import 'package:staff_app/features/home/presentation/controllers/attendance_entry_controller.dart';
import 'package:staff_app/features/home/presentation/controllers/staff_shift_controller.dart';

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

final attendanceEntryUsecaseProvider = Provider<AttendanceEntryUsecase>(
  (ref) => AttendanceEntryUsecase(repository: ref.read(homeRepositoryProvider)),
);

final getStaffShiftUsecaseProvider = Provider<GetStaffShiftUsecase>(
  (ref) => GetStaffShiftUsecase(repository: ref.read(homeRepositoryProvider)),
);

final getstaffShiftProvider =
    AsyncNotifierProvider<StaffShiftController, AsyncValue<StaffShift>>(
      () => StaffShiftController(),
    );

final attendanceEntryControllerProvider =
    StreamNotifierProvider.autoDispose<
      AttendanceEntryController,
      AsyncValue<Attendance>
    >(AttendanceEntryController.new);

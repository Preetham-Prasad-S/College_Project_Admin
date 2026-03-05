import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/features/home/dependency.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a = ref.watch(attendanceEntryControllerProvider);

    return Scaffold(
      body: Center(
        child: a.when(
          data: (data) => Text("${data.value?.inPremises}"),
          error: (error, stackTrace) => Text("$error"),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RideBookingProgress extends ConsumerWidget {
  const RideBookingProgress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(loading).when(data: (bool data) {
      return const ConfirmedBookingView();
    }, error: (Object error, StackTrace stackTrace) {
      return const Text("ERRR");
    }, loading: () {
      return Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel)),
          const CircularProgressIndicator.adaptive(),
          const Text("Matching you to an available driver....")
        ],
      ));
    });
  }
}

final loading = FutureProvider<bool>((ref) async {
  return await Future.delayed(const Duration(seconds: 2), () => true);
});

class ConfirmedBookingView extends StatelessWidget {
  const ConfirmedBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context)
                ..pop()
                ..pop()
                ..pop();
            },
            icon: const Icon(Icons.abc)),
        const Text("Booking Confirmed")
      ],
    ));
  }
}

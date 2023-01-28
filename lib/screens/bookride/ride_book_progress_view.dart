import 'package:egov/shared/utils/resources/colors.dart';
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
          Center(
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel)),
          ),
          const Center(child: CircularProgressIndicator.adaptive()),
          const Center(child: Text("Matching you to an available driver...."))
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
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                ..pop(true)
                ..pop(true)
                ..pop(true);
            },
            child: Container(
                height: 100,
                width: 100,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: primaryColor),
                child: const Icon(
                  Icons.done_rounded,
                  color: Colors.white,
                  size: 50,
                )),
          ),
        ),
        const Center(child: Text("Booking Confirmed"))
      ],
    ));
  }
}

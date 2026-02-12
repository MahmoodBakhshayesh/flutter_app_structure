import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../view_states/passenger_details_view_state.dart';

class PassengerDetailsView extends ConsumerWidget {
  final int passengerId;

  const PassengerDetailsView({super.key, required this.passengerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(passengerDetailsNotifierProvider(passengerId));
    final viewNotifier = ref.read(passengerDetailsNotifierProvider(passengerId).notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Details'),
      ),
      body: switch (viewState) {
        AsyncData(:final value) => Column(
          children: [
            GestureDetector(
                onTap: (){
                  viewNotifier.setMsg("${value.status}"+"${value.status.length}");
                },
                child: Text('${value.status}')),
            if (value.person != null) ...[
              Text('Name: ${value.person!.name}'),
              Text('Passport: ${value.person!.passportNo}'),
              Text('Nationality: ${value.person!.nationality}'),
            ] else
              const Text('Passenger not loaded'),
          ],
        ),
        AsyncError(:final error) => Center(child: Text('Error: $error')),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

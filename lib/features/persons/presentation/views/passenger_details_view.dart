import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpodfuckaround/core/interfaces/api_state.dart';
import '../../domain/entities/person.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              ref.refresh(passengerDetailsNotifierProvider(passengerId));
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: switch (viewState) {
        AsyncData(:final value) =>
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    viewNotifier.setMsg("${value.status}${value.status.length}");
                  },
                  child: Text(value.status),
                ),
                value.person.when(successBuilder: (Person? data) {
                  return Column(children: [
                    Text('Name: ${value.person.data?.name}'),
                    Text('Passport: ${value.person.data?.passportNo}'),
                    Text('Nationality: ${value.person.data?.nationality}'),
                  ],);
                },loadingBuilder: ()=>Text("llllllooooooooooding "),
                errorBuilder: (f)=>Text("error ${f}"),),

                Divider(),
                value.someOtherData.when(successBuilder: (String? data) {
                  return Column(children: [
                    Text('some other data: ${data}'),
                  ],);
                },loadingBuilder: ()=>Text("loading some other data "),
                  errorBuilder: (f)=>Text("error ${f}"),),
                // if (value.person.isOk) ...[
                //   Text('Name: ${value.person.data?.name}'),
                //   Text('Passport: ${value.person.data?.passportNo}'),
                //   Text('Nationality: ${value.person.data?.nationality}'),
                // ] else
                //   const Text('Passenger not loaded'),

                TextButton(
                  onPressed: () {
                    String? asd;
                    log(asd!);
                  },
                  child: Text("Test1"),
                ),
              ],
            ),
        AsyncError(:final error) => Center(child: Text('Error: $error')),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

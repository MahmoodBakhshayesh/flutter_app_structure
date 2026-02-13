import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/person.dart';
import '../view_states/passengers_view_state.dart';

class PassengersView extends StatelessWidget {
  const PassengersView({super.key});

  @override
  Widget build(BuildContext context) {
    return _PassengersView();
  }
}

class _PassengersView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(passengersNotifierProvider);
    final viewStateNotifier = ref.read(passengersNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Passengers List"),
        actions: [
          IconButton(
            onPressed: () {
              viewStateNotifier.refresh();
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              viewStateNotifier.setMsg("Updated!");
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded( 
            child: switch (viewState) {
              AsyncLoading() => const Center(child: CircularProgressIndicator()),
              AsyncData(:final value) => Column(
                children: [
                  Text(value.text),
                  Expanded(
                    child: PeopleList(
                      people: value.people,
                    ),
                  ),
                ],
              ),
              AsyncError(:final error) => Center(child: Text("Error: $error")),
              _ => const SizedBox(),
            },
          ),
        ],
      ),
    );
  }
}

class PeopleList extends StatelessWidget {
  final List<Person> people;

  const PeopleList({super.key, required this.people});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: people.length,
      itemBuilder: (c, i) => ListTile(
        title: Text(people[i].name),
        onTap: () {
          // Use goNamed instead of pushNamed to ensure URL updates correctly
          // and navigation stack is managed by GoRouter's declarative structure
          context.goNamed(

            "passenger_details",
            pathParameters: {'id': people[i].id.toString()},
          );
        },
      ),
    );
  }
}

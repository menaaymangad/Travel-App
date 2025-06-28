import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/public_transport.dart';
import '../cubit/public_transport_cubit.dart';
import '../cubit/public_transport_state.dart';
import 'package:travelapp/core/di/injection_container.dart';

class PublicTransportPage extends StatelessWidget {
  const PublicTransportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PublicTransportCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('City Transportation')),
        body: BlocBuilder<PublicTransportCubit, PublicTransportState>(
          builder: (context, state) {
            if (state is PublicTransportLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PublicTransportLoaded) {
              if (state.transports.isEmpty) {
                return const Center(
                    child: Text('No public transport info found.'));
              }
              return ListView.builder(
                itemCount: state.transports.length,
                itemBuilder: (context, index) {
                  final transport = state.transports[index];
                  return _buildTransportCard(context, transport);
                },
              );
            } else if (state is PublicTransportError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildTransportCard(BuildContext context, PublicTransport transport) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 3,
      child: ListTile(
        title: Text('${transport.type}: ${transport.name}'),
        subtitle: Text(
            '${transport.city} | ${transport.schedule}\n${transport.description}'),
        trailing: Text('${transport.price.toStringAsFixed(2)} EGP'),
      ),
    );
  }
}

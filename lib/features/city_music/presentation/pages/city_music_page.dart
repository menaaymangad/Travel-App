import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/music.dart';
import '../cubit/music_cubit.dart';
import '../cubit/music_state.dart';
import 'package:travelapp/core/di/injection_container.dart';

class CityMusicPage extends StatelessWidget {
  const CityMusicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MusicCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('City Music')),
        body: BlocBuilder<MusicCubit, MusicState>(
          builder: (context, state) {
            if (state is MusicLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MusicLoaded) {
              if (state.musics.isEmpty) {
                return const Center(child: Text('No music found.'));
              }
              return ListView.builder(
                itemCount: state.musics.length,
                itemBuilder: (context, index) {
                  final music = state.musics[index];
                  return _buildMusicCard(context, music);
                },
              );
            } else if (state is MusicError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildMusicCard(BuildContext context, Music music) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 3,
      child: ListTile(
        leading: Image.network(music.coverImage,
            width: 60, height: 60, fit: BoxFit.cover),
        title: Text(music.title),
        subtitle: Text('${music.artist} • ${music.city}'),
        trailing: IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () {
            // Integrate audio player here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Playing: ${music.title}')),
            );
          },
        ),
      ),
    );
  }
}

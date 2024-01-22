import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/models/spotify_playlist.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_bloc/playlist_bloc.dart';
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_bloc/playlist_event.dart';
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_bloc/playlist_state.dart';
import 'package:saro/features/spotify/spotify_playlist/widgets/playlist_tile.dart';

class SpotifyPlaylistView extends StatefulWidget {
  const SpotifyPlaylistView({super.key});

  @override
  State<SpotifyPlaylistView> createState() => _SpotifyPlaylistViewState();
}

class _SpotifyPlaylistViewState extends State<SpotifyPlaylistView> {
  loadMoreData() {
    context.read<SpotifyPlaylistBloc>().add(FetchPlaylistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpotifyPlaylistBloc, SpotifyPlaylistState>(
      builder: (context, state) {
        if (state.failureMsg != null) {
          return Center(
            child: Text(
              state.failureMsg!,
            ),
          );
        } else if (state.isListEmpty) {
          return const Center(
            child: Text(
              "Playlist is empty.",
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                loadMoreData();
                return true;
              }
              return false;
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:
                  state.spotifyPlaylist.length + (state.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < state.spotifyPlaylist.length) {
                  SpotifyPlaylistItem currentItem =
                      state.spotifyPlaylist[index];
                  return PlayListTile(
                    playlistItem: currentItem,
                  );
                } else {
                  return const LoadingIndicator(
                    height: 75,
                    width: 75,
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}

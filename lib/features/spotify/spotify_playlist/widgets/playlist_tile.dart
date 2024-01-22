import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/models/spotify_playlist.dart';
import 'package:saro/core/models/spotify_searched_track.dart';
import 'package:saro/core/ui/widgets/loading_indicator.dart';
import 'package:saro/features/spotify/search_track/widget/track_tile.dart';
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_track_bloc/spotify_playlist_tracks_bloc.dart';
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_track_bloc/spotify_playlist_tracks_event.dart';
import 'package:saro/features/spotify/spotify_playlist/bloc/playlist_track_bloc/spotify_playlist_tracks_state.dart';
import 'package:saro/resources/assets.gen.dart';

class PlayListTile extends StatefulWidget {
  const PlayListTile({
    super.key,
    this.playlistItem,
  });
  final SpotifyPlaylistItem? playlistItem;

  @override
  State<PlayListTile> createState() => _PlayListTileState();
}

class _PlayListTileState extends State<PlayListTile> {
  final iconSize = 40.0;

  late final SpotifyPlaylistTracksBloc playlistTrackBloc =
      get<SpotifyPlaylistTracksBloc>(param1: widget.playlistItem!.id);

  loadMoreData() {
    playlistTrackBloc.add(FetchPlaylistTrackEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Row(
        children: [
          Assets.icons.saroSpotifyPlayList.svg(
            height: iconSize,
            width: iconSize,
          ),
          7.5.hSizedBox,
          Text(
            widget.playlistItem?.name ?? "",
            style: context.labelMedium,
          ),
        ],
      ),
      children: [
        SizedBox(
          height: 100,
          child: BlocProvider.value(
            value: playlistTrackBloc..add(FetchPlaylistTrackEvent()),
            child: BlocBuilder<SpotifyPlaylistTracksBloc,
                SpotifyPlaylistTrackState>(
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
                      itemCount: state.spotifyPlaylistTracks.length +
                          (state.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < state.spotifyPlaylistTracks.length) {
                          SpotifySearchedTrack trackSearchResult =
                              state.spotifyPlaylistTracks[index];
                          return TrackTile(
                            track: trackSearchResult,
                          );
                        } else {
                          return const LoadingIndicator(
                            height: 35,
                            width: 35,
                          );
                        }
                      },
                    ),
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}

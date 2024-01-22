import 'package:injectable/injectable.dart';
import 'package:audioplayers/audioplayers.dart';

@singleton
class AudioService {
  AudioPlayer player = AudioPlayer();
  bool _isPlaying = false;

  // Play audio from URL
  void play(String url) async {
    // check if audio player is disposed, if then assign it with new one
    if (player.state == PlayerState.disposed) {
      player = AudioPlayer(); // Create a new player if disposed
    }
    await player.play(UrlSource(url));
    _isPlaying = true;
  }

  // Pause audio playback
  void pause() async {
    await player.pause();
    _isPlaying = false;
  }

  // Resume audio playback
  void resume() async {
    await player.resume();
    _isPlaying = true;
  }

  // Stop audio playback and reset
  void stop() async {
    await player.stop();
    await player.dispose();
    _isPlaying = false;
  }

  // Check if audio is playing
  bool isPlaying() {
    return _isPlaying;
  }

  // Dispose the audio player when no longer needed
  void dispose() {
    player.dispose();
  }
}

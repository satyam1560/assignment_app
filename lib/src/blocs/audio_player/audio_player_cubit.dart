import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayer _audioPlayer;

  AudioPlayerCubit({
    required AudioPlayer audioPlayer,
  })  : _audioPlayer = audioPlayer,
        super(AudioPlayerState.initial());

  void initAudioPlayer() async {
    emit(
      state.copyWith(
        duration: await _audioPlayer.getDuration(),
      ),
    );

    _audioPlayer.onDurationChanged.listen((d) {
      emit(
        state.copyWith(duration: d),
      );
    });

    _audioPlayer.onPositionChanged.listen((p) {
      emit(
        state.copyWith(position: p),
      );
    });
  }

  void slider(int second) {
    Duration newDuration = Duration(seconds: second);
    _audioPlayer.seek(newDuration);
    emit(
      state.copyWith(position: newDuration),
    );
  }

  Future<void> playAudioFromAsset({
    required String audioPath,
  }) async {
    await _audioPlayer.play(AssetSource(audioPath));
    emit(
      state.copyWith(
        status: AudioPlayerStatus.playing,
        duration: await _audioPlayer.getDuration(),
      ),
    );
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
    emit(
      state.copyWith(status: AudioPlayerStatus.paused),
    );
  }

  Future<void> resumeAudio() async {
    await _audioPlayer.resume();
    emit(
      state.copyWith(status: AudioPlayerStatus.playing),
    );
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    emit(
      state.copyWith(status: AudioPlayerStatus.initial),
    );
  }
}

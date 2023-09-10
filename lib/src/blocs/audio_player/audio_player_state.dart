part of 'audio_player_cubit.dart';

enum AudioPlayerStatus { initial, playing, paused }

class AudioPlayerState extends Equatable {
  const AudioPlayerState({
    this.status = AudioPlayerStatus.initial,
    this.duration = const Duration(),
    this.position = const Duration(),
  });

  factory AudioPlayerState.initial() {
    return const AudioPlayerState();
  }

  final AudioPlayerStatus status;
  final Duration duration;
  final Duration position;

  @override
  List<Object> get props => [
        status,
        duration,
        position,
      ];

  AudioPlayerState copyWith({
    AudioPlayerStatus? status,
    Duration? duration,
    Duration? position,
  }) {
    return AudioPlayerState(
      status: status ?? this.status,
      duration: duration ?? this.duration,
      position: position ?? this.position,
    );
  }

  @override
  bool get stringify => true;
}

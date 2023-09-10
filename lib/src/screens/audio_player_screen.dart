import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/blocs/blocs.dart';
import '/src/core/core.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  AudioPlayerScreenState createState() => AudioPlayerScreenState();
}

class AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final _audioPlayerCubit = serviceLocator<AudioPlayerCubit>();

  @override
  void initState() {
    _audioPlayerCubit.initAudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayerCubit.pauseAudio();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'Audio Player',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
        bloc: _audioPlayerCubit,
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 220.0,
                  width: 220.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/cover.jpg'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Slider(
                  activeColor: Colors.blue,
                  inactiveColor: Colors.deepOrange,
                  min: 0.0,
                  max: state.duration.inSeconds.toDouble(),
                  value: state.position.inSeconds.toDouble(),
                  onChanged: (value) {
                    _audioPlayerCubit.slider(value.toInt());
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              if (state.status == AudioPlayerStatus.playing ||
                  state.status == AudioPlayerStatus.paused)
                Row(
                  children: [
                    const SizedBox(width: 20.0),
                    Text(
                      '${state.position.inMinutes}'
                      ':${state.position.inSeconds.remainder(60)}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${state.duration.inMinutes}'
                      ':${state.duration.inSeconds.remainder(60)}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(width: 20.0),
                  ],
                ),
              const SizedBox(height: 20),
              Center(
                child: IconButton(
                  iconSize: 50.0,
                  icon: state.status == AudioPlayerStatus.playing
                      ? const Icon(
                          Icons.pause,
                          color: Colors.deepOrange,
                        )
                      : const Icon(
                          Icons.play_arrow,
                          color: Colors.deepOrange,
                        ),
                  onPressed: () {
                    if (state.status == AudioPlayerStatus.initial) {
                      _audioPlayerCubit.playAudioFromAsset(
                        audioPath: 'audios/perfect.mp3',
                      );
                    } else if (state.status == AudioPlayerStatus.paused) {
                      _audioPlayerCubit.resumeAudio();
                    } else if (state.status == AudioPlayerStatus.playing) {
                      _audioPlayerCubit.pauseAudio();
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

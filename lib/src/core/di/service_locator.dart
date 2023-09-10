import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '/src/blocs/blocs.dart';
import '/src/datasource/product_datasource.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> setupLocator() async {
  serviceLocator.registerLazySingleton(
    () => ProductDatasource(
      dio: Dio(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => ProductBloc(
      productDatasource: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AudioPlayerCubit(
      audioPlayer: AudioPlayer(),
    ),
  );
}

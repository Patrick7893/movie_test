import 'package:movies_test/blocs/movies_bloc.dart';
import 'package:movies_test/blocs/settings_bloc.dart';

class BlocProvider {
  final moviesBloc = MoviesBloc();
  final settingsBloc = SettingsBloc();

  static final instance = BlocProvider._internal();

  BlocProvider._internal() {
    settingsBloc.settings.pipe(moviesBloc.settingsSink);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:saro/app/theme_cubit/theme_state.dart';
import 'package:saro/core/models/dark_mode.dart';

import 'package:saro/core/services/database_service.dart';

@injectable
class ThemeCubit extends Cubit<ThemeState> {
  LocalDatabaseService databaseService;

  ThemeCubit(this.databaseService)
      : super(databaseService.getAppThemeStateValue == AppThemeState.light
            ? LightTheme()
            : DarkTheme());

  void toggleAppThemeState(bool changeToDarkTheme) async {
    if (changeToDarkTheme) {
      await databaseService.setAppThemeStateValue(AppThemeState.dark);
      emit(DarkTheme());
    } else {
      await databaseService.setAppThemeStateValue(AppThemeState.light);
      emit(LightTheme());
    }
  }
}

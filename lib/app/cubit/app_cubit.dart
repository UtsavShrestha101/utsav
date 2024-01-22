import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:saro/core/repository/auth_repository.dart';

import 'app_state.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  AppCubit(AuthRepository authRepository)
      : super(
          authRepository.credentials == null
              ? UnAuthenticated()
              : Authenticated(),
        );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saro/app/cubit/app_cubit.dart';
import 'package:saro/app/theme_cubit/theme_cubit.dart';
import 'package:saro/app/theme_cubit/theme_state.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/router/app_router.dart';
import 'package:saro/core/ui/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => get<AppCubit>(),
        ),
        BlocProvider(
          create: (context) => get<ThemeCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            // useInheritedMediaQuery: true,
            // locale: DevicePreview.locale(context),
            // builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            title: 'saro',
            routerConfig: AppRouter.router,

            theme: state is DarkTheme ? AppTheme.dark : AppTheme.light,
          );
        },
      ),
    );
  }
}

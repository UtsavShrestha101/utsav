import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/features/spotify/mini_player/mini_player.dart';
import 'package:saro/features/spotify/audio_player_bloc/bloc/audio_bloc.dart';
import 'package:saro/resources/assets.gen.dart';

import 'app_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.child,
    super.key,
  });

  final Widget child;

  static const _navigationBarIconSize = 50.0;

  static final _navBarItemsData = [
    _NavBarItemData(
      AppRouter.home,
      Assets.icons.saroMail.svg(width: _navigationBarIconSize),
    ),
    _NavBarItemData(
      AppRouter.search,
      Assets.icons.saroSearch.svg(width: _navigationBarIconSize),
    ),
    _NavBarItemData(
        AppRouter.post,
        Assets.icons.saroPaw.svg(
          width: _navigationBarIconSize,
        ),
        darkModeIcon: Assets.icons.saroPaw.svg(
            width: _navigationBarIconSize,
            colorFilter:
                const ColorFilter.mode(Colors.white, BlendMode.srcIn))),
    _NavBarItemData(
      AppRouter.wallet,
      Assets.icons.saroBone.svg(
        width: _navigationBarIconSize,
      ),
    ),
    _NavBarItemData(
      AppRouter.profile,
      Assets.icons.saroHead.svg(width: _navigationBarIconSize),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _navBarItemsData
        .indexWhere((e) => e.route == GoRouterState.of(context).uri.toString());
    Brightness brightness = Theme.of(context).brightness;
    return BlocProvider(
      create: (context) => get<AudioBloc>(),
      child: Scaffold(
        body: child,
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const MiniPlayer(),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1.0, color: AppColors.darkGray))),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: _navBarItemsData
                    .map((e) => BottomNavigationBarItem(
                          icon: brightness == Brightness.light
                              ? e.icon
                              : e.darkModeIcon ?? e.icon,
                          label: '',
                        ))
                    .toList(),
                currentIndex:
                    currentIndex.clamp(0, _navBarItemsData.length).toInt(),
                onTap: (i) => context.go(_navBarItemsData[i].route),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarItemData {
  final String route;
  final Widget icon;
  final Widget? darkModeIcon;
  _NavBarItemData(this.route, this.icon, {this.darkModeIcon});
}

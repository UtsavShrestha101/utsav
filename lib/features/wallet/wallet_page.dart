import 'package:flutter/material.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/ui/colors/app_colors.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/features/notification/bloc/notification/notification_bloc.dart';
import 'package:saro/features/notification/bloc/notification/notification_event.dart';
import 'package:saro/features/wallet/widget/activity_view.dart';
import 'package:saro/features/wallet/widget/balance_card.dart';
import 'package:saro/features/wallet/widget/credit_card_view.dart';

class WalletPage extends StatelessWidget {
  WalletPage({super.key});

  final NotificationBloc _notificationBloc = get<NotificationBloc>()
    ..add(
      LoadNotification(
        "transaction",
      ),
    );

  Future<void> _refresh() async {
    _notificationBloc.add(
      LoadNotification("transaction", refreshList: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              elevation: 0.0,
              pinned: true,
              floating: true,
              expandedHeight: 475,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                      child: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Bones",
                                      style: context.titleLarge,
                                    ),
                                  ),
                                  5.vSizedBox,
                                  const BalanceCard(),
                                  20.vSizedBox,
                                  SizedBox(
                                    width: size.width * 0.85,
                                    child: PrimaryButton(
                                      onPressed: () {},
                                      title: "withdraw",
                                      textStyle: context.titleLarge.copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  2.5.vSizedBox,
                                  const Divider(),
                                  2.5.vSizedBox,
                                  const CreditCardView(),
                                ]),
                          )),
                    ),
                  ],
                );
              }),
            ),
          ],
          body: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 19,
            ),
            height: size.height * 0.5,
            width: size.width,
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Activity",
                    style: context.labelLarge,
                  ),
                  ActivityView(
                    notificationBloc: _notificationBloc,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

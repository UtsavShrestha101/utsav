import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saro/core/di/dependency_injection.dart';
import 'package:saro/core/extensions/context_extension.dart';
import 'package:saro/core/extensions/num_extensions.dart';
import 'package:saro/core/ui/widgets/app_text_field.dart';
import 'package:saro/core/ui/widgets/primary_button.dart';
import 'package:saro/core/utils/form_validators.dart';
import 'package:saro/features/wallet/cubit/card_cubit/card_cubit.dart';
import 'package:saro/features/wallet/cubit/card_cubit/card_state.dart';
import 'package:saro/resources/assets.gen.dart';

class BoneTile extends StatefulWidget {
  final String receiverId;
  final bool? shouldPopOnSend;
  const BoneTile({super.key, required this.receiverId, this.shouldPopOnSend});

  @override
  State<BoneTile> createState() => _BoneTileState();
}

class _BoneTileState extends State<BoneTile> with FormValidators {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool get isFormValid => _formKey.currentState!.validate();
  VoidCallback get clearText => _textController.clear;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<CardCubit>(),
      child: BlocConsumer<CardCubit, CardState>(
        listener: (context, state) {
          if (state.statusMsg != null) {
            context.showSnackBar(state.statusMsg!);
            if (widget.shouldPopOnSend ?? false) context.pop();
          }
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextField(
                      leading: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Assets.icons.saroBone.svg(height: 46, width: 46),
                      ),
                      controller: _textController,
                      labelText: 'Send bone',
                      validator: isStringEmpty,
                      textInputType: TextInputType.number,
                    ),
                    10.vSizedBox,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: PrimaryButton(
                        isLoading: state.isLoading,
                        onPressed: () async {
                          if (isFormValid) {
                            await context.read<CardCubit>().transferAmount(
                                  double.parse(
                                    _textController.text.trim(),
                                  ),
                                  widget.receiverId,
                                );
                            clearText();
                          }
                        },
                        title: "Send",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

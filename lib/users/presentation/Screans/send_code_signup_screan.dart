import 'package:ahlachat/core/localization/Localization.dart';
import 'package:ahlachat/core/services/alerts.dart';
import 'package:ahlachat/core/utils/SharedWidget.dart';
import 'package:ahlachat/core/utils/enums.dart';
import 'package:ahlachat/core/utils/styles.dart';
import 'package:ahlachat/core/utils/validation.dart';
import 'package:ahlachat/users/presentation/components/shared_appbar.dart';
import 'package:ahlachat/users/presentation/components/shared_textformfield.dart';
import 'package:ahlachat/users/presentation/controller/userlogin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendCodeSignUpScrean extends StatelessWidget {
  SendCodeSignUpScrean({super.key});

  final phoneNumberTextField = TextEditingController();
  final passwordTextField = TextEditingController();
  final codeTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        showpop: true,
        tittle: getLang(context: context, key: 'Sign_up'),
      ),
      body: BlocBuilder<UserloginBloc, UserloginState>(
        buildWhen: (previous, current) =>
            previous.SendCodeForSignUpState != current.SendCodeForSignUpState ||
            previous.EnterCodeSignUpState != current.EnterCodeSignUpState ||
            previous.HasSentSignupCode != current.HasSentSignupCode,
        builder: (context, state) {
          final isSending =
              state.SendCodeForSignUpState == RequestState.loading;
          final isVerifying =
              state.EnterCodeSignUpState == RequestState.loading;
          final isBusy = isSending || isVerifying;

          return ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(
              30,
              40,
              30,
              MediaQuery.viewInsetsOf(context).bottom + 24,
            ),
            children: [
              CustomeTextField(
                enable: !isBusy,
                hint: getLang(context: context, key: 'InputNumber'),
                type: TextInputType.phone,
                Controller: phoneNumberTextField,
                obscureText: false,
              ),
              const SizedBox(height: 20),
              CustomeTextField(
                enable: !isVerifying,
                hint: getLang(context: context, key: 'Enter_Code'),
                type: TextInputType.number,
                Controller: codeTextField,
                obscureText: false,
                maxLength: 6,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                SideWidget: IgnorePointer(
                  ignoring: isSending,
                  child: InkWell(
                    onTap: () {
                      if (!validatePhoneNumber(
                          phoneNumber: phoneNumberTextField.text)) {
                        Showtoast(
                            message: getLang(
                                context: context, key: 'Enter_Valid_Phone'));
                        return;
                      }
                      context.read<UserloginBloc>().add(
                            SentCodeForSignupEvent(
                                Phone: phoneNumberTextField.text),
                          );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: MainColor, width: 1),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: isSending
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              getLang(context: context, key: 'Send_Code'),
                              style: StyleTitle,
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomeTextField(
                enable: !isBusy,
                hint: getLang(context: context, key: 'Password'),
                type: TextInputType.visiblePassword,
                Controller: passwordTextField,
                obscureText: true,
              ),
              const SizedBox(height: 36),
              IgnorePointer(
                ignoring: isBusy,
                child: Opacity(
                  opacity: isBusy ? .6 : 1,
                  child: UserSharedButton(
                    Buttontittle: getLang(context: context, key: 'Done'),
                    onClickAction: () {
                      if (!validatePhoneNumber(
                          phoneNumber: phoneNumberTextField.text)) {
                        Showtoast(
                            message: getLang(
                                context: context, key: 'Enter_Valid_Phone'));
                      } else if (!validatePassword(
                          password: passwordTextField.text)) {
                        Showtoast(
                            message: getLang(
                                context: context, key: 'Forget_Length'));
                      } else if (!state.HasSentSignupCode) {
                        Showtoast(
                            message:
                                getLang(context: context, key: 'Send_Code'));
                      } else if (codeTextField.text.length != 6) {
                        Showtoast(
                            message: getLang(
                                context: context, key: 'Correct_Verification'));
                      } else {
                        context.read<UserloginBloc>().add(
                              EnterCodeSignupEvent(
                                Code: codeTextField.text,
                                Password: passwordTextField.text,
                              ),
                            );
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

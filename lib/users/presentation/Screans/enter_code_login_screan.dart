import 'package:ahlachat/core/localization/Localization.dart';
import 'package:ahlachat/core/services/alerts.dart';
import 'package:ahlachat/core/services/services_locator.dart';
import 'package:ahlachat/core/utils/SharedWidget.dart';
import 'package:ahlachat/core/utils/SizeConfig.dart';
import 'package:ahlachat/core/utils/styles.dart';
import 'package:ahlachat/users/presentation/components/shared_appbar.dart';
import 'package:ahlachat/users/presentation/controller/userlogin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:simple_timer/simple_timer.dart';

class EnterCodeLoginScrean extends StatelessWidget {
  TextEditingController Code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        showpop: true,
        tittle: getLang(context: context, key: "Enter_Code"),
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(
          20,
          24,
          20,
          MediaQuery.viewInsetsOf(context).bottom + 24,
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.TenSize! * 2,
                  ),
                  Text(getLang(context: context, key: "Code_Send"),
                      style: StyleTitle),
                  SizedBox(
                    height: SizeConfig.TenSize! * 2,
                  ),
                  BlocBuilder<UserloginBloc, UserloginState>(
                    buildWhen: (previous, current) =>
                        previous.SendCodeState != current.SendCodeState,
                    builder: (context, state) {
                      return PinCodeTextField(
                        // The field previously never requested focus, leaving
                        // the user unable to enter the verification code on
                        // some Android devices. Request it as soon as this
                        // screen is shown so the numeric keyboard opens.
                        autoFocus: true,
                        keyboardType: TextInputType.number,
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          borderWidth: 0.0,
                          shape: PinCodeFieldShape.box,
                          fieldOuterPadding:
                              const EdgeInsets.symmetric(horizontal: 2),
                          borderRadius: BorderRadius.circular(10),
                          selectedColor: MainColor,
                          inactiveColor: Colors.black54,
                          fieldHeight: SizeConfig.TenSize! * 4.5,
                          fieldWidth:
                              ((MediaQuery.sizeOf(context).width - 64) / 6)
                                  .clamp(36.0, 48.0)
                                  .toDouble(),
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        cursorColor: Colors.black87,
                        enablePinAutofill: true,
                        enableActiveFill: false,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        enabled: state.SendCodeState,
                        controller: Code,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        beforeTextPaste: (text) {
                          return true;
                        },
                        appContext: context,
                      );
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.TenSize! * 2,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: [
                          TimerWidget(),
                          BlocBuilder<UserloginBloc, UserloginState>(
                            buildWhen: (previous, current) =>
                                previous.SendCodeState != current.SendCodeState,
                            builder: (context, state) {
                              return InkWell(
                                  onTap: () {
                                    final myBloc =
                                        BlocProvider.of<UserloginBloc>(context);
                                    print(state.SendCodeState);
                                    if (!state.SendCodeState) {
                                      Code.clear();
                                      print('codeAgain');
                                      myBloc.add(SendCodeAgainEvent());
                                    }
                                  },
                                  child: Text(
                                      getLang(
                                          context: context,
                                          key: "SendCode_Again"),
                                      style: !state.SendCodeState
                                          ? StyleTitle
                                          : StyleTitleG));
                            },
                          ),
                        ],
                      )),
                ],
              ),
              const SizedBox(height: 36),
              BlocBuilder<UserloginBloc, UserloginState>(
                buildWhen: (previous, current) =>
                    previous.EnterLoginState != current.EnterLoginState,
                builder: (context, state) {
                  return UserSharedButton(
                    Buttontittle: getLang(context: context, key: "Done"),
                    onClickAction: () {
                      if (Code.text.length != 6) {
                        Showtoast(
                            message: getLang(
                                context: context, key: "Correct_Verification"));
                      } else {
                        final myBloc = BlocProvider.of<UserloginBloc>(context);
                        //  myBloc.add(UpdateCountryCode(CountryCode: SelectCodeModel(flag:value.flagUri,Country:value.name ,code:value.dialCode ),));
                        myBloc.add(EnterCodeLoginEvent(Code: Code.text));
                      }
                    },
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with SingleTickerProviderStateMixin {
  late TimerController _timerController;

  @override
  void initState() {
    _timerController = TimerController(this);

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      final myBloc = BlocProvider.of<UserloginBloc>(context);
      myBloc.add(StartTimerControllerEvent(timerController: _timerController));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserloginBloc, UserloginState>(
      builder: (context, state) {
        if (state.timerController == null) {
          return SizedBox();
        }
        return Container(
            height: 24,
            child: SimpleTimer(
              strokeWidth: 1,
              onEnd: () {
                final myBloc = BlocProvider.of<UserloginBloc>(context);
                myBloc.add(ResetTimerControllerEvent());
              },
              controller: state.timerController,
              duration: Duration(seconds: 30),
            ));
      },
    );
  }
}

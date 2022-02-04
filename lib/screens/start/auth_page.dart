import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:zeroheatproject/constants/common_size.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

const duration = Duration(microseconds: 300);

class _AuthPageState extends State<AuthPage> {
  final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  );

  TextEditingController _phoneNumberController =
      TextEditingController(text: "010");

  TextEditingController _codeController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  VerificationSatatus _verificationSatatus = VerificationSatatus.none;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;

        return IgnorePointer(
          //퓨처 되는동안 인풋안되게 하는거
          ignoring: _verificationSatatus == VerificationSatatus.verifying,
          child: Form(
            key: _formkey,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  '전화번호 로그인',
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(common_padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        ExtendedImage.asset(
                          'assets/imgs/padlock.png',
                          width: size.width * 0.15,
                          height: size.width * 0.15,
                        ),
                        SizedBox(
                          width: common_sm_padding,
                        ),
                        Text(
                            '토마토마켓은 휴대폰 번호로 가입해요. \n번호는 안전하게 보관 되며 \n어디에도 공개되지 않아요.'),
                      ],
                    ),
                    SizedBox(
                      height: common_padding,
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [MaskedInputFormatter("000 0000 0000")],
                      decoration: InputDecoration(
                          focusedBorder: inputBorder, border: inputBorder),
                      validator: (phoneNumber) {
                        if (phoneNumber != null && phoneNumber.length == 13) {
                          //핸펀번호가 널이아니고 13일때만 맞는값
                          return null;
                        } else {
                          //error
                          return '전화번호를 정확히 입력해주십시요.';
                        }
                      },
                    ),
                    SizedBox(
                      height: common_sm_padding,
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formkey.currentState != null) {
                          bool passed = _formkey.currentState!.validate();
                          print(passed);
                          if (passed)
                            setState(() {
                              _verificationSatatus =
                                  VerificationSatatus.codeSent;
                            });
                        }
                      },
                      child: Text("인증문자 발송"),
                    ),
                    SizedBox(
                      height: common_padding,
                    ),
                    AnimatedOpacity(
                      duration: duration,
                      opacity:
                          (_verificationSatatus == VerificationSatatus.none)
                              ? 0
                              : 1,
                      child: AnimatedContainer(
                        duration: duration,
                        curve: Curves.easeInOut,
                        height: getVerificationHeight(_verificationSatatus),
                        child: TextFormField(
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [MaskedInputFormatter("000000")],
                          decoration: InputDecoration(
                              focusedBorder: inputBorder, border: inputBorder),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: duration,
                      curve: Curves.easeInOut,
                      height: getVerificationBtnHeight(_verificationSatatus),
                      child: TextButton(
                        onPressed: () {
                          attempVerify();
                        },
                        child: (_verificationSatatus ==
                                VerificationSatatus.verifying)
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "인증",
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double getVerificationHeight(VerificationSatatus status) {
    switch (status) {
      case VerificationSatatus.none:
        return 0;
      case VerificationSatatus.codeSent:
      case VerificationSatatus.verifying:
      case VerificationSatatus.verificationDone:
        return 60 + common_sm_padding;
    }
  }

  double getVerificationBtnHeight(VerificationSatatus status) {
    switch (status) {
      case VerificationSatatus.none:
        return 0;
      case VerificationSatatus.codeSent:
      case VerificationSatatus.verifying:
      case VerificationSatatus.verificationDone:
        return 48;
    }
  }

  void attempVerify() async {
    setState(() {
      _verificationSatatus = VerificationSatatus.verifying;
    });

    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _verificationSatatus = VerificationSatatus.verificationDone;
    });
  }
}

enum VerificationSatatus {
  //상태 바꿔줄때 enum씀
  none, //아무것도 안한 상태
  codeSent, //인증문자를 발송한 상태
  verifying, //인증을 하는중인 상태
  verificationDone //인증완료된 상태
}

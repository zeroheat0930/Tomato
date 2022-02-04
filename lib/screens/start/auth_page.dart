import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:zeroheatproject/constants/common_size.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  );

  TextEditingController _phoneNumberController =
      TextEditingController(text: "010");
  TextEditingController _codeController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;

        return Form(
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
                      }
                    },
                    child: Text("인증문자 발송"),
                  ),
                  SizedBox(
                    height: common_padding,
                  ),
                  TextFormField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [MaskedInputFormatter("000000")],
                    decoration: InputDecoration(
                        focusedBorder: inputBorder, border: inputBorder),
                  ),
                  SizedBox(
                    height: common_sm_padding,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "인증번호 확인",
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

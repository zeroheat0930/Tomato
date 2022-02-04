import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeroheatproject/constants/common_size.dart';
import 'package:zeroheatproject/utils/logger.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(left: common_padding, right: common_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: '도로명으로 검색',
              hintStyle: TextStyle(color: Theme.of(context).hintColor),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), //밑줄 색깔
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue), //글자입력할라할때 밑줄색깔 조정
              ),
              prefixIconConstraints: //글자 간격 패딩
                  BoxConstraints(minWidth: 24, minHeight: 24),
            ),
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              minimumSize: Size(10, 48),
            ),
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.compass,
              color: Colors.white,
              size: 20,
            ),
            label: Text(
              '현재 위치 찾기',
              style: Theme.of(context).textTheme.button,
            ),
          ),
          Expanded(
            //컬럼,로우에서만 가능
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: common_padding),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('address $index'),
                  subtitle: Text('subtitle $index'),
                );
              },
              itemCount: 30,
            ),
          )
        ],
      ),
    );
  }
}

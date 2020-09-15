import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lunch_wallet/common/notifier.dart';
import 'package:lunch_wallet/common/resource.dart';
import 'package:lunch_wallet/dto/menu.dart';
import 'package:lunch_wallet/model/setting.dart';

import 'package:provider/provider.dart';

class Palette extends StatefulWidget {
  @override
  _PaletteState createState() => _PaletteState();
}

class _PaletteState extends State<Palette> {
  final _focus = [FocusNode(), FocusNode(), FocusNode(), FocusNode()];
  final _controller = [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()];
  var errorText = '';
  BuildContext _context;
  File _image;

  @override 
  void didChangeDependencies() {
    // 起動時の最初の一回
    super.didChangeDependencies();
    _context = context;
  }

  @override
  void initState() {
    super.initState();
    _controller[catShop].text = '';
    _controller[catName].text = '';
    _controller[catNote].text = '';
    _controller[catPrice].text = '';
  }

  Future _insertImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Card(
          child: Column(
            children: <Widget> [
              Container(
                color: Theme.of(context).canvasColor,
                height: 20,
                padding: EdgeInsets.only(left: 25, right: 25),
                alignment: Alignment.centerLeft,
                child: Text(
                  errorText,
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                    fontWeight: FontWeight.w500,
                      fontSize: 14,
                  ),
                ),
              ),
              Container(
                color: Theme.of(context).toggleableActiveColor,
                height: 48,
                padding: EdgeInsets.only(left: 25, right: 25),
                alignment: Alignment.centerLeft,
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  autofocus: true,
                  focusNode: _focus[catShop],
                  controller: _controller[catShop],
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isCollapsed : true,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    hintText: catalogs[catShop][settingDetail],
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  validator: (String value) {
                    return value.isEmpty ? '必須入力です' : null;
                  },
                  onFieldSubmitted: (v){
                    FocusScope.of(context).requestFocus(_focus[catName]);
                  },
                ),
              ),
              ListTile(
                leading: Stack(
                  children: <Widget> [
                    Container(
                      width: 60,
                      height: 60,
                      child: (_image != null)
                        ? Image.file(
                          _image,
                          fit: BoxFit.cover,
                        )
                        : Image.asset(
                          'images/noimage.png',
                          fit: BoxFit.cover,
                        ),
                    ),
                    MaterialButton(
                      minWidth: 60,
                      height: 60,
                      color: Colors.white30,
                      onPressed: () => _insertImage(),
                      child: Text('+'),
                    )
                  ],
                ),
                title: TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  focusNode: _focus[catName],
                  controller: _controller[catName],
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isCollapsed : true,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).cursorColor),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    hintText: catalogs[catName][settingDetail],
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  onFieldSubmitted: (v){
                    FocusScope.of(context).requestFocus(_focus[catNote]);
                  },
                ),
                subtitle: TextFormField(
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  focusNode: _focus[catNote],
                  controller: _controller[catNote],
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isCollapsed : true,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).cursorColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    hintText: catalogs[catNote][settingDetail],
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  onFieldSubmitted: (v){
                    FocusScope.of(context).requestFocus(_focus[catPrice]);
                  },
                ),
                trailing: CircleAvatar(
                  radius: 30,
                  child: Container(
                    height: 48,
                    padding: EdgeInsets.only(left: 6, right: 6),
                    alignment: Alignment.center,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        focusNode: _focus[catPrice],
                        textAlign : TextAlign.center,
                        controller: _controller[catPrice],
                        keyboardType: TextInputType.numberWithOptions(signed:false),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          isCollapsed : true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          hintText: catalogs[catPrice][settingDetail],
                          hintStyle:  TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        inputFormatters: <TextInputFormatter> [
                          WhitelistingTextInputFormatter.digitsOnly,
                        ],
                        onFieldSubmitted: (v){
                          FocusScope.of(context).requestFocus(_focus[catShop]);
                        },
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton.icon(
                color: Colors.green,
                textColor: Colors.white,
                icon: buttons[btnReg][settingIcon],
                label: buttons[btnReg][settingTitle],
                onPressed: () async {
                  MenuDto _dto = MenuDto();
                  _controller[catShop].text == '' ? _dto.shop = null : _dto.shop = _controller[catShop].text;
                  _controller[catName].text == '' ? _dto.name = null : _dto.name = _controller[catName].text;
                  _controller[catNote].text == '' ? _dto.note = '' : _dto.note = _controller[catNote].text;
                  _controller[catPrice].text == '' ? _dto.price = null : _dto.price = int.parse(_controller[catPrice].text);
                  _image == null ? _dto.icon = null : _dto.icon = _image.path;
                  var _result = await editCatalog(context, _dto);
                  if (_result == 0) {
                    context.read<CatalogNotifier>().getAllCatalog();
                    Navigator.pop(_context);
                  } else {
                    setState(() {
                      switch(_result) {
                        case 1:
                          errorText = '*印の必須項目を入力してください';
                          break;
                        case 2:
                          errorText = 'すでに同じメニューが登録されています';
                          break;
                      }
                    });
                  }
                },
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 5)),
              RaisedButton.icon(
                color: Colors.orange,
                textColor: Colors.white,
                icon: buttons[btnCan][settingIcon],
                label: buttons[btnCan][settingTitle],
                onPressed: () => Navigator.pop(_context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
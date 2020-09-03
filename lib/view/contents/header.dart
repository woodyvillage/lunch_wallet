import 'package:flutter/material.dart';

class ApplicationHeader extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text('ランチウォレット'),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.all(6.0),
      //     child: IconButton(
      //       icon: Icon(Icons.add),
      //         onPressed: () async {},
      //     ),
      //   ),
      // ],
    );
  }
}
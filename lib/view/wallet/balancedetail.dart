import 'package:flutter/material.dart';

import 'package:lunch_wallet/common/resource.dart';

Widget circleAvatarItem({
  @required context,
  @required data,
}) {
  if (data.name == depositItem) {
    return CircleAvatar(
      radius: 30,
      child: Text(data.price.toString()),
    );
  } else if (data.shop == null) {
    return CircleAvatar(
      radius: 30,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).canvasColor,
        radius: 25,
        child: Text(data.price.toString()),
      ),
    );
  } else {
    return CircleAvatar(
      radius: 30,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).backgroundColor,
        radius: 25,
        child: Text(data.price.toString()),
      ),
    );
  }
}

Widget titleItem({
  @required data,
}) {
  if (data.note == null) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.name,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  } else {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.name,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          data.note,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

Widget subTitleItem({
  @required data,
}) {
  if (data.shop == null) {
    return Text(
      data.date,
      style: TextStyle(fontSize: 10),
    );
  } else {
    var timeline = data.date + ' - ' + data.shop;
    return Text(
      timeline,
      style: TextStyle(fontSize: 10),
    );
  }
}
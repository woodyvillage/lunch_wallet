import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lunch_wallet/common/bloc.dart';
import 'package:lunch_wallet/view/frame.dart';

void main() => runApp(
  Provider<ApplicationBloc>(
    create: (_) => ApplicationBloc(),
    dispose: (_, bloc) => bloc.dispose(),
    child: ApplicationFrame(),
  )
);
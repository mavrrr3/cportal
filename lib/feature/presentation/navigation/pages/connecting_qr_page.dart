import 'package:cportal_flutter/feature/presentation/bloc/connecting_qr_bloc/connecting_qr_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connection_code_web/connecting_qr_screen.dart';
import 'package:cportal_flutter/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectingQrPage extends StatelessWidget {
  const ConnectingQrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConnectingQrBloc>(
      create: (ctx) => sl<ConnectingQrBloc>(),
      child: const ConnectingQrScreen(),
    );
  }
}

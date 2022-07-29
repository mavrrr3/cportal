import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/create_pin_code_screen.dart';
import 'package:cportal_flutter/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePinCodePage extends StatelessWidget {
  const CreatePinCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PinCodeBloc>(
      create: (context) => sl<PinCodeBloc>(),
      child: const CreatePinCodeScreen(),
    );
  }
}

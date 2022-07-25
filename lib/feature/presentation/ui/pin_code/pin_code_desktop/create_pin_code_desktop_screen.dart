import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/widgets/create_pin_code_area.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/auth_desktop_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';

class CreatePinCodeDesktopScreen extends StatelessWidget {
  final TextEditingController pinController;
  final FocusNode pinFocusNode;

  const CreatePinCodeDesktopScreen({
    Key? key,
    required this.pinController,
    required this.pinFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PinCodeBloc, PinCodeState>(
      builder: (context, state) {
        return AuthDesktopLayout(
          child: Column(
            children: [
              const SizedBox(height: 260),
              CreatePinCodeArea(
                pinController: pinController,
                pinFocusNode: pinFocusNode,
                isDesktop: true,
              ),
            ],
          ),
        );
      },
    );
  }
}

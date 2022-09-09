// ignore_for_file: prefer_int_literals

import 'dart:async';

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/pin_code/pin_dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobilePinCodeField extends StatefulWidget {
  final TextEditingController controller;
  const MobilePinCodeField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MobilePinCodeField> createState() => MobilePinCodeFieldState();
}

class MobilePinCodeFieldState extends State<MobilePinCodeField>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late StreamSubscription subscriptionBloc;
  late bool isLoader;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    isLoader = false;
    subscriptionBloc = context.read<AuthBloc>().stream.listen((state) {
      if (state is Authenticated) {
        _successPinCode();
      }
    });
  }

  Future<void> _successPinCode() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    await controller.forward();
    setState(() {
      isLoader = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return isLoader
        ? SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(
              color: theme.successPIN,
              strokeWidth: 2,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDot(index: 1, slideEnd: 4.5),
              const SizedBox(width: 32),
              _buildDot(index: 2, slideEnd: 1.5),
              const SizedBox(width: 32),
              _buildDot(index: 3, slideEnd: -1.5),
              const SizedBox(width: 32),
              _buildDot(index: 4, slideEnd: -4.5),
            ],
          );
  }

  Widget _buildDot({required int index, required double slideEnd}) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: Offset(slideEnd, 0.0),
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeIn,
        ),
      ),
      child: PinDot(controller: widget.controller, symbolIndex: index),
    );
  }

  @override
  void dispose() {
    subscriptionBloc.cancel();
    controller.dispose();
    super.dispose();
  }
}

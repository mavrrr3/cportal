// ignore_for_file: prefer_int_literals

import 'dart:async';

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinDot extends StatefulWidget {
  final TextEditingController controller;
  final int symbolIndex;
  const PinDot({
    Key? key,
    required this.controller,
    required this.symbolIndex,
  }) : super(key: key);

  @override
  State<PinDot> createState() => _PinDotState();
}

class _PinDotState extends State<PinDot> with SingleTickerProviderStateMixin {
  late StreamSubscription subscriptionBloc;
  late AnimationController scaleController;
  late bool isError;
  late bool isSuccess;
  late final Color inActiveDotColor;
  late final Color activeDotColor;
  late final Color errorColor;
  late final Color successColor;

  @override
  void initState() {
    super.initState();
    isError = false;
    isSuccess = false;
    scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    subscriptionBloc = context.read<AuthBloc>().stream.listen((state) {
      if (state is WrongPinCode) {
        if (widget.controller.text.isNotEmpty) {
          _wrongPinCode();
        }
      }
      if (state is Authenticated) {
        _successPinCode();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final theme = Theme.of(context).extension<CustomTheme>()!;
    inActiveDotColor = theme.text!.withOpacity(0.2);
    activeDotColor = theme.primary!;
    errorColor = theme.red!;
    successColor = theme.successPIN!;
  }

  Future<void> _wrongPinCode() async {
    setState(() {
      isError = true;
    });
    await scaleController.forward();
    await scaleController.reverse();
    await Future<dynamic>.delayed(const Duration(milliseconds: 300));
    setState(() {
      isError = false;
      widget.controller.clear();
    });
  }

  Future<void> _successPinCode() async {
    setState(() {
      isSuccess = true;
    });
    await scaleController.forward();
    await scaleController.reverse();
  }

  Color _defineColor() {
    if (isSuccess) {
      return successColor;
    } else if (isError) {
      return errorColor;
    } else {
      return widget.controller.text.length >= widget.symbolIndex
          ? activeDotColor
          : inActiveDotColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(
          parent: scaleController,
          curve: Curves.easeIn,
          reverseCurve: Curves.easeIn,
        ),
      ),
      child: AnimatedContainer(
        width: 16,
        height: 16,
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _defineColor(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    subscriptionBloc.cancel();
    scaleController.dispose();
    super.dispose();
  }
}

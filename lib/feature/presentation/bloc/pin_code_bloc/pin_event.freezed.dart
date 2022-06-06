// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pin_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PinEvent {
  String get pinCode => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pinCode) inputPin,
    required TResult Function(String pinCode) repeatPin,
    required TResult Function(String pinCode) createPin,
    required TResult Function(String pinCode) editPin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String pinCode)? inputPin,
    TResult Function(String pinCode)? repeatPin,
    TResult Function(String pinCode)? createPin,
    TResult Function(String pinCode)? editPin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pinCode)? inputPin,
    TResult Function(String pinCode)? repeatPin,
    TResult Function(String pinCode)? createPin,
    TResult Function(String pinCode)? editPin,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InputPinEvent value) inputPin,
    required TResult Function(_RepeatPinEvent value) repeatPin,
    required TResult Function(_CreatePinEvent value) createPin,
    required TResult Function(_EditPinEvent value) editPin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InputPinEvent value)? inputPin,
    TResult Function(_RepeatPinEvent value)? repeatPin,
    TResult Function(_CreatePinEvent value)? createPin,
    TResult Function(_EditPinEvent value)? editPin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InputPinEvent value)? inputPin,
    TResult Function(_RepeatPinEvent value)? repeatPin,
    TResult Function(_CreatePinEvent value)? createPin,
    TResult Function(_EditPinEvent value)? editPin,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PinEventCopyWith<PinEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PinEventCopyWith<$Res> {
  factory $PinEventCopyWith(PinEvent value, $Res Function(PinEvent) then) =
      _$PinEventCopyWithImpl<$Res>;
  $Res call({String pinCode});
}

/// @nodoc
class _$PinEventCopyWithImpl<$Res> implements $PinEventCopyWith<$Res> {
  _$PinEventCopyWithImpl(this._value, this._then);

  final PinEvent _value;
  // ignore: unused_field
  final $Res Function(PinEvent) _then;

  @override
  $Res call({
    Object? pinCode = freezed,
  }) {
    return _then(_value.copyWith(
      pinCode: pinCode == freezed
          ? _value.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_InputPinEventCopyWith<$Res>
    implements $PinEventCopyWith<$Res> {
  factory _$$_InputPinEventCopyWith(
          _$_InputPinEvent value, $Res Function(_$_InputPinEvent) then) =
      __$$_InputPinEventCopyWithImpl<$Res>;
  @override
  $Res call({String pinCode});
}

/// @nodoc
class __$$_InputPinEventCopyWithImpl<$Res> extends _$PinEventCopyWithImpl<$Res>
    implements _$$_InputPinEventCopyWith<$Res> {
  __$$_InputPinEventCopyWithImpl(
      _$_InputPinEvent _value, $Res Function(_$_InputPinEvent) _then)
      : super(_value, (v) => _then(v as _$_InputPinEvent));

  @override
  _$_InputPinEvent get _value => super._value as _$_InputPinEvent;

  @override
  $Res call({
    Object? pinCode = freezed,
  }) {
    return _then(_$_InputPinEvent(
      pinCode: pinCode == freezed
          ? _value.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_InputPinEvent extends _InputPinEvent
    with _InitialStateEmitter, _EnteringStateEmitter, _ErrorStateEmitter {
  const _$_InputPinEvent({required this.pinCode}) : super._();

  @override
  final String pinCode;

  @override
  String toString() {
    return 'PinEvent.inputPin(pinCode: $pinCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InputPinEvent &&
            const DeepCollectionEquality().equals(other.pinCode, pinCode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(pinCode));

  @JsonKey(ignore: true)
  @override
  _$$_InputPinEventCopyWith<_$_InputPinEvent> get copyWith =>
      __$$_InputPinEventCopyWithImpl<_$_InputPinEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pinCode) inputPin,
    required TResult Function(String pinCode) repeatPin,
    required TResult Function(String pinCode) createPin,
    required TResult Function(String pinCode) editPin,
  }) {
    return inputPin(pinCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String pinCode)? inputPin,
    TResult Function(String pinCode)? repeatPin,
    TResult Function(String pinCode)? createPin,
    TResult Function(String pinCode)? editPin,
  }) {
    return inputPin?.call(pinCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pinCode)? inputPin,
    TResult Function(String pinCode)? repeatPin,
    TResult Function(String pinCode)? createPin,
    TResult Function(String pinCode)? editPin,
    required TResult orElse(),
  }) {
    if (inputPin != null) {
      return inputPin(pinCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InputPinEvent value) inputPin,
    required TResult Function(_RepeatPinEvent value) repeatPin,
    required TResult Function(_CreatePinEvent value) createPin,
    required TResult Function(_EditPinEvent value) editPin,
  }) {
    return inputPin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InputPinEvent value)? inputPin,
    TResult Function(_RepeatPinEvent value)? repeatPin,
    TResult Function(_CreatePinEvent value)? createPin,
    TResult Function(_EditPinEvent value)? editPin,
  }) {
    return inputPin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InputPinEvent value)? inputPin,
    TResult Function(_RepeatPinEvent value)? repeatPin,
    TResult Function(_CreatePinEvent value)? createPin,
    TResult Function(_EditPinEvent value)? editPin,
    required TResult orElse(),
  }) {
    if (inputPin != null) {
      return inputPin(this);
    }
    return orElse();
  }
}

abstract class _InputPinEvent extends PinEvent
    implements
        _PinCodeContainer,
        _InitialStateEmitter,
        _EnteringStateEmitter,
        _ErrorStateEmitter {
  const factory _InputPinEvent({required final String pinCode}) =
      _$_InputPinEvent;
  const _InputPinEvent._() : super._();

  @override
  String get pinCode => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_InputPinEventCopyWith<_$_InputPinEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_RepeatPinEventCopyWith<$Res>
    implements $PinEventCopyWith<$Res> {
  factory _$$_RepeatPinEventCopyWith(
          _$_RepeatPinEvent value, $Res Function(_$_RepeatPinEvent) then) =
      __$$_RepeatPinEventCopyWithImpl<$Res>;
  @override
  $Res call({String pinCode});
}

/// @nodoc
class __$$_RepeatPinEventCopyWithImpl<$Res> extends _$PinEventCopyWithImpl<$Res>
    implements _$$_RepeatPinEventCopyWith<$Res> {
  __$$_RepeatPinEventCopyWithImpl(
      _$_RepeatPinEvent _value, $Res Function(_$_RepeatPinEvent) _then)
      : super(_value, (v) => _then(v as _$_RepeatPinEvent));

  @override
  _$_RepeatPinEvent get _value => super._value as _$_RepeatPinEvent;

  @override
  $Res call({
    Object? pinCode = freezed,
  }) {
    return _then(_$_RepeatPinEvent(
      pinCode: pinCode == freezed
          ? _value.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RepeatPinEvent extends _RepeatPinEvent {
  const _$_RepeatPinEvent({required this.pinCode}) : super._();

  @override
  final String pinCode;

  @override
  String toString() {
    return 'PinEvent.repeatPin(pinCode: $pinCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RepeatPinEvent &&
            const DeepCollectionEquality().equals(other.pinCode, pinCode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(pinCode));

  @JsonKey(ignore: true)
  @override
  _$$_RepeatPinEventCopyWith<_$_RepeatPinEvent> get copyWith =>
      __$$_RepeatPinEventCopyWithImpl<_$_RepeatPinEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pinCode) inputPin,
    required TResult Function(String pinCode) repeatPin,
    required TResult Function(String pinCode) createPin,
    required TResult Function(String pinCode) editPin,
  }) {
    return repeatPin(pinCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String pinCode)? inputPin,
    TResult Function(String pinCode)? repeatPin,
    TResult Function(String pinCode)? createPin,
    TResult Function(String pinCode)? editPin,
  }) {
    return repeatPin?.call(pinCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pinCode)? inputPin,
    TResult Function(String pinCode)? repeatPin,
    TResult Function(String pinCode)? createPin,
    TResult Function(String pinCode)? editPin,
    required TResult orElse(),
  }) {
    if (repeatPin != null) {
      return repeatPin(pinCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InputPinEvent value) inputPin,
    required TResult Function(_RepeatPinEvent value) repeatPin,
    required TResult Function(_CreatePinEvent value) createPin,
    required TResult Function(_EditPinEvent value) editPin,
  }) {
    return repeatPin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InputPinEvent value)? inputPin,
    TResult Function(_RepeatPinEvent value)? repeatPin,
    TResult Function(_CreatePinEvent value)? createPin,
    TResult Function(_EditPinEvent value)? editPin,
  }) {
    return repeatPin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InputPinEvent value)? inputPin,
    TResult Function(_RepeatPinEvent value)? repeatPin,
    TResult Function(_CreatePinEvent value)? createPin,
    TResult Function(_EditPinEvent value)? editPin,
    required TResult orElse(),
  }) {
    if (repeatPin != null) {
      return repeatPin(this);
    }
    return orElse();
  }
}

abstract class _RepeatPinEvent extends PinEvent {
  const factory _RepeatPinEvent({required final String pinCode}) =
      _$_RepeatPinEvent;
  const _RepeatPinEvent._() : super._();

  @override
  String get pinCode => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RepeatPinEventCopyWith<_$_RepeatPinEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_CreatePinEventCopyWith<$Res>
    implements $PinEventCopyWith<$Res> {
  factory _$$_CreatePinEventCopyWith(
          _$_CreatePinEvent value, $Res Function(_$_CreatePinEvent) then) =
      __$$_CreatePinEventCopyWithImpl<$Res>;
  @override
  $Res call({String pinCode});
}

/// @nodoc
class __$$_CreatePinEventCopyWithImpl<$Res> extends _$PinEventCopyWithImpl<$Res>
    implements _$$_CreatePinEventCopyWith<$Res> {
  __$$_CreatePinEventCopyWithImpl(
      _$_CreatePinEvent _value, $Res Function(_$_CreatePinEvent) _then)
      : super(_value, (v) => _then(v as _$_CreatePinEvent));

  @override
  _$_CreatePinEvent get _value => super._value as _$_CreatePinEvent;

  @override
  $Res call({
    Object? pinCode = freezed,
  }) {
    return _then(_$_CreatePinEvent(
      pinCode: pinCode == freezed
          ? _value.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CreatePinEvent extends _CreatePinEvent {
  const _$_CreatePinEvent({required this.pinCode}) : super._();

  @override
  final String pinCode;

  @override
  String toString() {
    return 'PinEvent.createPin(pinCode: $pinCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreatePinEvent &&
            const DeepCollectionEquality().equals(other.pinCode, pinCode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(pinCode));

  @JsonKey(ignore: true)
  @override
  _$$_CreatePinEventCopyWith<_$_CreatePinEvent> get copyWith =>
      __$$_CreatePinEventCopyWithImpl<_$_CreatePinEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pinCode) inputPin,
    required TResult Function(String pinCode) repeatPin,
    required TResult Function(String pinCode) createPin,
    required TResult Function(String pinCode) editPin,
  }) {
    return createPin(pinCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String pinCode)? inputPin,
    TResult Function(String pinCode)? repeatPin,
    TResult Function(String pinCode)? createPin,
    TResult Function(String pinCode)? editPin,
  }) {
    return createPin?.call(pinCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pinCode)? inputPin,
    TResult Function(String pinCode)? repeatPin,
    TResult Function(String pinCode)? createPin,
    TResult Function(String pinCode)? editPin,
    required TResult orElse(),
  }) {
    if (createPin != null) {
      return createPin(pinCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InputPinEvent value) inputPin,
    required TResult Function(_RepeatPinEvent value) repeatPin,
    required TResult Function(_CreatePinEvent value) createPin,
    required TResult Function(_EditPinEvent value) editPin,
  }) {
    return createPin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InputPinEvent value)? inputPin,
    TResult Function(_RepeatPinEvent value)? repeatPin,
    TResult Function(_CreatePinEvent value)? createPin,
    TResult Function(_EditPinEvent value)? editPin,
  }) {
    return createPin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InputPinEvent value)? inputPin,
    TResult Function(_RepeatPinEvent value)? repeatPin,
    TResult Function(_CreatePinEvent value)? createPin,
    TResult Function(_EditPinEvent value)? editPin,
    required TResult orElse(),
  }) {
    if (createPin != null) {
      return createPin(this);
    }
    return orElse();
  }
}

abstract class _CreatePinEvent extends PinEvent {
  const factory _CreatePinEvent({required final String pinCode}) =
      _$_CreatePinEvent;
  const _CreatePinEvent._() : super._();

  @override
  String get pinCode => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CreatePinEventCopyWith<_$_CreatePinEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_EditPinEventCopyWith<$Res>
    implements $PinEventCopyWith<$Res> {
  factory _$$_EditPinEventCopyWith(
          _$_EditPinEvent value, $Res Function(_$_EditPinEvent) then) =
      __$$_EditPinEventCopyWithImpl<$Res>;
  @override
  $Res call({String pinCode});
}

/// @nodoc
class __$$_EditPinEventCopyWithImpl<$Res> extends _$PinEventCopyWithImpl<$Res>
    implements _$$_EditPinEventCopyWith<$Res> {
  __$$_EditPinEventCopyWithImpl(
      _$_EditPinEvent _value, $Res Function(_$_EditPinEvent) _then)
      : super(_value, (v) => _then(v as _$_EditPinEvent));

  @override
  _$_EditPinEvent get _value => super._value as _$_EditPinEvent;

  @override
  $Res call({
    Object? pinCode = freezed,
  }) {
    return _then(_$_EditPinEvent(
      pinCode: pinCode == freezed
          ? _value.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_EditPinEvent extends _EditPinEvent {
  const _$_EditPinEvent({required this.pinCode}) : super._();

  @override
  final String pinCode;

  @override
  String toString() {
    return 'PinEvent.editPin(pinCode: $pinCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditPinEvent &&
            const DeepCollectionEquality().equals(other.pinCode, pinCode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(pinCode));

  @JsonKey(ignore: true)
  @override
  _$$_EditPinEventCopyWith<_$_EditPinEvent> get copyWith =>
      __$$_EditPinEventCopyWithImpl<_$_EditPinEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pinCode) inputPin,
    required TResult Function(String pinCode) repeatPin,
    required TResult Function(String pinCode) createPin,
    required TResult Function(String pinCode) editPin,
  }) {
    return editPin(pinCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String pinCode)? inputPin,
    TResult Function(String pinCode)? repeatPin,
    TResult Function(String pinCode)? createPin,
    TResult Function(String pinCode)? editPin,
  }) {
    return editPin?.call(pinCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pinCode)? inputPin,
    TResult Function(String pinCode)? repeatPin,
    TResult Function(String pinCode)? createPin,
    TResult Function(String pinCode)? editPin,
    required TResult orElse(),
  }) {
    if (editPin != null) {
      return editPin(pinCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InputPinEvent value) inputPin,
    required TResult Function(_RepeatPinEvent value) repeatPin,
    required TResult Function(_CreatePinEvent value) createPin,
    required TResult Function(_EditPinEvent value) editPin,
  }) {
    return editPin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InputPinEvent value)? inputPin,
    TResult Function(_RepeatPinEvent value)? repeatPin,
    TResult Function(_CreatePinEvent value)? createPin,
    TResult Function(_EditPinEvent value)? editPin,
  }) {
    return editPin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InputPinEvent value)? inputPin,
    TResult Function(_RepeatPinEvent value)? repeatPin,
    TResult Function(_CreatePinEvent value)? createPin,
    TResult Function(_EditPinEvent value)? editPin,
    required TResult orElse(),
  }) {
    if (editPin != null) {
      return editPin(this);
    }
    return orElse();
  }
}

abstract class _EditPinEvent extends PinEvent {
  const factory _EditPinEvent({required final String pinCode}) =
      _$_EditPinEvent;
  const _EditPinEvent._() : super._();

  @override
  String get pinCode => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_EditPinEventCopyWith<_$_EditPinEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PinState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() enteringPin,
    required TResult Function(String firstPinCode) repetingPin,
    required TResult Function(String firstPinCode, String secondPinCode)
        writing,
    required TResult Function(String pinCode) hasPin,
    required TResult Function(String pinCode, String wrongPinMessage) wrong,
    required TResult Function(String pinCode) success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialPinState value) initial,
    required TResult Function(_EnteringPinState value) enteringPin,
    required TResult Function(_RepetingPinState value) repetingPin,
    required TResult Function(_WritingPinState value) writing,
    required TResult Function(_HasPinState value) hasPin,
    required TResult Function(_WrongPinState value) wrong,
    required TResult Function(_SuccessPinState value) success,
    required TResult Function(_ErrorPinState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PinStateCopyWith<$Res> {
  factory $PinStateCopyWith(PinState value, $Res Function(PinState) then) =
      _$PinStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$PinStateCopyWithImpl<$Res> implements $PinStateCopyWith<$Res> {
  _$PinStateCopyWithImpl(this._value, this._then);

  final PinState _value;
  // ignore: unused_field
  final $Res Function(PinState) _then;
}

/// @nodoc
abstract class _$$_InitialPinStateCopyWith<$Res> {
  factory _$$_InitialPinStateCopyWith(
          _$_InitialPinState value, $Res Function(_$_InitialPinState) then) =
      __$$_InitialPinStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialPinStateCopyWithImpl<$Res>
    extends _$PinStateCopyWithImpl<$Res>
    implements _$$_InitialPinStateCopyWith<$Res> {
  __$$_InitialPinStateCopyWithImpl(
      _$_InitialPinState _value, $Res Function(_$_InitialPinState) _then)
      : super(_value, (v) => _then(v as _$_InitialPinState));

  @override
  _$_InitialPinState get _value => super._value as _$_InitialPinState;
}

/// @nodoc

class _$_InitialPinState extends _InitialPinState {
  const _$_InitialPinState() : super._();

  @override
  String toString() {
    return 'PinState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_InitialPinState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() enteringPin,
    required TResult Function(String firstPinCode) repetingPin,
    required TResult Function(String firstPinCode, String secondPinCode)
        writing,
    required TResult Function(String pinCode) hasPin,
    required TResult Function(String pinCode, String wrongPinMessage) wrong,
    required TResult Function(String pinCode) success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialPinState value) initial,
    required TResult Function(_EnteringPinState value) enteringPin,
    required TResult Function(_RepetingPinState value) repetingPin,
    required TResult Function(_WritingPinState value) writing,
    required TResult Function(_HasPinState value) hasPin,
    required TResult Function(_WrongPinState value) wrong,
    required TResult Function(_SuccessPinState value) success,
    required TResult Function(_ErrorPinState value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _InitialPinState extends PinState {
  const factory _InitialPinState() = _$_InitialPinState;
  const _InitialPinState._() : super._();
}

/// @nodoc
abstract class _$$_EnteringPinStateCopyWith<$Res> {
  factory _$$_EnteringPinStateCopyWith(
          _$_EnteringPinState value, $Res Function(_$_EnteringPinState) then) =
      __$$_EnteringPinStateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_EnteringPinStateCopyWithImpl<$Res>
    extends _$PinStateCopyWithImpl<$Res>
    implements _$$_EnteringPinStateCopyWith<$Res> {
  __$$_EnteringPinStateCopyWithImpl(
      _$_EnteringPinState _value, $Res Function(_$_EnteringPinState) _then)
      : super(_value, (v) => _then(v as _$_EnteringPinState));

  @override
  _$_EnteringPinState get _value => super._value as _$_EnteringPinState;
}

/// @nodoc

class _$_EnteringPinState extends _EnteringPinState {
  const _$_EnteringPinState() : super._();

  @override
  String toString() {
    return 'PinState.enteringPin()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_EnteringPinState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() enteringPin,
    required TResult Function(String firstPinCode) repetingPin,
    required TResult Function(String firstPinCode, String secondPinCode)
        writing,
    required TResult Function(String pinCode) hasPin,
    required TResult Function(String pinCode, String wrongPinMessage) wrong,
    required TResult Function(String pinCode) success,
    required TResult Function(String message) error,
  }) {
    return enteringPin();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
  }) {
    return enteringPin?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (enteringPin != null) {
      return enteringPin();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialPinState value) initial,
    required TResult Function(_EnteringPinState value) enteringPin,
    required TResult Function(_RepetingPinState value) repetingPin,
    required TResult Function(_WritingPinState value) writing,
    required TResult Function(_HasPinState value) hasPin,
    required TResult Function(_WrongPinState value) wrong,
    required TResult Function(_SuccessPinState value) success,
    required TResult Function(_ErrorPinState value) error,
  }) {
    return enteringPin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
  }) {
    return enteringPin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
    required TResult orElse(),
  }) {
    if (enteringPin != null) {
      return enteringPin(this);
    }
    return orElse();
  }
}

abstract class _EnteringPinState extends PinState {
  const factory _EnteringPinState() = _$_EnteringPinState;
  const _EnteringPinState._() : super._();
}

/// @nodoc
abstract class _$$_RepetingPinStateCopyWith<$Res> {
  factory _$$_RepetingPinStateCopyWith(
          _$_RepetingPinState value, $Res Function(_$_RepetingPinState) then) =
      __$$_RepetingPinStateCopyWithImpl<$Res>;
  $Res call({String firstPinCode});
}

/// @nodoc
class __$$_RepetingPinStateCopyWithImpl<$Res>
    extends _$PinStateCopyWithImpl<$Res>
    implements _$$_RepetingPinStateCopyWith<$Res> {
  __$$_RepetingPinStateCopyWithImpl(
      _$_RepetingPinState _value, $Res Function(_$_RepetingPinState) _then)
      : super(_value, (v) => _then(v as _$_RepetingPinState));

  @override
  _$_RepetingPinState get _value => super._value as _$_RepetingPinState;

  @override
  $Res call({
    Object? firstPinCode = freezed,
  }) {
    return _then(_$_RepetingPinState(
      firstPinCode: firstPinCode == freezed
          ? _value.firstPinCode
          : firstPinCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RepetingPinState extends _RepetingPinState {
  const _$_RepetingPinState({required this.firstPinCode}) : super._();

  @override
  final String firstPinCode;

  @override
  String toString() {
    return 'PinState.repetingPin(firstPinCode: $firstPinCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RepetingPinState &&
            const DeepCollectionEquality()
                .equals(other.firstPinCode, firstPinCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(firstPinCode));

  @JsonKey(ignore: true)
  @override
  _$$_RepetingPinStateCopyWith<_$_RepetingPinState> get copyWith =>
      __$$_RepetingPinStateCopyWithImpl<_$_RepetingPinState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() enteringPin,
    required TResult Function(String firstPinCode) repetingPin,
    required TResult Function(String firstPinCode, String secondPinCode)
        writing,
    required TResult Function(String pinCode) hasPin,
    required TResult Function(String pinCode, String wrongPinMessage) wrong,
    required TResult Function(String pinCode) success,
    required TResult Function(String message) error,
  }) {
    return repetingPin(firstPinCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
  }) {
    return repetingPin?.call(firstPinCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (repetingPin != null) {
      return repetingPin(firstPinCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialPinState value) initial,
    required TResult Function(_EnteringPinState value) enteringPin,
    required TResult Function(_RepetingPinState value) repetingPin,
    required TResult Function(_WritingPinState value) writing,
    required TResult Function(_HasPinState value) hasPin,
    required TResult Function(_WrongPinState value) wrong,
    required TResult Function(_SuccessPinState value) success,
    required TResult Function(_ErrorPinState value) error,
  }) {
    return repetingPin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
  }) {
    return repetingPin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
    required TResult orElse(),
  }) {
    if (repetingPin != null) {
      return repetingPin(this);
    }
    return orElse();
  }
}

abstract class _RepetingPinState extends PinState {
  const factory _RepetingPinState({required final String firstPinCode}) =
      _$_RepetingPinState;
  const _RepetingPinState._() : super._();

  String get firstPinCode => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_RepetingPinStateCopyWith<_$_RepetingPinState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_WritingPinStateCopyWith<$Res> {
  factory _$$_WritingPinStateCopyWith(
          _$_WritingPinState value, $Res Function(_$_WritingPinState) then) =
      __$$_WritingPinStateCopyWithImpl<$Res>;
  $Res call({String firstPinCode, String secondPinCode});
}

/// @nodoc
class __$$_WritingPinStateCopyWithImpl<$Res>
    extends _$PinStateCopyWithImpl<$Res>
    implements _$$_WritingPinStateCopyWith<$Res> {
  __$$_WritingPinStateCopyWithImpl(
      _$_WritingPinState _value, $Res Function(_$_WritingPinState) _then)
      : super(_value, (v) => _then(v as _$_WritingPinState));

  @override
  _$_WritingPinState get _value => super._value as _$_WritingPinState;

  @override
  $Res call({
    Object? firstPinCode = freezed,
    Object? secondPinCode = freezed,
  }) {
    return _then(_$_WritingPinState(
      firstPinCode: firstPinCode == freezed
          ? _value.firstPinCode
          : firstPinCode // ignore: cast_nullable_to_non_nullable
              as String,
      secondPinCode: secondPinCode == freezed
          ? _value.secondPinCode
          : secondPinCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_WritingPinState extends _WritingPinState {
  const _$_WritingPinState(
      {required this.firstPinCode, required this.secondPinCode})
      : super._();

  @override
  final String firstPinCode;
  @override
  final String secondPinCode;

  @override
  String toString() {
    return 'PinState.writing(firstPinCode: $firstPinCode, secondPinCode: $secondPinCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WritingPinState &&
            const DeepCollectionEquality()
                .equals(other.firstPinCode, firstPinCode) &&
            const DeepCollectionEquality()
                .equals(other.secondPinCode, secondPinCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(firstPinCode),
      const DeepCollectionEquality().hash(secondPinCode));

  @JsonKey(ignore: true)
  @override
  _$$_WritingPinStateCopyWith<_$_WritingPinState> get copyWith =>
      __$$_WritingPinStateCopyWithImpl<_$_WritingPinState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() enteringPin,
    required TResult Function(String firstPinCode) repetingPin,
    required TResult Function(String firstPinCode, String secondPinCode)
        writing,
    required TResult Function(String pinCode) hasPin,
    required TResult Function(String pinCode, String wrongPinMessage) wrong,
    required TResult Function(String pinCode) success,
    required TResult Function(String message) error,
  }) {
    return writing(firstPinCode, secondPinCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
  }) {
    return writing?.call(firstPinCode, secondPinCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (writing != null) {
      return writing(firstPinCode, secondPinCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialPinState value) initial,
    required TResult Function(_EnteringPinState value) enteringPin,
    required TResult Function(_RepetingPinState value) repetingPin,
    required TResult Function(_WritingPinState value) writing,
    required TResult Function(_HasPinState value) hasPin,
    required TResult Function(_WrongPinState value) wrong,
    required TResult Function(_SuccessPinState value) success,
    required TResult Function(_ErrorPinState value) error,
  }) {
    return writing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
  }) {
    return writing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
    required TResult orElse(),
  }) {
    if (writing != null) {
      return writing(this);
    }
    return orElse();
  }
}

abstract class _WritingPinState extends PinState {
  const factory _WritingPinState(
      {required final String firstPinCode,
      required final String secondPinCode}) = _$_WritingPinState;
  const _WritingPinState._() : super._();

  String get firstPinCode => throw _privateConstructorUsedError;
  String get secondPinCode => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_WritingPinStateCopyWith<_$_WritingPinState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_HasPinStateCopyWith<$Res> {
  factory _$$_HasPinStateCopyWith(
          _$_HasPinState value, $Res Function(_$_HasPinState) then) =
      __$$_HasPinStateCopyWithImpl<$Res>;
  $Res call({String pinCode});
}

/// @nodoc
class __$$_HasPinStateCopyWithImpl<$Res> extends _$PinStateCopyWithImpl<$Res>
    implements _$$_HasPinStateCopyWith<$Res> {
  __$$_HasPinStateCopyWithImpl(
      _$_HasPinState _value, $Res Function(_$_HasPinState) _then)
      : super(_value, (v) => _then(v as _$_HasPinState));

  @override
  _$_HasPinState get _value => super._value as _$_HasPinState;

  @override
  $Res call({
    Object? pinCode = freezed,
  }) {
    return _then(_$_HasPinState(
      pinCode: pinCode == freezed
          ? _value.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_HasPinState extends _HasPinState {
  const _$_HasPinState({required this.pinCode}) : super._();

  @override
  final String pinCode;

  @override
  String toString() {
    return 'PinState.hasPin(pinCode: $pinCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HasPinState &&
            const DeepCollectionEquality().equals(other.pinCode, pinCode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(pinCode));

  @JsonKey(ignore: true)
  @override
  _$$_HasPinStateCopyWith<_$_HasPinState> get copyWith =>
      __$$_HasPinStateCopyWithImpl<_$_HasPinState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() enteringPin,
    required TResult Function(String firstPinCode) repetingPin,
    required TResult Function(String firstPinCode, String secondPinCode)
        writing,
    required TResult Function(String pinCode) hasPin,
    required TResult Function(String pinCode, String wrongPinMessage) wrong,
    required TResult Function(String pinCode) success,
    required TResult Function(String message) error,
  }) {
    return hasPin(pinCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
  }) {
    return hasPin?.call(pinCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (hasPin != null) {
      return hasPin(pinCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialPinState value) initial,
    required TResult Function(_EnteringPinState value) enteringPin,
    required TResult Function(_RepetingPinState value) repetingPin,
    required TResult Function(_WritingPinState value) writing,
    required TResult Function(_HasPinState value) hasPin,
    required TResult Function(_WrongPinState value) wrong,
    required TResult Function(_SuccessPinState value) success,
    required TResult Function(_ErrorPinState value) error,
  }) {
    return hasPin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
  }) {
    return hasPin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
    required TResult orElse(),
  }) {
    if (hasPin != null) {
      return hasPin(this);
    }
    return orElse();
  }
}

abstract class _HasPinState extends PinState {
  const factory _HasPinState({required final String pinCode}) = _$_HasPinState;
  const _HasPinState._() : super._();

  String get pinCode => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_HasPinStateCopyWith<_$_HasPinState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_WrongPinStateCopyWith<$Res> {
  factory _$$_WrongPinStateCopyWith(
          _$_WrongPinState value, $Res Function(_$_WrongPinState) then) =
      __$$_WrongPinStateCopyWithImpl<$Res>;
  $Res call({String pinCode, String wrongPinMessage});
}

/// @nodoc
class __$$_WrongPinStateCopyWithImpl<$Res> extends _$PinStateCopyWithImpl<$Res>
    implements _$$_WrongPinStateCopyWith<$Res> {
  __$$_WrongPinStateCopyWithImpl(
      _$_WrongPinState _value, $Res Function(_$_WrongPinState) _then)
      : super(_value, (v) => _then(v as _$_WrongPinState));

  @override
  _$_WrongPinState get _value => super._value as _$_WrongPinState;

  @override
  $Res call({
    Object? pinCode = freezed,
    Object? wrongPinMessage = freezed,
  }) {
    return _then(_$_WrongPinState(
      pinCode: pinCode == freezed
          ? _value.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String,
      wrongPinMessage: wrongPinMessage == freezed
          ? _value.wrongPinMessage
          : wrongPinMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_WrongPinState extends _WrongPinState {
  const _$_WrongPinState({required this.pinCode, required this.wrongPinMessage})
      : super._();

  @override
  final String pinCode;
  @override
  final String wrongPinMessage;

  @override
  String toString() {
    return 'PinState.wrong(pinCode: $pinCode, wrongPinMessage: $wrongPinMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WrongPinState &&
            const DeepCollectionEquality().equals(other.pinCode, pinCode) &&
            const DeepCollectionEquality()
                .equals(other.wrongPinMessage, wrongPinMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pinCode),
      const DeepCollectionEquality().hash(wrongPinMessage));

  @JsonKey(ignore: true)
  @override
  _$$_WrongPinStateCopyWith<_$_WrongPinState> get copyWith =>
      __$$_WrongPinStateCopyWithImpl<_$_WrongPinState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() enteringPin,
    required TResult Function(String firstPinCode) repetingPin,
    required TResult Function(String firstPinCode, String secondPinCode)
        writing,
    required TResult Function(String pinCode) hasPin,
    required TResult Function(String pinCode, String wrongPinMessage) wrong,
    required TResult Function(String pinCode) success,
    required TResult Function(String message) error,
  }) {
    return wrong(pinCode, wrongPinMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
  }) {
    return wrong?.call(pinCode, wrongPinMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (wrong != null) {
      return wrong(pinCode, wrongPinMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialPinState value) initial,
    required TResult Function(_EnteringPinState value) enteringPin,
    required TResult Function(_RepetingPinState value) repetingPin,
    required TResult Function(_WritingPinState value) writing,
    required TResult Function(_HasPinState value) hasPin,
    required TResult Function(_WrongPinState value) wrong,
    required TResult Function(_SuccessPinState value) success,
    required TResult Function(_ErrorPinState value) error,
  }) {
    return wrong(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
  }) {
    return wrong?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
    required TResult orElse(),
  }) {
    if (wrong != null) {
      return wrong(this);
    }
    return orElse();
  }
}

abstract class _WrongPinState extends PinState {
  const factory _WrongPinState(
      {required final String pinCode,
      required final String wrongPinMessage}) = _$_WrongPinState;
  const _WrongPinState._() : super._();

  String get pinCode => throw _privateConstructorUsedError;
  String get wrongPinMessage => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_WrongPinStateCopyWith<_$_WrongPinState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SuccessPinStateCopyWith<$Res> {
  factory _$$_SuccessPinStateCopyWith(
          _$_SuccessPinState value, $Res Function(_$_SuccessPinState) then) =
      __$$_SuccessPinStateCopyWithImpl<$Res>;
  $Res call({String pinCode});
}

/// @nodoc
class __$$_SuccessPinStateCopyWithImpl<$Res>
    extends _$PinStateCopyWithImpl<$Res>
    implements _$$_SuccessPinStateCopyWith<$Res> {
  __$$_SuccessPinStateCopyWithImpl(
      _$_SuccessPinState _value, $Res Function(_$_SuccessPinState) _then)
      : super(_value, (v) => _then(v as _$_SuccessPinState));

  @override
  _$_SuccessPinState get _value => super._value as _$_SuccessPinState;

  @override
  $Res call({
    Object? pinCode = freezed,
  }) {
    return _then(_$_SuccessPinState(
      pinCode: pinCode == freezed
          ? _value.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SuccessPinState extends _SuccessPinState {
  const _$_SuccessPinState({required this.pinCode}) : super._();

  @override
  final String pinCode;

  @override
  String toString() {
    return 'PinState.success(pinCode: $pinCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SuccessPinState &&
            const DeepCollectionEquality().equals(other.pinCode, pinCode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(pinCode));

  @JsonKey(ignore: true)
  @override
  _$$_SuccessPinStateCopyWith<_$_SuccessPinState> get copyWith =>
      __$$_SuccessPinStateCopyWithImpl<_$_SuccessPinState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() enteringPin,
    required TResult Function(String firstPinCode) repetingPin,
    required TResult Function(String firstPinCode, String secondPinCode)
        writing,
    required TResult Function(String pinCode) hasPin,
    required TResult Function(String pinCode, String wrongPinMessage) wrong,
    required TResult Function(String pinCode) success,
    required TResult Function(String message) error,
  }) {
    return success(pinCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
  }) {
    return success?.call(pinCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(pinCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialPinState value) initial,
    required TResult Function(_EnteringPinState value) enteringPin,
    required TResult Function(_RepetingPinState value) repetingPin,
    required TResult Function(_WritingPinState value) writing,
    required TResult Function(_HasPinState value) hasPin,
    required TResult Function(_WrongPinState value) wrong,
    required TResult Function(_SuccessPinState value) success,
    required TResult Function(_ErrorPinState value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _SuccessPinState extends PinState {
  const factory _SuccessPinState({required final String pinCode}) =
      _$_SuccessPinState;
  const _SuccessPinState._() : super._();

  String get pinCode => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_SuccessPinStateCopyWith<_$_SuccessPinState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorPinStateCopyWith<$Res> {
  factory _$$_ErrorPinStateCopyWith(
          _$_ErrorPinState value, $Res Function(_$_ErrorPinState) then) =
      __$$_ErrorPinStateCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$$_ErrorPinStateCopyWithImpl<$Res> extends _$PinStateCopyWithImpl<$Res>
    implements _$$_ErrorPinStateCopyWith<$Res> {
  __$$_ErrorPinStateCopyWithImpl(
      _$_ErrorPinState _value, $Res Function(_$_ErrorPinState) _then)
      : super(_value, (v) => _then(v as _$_ErrorPinState));

  @override
  _$_ErrorPinState get _value => super._value as _$_ErrorPinState;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_ErrorPinState(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ErrorPinState extends _ErrorPinState {
  const _$_ErrorPinState({this.message = 'Произошла ошибка'}) : super._();

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'PinState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ErrorPinState &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_ErrorPinStateCopyWith<_$_ErrorPinState> get copyWith =>
      __$$_ErrorPinStateCopyWithImpl<_$_ErrorPinState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() enteringPin,
    required TResult Function(String firstPinCode) repetingPin,
    required TResult Function(String firstPinCode, String secondPinCode)
        writing,
    required TResult Function(String pinCode) hasPin,
    required TResult Function(String pinCode, String wrongPinMessage) wrong,
    required TResult Function(String pinCode) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? enteringPin,
    TResult Function(String firstPinCode)? repetingPin,
    TResult Function(String firstPinCode, String secondPinCode)? writing,
    TResult Function(String pinCode)? hasPin,
    TResult Function(String pinCode, String wrongPinMessage)? wrong,
    TResult Function(String pinCode)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialPinState value) initial,
    required TResult Function(_EnteringPinState value) enteringPin,
    required TResult Function(_RepetingPinState value) repetingPin,
    required TResult Function(_WritingPinState value) writing,
    required TResult Function(_HasPinState value) hasPin,
    required TResult Function(_WrongPinState value) wrong,
    required TResult Function(_SuccessPinState value) success,
    required TResult Function(_ErrorPinState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialPinState value)? initial,
    TResult Function(_EnteringPinState value)? enteringPin,
    TResult Function(_RepetingPinState value)? repetingPin,
    TResult Function(_WritingPinState value)? writing,
    TResult Function(_HasPinState value)? hasPin,
    TResult Function(_WrongPinState value)? wrong,
    TResult Function(_SuccessPinState value)? success,
    TResult Function(_ErrorPinState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ErrorPinState extends PinState {
  const factory _ErrorPinState({final String message}) = _$_ErrorPinState;
  const _ErrorPinState._() : super._();

  String get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_ErrorPinStateCopyWith<_$_ErrorPinState> get copyWith =>
      throw _privateConstructorUsedError;
}

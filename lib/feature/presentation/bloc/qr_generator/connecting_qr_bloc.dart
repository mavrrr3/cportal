import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/auth_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

part 'connecting_qr_event.dart';
part 'connecting_qr_state.dart';

class ConnectingQrBloc extends Bloc<ConnectingQrEvent, ConnectingQrState> {
  final AuthUseCase _authUseCase;

  final _userStream = StreamController<UserEntity?>();
  late StreamSubscription<UserEntity?> _streamSubscription;

  ConnectingQrBloc(this._authUseCase) : super(ConnectingQrInitial(_authUseCase.generateConnectingCode())) {
    _setupEvents();
    add(CheckLoginCredentials());

    _streamSubscription = _userStream.stream.listen((event) {
      if (event != null) {
        add(ReceivedUser(user: event));
      } else {
        add(CheckLoginCredentials());
      }
    });

    _authUseCase.sendConnectingData(qrData: state.qrData);
  }

  void _setupEvents() {
    on<CheckLoginCredentials>(_onCheckLoginCredentials, transformer: bloc_concurrency.droppable());
    on<ReceivedUser>(_onReceivedUser, transformer: bloc_concurrency.sequential());
  }

  FutureOr<void> _onCheckLoginCredentials(ConnectingQrEvent _, Emitter<ConnectingQrState> __) {
    Future.delayed(const Duration(seconds: 2), _tryGetUser);
  }

  FutureOr<void> _onReceivedUser(ReceivedUser event, Emitter<ConnectingQrState> emit) {
    emit(ConnectingQrSuccessAuth(user: event.user, qrData: state.qrData));
  }

  Future<void> _tryGetUser() async {
    final user = await _authUseCase.loginWithConnectingCode(state.qrData);
    if (!_userStream.isClosed) {
      _userStream.add(user);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    _userStream.close();

    return super.close();
  }
}

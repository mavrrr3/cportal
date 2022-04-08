import 'package:bloc/bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  //Mock для теста заменить на репозиторий для Auth
  bool isAuth = true;
  AuthCubit(this.isAuth) : super(AuthInitial()) {
    if (isAuth) {
      emit(Authinticated());
    } else {
      emit(UnAuthinticated());
    }
  }
}

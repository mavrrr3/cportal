import 'package:bloc_test/bloc_test.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/models/user_model.dart';
import 'package:cportal_flutter/feature/domain/entities/user_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/users_usecases/check_auth_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/users_usecases/login_user_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockLoginUserUseCase extends Mock implements LoginUserUseCase {}

class MockCheckUserUseCase extends Mock implements CheckAuthUseCase {}

void main() {
  late MockLoginUserUseCase loginUser;
  late MockCheckUserUseCase checkAuth;
  late AuthBloc authBloc;

  setUp(() {
    loginUser = MockLoginUserUseCase();
    checkAuth = MockCheckUserUseCase();
    authBloc = AuthBloc(loginUser, checkAuth);
  });
  tearDown(() {
    authBloc.close();
  });

  test('bloc should have initial state as [AuthInitial]', () {
    expect(authBloc.state, const AuthInitial());
  });

  const tCodeSixSimbol = '123456';
  const tCodeWrong = '123';
  const tIsAuth = true;
  final tFailure = CacheFailure();

  final UserModel tUserModel = UserModel(
    id: 'id',
    userName: 'userName',
    profileId: 'profileId',
    lastLogin: DateTime.parse('2022-03-21T14:59:58.884Z'),
    blocked: false,
    dateCreated: DateTime.parse('2022-03-21T14:59:58.884Z'),
    userCreated: 'userCreated',
    dateUpdated: DateTime.parse('2022-03-21T14:59:58.884Z'),
    userUpdated: 'userUpdated',
    userType: UserTypeModel(id: '1', code: 'ddd', description: 'ddd'),
  );
  final UserEntity tUserEntity = tUserModel;
  blocTest<AuthBloc, AuthState>(
    '''emits [AuthInitial] when connectingCode not equal 6.''',
    build: () => authBloc,
    act: (bloc) {
      bloc.add(const ChangeAuthCode(tCodeWrong));
    },
    expect: () => [
      const AuthInitial(),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    '''emits [] when connectingCode equal 6.''',
    build: () => authBloc,
    act: (bloc) {
      bloc.add(const ChangeAuthCode(tCodeSixSimbol));
    },
    expect: () => <AuthState>[],
  );

  blocTest<AuthBloc, AuthState>(
    '''emits [AuthInitial,Authenticated] when checkAuth return bool.''',
    build: () => authBloc,
    act: (bloc) {
      when(() => checkAuth()).thenAnswer((_) async => const Right(tIsAuth));

      bloc.add(const CheckAuth());
    },
    expect: () => <AuthState>[
      const AuthInitial(),
      const Authenticated(tIsAuth),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    '''emits [AuthInitial,ErrorAuthState] when checkAuth return Failure.''',
    build: () => authBloc,
    act: (bloc) {
      when(() => checkAuth()).thenAnswer((_) async => Left(tFailure));

      bloc.add(const CheckAuth());
    },
    expect: () => <AuthState>[
      const AuthInitial(),
      const ErrorAuthState(error: 'Ошибка обработки кэша'),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    '''emits [AuthInitial,AuthUser] when loginUser return [UserModel].''',
    build: () => authBloc,
    act: (bloc) {
      when(() =>
              loginUser(const LoginUserParams(connectingCode: tCodeSixSimbol)))
          .thenAnswer((_) async => Right(tUserModel));

      bloc.add(const AuthEventImpl(tCodeSixSimbol));
    },
    expect: () => <AuthState>[
      const AuthInitial(),
      AuthUser(user: tUserEntity),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    '''emits [AuthInitial,ErrorAuthState] when loginUser return [Failure].''',
    build: () => authBloc,
    act: (bloc) {
      when(() =>
              loginUser(const LoginUserParams(connectingCode: tCodeSixSimbol)))
          .thenAnswer((_) async => Left(tFailure));

      bloc.add(const AuthEventImpl(tCodeSixSimbol));
    },
    expect: () => <AuthState>[
      const AuthInitial(),
      const ErrorAuthState(error: 'Ошибка обработки кэша'),
    ],
  );
}

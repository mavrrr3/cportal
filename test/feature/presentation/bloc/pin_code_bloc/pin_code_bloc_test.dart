// import 'package:bloc_test/bloc_test.dart';
// import 'package:cportal_flutter/core/error/failure.dart';
// import 'package:cportal_flutter/feature/domain/usecases/pin_code_enter_usecase.dart';
// import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockUseCase extends Mock implements PinCodeEnterUseCase {}

// void main() {
//   late MockUseCase useCase;
//   late PinCodeBloc getPinCodeBloc;
//   late String tPinCode;

//   setUp(() {
//     useCase = MockUseCase();
//     getPinCodeBloc = PinCodeBloc(useCase);
//     tPinCode = '1234';
//   });

//   tearDown(() {
//     getPinCodeBloc.close();
//   });

//   test('bloc should have initial state as [PinCodeState]', () {
//     expect(getPinCodeBloc.state, const PinCodeState());
//   });

//   group('PinCodeCheckEvent', () {
//     const String tPinCode = '1234';

//     blocTest<PinCodeBloc, PinCodeState>(
//       '''emits [ PinCodeInputEnum.done] when PinCodeCheckEvent return PIN-code.''',
//       build: () => getPinCodeBloc,
//       act: (bloc) {
//         when(() => useCase.getPin()).thenAnswer((_) async => tPinCode);

//         bloc.add(PinCodeCheckEvent());
//       },
//       expect: () => [
//         const PinCodeState().copyWith(
//           pinCode: tPinCode,
//           status: PinCodeInputEnum.done,
//         ),
//       ],
//       verify: (_) {
//         verify(() => useCase.getPin()).called(1);
//       },
//     );

//     blocTest<PinCodeBloc, PinCodeState>(
//       '''emits [PinCodeInputEnum.create] when PinCodeCheckEvent return null.''',
//       build: () => getPinCodeBloc,
//       act: (bloc) {
//         when(() => useCase.getPin()).thenAnswer((_) async => null);

//         bloc.add(PinCodeCheckEvent());
//       },
//       expect: () => [
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.create,
//         ),
//       ],
//       verify: (_) {
//         verify(() => useCase.getPin()).called(1);
//       },
//     );
//   });

//   group('CreatePinCodeSubmit', () {
//     blocTest<PinCodeBloc, PinCodeState>(
//       '''emits [ PinCodeInputEnum.done] when CreatePinCodeSubmit return right PIN-code.''',
//       build: () => getPinCodeBloc,
//       act: (bloc) {
//         when(() => useCase.getPin()).thenAnswer((_) async => tPinCode);

//         bloc.add(CreatePinCodeSubmit(
//           pinCode: tPinCode,
//           status: PinCodeInputEnum.create,
//         ));
//       },
//       expect: () => [
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.create,
//         ),
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.done,
//         ),
//       ],
//       verify: (_) {
//         verify(() => useCase.getPin());
//       },
//     );

//     blocTest<PinCodeBloc, PinCodeState>(
//       '''emits [ PinCodeInputEnum.wrong] when CreatePinCodeSubmit return wrong PIN-code.''',
//       build: () => getPinCodeBloc,
//       act: (bloc) {
//         when(() => useCase.getPin()).thenAnswer((_) async => tPinCode);

//         bloc.add(const CreatePinCodeSubmit(
//           pinCode: 'wrongPinCode',
//           status: PinCodeInputEnum.create,
//         ));
//       },
//       expect: () => [
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.create,
//         ),
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.wrong,
//         ),
//       ],
//       verify: (_) {
//         verify(() => useCase.getPin());
//       },
//     );

//     blocTest<PinCodeBloc, PinCodeState>(
//       '''emits [ PinCodeInputEnum.create, PinCodeInputEnum.repeat] when CreatePinCodeSubmit return null.''',
//       build: () => getPinCodeBloc,
//       act: (bloc) {
//         when(() => useCase.getPin()).thenAnswer((_) async => null);
//         when(() => useCase(PinCodeParams(pinCode: tPinCode)))
//             .thenAnswer((_) async => Right(tPinCode));

//         bloc.add(CreatePinCodeSubmit(
//           pinCode: tPinCode,
//           status: PinCodeInputEnum.create,
//         ));
//       },
//       expect: () => [
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.create,
//         ),
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.repeat,
//         ),
//       ],
//       verify: (_) {
//         verify(() => useCase.getPin());
//         verify(() => useCase(PinCodeParams(pinCode: tPinCode)));
//       },
//     );

//     blocTest<PinCodeBloc, PinCodeState>(
//       '''emits [ PinCodeInputEnum.create, PinCodeInputEnum.error] when CreatePinCodeSubmit return CacheFailure.''',
//       build: () => getPinCodeBloc,
//       act: (bloc) {
//         when(() => useCase.getPin()).thenAnswer((_) async => null);
//         when(() => useCase(PinCodeParams(pinCode: tPinCode)))
//             .thenAnswer((_) async => Left(CacheFailure()));

//         bloc.add(CreatePinCodeSubmit(
//           pinCode: tPinCode,
//           status: PinCodeInputEnum.create,
//         ));
//       },
//       expect: () => [
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.create,
//         ),
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.error,
//         ),
//       ],
//       verify: (_) {
//         verify(() => useCase.getPin());
//         verify(() => useCase(PinCodeParams(pinCode: tPinCode)));
//       },
//     );
//   });

//   group('RepeatPinCodeSubmit', () {
//     blocTest<PinCodeBloc, PinCodeState>(
//       '''emits [ PinCodeInputEnum.done] when RepeatPinCodeSubmit return right PIN-code.''',
//       build: () => getPinCodeBloc,
//       act: (bloc) {
//         when(() => useCase.getPin()).thenAnswer((_) async => tPinCode);

//         bloc.add(RepeatPinCodeSubmit(
//           pinCode: tPinCode,
//           status: PinCodeInputEnum.repeat,
//         ));
//       },
//       expect: () => [
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.done,
//         ),
//       ],
//       verify: (_) {
//         verify(() => useCase.getPin());
//       },
//     );

//     blocTest<PinCodeBloc, PinCodeState>(
//       '''emits [ PinCodeInputEnum.done] when RepeatPinCodeSubmit return wrong PIN-code.''',
//       build: () => getPinCodeBloc,
//       act: (bloc) {
//         when(() => useCase.getPin()).thenAnswer((_) async => tPinCode);

//         bloc.add(const RepeatPinCodeSubmit(
//           pinCode: 'wrongPinCode',
//           status: PinCodeInputEnum.repeat,
//         ));
//       },
//       expect: () => [
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.wrong,
//         ),
//       ],
//       verify: (_) {
//         verify(() => useCase.getPin());
//       },
//     );
//   });

//   group('EditPinCodeSubmit', () {
//     blocTest<PinCodeBloc, PinCodeState>(
//       '''emits [ PinCodeInputEnum.repeat] when EditPinCodeSubmit return Right(tPinCode).''',
//       build: () => getPinCodeBloc,
//       act: (bloc) {
//         when(() => useCase(PinCodeParams(pinCode: tPinCode)))
//             .thenAnswer((_) async => Right(tPinCode));

//         bloc.add(EditPinCodeSubmit(
//           pinCode: tPinCode,
//           status: PinCodeInputEnum.edit,
//         ));
//       },
//       expect: () => [
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.repeat,
//         ),
//       ],
//       verify: (_) {
//         verify(() => useCase(PinCodeParams(pinCode: tPinCode)));
//       },
//     );

//     blocTest<PinCodeBloc, PinCodeState>(
//       '''emits [ PinCodeInputEnum.error] when EditPinCodeSubmit return Left(CacheFailure()).''',
//       build: () => getPinCodeBloc,
//       act: (bloc) {
//         when(() => useCase(PinCodeParams(pinCode: tPinCode)))
//             .thenAnswer((_) async => Left(CacheFailure()));

//         bloc.add(EditPinCodeSubmit(
//           pinCode: tPinCode,
//           status: PinCodeInputEnum.edit,
//         ));
//       },
//       expect: () => [
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.error,
//         ),
//       ],
//       verify: (_) {
//         verify(() => useCase(PinCodeParams(pinCode: tPinCode)));
//       },
//     );
//   });

//   group('InputPinCodeSubmit', () {
//     blocTest<PinCodeBloc, PinCodeState>(
//       '''emits [ PinCodeInputEnum.repeat] when InputPinCodeSubmit return right PIN-code.''',
//       build: () => getPinCodeBloc,
//       act: (bloc) {
//         when(() => useCase.getPin()).thenAnswer((_) async => tPinCode);

//         bloc.add(InputPinCodeSubmit(
//           pinCode: tPinCode,
//           status: PinCodeInputEnum.input,
//         ));
//       },
//       expect: () => [
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.done,
//         ),
//       ],
//       verify: (_) {
//         verify(() => useCase.getPin());
//       },
//     );

//     blocTest<PinCodeBloc, PinCodeState>(
//       '''emits [ PinCodeInputEnum.repeat] when InputPinCodeSubmit return wrong PIN-code.''',
//       build: () => getPinCodeBloc,
//       act: (bloc) {
//         when(() => useCase.getPin()).thenAnswer((_) async => tPinCode);

//         bloc.add(const InputPinCodeSubmit(
//           pinCode: 'wrongPinCode',
//           status: PinCodeInputEnum.input,
//         ));
//       },
//       expect: () => [
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.wrongInput,
//         ),
//       ],
//       verify: (_) {
//         verify(() => useCase.getPin());
//       },
//     );
//   });

//   group('EditPinCodeCheckEvent', () {
//     blocTest<PinCodeBloc, PinCodeState>(
//       '''emits [ PinCodeInputEnum.create] when EditPinCodeCheckEvent.''',
//       build: () => getPinCodeBloc,
//       act: (bloc) {
//         bloc.add(EditPinCodeCheckEvent());
//       },
//       expect: () => [
//         const PinCodeState().copyWith(
//           status: PinCodeInputEnum.create,
//         ),
//       ],
//     );
//   });

//   group('ChangedPinCode', () {
//     PinCodeInputEnum getStatus(PinCodeInputEnum status) {
//       return status == PinCodeInputEnum.create
//           ? PinCodeInputEnum.create
//           : status == PinCodeInputEnum.wrong
//               ? PinCodeInputEnum.create
//               : status == PinCodeInputEnum.wrongInput
//                   ? PinCodeInputEnum.wrongInput
//                   : PinCodeInputEnum.repeat;
//     }

//     blocTest<PinCodeBloc, PinCodeState>(
//       '''emits [ PinCodeInputEnum.repeat] when ChangedPinCode.''',
//       build: () => getPinCodeBloc,
//       act: (bloc) {
//         bloc.add(
//           ChangedPinCode(
//             pinCode: tPinCode,
//             status: PinCodeInputEnum.input,
//           ),
//         );
//       },
//       expect: () => [
//         const PinCodeState().copyWith(
//           pinCode: tPinCode,
//           status: getStatus(PinCodeInputEnum.input),
//         ),
//       ],
//     );
//   });
// }

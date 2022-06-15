// import 'package:cportal_flutter/feature/data/datasources/pin_code_local_datasource.dart';
// import 'package:cportal_flutter/feature/data/repositories/pin_code_repository.dart';
// import 'package:test/test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockLocalDataSource extends Mock implements IPinCodeDataSource {}

// void main() {
//   late PinCodeRepository repository;
//   late MockLocalDataSource mockLocalDataSource;

//   setUp(() {
//     mockLocalDataSource = MockLocalDataSource();
//     repository = PinCodeRepository(
//       localDataSource: mockLocalDataSource,
//     );
//   });

//   const String tPinCode = '1111';

//   test(
//     'should return PIN code when it present',
//     () async {
//       // Arrange.
//       when(() => mockLocalDataSource.writePin(tPinCode))
//           .thenAnswer((_) async => any());
//       when(() => mockLocalDataSource.getPin())
//           .thenAnswer((_) async => tPinCode);

//       // Act..
//       final String? result = await repository.getPin();

//       // Assert.
//       verify(() => mockLocalDataSource.getPin());
//       expect(result, equals(tPinCode));
//     },
//   );
// }

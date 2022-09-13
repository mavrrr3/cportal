import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_connecting_qr_repository.dart';
import 'package:cportal_flutter/feature/domain/usecases/connecting_qr/connecting_params.dart';
import 'package:dartz/dartz.dart';

class SendScannedDataUseCase extends IUseCase<void, ConnectingParams> {
  final IConnectingQrRepository _connectingQrRepository;

  SendScannedDataUseCase(this._connectingQrRepository);

  @override
  Future<Either<Failure, void>> call(ConnectingParams params) async {
    return _connectingQrRepository.sendScannedData(
        connectingCode: params.connectingCode);
  }
}

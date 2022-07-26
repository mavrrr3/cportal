import 'package:cportal_flutter/feature/domain/repositories/i_connecting_qr_repository.dart';

class GenerateConnectingCodeUseCase {
  final IConnectingQrRepository _connectingQrRepository;

  GenerateConnectingCodeUseCase(this._connectingQrRepository);

  String call() => _connectingQrRepository.generateConnectingCode();
}

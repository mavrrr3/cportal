abstract class IConnectingQrRemoteDataSource {
  Future<void> sendConnectingData({required String connectingCode});

  Future<void> sendScannedData({required String connectingCode});
}

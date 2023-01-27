import 'package:egov/core/services/storage/storage_service.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../models/event_generics.dart';
import '../models/event.dart';
import '../models/stream_socket.dart';
import '../utils/config.dart';
import "package:socket_io_client/socket_io_client.dart" as client;

class SocketClient {
  final StorageService storageService;
  String baseUrl = AppConfig.baseUrl;
  SocketClient({
    required this.storageService,
  });
  client.Socket? socket;
  void init() {
    // final token = tokenRepository.getToken().token;
    socket = client.io(
        baseUrl,
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({'authorization': 'Bearer '})
            .build());

    socket?.connect();
    socket?.onConnect((_) {});
    socket?.onDisconnect((_) {});
    socket?.onError((n) {});
  }

  void disconnectSocket() {
    socket?.disconnect();
    socket?.dispose();
    socket = null;
  }

  StreamSocket<T> connectAndListen<T>(String event) {
    if (socket == null) {
      init();
    }

    final streamSocket = StreamSocket<T>();
    socket!.on(event, (data) {
      var json = Map<String, dynamic>.from(data);
      final eventResponse = EventGeneric.fromJson<T>(json);

      streamSocket.addResponse(eventResponse);
    });
    return streamSocket;
  }

  void emit(Event event) {
    if (socket == null) {
      init();
    }
    socket?.emit(event.name, event.data());
  }
}

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void initSocket(String userId, double latitude, double longitude) {
    socket = IO.io(
      'http://10.0.2.2:2005',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setQuery({'userId': userId})
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print('Connected to socket: ${socket.id}');
      updateLocation(userId, latitude, longitude);
    });

    socket.on('locationUpdate', (data) {
      print('Location Update Received: $data');
    });

    socket.onDisconnect((_) => print('Socket disconnected'));
  }

  void updateLocation(String userId, double latitude, double longitude) {
    socket.emit('updateLocation', {
      'userId': userId,
      'location': {'latitude': latitude, 'longitude': longitude},
    });
  }

  void dispose() {
    socket.disconnect();
  }
}

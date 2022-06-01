import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class CustomServer {
  Future<void> initialize(Handler handler) async {
    final String address = 'localhost';
    final int port = 8080;
    await shelf_io.serve(handler, address, port);
    print('server started!');
  }
}

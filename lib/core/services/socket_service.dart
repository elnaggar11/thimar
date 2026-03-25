import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late socket_io.Socket _socket;
  bool _isConnected = false;

  void logSocket(String message) {
    if (!kDebugMode) return;
    const String tag = '\x1B[33m[SocketService]\x1B[0m';
    log('$tag $message');
  }

  factory SocketService() => _instance;

  SocketService._internal();

  void init({Map<String, dynamic>? options}) {
    if (_isConnected) {
      logSocket('Already connected, skipping init');

      return;
    }
    logSocket(
      'Initializing connection to https://aaleyat.saied.aait-d.com:4089',
    );

    _socket = socket_io.io(
      'https://aaleyat.saied.aait-d.com:4089',
      options ??
          {
            'transports': ['websocket'],
            'autoConnect': false,
          },
    );
    _socket.on('connect', (_) {
      _isConnected = true;
      logSocket('Socket connected');
    });

    _socket.on('connect_error', (err) {
      logSocket('Connection error: $err');
    });

    _socket.on('error', (err) {
      logSocket('General socket error:: $err');
    });

    _socket.on('disconnect', (_) {
      _isConnected = false;
      logSocket('Socket disconnected');
    });

    _socket.connect();
    logSocket('Connection initiated');
  }

  void joinOrderRoom(String orderId) {
    if (!_isConnected) {
      logSocket('Cannot emit [join-order-room] - socket not connected');
      return;
    }
    _socket.emit('join-order-room', {'orderId': orderId});
    logSocket('Emitting event [join-order-room] with data: $orderId');
  }

  void leaveOrderRoom(String orderId) {
    if (!_isConnected) {
      logSocket('Cannot emit [leave-order-room] - socket not connected');
      return;
    }
    _socket.emit('leave-order-room', {'orderId': orderId});
    logSocket('Emitting event [leave-order-room] with data: $orderId');
  }

  void send(String event, dynamic data) {
    if (!_isConnected) {
      logSocket('Cannot emit [$event] - socket not connected');
      return;
    }
    _socket.emit(event, data);
    logSocket('Emitting event [$event] with data: $data');
  }

  void listen(String event, Function(dynamic) callback) {
    logSocket('Listening to event [$event]');
    _socket.on(event, (data) {
      logSocket('Event [$event] received with data: $data');
      callback(data);
    });
  }

  void removeListener(String event) {
    logSocket('Removing listener for event [$event]');

    _socket.off(event);
  }

  void disconnect() {
    if (_isConnected) {
      logSocket('Disconnecting socket');

      _socket.disconnect();
      _isConnected = false;
    } else {
      logSocket('Socket already disconnected');
    }
  }

  void connect() {
    if (!_isConnected) {
      logSocket('Reconnecting socket...');
      _socket.connect();
    } else {
      logSocket('Socket already connected');
    }
  }
}

/// **WebSocket Service Explanation**
// 1 Create a private single instance of the class.

// 2 Always return the same instance using a factory constructor.

//  3 When init() is called:

// If already connected, do nothing.

// Else:

// Create socket with the URL and options.

// Connect the socket.

// Set _isConnected to true.

//4 When send() is called:

// If connected, emit the event with data.

//5 When listen() is called:

// Listen for the event and run the callback when data is received.

//6 When removeListener() is called:

// Remove the listener for that event.

//7 When disconnect() is called:

// If connected, disconnect the socket and set _isConnected to false.

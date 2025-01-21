part of flutter_twilio_conversations;

/// Entry point for the Twilio Programmable Dart.
class TwilioConversationsClient extends FlutterTwilioConversationsPlatform {
  static EventChannel _mediaProgressChannel =
      EventChannel('flutter_twilio_conversations/media_progress');

  static EventChannel _loggingChannel =
      EventChannel('flutter_twilio_conversations/logging');

  static StreamSubscription? _loggingStream;

  static bool _dartDebug = false;

  static ChatClient? chatClient;

  static Exception _convertException(Exception err) {
    var code = int.tryParse(err.toString());
    // If code is an integer, then it is a Twilio ErrorInfo exception.
    if (code != null) {
      return ErrorInfo(int.parse(err.toString()), err.toString(), err.toString() as int);
    }

    // For now just rethrow the PlatformException. But we could make custom ones based on the code value.
    // code can be:
    // - "ERROR" Something went wrong in the custom native code.
    // - "IllegalArgumentException" Something went wrong calling the twilio SDK.
    // - "JSONException" Something went wrong parsing a JSON string.
    // - "MISSING_PARAMS" Missing params, only the native debug method uses this at the moment.
    return err;
  }

  /// Internal logging method for dart.
  static void _log(dynamic msg) {
    if (_dartDebug) {
      print('[   DART   ] $msg');
    }
  }

  /// Enable debug logging.
  ///
  /// For native logging set [native] to `true` and for dart set [dart] to `true`.
  static Future<void> debug({
    bool dart = false,
    bool native = false,
    bool sdk = false,
  }) async {
    _dartDebug = dart;
    await FlutterTwilioConversationsPlatform.instance
        .platformDebug(dart, native, sdk);
    if (native && _loggingStream == null) {
      _loggingStream =
          _loggingChannel.receiveBroadcastStream().listen((dynamic event) {
        if (native) {
          print('[  NATIVE  ] $event');
        }
      });
    } else if (!native && _loggingStream != null) {
      await _loggingStream?.cancel();
      _loggingStream = null;
    }
  }

  /// Create to a [ChatClient].
  static Future<ChatClient?> create(String token, Properties properties) async {
    assert(token != '');

     TwilioConversationsClient._log(
          'TwilioConversationsPlugin.create => starting request in Dart');
      final methodData = await FlutterTwilioConversationsPlatform.instance
          .createChatClient(token, properties.toMap());

      TwilioConversationsClient._log(
          'TwilioConversationsPlugin.create => finished request in Dart');
      final chatClientMap = Map<String, dynamic>.from(methodData as Map);
      chatClient = ChatClient._fromMap(chatClientMap);
      return chatClient;
  }
}

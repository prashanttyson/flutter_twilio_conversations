part of flutter_twilio_conversations;

class Messages {
  final Channel _channel;

  //#region Private API properties
  int? _lastReadMessageIndex;
  //#endregion

  //#region Public API properties
  /// Return user last read message index for the channel.
  int? get lastReadMessageIndex {
    return _lastReadMessageIndex;
  }
  //#endregion

  Messages(this._channel);

  //#region Public API methods
  /// Sends a message to the channel.
  Future<Message> sendMessage(MessageOptions options) async {
     final methodData = await FlutterTwilioConversationsPlatform.instance
          .sendMessage(options.toMap(), _channel.sid);
      final messageMap = Map<String, dynamic>.from(methodData);
      return Message._fromMap(messageMap, this);
  }

  /// Removes a message from the channel.
  Future<void> removeMessage(Message message) async {
     await FlutterTwilioConversationsPlatform.instance
          .removeMessage(_channel.sid, message.messageIndex!);
  }

  /// Fetch at most count messages including and prior to the specified index.
  Future<List<Message>> getMessagesBefore(int index, int count) async {
    final methodData = await FlutterTwilioConversationsPlatform.instance
          .getMessagesBefore(index, count, _channel.sid);
      final List<Map<String, dynamic>> messageMapList = methodData
          .map<Map<String, dynamic>>((r) => Map<String, dynamic>.from(r))
          .toList();

      var messages = <Message>[];
      for (final messageMap in messageMapList) {
        messages.add(Message._fromMap(messageMap, this));
      }
      return messages;
  }

  /// Fetch at most count messages including and subsequent to the specified index.
  Future<List<Message>> getMessagesAfter(int index, int count) async {
    final methodData = await FlutterTwilioConversationsPlatform.instance
          .getMessagesAfter(index, count, _channel.sid);
      final List<Map<String, dynamic>> messageMapList = methodData
          .map<Map<String, dynamic>>((r) => Map<String, dynamic>.from(r))
          .toList();
      var messages = <Message>[];
      for (final messageMap in messageMapList) {
        messages.add(Message._fromMap(messageMap, this));
      }
      return messages;
  }

  /// Load last messages in chat.
  Future<List<Message>> getLastMessages(int count) async {
    final methodData = await FlutterTwilioConversationsPlatform.instance
          .getLastMessages(count, _channel.sid);
      final List<Map<String, dynamic>> messageMapList = methodData
          .map<Map<String, dynamic>>((r) => Map<String, dynamic>.from(r))
          .toList();

      var messages = <Message>[];
      for (final messageMap in messageMapList) {
        messages.add(Message._fromMap(messageMap, this));
      }
      return messages;
  }

  /// Get message object by known index.
  Future<Message> getMessageByIndex(int messageIndex) async {
    final methodData = await FlutterTwilioConversationsPlatform.instance
          .getMessageByIndex(_channel.sid, messageIndex);

      final messageMap = Map<String, dynamic>.from(methodData);
      return Message._fromMap(messageMap, this);
  }

  /// Set user last read message index for the channel.
  Future<int?> setLastReadMessageIndexWithResult(
      int lastReadMessageIndex) async {
     return _lastReadMessageIndex = await FlutterTwilioConversationsPlatform
          .instance
          .setLastReadMessageIndexWithResult(
        _channel.sid,
        lastReadMessageIndex,
      );
  }

  /// Increase user last read message index for the channel.
  ///
  /// Index is ignored if it is smaller than user current index.
  Future<int?> advanceLastReadMessageIndexWithResult(
      int lastReadMessageIndex) async {
     return _lastReadMessageIndex = await FlutterTwilioConversationsPlatform
          .instance
          .advanceLastReadMessageIndexWithResult(
              _channel.sid, lastReadMessageIndex);
  }

  /// Set last read message index to last message index in channel.
  Future<int?> setAllMessagesReadWithResult() async {
    return _lastReadMessageIndex = await FlutterTwilioConversationsPlatform
          .instance
          .setAllMessagesReadWithResult(_channel.sid);
  }

  /// Set last read message index before the first message index in channel.
  Future<int?> setNoMessagesReadWithResult() async {
     return _lastReadMessageIndex = await FlutterTwilioConversationsPlatform
          .instance
          .setNoMessagesReadWithResult(_channel.sid);
  }
  //#endregion

  /// Update properties from a map.
  void _updateFromMap(Map<String, dynamic> map) {
    _lastReadMessageIndex = map['lastReadMessageIndex'];
  }
}

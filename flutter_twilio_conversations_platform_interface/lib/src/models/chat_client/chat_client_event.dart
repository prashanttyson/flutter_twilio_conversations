import 'package:flutter_twilio_conversations/flutter_twilio_conversations.dart';
import 'package:flutter_twilio_conversations_platform_interface/src/models/chat_client/conversation_model.dart';
import 'package:flutter_twilio_conversations_platform_interface/src/models/model_exports.dart';

/// The base RoomEvent that all other RoomEvent types must extend.
abstract class BaseChatClientEvent {
  final ConnectionState? connectionState;

  const BaseChatClientEvent(this.connectionState);

  @override
  String toString() =>
      'BaseChatClientEvent: { connectionState: $connectionState }';
}

class ConnectionStateChange extends BaseChatClientEvent {
  // final TwilioException? exception;

  const ConnectionStateChange(
    ConnectionState connectionState,
    // this.exception,
  ) : super(connectionState);
}

class ConversationJoined extends BaseChatClientEvent {
  // final TwilioException? exception;
  final ConversationModel? conversationModel;

  const ConversationJoined(
    ConnectionState connectionState,
    this.conversationModel,
    // this.exception,
  ) : super(connectionState);

  @override
  String toString() => 'Connect: { conversationModel: $conversationModel  }';
}

/// Use this event if connecting to a Room failed.
class ConnectError extends BaseChatClientEvent {
  // final TwilioException? exception;
  final String error;

  const ConnectError(
    ConnectionState connectionState,
    this.error,
    // this.exception,
  ) : super(connectionState);

  @override
  String toString() => 'ConnectError: { chatClientModel: $error, exception:  }';
}

// /// Use this event when the LocalParticipant is connected to the Room.
// class Connected extends BaseChatClientEvent {
//   const Connected(ChatClientModel chatClientModel) : super(chatClientModel);

//   @override
//   String toString() => 'Connected: { chatClientModel: $chatClientModel }';
// }

// /// Use this event when the LocalParticipant disconnects from the Room.
// class Disconnected extends BaseChatClientEvent {
//   final TwilioExceptionModel? exception;

//   const Disconnected(
//     ChatClientModel chatClientModel,
//     this.exception,
//   ) : super(chatClientModel);

//   @override
//   String toString() => 'Disconnected: { chatClientModel: $chatClientModel, exception: $exception }';
// }

// /// Use this event when a new RemoteParticipant connects to the Room.
// class ParticipantConnected extends BaseChatClientEvent {
//   final RemoteParticipantModel connectedParticipant;

//   const ParticipantConnected(
//     ChatClientModel chatClientModel,
//     this.connectedParticipant,
//   ) : super(chatClientModel);

//   @override
//   String toString() => 'ParticipantConnected: { chatClientModel: $chatClientModel, connectedParticipant: $connectedParticipant }';
// }

// /// Use this event when a RemoteParticipant disconnects from the Room.
// class ParticipantDisconnected extends BaseChatClientEvent {
//   final RemoteParticipantModel disconnectedParticipant;

//   const ParticipantDisconnected(
//     ChatClientModel chatClientModel,
//     this.disconnectedParticipant,
//   ) : super(chatClientModel);

//   @override
//   String toString() => 'ParticipantDisconnected: { chatClientModel: $chatClientModel, disconnectedParticipant: $disconnectedParticipant }';
// }

// /// Use this event when the LocalParticipant reconnects to the Room.
// class Reconnected extends BaseChatClientEvent {
//   const Reconnected(ChatClientModel chatClientModel) : super(chatClientModel);

//   @override
//   String toString() => 'Reconnected: { chatClientModel: $chatClientModel }';
// }

// /// Use this event when the LocalParticipant is reconnecting to the Room.
// class Reconnecting extends BaseChatClientEvent {
//   final TwilioExceptionModel? exception;

//   const Reconnecting(
//     ChatClientModel chatClientModel,
//     this.exception,
//   ) : super(chatClientModel);

//   @override
//   String toString() => 'Reconnecting: { chatClientModel: $chatClientModel, exception: $exception }';
// }

// ///Use this event when recording of the LocalParticipant has started.
// class RecordingStarted extends BaseChatClientEvent {
//   const RecordingStarted(ChatClientModel chatClientModel) : super(chatClientModel);

//   @override
//   String toString() => 'RecordingStarted: { chatClientModel: $chatClientModel }';
// }

// ///Use this event when recording of the LocalParticipant has stopped.
// class RecordingStopped extends BaseChatClientEvent {
//   const RecordingStopped(ChatClientModel chatClientModel) : super(chatClientModel);

//   @override
//   String toString() => 'RecordingStopped: { chatClientModel: $chatClientModel }';
// }

// /// Use this event when a new RemoteParticipant becomes the dominant speaker.
// class DominantSpeakerChanged extends BaseChatClientEvent {
//   final RemoteParticipantModel? dominantSpeaker;

//   const DominantSpeakerChanged(
//     ChatClientModel chatClientModel,
//     this.dominantSpeaker,
//   ) : super(chatClientModel);

//   @override
//   String toString() => 'DominantSpeakerChanged: { chatClientModel: $chatClientModel, dominantSpeaker: $dominantSpeaker }';
// }

// /// Use this event if an invalid RoomEvent is received from native code which should be skipped.
// class SkippableRoomEvent extends BaseChatClientEvent {
//   const SkippableRoomEvent() : super(null);

//   @override
//   String toString() => 'SkippableRoomEvent';
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Chat Model
class Chat {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unread;
  final bool isEmergency;
  final String avatar;
  final bool isOnline;

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unread = 0,
    this.isEmergency = false,
    this.avatar = '',
    this.isOnline = false,
  });

  Chat copyWith({
    String? id,
    String? name,
    String? lastMessage,
    String? time,
    int? unread,
    bool? isEmergency,
    String? avatar,
    bool? isOnline,
  }) {
    return Chat(
      id: id ?? this.id,
      name: name ?? this.name,
      lastMessage: lastMessage ?? this.lastMessage,
      time: time ?? this.time,
      unread: unread ?? this.unread,
      isEmergency: isEmergency ?? this.isEmergency,
      avatar: avatar ?? this.avatar,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}

// Message Model
class Message {
  final String id;
  final String chatId;
  final String text;
  final bool isMe;
  final String time;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.chatId,
    required this.text,
    required this.isMe,
    required this.time,
    required this.timestamp,
  });
}

// Chat State
class ChatState {
  final List<Chat> chats;
  final Map<String, List<Message>> messages;

  ChatState({
    required this.chats,
    required this.messages,
  });

  ChatState copyWith({
    List<Chat>? chats,
    Map<String, List<Message>>? messages,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
      messages: messages ?? this.messages,
    );
  }
}

// Chat Notifier
class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier()
      : super(ChatState(
          chats: _initialChats,
          messages: _initialMessages,
        ));

  // Get or create a chat
  Chat getOrCreateChat(String personId, String personName, {String? avatar}) {
    // Check if chat already exists
    final existingChat = state.chats.firstWhere(
      (chat) => chat.id == personId,
      orElse: () => Chat(
        id: personId,
        name: personName,
        lastMessage: '',
        time: 'Just now',
        avatar: avatar ?? 'https://i.pravatar.cc/150?u=$personId',
      ),
    );

    // If chat doesn't exist in state, add it
    if (!state.chats.any((chat) => chat.id == personId)) {
      state = state.copyWith(
        chats: [existingChat, ...state.chats],
      );
    }

    return existingChat;
  }

  // Send a message
  void sendMessage(String chatId, String text) {
    final now = DateTime.now();
    final newMessage = Message(
      id: '${chatId}_${now.millisecondsSinceEpoch}',
      chatId: chatId,
      text: text,
      isMe: true,
      time: _formatTime(now),
      timestamp: now,
    );

    final chatMessages = state.messages[chatId] ?? [];
    final updatedMessages = Map<String, List<Message>>.from(state.messages);
    updatedMessages[chatId] = [...chatMessages, newMessage];

    // Update chat with last message
    final updatedChats = state.chats.map((chat) {
      if (chat.id == chatId) {
        return chat.copyWith(
          lastMessage: text,
          time: 'Just now',
        );
      }
      return chat;
    }).toList();

    state = state.copyWith(
      messages: updatedMessages,
      chats: updatedChats,
    );
  }

  // Get messages for a chat
  List<Message> getMessages(String chatId) {
    return state.messages[chatId] ?? [];
  }

  // Mark chat as read
  void markAsRead(String chatId) {
    final updatedChats = state.chats.map((chat) {
      if (chat.id == chatId) {
        return chat.copyWith(unread: 0);
      }
      return chat;
    }).toList();

    state = state.copyWith(chats: updatedChats);
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}

// Initial data
final List<Chat> _initialChats = [
  Chat(
    id: '1',
    name: 'Emergency Support',
    lastMessage: 'How can we help you today?',
    time: '2m ago',
    unread: 2,
    isEmergency: true,
    avatar: 'https://i.pravatar.cc/150?u=emergency',
  ),
  Chat(
    id: '2',
    name: 'Dr. Sarah Miller',
    lastMessage: 'Your training certificate is ready',
    time: '1h ago',
    unread: 0,
    avatar: 'https://i.pravatar.cc/150?u=sarah',
    isOnline: true,
  ),
  Chat(
    id: '3',
    name: 'Community Group',
    lastMessage: 'New first aid workshop this weekend!',
    time: '3h ago',
    unread: 5,
    avatar: 'https://i.pravatar.cc/150?u=community',
  ),
  Chat(
    id: '4',
    name: 'John (Responder)',
    lastMessage: 'Thanks for your feedback',
    time: 'Yesterday',
    unread: 0,
    avatar: 'https://i.pravatar.cc/150?u=john',
  ),
];

final Map<String, List<Message>> _initialMessages = {
  '1': [
    Message(
      id: '1_1',
      chatId: '1',
      text: 'Hello! How can we assist you today?',
      isMe: false,
      time: '10:40 AM',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    Message(
      id: '1_2',
      chatId: '1',
      text: 'I need help with first aid training.',
      isMe: true,
      time: '10:41 AM',
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
    Message(
      id: '1_3',
      chatId: '1',
      text: 'How can we help you today?',
      isMe: false,
      time: '10:42 AM',
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
  ],
  '2': [
    Message(
      id: '2_1',
      chatId: '2',
      text: 'Your training certificate is ready',
      isMe: false,
      time: '9:30 AM',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ],
  '4': [
    Message(
      id: '4_1',
      chatId: '4',
      text: "I'm 2 minutes away. Please stay calm.",
      isMe: false,
      time: '10:42 AM',
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
    Message(
      id: '4_2',
      chatId: '4',
      text: "I'm by the main entrance. I have my hazard lights on.",
      isMe: true,
      time: '10:43 AM',
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    Message(
      id: '4_3',
      chatId: '4',
      text: "Understood. I see your location. Don't move the patient.",
      isMe: false,
      time: '10:43 AM',
      timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
  ],
};

// Provider
final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier();
});

// Helper providers
final chatsListProvider = Provider<List<Chat>>((ref) {
  return ref.watch(chatProvider).chats;
});

// Provider that only returns chats with messages
final chatsWithMessagesProvider = Provider<List<Chat>>((ref) {
  final state = ref.watch(chatProvider);
  return state.chats.where((chat) {
    final messages = state.messages[chat.id];
    return messages != null && messages.isNotEmpty;
  }).toList();
});

final chatMessagesProvider = Provider.family<List<Message>, String>((ref, chatId) {
  return ref.watch(chatProvider).messages[chatId] ?? [];
});

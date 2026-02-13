import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../core/providers/chat_provider.dart';
import '../../core/router/app_router.dart';
import '../../widgets/new_chat_dialog.dart';

class MessagesInbox extends ConsumerStatefulWidget {
  const MessagesInbox({super.key});

  @override
  ConsumerState<MessagesInbox> createState() => _MessagesInboxState();
}

class _MessagesInboxState extends ConsumerState<MessagesInbox> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  List<Chat> get _filteredChats {
    final chats = ref.watch(chatsWithMessagesProvider);
    if (_searchQuery.isEmpty) return chats;
    return chats.where((chat) {
      return chat.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          chat.lastMessage.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Search messages...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.surface,
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          // Chat List
          Expanded(
            child: _filteredChats.isEmpty
                ? const Center(
                    child: Text(
                      'No messages found',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = _filteredChats[index];
                      return _ChatItem(
                        chat: chat,
                        onTap: () {
                          // Mark as read
                          ref.read(chatProvider.notifier).markAsRead(chat.id);

                          // Determine the base route based on current location
                          final currentPath = GoRouterState.of(
                            context,
                          ).uri.path;
                          final baseRoute =
                              currentPath.startsWith(
                                AppRoutes.responderMessages,
                              )
                              ? AppRoutes.responderMessages
                              : AppRoutes.messages;

                          // Navigate to chat
                          context.push(
                            '$baseRoute/${chat.id}?name=${Uri.encodeComponent(chat.name)}&avatar=${Uri.encodeComponent(chat.avatar)}',
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ChatItem extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;

  const _ChatItem({required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: chat.isEmergency
            ? AppColors.primaryRed
            : AppColors.surface,
        child: chat.isEmergency
            ? Icon(Icons.emergency, color: Colors.white)
            : ClipOval(
                child: Image(
                  image: NetworkImage(chat.avatar),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, color: AppColors.primaryRed);
                  },
                ),
              ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              chat.name,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: chat.unread > 0
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          Text(
            chat.time,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              chat.lastMessage,
              style: const TextStyle(color: AppColors.textSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (chat.unread > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryRed,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${chat.unread}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_theme.dart';

class MessagesInbox extends StatefulWidget {
  const MessagesInbox({super.key});

  @override
  State<MessagesInbox> createState() => _MessagesInboxState();
}

class _MessagesInboxState extends State<MessagesInbox> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  final List<_ChatPreview> _chats = [
    _ChatPreview(
      id: '1',
      name: 'Emergency Support',
      lastMessage: 'How can we help you today?',
      time: '2m ago',
      unread: 2,
      isEmergency: true,
    ),
    _ChatPreview(
      id: '2',
      name: 'Dr. Sarah Miller',
      lastMessage: 'Your training certificate is ready',
      time: '1h ago',
      unread: 0,
    ),
    _ChatPreview(
      id: '3',
      name: 'Community Group',
      lastMessage: 'New first aid workshop this weekend!',
      time: '3h ago',
      unread: 5,
    ),
    _ChatPreview(
      id: '4',
      name: 'John (Responder)',
      lastMessage: 'Thanks for your feedback',
      time: 'Yesterday',
      unread: 0,
    ),
  ];

  List<_ChatPreview> get _filteredChats {
    if (_searchQuery.isEmpty) return _chats;
    return _chats.where((chat) {
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
                          context.push(
                            '/messages/${chat.id}?name=${Uri.encodeComponent(chat.name)}',
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

class _ChatPreview {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unread;
  final bool isEmergency;

  _ChatPreview({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unread,
    this.isEmergency = false,
  });
}

class _ChatItem extends StatelessWidget {
  final _ChatPreview chat;
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
        child: Icon(
          chat.isEmergency ? Icons.emergency : Icons.person,
          color: chat.isEmergency ? Colors.white : AppColors.textSecondary,
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

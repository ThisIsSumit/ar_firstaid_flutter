import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import '../../core/providers/chat_provider.dart';

class MessagesPage extends ConsumerStatefulWidget {
  const MessagesPage({super.key});

  @override
  ConsumerState<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends ConsumerState<MessagesPage> {
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
    const Color scaffoldBg = Color(0xFF0A0A0B);
    const Color primaryRed = Color(0xFFFF3B5C);
    const Color surfaceDark = Color(0xFF15151A);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A24),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add_moderator_rounded,
              color: primaryRed,
              size: 18,
            ),
          ),
        ),
        title: const Text(
          'LifeLens',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.messages),
            icon: const Icon(Icons.edit_note_rounded, color: Colors.white),
          ),
          IconButton(
            onPressed: () => context.push('${AppRoutes.profile}/settings'),
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Messages',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: surfaceDark,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: const Icon(Icons.search, color: Colors.white24),
                  hintText: 'Search chats, responders...',
                  hintStyle: const TextStyle(
                    color: Colors.white24,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white24),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                ),
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
            ),
          ),

          const SizedBox(height: 25),

          Expanded(
            child: _filteredChats.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isEmpty
                              ? 'No messages yet'
                              : 'No chats found',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16,
                          ),
                        ),
                        if (_searchQuery.isEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Start a conversation from the Community tab',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.3),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = _filteredChats[index];
                      return _buildChatTile(context, chat: chat, index: index)
                          .animate()
                          .fadeIn(duration: 400.ms, delay: (index * 50).ms)
                          .slideX(
                            begin: -0.1,
                            duration: 400.ms,
                            delay: (index * 50).ms,
                          );
                    },
                  ),
          ),
        ],
      ).animate().fadeIn(duration: 400.ms),
    );
  }

  Widget _buildChatTile(
    BuildContext context, {
    required Chat chat,
    required int index,
  }) {
    const Color primaryRed = Color(0xFFFF3B5C);

    return GestureDetector(
      onTap: () {
        // Mark as read
        ref.read(chatProvider.notifier).markAsRead(chat.id);

        // Determine the base route based on current location
        final currentPath = GoRouterState.of(context).uri.path;
        final baseRoute = currentPath.startsWith(AppRoutes.responderMessages)
            ? AppRoutes.responderMessages
            : AppRoutes.messages;

        // Navigate to chat
        context.push(
          '$baseRoute/${chat.id}?name=${Uri.encodeComponent(chat.name)}&avatar=${Uri.encodeComponent(chat.avatar)}',
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: chat.isEmergency
              ? const Color(0xFF1A1315)
              : const Color(0xFF15151A),
          borderRadius: BorderRadius.circular(20),
          border: chat.isEmergency
              ? Border.all(color: primaryRed.withOpacity(0.3))
              : null,
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFF1A1A24),
                  child: chat.avatar.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            chat.avatar,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                chat.isEmergency
                                    ? Icons.local_hospital_rounded
                                    : Icons.person,
                                color: primaryRed.withOpacity(0.7),
                                size: 28,
                              );
                            },
                          ),
                        )
                      : Icon(
                          chat.isEmergency
                              ? Icons.local_hospital_rounded
                              : Icons.person,
                          color: primaryRed.withOpacity(0.7),
                          size: 28,
                        ),
                ),
                if (chat.isOnline)
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF0A0A0B),
                        width: 2,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: chat.unread > 0
                                ? FontWeight.bold
                                : FontWeight.w600,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (chat.isEmergency)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: primaryRed,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'PRIORITY',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        chat.time,
                        style: TextStyle(
                          color: chat.isEmergency
                              ? primaryRed
                              : Colors.white.withOpacity(0.3),
                          fontSize: 12,
                          fontWeight: chat.isEmergency
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (chat.unread > 0) ...[
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(6),
                constraints: const BoxConstraints(minWidth: 24),
                decoration: const BoxDecoration(
                  color: primaryRed,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${chat.unread}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

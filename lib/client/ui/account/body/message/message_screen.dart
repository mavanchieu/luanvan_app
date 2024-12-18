import 'package:app_lv/client/services/socket.io.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_lv/client/manager/message_manager.dart';
import 'package:app_lv/client/services/login.service.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final SocketService socketService = SocketService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    socketService.connect();

    // Lấy danh sách tin nhắn khi khởi tạo
    context
        .read<MessageManager>()
        .fetchMesssage(context.read<LoginService>().userId)
        .then((_) => _scrollToBottom());

    // Lắng nghe sự kiện từ socket
    socketService.on('createMessage', (data) async {
      if (mounted) {
        print('createMessage: $data');
        await context
            .read<MessageManager>()
            .fetchMesssage(context.read<LoginService>().userId);
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat với cửa hàng"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<MessageManager>(
              builder: (context, messageManager, child) {
                if (messageManager.chatModel.isEmpty) {
                  return const Center(
                    child: Text("Không có tin nhắn nào."),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messageManager.chatModel[0].messages.length,
                  itemBuilder: (context, index) {
                    final message = messageManager.chatModel[0].messages[index];

                    return Align(
                      alignment: message.status == "0"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: message.status == "0"
                              ? Colors.blue[100]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message.content,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Nhập tin nhắn...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    _sendMessage(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    final content = _messageController.text.trim();
    if (content.isNotEmpty) {
      context
          .read<MessageManager>()
          .create(context.read<LoginService>().userId, content)
          .then((_) => _scrollToBottom());
      _messageController.clear();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/controllers/chat_controller.dart';
import 'package:waro/controllers/auth_controller.dart';
import 'package:waro/core/theme/app_colors.dart';

class ChatScreen extends StatefulWidget {
  final String partnerId;
  final String partnerName;
  final String? inquiryId;
  final String? leadId;

  const ChatScreen({
    super.key,
    required this.partnerId,
    required this.partnerName,
    this.inquiryId,
    this.leadId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController controller = Get.put(ChatController());
  final AuthController authController = Get.find<AuthController>();
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.connectSocket();
    controller.fetchConversation(
      widget.partnerId,
      inquiryId: widget.inquiryId,
      leadId: widget.leadId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.white,
                child: Text(widget.partnerName.substring(0, 1).toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.black)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.partnerName,
                    style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: -0.2),
                  ),
                  Text(
                    'Online',
                    style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(LucideIcons.phone, size: 20), onPressed: () {}),
          IconButton(icon: const Icon(LucideIcons.moreVertical, size: 20), onPressed: () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.messages.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                reverse: false,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];
                  final isMe = (msg['senderId'] is Map ? msg['senderId']['_id'] : msg['senderId']) == authController.user.value?.id;
                  
                  return _buildMessageBubble(msg['text'] ?? '', isMe);
                },
              );
            }),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        constraints: BoxConstraints(maxWidth: Get.width * 0.75),
        decoration: BoxDecoration(
          gradient: isMe 
            ? LinearGradient(colors: [AppColors.primary, AppColors.primaryDark])
            : null,
          color: isMe ? null : AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: GoogleFonts.outfit(
            color: Colors.black,
            fontSize: 14,
            fontWeight: isMe ? FontWeight.w800 : FontWeight.w500,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: Row(
        children: [
          _buildCircleAction(LucideIcons.plus),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _messageController,
                style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Type message...',
                  hintStyle: GoogleFonts.outfit(color: AppColors.grey, fontWeight: FontWeight.w500),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.black,
            child: IconButton(
              icon: const Icon(LucideIcons.send, size: 18, color: AppColors.primary),
              onPressed: () {
                if (_messageController.text.trim().isNotEmpty) {
                  controller.sendMessage(
                    widget.partnerId,
                    _messageController.text.trim(),
                    inquiryId: widget.inquiryId,
                    leadId: widget.leadId,
                  );
                  _messageController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleAction(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: AppColors.foreground),
    );
  }
}

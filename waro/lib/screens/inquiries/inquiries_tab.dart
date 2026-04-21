import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/controllers/inquiry_controller.dart';
import 'package:waro/core/theme/app_colors.dart';
import '../chat/chat_screen.dart';

class InquiriesTab extends StatefulWidget {
  const InquiriesTab({super.key});

  @override
  State<InquiriesTab> createState() => _InquiriesTabState();
}

class _InquiriesTabState extends State<InquiriesTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final InquiryController controller = Get.put(InquiryController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'MESSAGES',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 20, letterSpacing: -0.5),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.grey,
              dividerColor: Colors.transparent,
              labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 0.5),
              tabs: const [
                Tab(text: 'INQUIRIES'),
                Tab(text: 'BUY LEADS'),
                Tab(text: 'CALL ALERTS'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInquiryList(controller.inquiries),
          _buildInquiryList(controller.leads),
          _buildCallAlerts(),
        ],
      ),
    );
  }

  Widget _buildInquiryList(RxList list) {
    return Obx(() {
      if (controller.isLoading.value && list.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      
      if (list.isEmpty) {
        return Center(
          child: Opacity(
            opacity: 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.messageSquare, size: 60, color: AppColors.grey),
                const SizedBox(height: 16),
                Text('NO MESSAGES YET', style: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1)),
              ],
            ),
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          final name = item['name'] ?? item['fullName'] ?? 'User';
          final company = item['companyName'] ?? item['senderCompanyName'] ?? 'Company';
          
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primary)),
                child: CircleAvatar(
                  backgroundColor: AppColors.lightGrey,
                  child: Text(name.substring(0, 1).toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                ),
              ),
              title: Text(
                company,
                style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 15),
              ),
              subtitle: Text(
                name,
                style: GoogleFonts.outfit(fontSize: 12, color: AppColors.grey, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(LucideIcons.chevronRight, size: 16, color: AppColors.grey),
              onTap: () => Get.to(() => ChatScreen(
                partnerId: item['senderId'] ?? item['userId']?['_id'] ?? '',
                partnerName: company,
                inquiryId: item['_id'],
              )),
            ),
          );
        },
      );
    });
  }

  Widget _buildCallAlerts() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.phoneIncoming, size: 60, color: AppColors.grey),
          const SizedBox(height: 16),
          Text('NO CALL ALERTS', style: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1, color: AppColors.grey)),
        ],
      ),
    );
  }
}

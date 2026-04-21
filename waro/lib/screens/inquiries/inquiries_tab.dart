import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/controllers/inquiry_controller.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/section_header.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 12, 8),
              child: Row(
                children: [
                  Text('Messages',
                      style: GoogleFonts.plusJakartaSans(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.foreground, letterSpacing: -0.5)),
                  const Spacer(),
                  IconButton(icon: const Icon(LucideIcons.search), onPressed: () => Get.toNamed('/search')),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: BorderRadius.circular(999),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppColors.foreground,
                  borderRadius: BorderRadius.circular(999),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 12.5),
                unselectedLabelStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 12.5),
                dividerColor: Colors.transparent,
                tabs: const [Tab(text: 'Inquiries'), Tab(text: 'Buy leads'), Tab(text: 'Calls')],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _list(controller.inquiries),
                  _list(controller.leads),
                  const EmptyState(
                    icon: LucideIcons.phoneIncoming,
                    title: 'No call alerts',
                    subtitle: 'Direct call requests from buyers will appear here.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _list(RxList list) {
    return Obx(() {
      if (controller.isLoading.value && list.isEmpty) return const LoadingView();
      if (list.isEmpty) {
        return const EmptyState(
          icon: LucideIcons.messageSquare,
          title: 'No messages yet',
          subtitle: 'Inquiries and leads from your network will show up here.',
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        itemCount: list.length,
        itemBuilder: (_, i) {
          final item = list[i];
          final name = item['name'] ?? item['fullName'] ?? 'User';
          final company = item['companyName'] ?? item['senderCompanyName'] ?? 'Company';
          final preview = item['message'] ?? item['inquiry'] ?? 'Tap to view conversation';
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.borderSoft),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              onTap: () => Get.to(() => ChatScreen(
                    partnerId: item['senderId'] ?? item['userId']?['_id'] ?? '',
                    partnerName: company,
                    inquiryId: item['_id'],
                  )),
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primary.withOpacity(0.25),
                child: Text(
                  (name.isNotEmpty ? name[0] : '?').toUpperCase(),
                  style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, color: AppColors.foreground),
                ),
              ),
              title: Text(company, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 14)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  preview.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(fontSize: 12.5, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
                ),
              ),
              trailing: const Icon(LucideIcons.chevronRight, size: 16, color: AppColors.textMuted),
            ),
          );
        },
      );
    });
  }
}

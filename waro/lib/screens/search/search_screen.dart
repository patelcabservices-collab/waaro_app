import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/app_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _q = TextEditingController();
  String _filter = 'All';
  static const _filters = ['All', 'Products', 'Businesses', 'Posts', 'Inquiries'];
  static const _suggestions = [
    'Steel suppliers in Mumbai',
    'Industrial pumps',
    'Cotton fabric wholesale',
    'PCB manufacturing',
    'Packaging machinery',
  ];

  @override
  void initState() {
    super.initState();
    final arg = Get.arguments;
    if (arg is String) _q.text = arg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(LucideIcons.arrowLeft), onPressed: () => Get.back()),
        title: const Text('Search'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          AppTextField(
            controller: _q,
            hint: 'Search products, businesses, posts…',
            prefixIcon: LucideIcons.search,
            autofocus: true,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final f = _filters[i];
                final selected = _filter == f;
                return ChoiceChip(
                  label: Text(f),
                  selected: selected,
                  onSelected: (_) => setState(() => _filter = f),
                  labelStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: selected ? AppColors.primary : AppColors.foreground,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          if (_q.text.trim().isEmpty) ...[
            Text('Trending searches', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 14)),
            const SizedBox(height: 10),
            ..._suggestions.map((s) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(LucideIcons.trendingUp, size: 18, color: AppColors.textSecondary),
                  title: Text(s, style: GoogleFonts.plusJakartaSans(fontSize: 13.5, fontWeight: FontWeight.w600)),
                  trailing: const Icon(LucideIcons.arrowUpRight, size: 16, color: AppColors.textMuted),
                  onTap: () => setState(() => _q.text = s),
                )),
          ] else
            ..._mockResults().map(_resultRow),
        ],
      ),
    );
  }

  List<Map<String, String>> _mockResults() => [
        {'title': '${_q.text} – Premium grade', 'meta': 'Manufacturer · Verified · Pune'},
        {'title': '${_q.text} – Bulk pricing', 'meta': 'Wholesaler · Mumbai'},
        {'title': '${_q.text} – Custom options', 'meta': 'Distributor · Delhi NCR'},
      ];

  Widget _resultRow(Map<String, String> r) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderSoft),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(12)),
              child: const Icon(LucideIcons.package, size: 18, color: AppColors.foreground),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r['title']!, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 13.5)),
                  const SizedBox(height: 2),
                  Text(r['meta']!, style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const Icon(LucideIcons.chevronRight, size: 16, color: AppColors.textMuted),
          ],
        ),
      );
}

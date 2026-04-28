import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/controllers/create_controller.dart';
import 'package:waro/core/theme/app_colors.dart';
import 'package:waro/widgets/common/app_text_field.dart';
import 'package:waro/widgets/common/primary_button.dart';

class CreateTab extends StatefulWidget {
  const CreateTab({super.key});

  @override
  State<CreateTab> createState() => _CreateTabState();
}

class _CreateTabState extends State<CreateTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final CreateController _controller = Get.put(CreateController());

  final _productName = TextEditingController();
  final _productDesc = TextEditingController();
  final _price = TextEditingController();
  final _unit = TextEditingController(text: 'PC');
  File? _productImage;

  final _postDesc = TextEditingController();
  final _location = TextEditingController();
  File? _postImage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
              child: Row(
                children: [
                  Text('Create',
                      style: GoogleFonts.plusJakartaSans(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.foreground, letterSpacing: -0.5)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 12, 20, 12),
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
                labelStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 13),
                unselectedLabelStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 13),
                dividerColor: Colors.transparent,
                tabs: const [Tab(text: 'Product'), Tab(text: 'Post')],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildProductForm(), _buildPostForm()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _imagePicker(_productImage, (f) => setState(() => _productImage = f), 'Add product image'),
          const SizedBox(height: 22),
          AppTextField(controller: _productName, label: 'Product name', hint: 'e.g. Industrial pump', prefixIcon: LucideIcons.box),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: AppTextField(controller: _price, label: 'Price', hint: '10000', prefixIcon: LucideIcons.tag, keyboardType: TextInputType.number),
              ),
              const SizedBox(width: 12),
              Expanded(child: AppTextField(controller: _unit, label: 'Unit', hint: 'PC / KG', prefixIcon: LucideIcons.layers)),
            ],
          ),
          const SizedBox(height: 14),
          AppTextField(controller: _productDesc, label: 'Description', hint: 'Tell buyers about this product…', prefixIcon: LucideIcons.alignLeft, maxLines: 5, minLines: 4),
          const SizedBox(height: 28),
          Obx(() => PrimaryButton(
                label: 'List product',
                loading: _controller.isLoading.value,
                variant: PrimaryButtonVariant.dark,
                icon: LucideIcons.send,
                onPressed: _submitProduct,
              )),
        ],
      ),
    );
  }

  Widget _buildPostForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _imagePicker(_postImage, (f) => setState(() => _postImage = f), 'Add a photo'),
          const SizedBox(height: 22),
          AppTextField(controller: _postDesc, label: 'Caption', hint: "What's on your mind?", prefixIcon: LucideIcons.messageSquare, maxLines: 6, minLines: 4),
          const SizedBox(height: 14),
          AppTextField(controller: _location, label: 'Location', hint: 'Add location (optional)', prefixIcon: LucideIcons.mapPin),
          const SizedBox(height: 28),
          Obx(() => PrimaryButton(
                label: 'Share post',
                loading: _controller.isLoading.value,
                variant: PrimaryButtonVariant.dark,
                icon: LucideIcons.send,
                onPressed: _submitPost,
              )),
        ],
      ),
    );
  }

  Widget _imagePicker(File? image, Function(File) onPicked, String label) {
    return InkWell(
      onTap: () async {
        try {
          final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
          if (picked != null) onPicked(File(picked.path));
        } catch (_) {
          Get.snackbar('Image picker', 'Not available in this environment');
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.18), shape: BoxShape.circle),
                    child: const Icon(LucideIcons.imagePlus, size: 26, color: AppColors.primaryDark),
                  ),
                  const SizedBox(height: 10),
                  Text(label, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 13.5, color: AppColors.foreground)),
                  const SizedBox(height: 4),
                  Text('PNG or JPG · up to 5MB', style: GoogleFonts.plusJakartaSans(fontSize: 11.5, color: AppColors.textMuted, fontWeight: FontWeight.w600)),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(image, fit: BoxFit.cover, width: double.infinity),
              ),
      ),
    );
  }

  void _submitProduct() async {
    if (_productName.text.isEmpty) {
      Get.snackbar('Missing field', 'Product name is required');
      return;
    }
    final ok = await _controller.createProduct(
      productName: _productName.text,
      description: _productDesc.text,
      price: double.tryParse(_price.text) ?? 0,
      priceUnit: _unit.text.isEmpty ? 'PC' : _unit.text,
      category: 'Electronics',
      city: 'Ahmedabad',
      state: 'Gujarat',
      imageFile: _productImage,
    );
    if (ok) {
      Get.snackbar('Listed', 'Your product is now live');
      _reset();
    }
  }

  void _submitPost() async {
    if (_postDesc.text.isEmpty || _postImage == null) {
      Get.snackbar('Missing fields', 'Caption and image are required');
      return;
    }
    final ok = await _controller.createPost(
      description: _postDesc.text,
      keywords: '',
      imageFile: _postImage!,
    );
    if (ok) {
      Get.snackbar('Shared', 'Your post is live');
      _reset();
    }
  }

  void _reset() {
    _productName.clear();
    _productDesc.clear();
    _price.clear();
    _postDesc.clear();
    _location.clear();
    setState(() {
      _productImage = null;
      _postImage = null;
    });
  }
}

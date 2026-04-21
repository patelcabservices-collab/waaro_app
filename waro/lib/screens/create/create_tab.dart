import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:waro/controllers/create_controller.dart';
import 'package:waro/core/theme/app_colors.dart';

class CreateTab extends StatefulWidget {
  const CreateTab({super.key});

  @override
  State<CreateTab> createState() => _CreateTabState();
}

class _CreateTabState extends State<CreateTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final CreateController _controller = Get.put(CreateController());
  
  final _productNameController = TextEditingController();
  final _productDescController = TextEditingController();
  final _priceController = TextEditingController();
  File? _productImage;
  
  final _postDescController = TextEditingController();
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
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'CREATE NEW',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 2, color: AppColors.foreground),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.grey,
              labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1),
              unselectedLabelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'PRODUCT'),
                Tab(text: 'POST'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProductForm(),
                _buildPostForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImagePicker(_productImage, (file) => setState(() => _productImage = file), 'PRODUCT IMAGE'),
          const SizedBox(height: 32),
          _buildPremiumInput(_productNameController, 'Product Name', 'e.g. Industrial Pump', LucideIcons.box),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildPremiumInput(_priceController, 'Price', '₹ 10,000', LucideIcons.tag, keyboardType: TextInputType.number)),
              const SizedBox(width: 16),
              Expanded(child: _buildPremiumInput(TextEditingController(text: 'PC'), 'Unit', 'per PC', LucideIcons.layers)),
            ],
          ),
          const SizedBox(height: 20),
          _buildPremiumInput(_productDescController, 'Description', 'Tell us more about the product...', LucideIcons.alignLeft, maxLines: 4),
          const SizedBox(height: 40),
          _buildSubmitButton('LIST PRODUCT', _submitProduct),
        ],
      ),
    );
  }

  Widget _buildPostForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImagePicker(_postImage, (file) => setState(() => _postImage = file), 'POST MEDIA'),
          const SizedBox(height: 32),
          _buildPremiumInput(_postDescController, 'Caption', 'What\'s on your mind?', LucideIcons.messageCircle, maxLines: 5),
          const SizedBox(height: 20),
          _buildPremiumInput(TextEditingController(), 'Location', 'Add location', LucideIcons.mapPin),
          const SizedBox(height: 40),
          _buildSubmitButton('SHARE POST', _submitPost),
        ],
      ),
    );
  }

  Widget _buildPremiumInput(TextEditingController controller, String label, String hint, IconData icon, {int maxLines = 1, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(label.toUpperCase(), style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.grey, letterSpacing: 1)),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5)],
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.outfit(color: AppColors.grey.withOpacity(0.5), fontWeight: FontWeight.w500),
              prefixIcon: Icon(icon, size: 18, color: AppColors.grey),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
              fillColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePicker(File? image, Function(File) onPicked, String label) {
    return InkWell(
      onTap: () async {
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) onPicked(File(pickedFile.path));
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.primary.withOpacity(0.5), style: BorderStyle.solid),
          boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.05), blurRadius: 20)],
        ),
        child: image == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(LucideIcons.camera, size: 30, color: AppColors.primaryDark),
                ),
                const SizedBox(height: 12),
                Text(label, style: GoogleFonts.outfit(fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 0.5)),
              ],
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.file(image, fit: BoxFit.cover),
            ),
      ),
    );
  }

  Widget _buildSubmitButton(String label, VoidCallback onPressed) {
    return Obx(() => ElevatedButton(
      onPressed: _controller.isLoading.value ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: AppColors.primary,
        minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        shadowColor: AppColors.primary.withOpacity(0.2),
      ),
      child: _controller.isLoading.value 
        ? const CircularProgressIndicator(color: AppColors.primary)
        : Text(label, style: GoogleFonts.outfit(fontWeight: FontWeight.w900, letterSpacing: 1.5)),
    ));
  }

  void _submitProduct() async {
    if (_productNameController.text.isEmpty) {
      Get.snackbar('Error', 'Product name is required');
      return;
    }
    
    bool success = await _controller.createProduct(
      productName: _productNameController.text,
      description: _productDescController.text,
      price: double.tryParse(_priceController.text) ?? 0,
      priceUnit: 'PC',
      category: 'Electronics',
      city: 'Ahmedabad',
      state: 'Gujarat',
      imageFile: _productImage,
    );
    
    if (success) {
      Get.snackbar('Success', 'Product created!');
      _wipeFields();
    }
  }

  void _submitPost() async {
    if (_postDescController.text.isEmpty || _postImage == null) {
      Get.snackbar('Error', 'Description and image are required');
      return;
    }
    
    bool success = await _controller.createPost(
      description: _postDescController.text,
      keywords: '',
      imageFile: _postImage!,
    );
    
    if (success) {
      Get.snackbar('Success', 'Post shared!');
      _wipeFields();
    }
  }

  void _wipeFields() {
    _productNameController.clear();
    _productDescController.clear();
    _priceController.clear();
    _postDescController.clear();
    setState(() {
      _productImage = null;
      _postImage = null;
    });
  }
}

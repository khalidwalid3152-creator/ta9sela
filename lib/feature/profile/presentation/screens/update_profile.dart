import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverCubit.dart';
import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverState.dart';
import 'package:ta9sela/feature/home/data/cubits/userCubit/userState.dart';
import 'package:ta9sela/feature/home/data/cubits/userCubit/usersCubit.dart';
import 'package:ta9sela/feature/home/data/models/driverModel.dart';

import 'package:ta9sela/feature/home/data/models/userModel.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic user;
 

   const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController governorateController;
  late TextEditingController passwordController;

  String _imageUrl = '';
  bool _uploading = false;

  /// 🔥 Cloudinary config بتاعك
  final CloudinaryPublic _cloudinary = CloudinaryPublic(
    'dfplculyh',
    'kimage',
    cache: false,
  );

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    phoneController = TextEditingController(text: widget.user.phone);
    governorateController = TextEditingController(
      text: widget.user.governorate,
    );
    passwordController = TextEditingController(text: widget.user.password);
    _imageUrl = widget.user.userType == 'driver'
    ? (widget.user.profileImage ?? '')
    : widget.user.imageUrl;

  }

  /// ✅ اختيار صورة ورفعها Cloudinary
  Future<void> pickAndUpload(ImageSource source) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source, imageQuality: 70);

    if (file == null) return;

    try {
      setState(() => _uploading = true);

      CloudinaryResponse response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      setState(() {
        _imageUrl = response.secureUrl;
      });
    } catch (e) {
      print("Upload Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('فشل رفع الصورة')));
    } finally {
      setState(() => _uploading = false);
    }
  }

  /// Bottom sheet اختيار الكاميرا أو الجاليري
  void showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('كاميرا'),
            onTap: () {
              Navigator.pop(context);
              pickAndUpload(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('الجاليري'),
            onTap: () {
              Navigator.pop(context);
              pickAndUpload(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  void saveU() {
    final updatedUser = UserModel(
      id: widget.user.id,
      password: passwordController.text.isEmpty
          ? widget.user.password
          : passwordController.text.trim(),
      name: nameController.text.isEmpty
          ? widget.user.name
          : nameController.text.trim(),
      email: emailController.text.isEmpty
          ? widget.user.email
          : emailController.text.trim(),
      phone: phoneController.text.isEmpty
          ? widget.user.phone
          : phoneController.text.trim(),
      userType: widget.user.userType,
      governorate: governorateController.text.isEmpty
          ? widget.user.governorate
          : governorateController.text.trim(),
      imageUrl: _imageUrl.isEmpty ? widget.user.imageUrl : _imageUrl,
    );
    context.read<UserCubit>().updateUser(updatedUser);

    Navigator.pop(context, updatedUser); // ✅ ده اللي بيرجعك
  }
void saveD() {
  final updatedDriver = DriverModel(
    id: widget.user.id, // ✅ أهم حاجة: نفس الـ doc id
    password: passwordController.text.trim().isEmpty
        ? widget.user.password
        : passwordController.text.trim(),

    name: nameController.text.trim().isEmpty
        ? widget.user.name
        : nameController.text.trim(),

    email: emailController.text.trim().isEmpty
        ? widget.user.email
        : emailController.text.trim(),

    phone: phoneController.text.trim().isEmpty
        ? widget.user.phone
        : phoneController.text.trim(),

    governorate: governorateController.text.trim().isEmpty
        ? widget.user.governorate
        : governorateController.text.trim(),

    userType: widget.user.userType, // غالبًا "driver"

    // ✅ صورة البروفايل للسواق (حسب موديلك اسمه profileImage)
    profileImage: _imageUrl.isEmpty ? widget.user.imageUrl : _imageUrl,

    // ✅ خلي الباقي زي ما هو/قيم افتراضية معقولة
    carImage: '', // لو عندك شاشة مخصوص للعربية حط قيمتها هنا
    rating: 0.0,
    totalTrips: 0,
    isOnline: false,
    lat: 0,
    lng: 0,
  );

  context.read<DriverCubit>().updateDriver(updatedDriver);

  Navigator.pop(context, updatedDriver);
}


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserCubit, UserState>(listener: (context, state) {}),
          BlocListener<DriverCubit, DriverState>(listener: (context, state) {}),
        ],
        child: Scaffold(
          appBar: AppBar(title: const Text("تعديل البيانات")),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                /// صورة المستخدم
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(_imageUrl),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: InkWell(
                          onTap: showImagePicker,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: _uploading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                _field("الاسم", nameController),
                _field("الايميل", emailController),
                _field("الموبايل", phoneController),
                _field("المحافظة", governorateController),
                _field("كلمة المرور", passwordController),

                const SizedBox(height: 25),

                ElevatedButton(
                  onPressed: () {
                    if (widget.user.userType == 'user') {
                      saveU();
                    } else if (widget.user.userType == 'driver') {
                      saveD();
                    }
                  },
                  child: const Text("حفظ"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

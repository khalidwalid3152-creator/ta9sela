import 'dart:io';

class Validators {
  /// Validate Name
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الاسم مطلوب';
    } else if (value.trim().length < 3) {
      return 'الاسم يجب أن يكون 3 أحرف على الأقل';
    }
    return null;
  }

  /// Validate Email
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'أدخل بريد إلكتروني صالح';
    }
    return null;
  }

  /// Validate Password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    } else if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return null;
  }

  /// Validate Phone
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'رقم الهاتف مطلوب';
    } else if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
      return 'أدخل رقم هاتف صالح';
    }
    return null;
  }

  /// Validate User Type (مثلاً Student / Teacher)
  static String? validateUserType(String? value) {
    if (value == null || value.isEmpty) {
      return 'اختر نوع المستخدم';
    }
    return null;
  }

  /// Validate Profile Image
  static String? validateImage(File? file) {
    if (file == null) {
      return 'اختر صورة';
    }
    return null;
  }

  /// Confirm Password
  static String? validateConfirmPassword(String? password, String? confirm) {
    if (confirm == null || confirm.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    } else if (password != confirm) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }
}

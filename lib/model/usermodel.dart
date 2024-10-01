class UserModel {
  String? message;
  bool? status;
  String? token;
  User? user;

  UserModel({this.message, this.status, this.token, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = message;
    data['status'] = status;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? code;
  Null username;
  Null profileImage;
  String? name;
  String? email;
  Null emailVerifiedAt;
  String? phone;
  String? otpExpiresAt;
  int? otp;
  Null phoneOtp;
  Null phoneOtpExpiresAt;
  Null forgotOtp;
  Null forgotOtpExpiresAt;
  String? createdAt;
  String? updatedAt;
  String? userType;
  int? isFirstLogin;
  String? otpVerified;
  String? phoneOtpVerified;
  String? isDeactivate;
  Null deactivateReason;
  Null deletedAt;
  String? deletedStatus;
  Null deviceToken;
  String? appType;

  User(
      {this.id,
      this.code,
      this.username,
      this.profileImage,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.phone,
      this.otpExpiresAt,
      this.otp,
      this.phoneOtp,
      this.phoneOtpExpiresAt,
      this.forgotOtp,
      this.forgotOtpExpiresAt,
      this.createdAt,
      this.updatedAt,
      this.userType,
      this.isFirstLogin,
      this.otpVerified,
      this.phoneOtpVerified,
      this.isDeactivate,
      this.deactivateReason,
      this.deletedAt,
      this.deletedStatus,
      this.deviceToken,
      this.appType});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    username = json['username'];
    profileImage = json['profile_image'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    otpExpiresAt = json['otp_expires_at'];
    otp = json['otp'];
    phoneOtp = json['phone_otp'];
    phoneOtpExpiresAt = json['phone_otp_expires_at'];
    forgotOtp = json['forgot_otp'];
    forgotOtpExpiresAt = json['forgot_otp_expires_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userType = json['user_type'];
    isFirstLogin = json['is_first_login'];
    otpVerified = json['otp_verified'];
    phoneOtpVerified = json['phone_otp_verified'];
    isDeactivate = json['is_deactivate'];
    deactivateReason = json['deactivate_reason'];
    deletedAt = json['deleted_at'];
    deletedStatus = json['deleted_status'];
    deviceToken = json['device_token'];
    appType = json['app_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['code'] = code;
    data['username'] = username;
    data['profile_image'] = profileImage;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone'] = phone;
    data['otp_expires_at'] = otpExpiresAt;
    data['otp'] = otp;
    data['phone_otp'] = phoneOtp;
    data['phone_otp_expires_at'] = phoneOtpExpiresAt;
    data['forgot_otp'] = forgotOtp;
    data['forgot_otp_expires_at'] = forgotOtpExpiresAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_type'] = userType;
    data['is_first_login'] = isFirstLogin;
    data['otp_verified'] = otpVerified;
    data['phone_otp_verified'] = phoneOtpVerified;
    data['is_deactivate'] = isDeactivate;
    data['deactivate_reason'] = deactivateReason;
    data['deleted_at'] = deletedAt;
    data['deleted_status'] = deletedStatus;
    data['device_token'] = deviceToken;
    data['app_type'] = appType;
    return data;
  }
}
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
    data['message'] = this.message;
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? code;
  Null? username;
  Null? profileImage;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? phone;
  String? otpExpiresAt;
  int? otp;
  Null? phoneOtp;
  Null? phoneOtpExpiresAt;
  Null? forgotOtp;
  Null? forgotOtpExpiresAt;
  String? createdAt;
  String? updatedAt;
  String? userType;
  int? isFirstLogin;
  String? otpVerified;
  String? phoneOtpVerified;
  String? isDeactivate;
  Null? deactivateReason;
  Null? deletedAt;
  String? deletedStatus;
  Null? deviceToken;
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
    data['id'] = this.id;
    data['code'] = this.code;
    data['username'] = this.username;
    data['profile_image'] = this.profileImage;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['otp_expires_at'] = this.otpExpiresAt;
    data['otp'] = this.otp;
    data['phone_otp'] = this.phoneOtp;
    data['phone_otp_expires_at'] = this.phoneOtpExpiresAt;
    data['forgot_otp'] = this.forgotOtp;
    data['forgot_otp_expires_at'] = this.forgotOtpExpiresAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_type'] = this.userType;
    data['is_first_login'] = this.isFirstLogin;
    data['otp_verified'] = this.otpVerified;
    data['phone_otp_verified'] = this.phoneOtpVerified;
    data['is_deactivate'] = this.isDeactivate;
    data['deactivate_reason'] = this.deactivateReason;
    data['deleted_at'] = this.deletedAt;
    data['deleted_status'] = this.deletedStatus;
    data['device_token'] = this.deviceToken;
    data['app_type'] = this.appType;
    return data;
  }
}
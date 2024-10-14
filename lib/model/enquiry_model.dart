class EnquiryModel {
  String? firstName;
  String? email;
  String? phone;
  String? address;
  String? enquiryAbout;
  String? howDidYouFindUs;

  EnquiryModel({
    this.firstName,
    this.email,
    this.phone,
    this.address,
    this.enquiryAbout,
    this.howDidYouFindUs,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'email': email,
      'phone': phone,
      'address': address,
      'enquiry': enquiryAbout,
      'how_did_you_find_us': howDidYouFindUs,
    };
  }
}
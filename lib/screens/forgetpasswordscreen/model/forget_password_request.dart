class ForgetPasswordRequest {
  String? email;

  ForgetPasswordRequest({
    this.email,
  });

  factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      ForgetPasswordRequest(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}

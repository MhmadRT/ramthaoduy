import 'dart:convert';

ApproveAndRejectRequest approveAndRejectFromJson(String str) =>
    ApproveAndRejectRequest.fromJson(json.decode(str));

String approveAndRejectToJson(ApproveAndRejectRequest data) =>
    json.encode(data.toJson());

class ApproveAndRejectRequest {
  int? postId;
  String? status;

  ApproveAndRejectRequest({
    this.postId,
    this.status,
  });

  factory ApproveAndRejectRequest.fromJson(Map<String, dynamic> json) =>
      ApproveAndRejectRequest(
        postId: json["post_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "status": status,
      };
}

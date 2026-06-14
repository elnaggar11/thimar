import 'base.dart';

class RewardModel extends Model {
  late final String rewardId;
  late final String companyId;
  late final String name;
  late final String media;
  late final String companyName;
  late final String companyLogo;
  late final int qty;
  late final int pointsRequired;
  late final int pointsCostTotal;
  late final String status;
  late final String statusLabel;
  late final bool canAfford;
  late final bool canCancel;
  late final DateTime? requestedAt;
  late final DateTime? reviewedAt;
  late final String? reviewNote;

  RewardModel.fromJson([Map<String, dynamic>? json]) {
    final payload = json ?? <String, dynamic>{};
    id = stringFromJson(payload, "id");
    qty = intFromJson(payload, "qty");
    status = stringFromJson(payload, "status");
    statusLabel = stringFromJson(payload, "status_label");
    canAfford = boolFromJson(payload, "can_afford");
    canCancel = boolFromJson(payload, "can_cancel");

    final requestedAtValue = stringNullFromJson(payload, "requested_at");
    requestedAt = requestedAtValue != null && requestedAtValue.isNotEmpty
        ? DateTime.tryParse(requestedAtValue)
        : null;

    final reviewedAtValue = stringNullFromJson(payload, "reviewed_at");
    reviewedAt = reviewedAtValue != null && reviewedAtValue.isNotEmpty
        ? DateTime.tryParse(reviewedAtValue)
        : null;

    reviewNote = stringNullFromJson(payload, "review_note");

    final rewardAttributes = payload["reward"] is Map<String, dynamic>
        ? payload["reward"] as Map<String, dynamic>
        : payload;
    final companyAttributes = payload["company"] is Map<String, dynamic>
        ? payload["company"] as Map<String, dynamic>
        : <String, dynamic>{};

    rewardId = stringFromJson(rewardAttributes, "id");
    companyId = stringFromJson(companyAttributes, "id");

    name = stringFromJson(rewardAttributes, "name");

    var requiredPoints = intFromJson(rewardAttributes, "points_cost");
    if (requiredPoints <= 0) {
      requiredPoints = intFromJson(rewardAttributes, "points_required");
    }
    if (requiredPoints <= 0) {
      requiredPoints = intFromJson(rewardAttributes, "points");
    }
    if (requiredPoints <= 0) {
      requiredPoints = intFromJson(payload, "points_required");
    }
    if (requiredPoints <= 0) {
      requiredPoints = intFromJson(payload, "points_cost");
    }
    pointsRequired = requiredPoints;

    final rawPointsCostTotal = intFromJson(payload, "points_cost_total");
    pointsCostTotal = rawPointsCostTotal > 0
        ? rawPointsCostTotal
        : pointsRequired;

    var mediaValue = stringFromJson(rewardAttributes, "media");
    if (mediaValue.isEmpty) {
      mediaValue = stringFromJson(rewardAttributes, "image");
    }
    if (mediaValue.isEmpty) {
      mediaValue = stringFromJson(rewardAttributes, "media_url");
    }
    if (mediaValue.isEmpty) {
      mediaValue = stringFromJson(rewardAttributes, "cover");
    }
    final companyLogoCandidate = stringFromJson(companyAttributes, "logo");
    if (mediaValue.isEmpty) mediaValue = companyLogoCandidate;
    if (mediaValue.isEmpty) mediaValue = stringFromJson(payload, "media");
    media = mediaValue;

    var companyNameValue = stringFromJson(companyAttributes, "name");
    if (companyNameValue.isEmpty) {
      companyNameValue = stringFromJson(payload, "company_name");
    }
    companyName = companyNameValue;

    var companyLogoValue = companyLogoCandidate;
    if (companyLogoValue.isEmpty) {
      companyLogoValue = stringFromJson(payload, "company_logo");
    }
    companyLogo = companyLogoValue;
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "reward_id": rewardId,
    "company_id": companyId,
    "name": name,
    "media": media,
    "qty": qty,
    "points_required": pointsRequired,
    "points_cost_total": pointsCostTotal,
    "status": status,
    "status_label": statusLabel,
    "can_afford": canAfford,
    "can_cancel": canCancel,
    "requested_at": requestedAt?.toIso8601String(),
    "reviewed_at": reviewedAt?.toIso8601String(),
    "review_note": reviewNote,
    "company_name": companyName,
    "company_logo": companyLogo,
  };
}

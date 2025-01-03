/// The RewardModel tracks the user's progress toward unlocking rewards.
/// It contains information such as:
/// - Reward name and description.
/// - Points required to unlock the reward.
/// - Status of whether the reward is unlocked or not.

class RewardModel {
  String rewardName;
  int pointsRequired;

  RewardModel({
    required this.rewardName,
    required this.pointsRequired,
  });
}

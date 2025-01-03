/// The RewardWidget showcases the user's earned rewards and progress towards new ones,
/// providing a visual and interactive representation of achievements.


import 'package:flutter/material.dart';
import 'package:to_bee/models/reward_model.dart';

class RewardsDisplay extends StatelessWidget {
  final List<RewardModel> rewards;
  final int userPoints;
  final Function onUnlockReward;

  RewardsDisplay({
    required this.rewards,
    required this.userPoints,
    required this.onUnlockReward,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rewards.length,
      itemBuilder: (context, index) {
        final reward = rewards[index];
        return Card(
          child: ListTile(
            title: Text(reward.rewardName),
            subtitle: Text('Points Required: ${reward.pointsRequired}'),
            trailing: ElevatedButton(
              onPressed: userPoints >= reward.pointsRequired
                  ? () => onUnlockReward(reward)
                  : null,
              child: Text('Unlock'),
            ),
          ),
        );
      },
    );
  }
}

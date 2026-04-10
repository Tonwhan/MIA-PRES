class CaregiverModel {
  final String id;
  final String name;
  final String avatarUrl;
  final String? agoraChannelName;

  CaregiverModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.agoraChannelName,
  });

 //TODO: Create 'caregivers' table in Supabase
  factory CaregiverModel.fromSupabase(Map<String, dynamic> data) {
    return CaregiverModel(
      id: data['id'],
      name: data['name'],
      avatarUrl: data['avatar_url'] ?? '',
      agoraChannelName: data['agora_channel'],
    );
  }
}

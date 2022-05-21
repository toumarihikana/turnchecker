class SaveCheckListModel {
  List<Profile>? profiles;

  SaveCheckListModel({this.profiles});

  SaveCheckListModel.fromJson(Map<String, dynamic> json) {
    if (json['profiles'] != null) {
      profiles = <Profile>[];
      json['profiles'].forEach((v) {
        profiles!.add(Profile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profiles != null) {
      data['profiles'] = profiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profile {
  String? name;
  List<String>? cards;

  Profile({this.name, this.cards});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cards = json['cards'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cards'] = cards;
    return data;
  }
}

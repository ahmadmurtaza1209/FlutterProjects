import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel(
      {required this.firstName, required this.metadata, required this.imageUrl
      // required this.userId,
      // required this.address,
      // required this.location,
      // late final String userId;
      // late final String address;
      // late final String location;
      // late final String dateOfBirth;

      // required this.dateOfBirth,
      // required this.coverImage,

      });

  UserModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    firstName = documentSnapshot["firstName"] ?? "";
    imageUrl = documentSnapshot["imageUrl"] ?? "";
    metadata = MetaData.fromjson(documentSnapshot["metadata"]);
    phone = documentSnapshot["phone"] ?? "N/A";
    gender = documentSnapshot["gender"] ?? "N/A";
    coverImageUrl = documentSnapshot["coverImage"] ?? "";
    birthday = documentSnapshot["birthday"] ?? "N/A";
    homeTown = documentSnapshot["homeTown"] ?? "N/A";
    // address = data["address"] ?? "";
    // location = data["location"] ?? "";
    // dateOfBirth = data["dateOfBirth"] ?? "";

    // coverImage = data["coverImage"] ?? "";
    // userId = data["uid"] ?? "";
  }

  UserModel.fromjson(Map<String, dynamic> data) {
    firstName = data["firstName"] ?? "";
    imageUrl = data["imageUrl"] ?? "";
    metadata = MetaData.fromjson(data["metadata"]);
    phone = data["phone"] ?? "N/A";
    gender = data["gender"] ?? "N/A";
    coverImageUrl = data["coverImage"] ?? "";
    birthday = data["birthday"] ?? "N/A";
    homeTown = data["homeTown"] ?? "N/A";
    // address = data["address"] ?? "";
    // location = data["location"] ?? "";
    // dateOfBirth = data["dateOfBirth"] ?? "";

    // coverImage = data["coverImage"] ?? "";
    // userId = data["uid"] ?? "";
  }

  late final String firstName;
  late final String imageUrl;
  late final String gender;
  late final String phone;
  late final String coverImageUrl;
  late final String birthday;
  late final String homeTown;
  late MetaData metadata;

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["firstName"] = firstName;
    data["imageUrl"] = imageUrl;
    data["metadata"] = metadata.tojson();
    data["phone"] = phone;
    data["gender"] = gender;
    data["coverImage"] = coverImageUrl;
    data["birthday"] = birthday;
    data["homeTown"] = homeTown;
    // data["address"] = address;
    // data["location"] = location;
    // data["dateOfBirth"] = dateOfBirth;

    // data["coverImage"] = coverImage;

    // data["userId"] = userId;
    return data;
  }
}

class MetaData {
  MetaData({
    required this.email,
    required this.phone,
    required this.gender,
  });

  MetaData.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    email = documentSnapshot["email"] ?? "";
    phone = documentSnapshot["phone"] ?? "N/A";
    gender = documentSnapshot["gender"] ?? "N/A";
    coverImageUrl = documentSnapshot["coverImage"] ?? "";
    birthday = documentSnapshot["birthday"] ?? "N/A";
    homeTown = documentSnapshot["homeTown"] ?? "N/A";
  }

  MetaData.fromjson(Map<String, dynamic> data) {
    email = data["email"] ?? "";
    phone = data["phone"] ?? "N/A";
    gender = data["gender"] ?? "N/A";
    coverImageUrl = data["coverImage"] ?? "";
    birthday = data["birthday"] ?? "N/A";
    homeTown = data["homeTown"] ?? "N/A";
  }

  late final String email;
  late final String gender;
  late final String phone;
  late final String coverImageUrl;
  late final String birthday;
  late final String homeTown;

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["email"] = email;
    data["phone"] = phone;
    data["gender"] = gender;
    data["coverImage"] = coverImageUrl;
    data["birthday"] = birthday;
    data["homeTown"] = homeTown;

    return data;
  }
}

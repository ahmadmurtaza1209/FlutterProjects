import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // late final String coverImage;
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
    // address = data["address"] ?? "";
    // location = data["location"] ?? "";
    // dateOfBirth = data["dateOfBirth"] ?? "";

    // coverImage = data["coverImage"] ?? "";
    // userId = data["uid"] ?? "";
  }

  late final String firstName;
  late final String imageUrl;
  late MetaData metadata;

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["firstName"] = firstName;
    data["imageUrl"] = imageUrl;
    data["metadata"] = metadata.tojson();
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
    phone = documentSnapshot["phone"] ?? "";
    gender = documentSnapshot["gender"] ?? "";
  }

  MetaData.fromjson(Map<String, dynamic> data) {
    email = data["email"] ?? "";
    phone = data["phone"] ?? "";
    gender = data["gender"] ?? "";
  }

  late final String email;
  late final String gender;
  late final String phone;

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["email"] = email;
    data["phone"] = phone;
    data["gender"] = gender;

    return data;
  }
}

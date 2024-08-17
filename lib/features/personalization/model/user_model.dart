import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;
  double height;
  double weight;
  double bmi; // updated to double

  String get fullName => '$firstName $lastName';

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.height = 0.0, // initialize new field
    this.weight = 0.0, // initialize new field
    this.bmi = 0.0, // initialize new field
  });

  // Factory method to create an empty UserModel
  factory UserModel.empty() {
    return UserModel(
      id: '',
      firstName: '',
      lastName: '',
      userName: '',
      email: '',
      phoneNumber: '',
      profilePicture: '',
      height: 0.0,
      // default value for new field
      weight: 0.0,
      // default value for new field
      bmi: 0.0, // default value for new field
    );
  }

  // Factory method to create a UserModel from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profilePicture: json['profilePicture'] as String,
      height: (json['height'] as num).toDouble(),
      // parse new field
      weight: (json['weight'] as num).toDouble(),
      // parse new field
      bmi: (json['bmi'] as num).toDouble(), // parse new field
    );
  }

  /// Factory method to create a UserModel from a Firestore snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() != null) {
      final data = snapshot.data() as Map<String, dynamic>;
      return UserModel(
        id: snapshot.id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        userName: data['userName'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        height: (data['height'] ?? 0.0) as double,
        // default value for new field
        weight: (data['weight'] ?? 0.0) as double,
        // default value for new field
        bmi: (data['bmi'] ?? 0.0) as double, // default value for new field
      );
    } else {
      return UserModel.empty();
    }
  }

  // Method to convert a UserModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'height': height, // include new field
      'weight': weight, // include new field
      'bmi': bmi, // include new field
    };
  }

  // Method to create a copy of the UserModel with modifications
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    double? height, // add new field
    double? weight, // add new field
    double? bmi, // add new field
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      height: height ?? this.height,
      // use new field
      weight: weight ?? this.weight,
      // use new field
      bmi: bmi ?? this.bmi, // use new field
    );
  }

  // Override the toString method for better debug print
  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, userName: $userName, email: $email, phoneNumber: $phoneNumber, profilePicture: $profilePicture, height: $height, weight: $weight, bmi: $bmi)';
  }

  // Override the equality operator to compare instances by values
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.userName == userName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.profilePicture == profilePicture &&
        other.height == height &&
        other.weight == weight &&
        other.bmi == bmi;
  }

  // Override hashCode to use all fields
  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        profilePicture.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        bmi.hashCode;
  }
}

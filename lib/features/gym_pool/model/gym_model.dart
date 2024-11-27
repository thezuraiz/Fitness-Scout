import 'package:cloud_firestore/cloud_firestore.dart';

// enum status { Approved, Not-Approved, Blocked, Pending }

class GymOwnerModel {
  final String id;
  final String name;
  final String username;
  final String email;
  final String? profilePicture;
  final String? description;
  final String? gymName; // New optional field
  final Location? location;
  final String? address;
  final String? contactNumber;
  final String? website;
  final String? license;
  final Map<String, dynamic>? openingHours;
  final List<String>? images;
  final List<Map<String, dynamic>>? amenities;
  final OwnerBankDetails? ownerBankDetails;
  final double balance;
  final String isApproved;
  final List<Visitor>? visitors;
  final String gymType;
  final int ratings;

  GymOwnerModel(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      this.profilePicture,
      this.description,
      this.gymName, // Added here
      this.location,
      this.address,
      this.contactNumber,
      this.website,
      this.license,
      this.openingHours,
      this.images,
      this.amenities,
      this.ownerBankDetails,
      this.balance = 0.0,
      this.isApproved = 'Not-Approved',
      this.visitors,
      this.gymType = 'Normal',
      this.ratings = 0});

  // Convert Firestore document snapshot to GymOwnerModel
  factory GymOwnerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>? ?? {};

    return GymOwnerModel(
      id: snapshot.id,
      name: data['name'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      profilePicture: data['profile_picture'],
      description: data['description'],
      gymName: data['gym_name'],
      location: data['location'] != null
          ? Location.fromJson(data['location'] as Map<String, dynamic>)
          : null,
      address: data['address'],
      contactNumber: data['contact_number'],
      website: data['website'],
      license: data['license'],
      openingHours: data['opening_hours'] != null
          ? Map<String, dynamic>.from(data['opening_hours'])
              .map((key, value) => MapEntry(key, value.toString()))
          : null,
      images: data['images'] != null
          ? List<String>.from(data['images'] as List)
          : null,
      amenities: data['amenities'] != null
          ? List<Map<String, dynamic>>.from(data['amenities'] as List)
          : null,
      ownerBankDetails: data['owner_bank_details'] != null
          ? OwnerBankDetails.fromJson(
              data['owner_bank_details'] as Map<String, dynamic>)
          : null,
      balance: (data['balance'] ?? 0.0).toDouble(),
      isApproved: data['isApproved'] ?? 'Not-Approved',
      visitors: (data['visitors'] as List<dynamic>?)
              ?.map((visitor) =>
                  Visitor.fromJson(visitor as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  // Convert GymOwnerModel object to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "profile_picture": profilePicture,
        "description": description,
        "gym_name": gymName, // Added here
        "location": location?.toJson(),
        "address": address,
        "contact_number": contactNumber,
        "website": website,
        "license": license,
        "opening_hours": openingHours,
        "images": images,
        "amenities": amenities,
        "owner_bank_details": ownerBankDetails?.toJson(),
        "balance": balance,
        "isApproved": isApproved,
        "visitors": visitors?.map((v) => v.toJson()).toList(),
        'ratings': ratings ?? '',
      };

  // Create an empty GymOwnerModel instance
  factory GymOwnerModel.empty() {
    return GymOwnerModel(
      id: '',
      name: '',
      username: '',
      email: '',
      profilePicture: '',
      description: '',
      gymName: '',
      location: null,
      address: '',
      contactNumber: '',
      website: '',
      license: '',
      openingHours: {},
      images: [],
      amenities: [],
      ownerBankDetails: null,
      balance: 0.0,
      isApproved: 'Not-Approved',
      visitors: [],
      ratings: 0,
    );
  }
}

class Visitor {
  final String userId;
  final Map<String, dynamic> checkInTime;
  final Map<String, dynamic>? checkOutTime;

  Visitor({
    required this.userId,
    required this.checkInTime,
    this.checkOutTime,
  });

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "check_in_time": checkInTime,
        "check_out_time": checkOutTime,
      };

  factory Visitor.fromJson(Map<String, dynamic> json) => Visitor(
        userId: json["user_id"],
        checkInTime: json["check_in_time"],
        checkOutTime:
            json["check_out_time"] != null ? json["check_out_time"] : {},
      );
}

// Define the Location model
class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );
}

// Define the OwnerBankDetails model
class OwnerBankDetails {
  final String bankName;
  final String accountNumber;
  final String iban;

  OwnerBankDetails({
    required this.bankName,
    required this.accountNumber,
    required this.iban,
  });

  Map<String, dynamic> toJson() => {
        "bank_name": bankName,
        "account_number": accountNumber,
        "iban": iban,
      };

  factory OwnerBankDetails.fromJson(Map<String, dynamic> json) =>
      OwnerBankDetails(
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        iban: json["iban"],
      );
}

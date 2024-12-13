import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/helpers/logger.dart';

class GymOwnerModel {
  final String id;
  final String name;
  final String username;
  final String email;
  final String? profilePicture;
  final String? description;
  final String? gymName;
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

  GymOwnerModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.profilePicture,
    this.description,
    this.gymName,
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
    this.ratings = 0,
  });

  // Factory to create a GymOwnerModel from Firestore document snapshot
  factory GymOwnerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>? ?? {};

    ZLogger.info('Parsing GymOwnerModel: $data');

    try {
      return GymOwnerModel(
        id: snapshot.id,
        name: data['name'] ?? 'No Name',
        username: data['username'] ?? 'Unknown',
        email: data['email'] ?? 'No Email',
        profilePicture: data['profile_picture'] ?? '',
        description: data['description'] ?? 'No description available',
        gymName: data['gym_name'] ?? 'Unknown Gym',
        location: data['location'] != null
            ? Location.fromJson(data['location'] as Map<String, dynamic>)
            : null,
        address: data['address'] ?? '',
        contactNumber: data['contact_number'] ?? 'No Contact',
        website: data['website'] ?? '',
        license: data['license'] ?? '',
        openingHours: data['opening_hours'] as Map<String, dynamic>? ?? {},
        images: (data['images'] as List<dynamic>?)?.cast<String>() ?? [],
        amenities: (data['amenities'] as List<dynamic>?)
                ?.map((amenity) => amenity as Map<String, dynamic>)
                .toList() ??
            [],
        ownerBankDetails: data['owner_bank_details'] != null
            ? OwnerBankDetails.fromJson(
                data['owner_bank_details'] as Map<String, dynamic>)
            : null,
        balance: (data['balance'] as num?)?.toDouble() ?? 0.0,
        isApproved: data['isApproved'] ?? 'Not-Approved',
        visitors: (data['visitors'] as List<dynamic>?)
                ?.map((visitor) =>
                    Visitor.fromJson(visitor as Map<String, dynamic>))
                .toList() ??
            [],
        gymType: data['gym_type'] ?? 'Normal',
        ratings: data['ratings'] ?? 0,
      );
    } catch (e, stackTrace) {
      ZLogger.error('Error parsing GymOwnerModel: $e $stackTrace');
      rethrow;
    }
  }

  // Convert GymOwnerModel to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "profile_picture": profilePicture,
        "description": description,
        "gym_name": gymName,
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
        "gym_type": gymType,
        "ratings": ratings,
      };

  // Factory for creating an empty GymOwnerModel
  factory GymOwnerModel.empty() => GymOwnerModel(
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
        gymType: 'Normal',
        ratings: 0,
      );
}

class Visitor {
  final String userId;
  final String name;
  final Map<String, dynamic> checkInTime;
  final Map<String, dynamic>? checkOutTime;

  Visitor({
    required this.userId,
    required this.checkInTime,
    required this.name,
    this.checkOutTime,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) => Visitor(
        userId: json["user_id"] ?? '',
        name: json["name"] ?? '',
        checkInTime: json["check_in_time"] ?? {},
        checkOutTime: json["check_out_time"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "check_in_time": checkInTime,
        "check_out_time": checkOutTime,
      };
}

class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: (json["latitude"] as num?)?.toDouble() ?? 0.0,
        longitude: (json["longitude"] as num?)?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class OwnerBankDetails {
  final String bankName;
  final String accountNumber;
  final String iban;

  OwnerBankDetails({
    required this.bankName,
    required this.accountNumber,
    required this.iban,
  });

  factory OwnerBankDetails.fromJson(Map<String, dynamic> json) =>
      OwnerBankDetails(
        bankName: json["bank_name"] ?? '',
        accountNumber: json["account_number"] ?? '',
        iban: json["iban"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "bank_name": bankName,
        "account_number": accountNumber,
        "iban": iban,
      };
}

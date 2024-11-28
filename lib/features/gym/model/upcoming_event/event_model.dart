class GymEvent {
  final String eventId;
  final String title;
  final String description;
  final String startTime;
  final String location;
  final String? eventLink;
  final String contactNumber;
  final String email;
  final bool isFree;
  final double? price;

  GymEvent({
    required this.eventId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.location,
    this.eventLink,
    required this.contactNumber,
    required this.email,
    required this.isFree,
    this.price,
  });

  // Factory constructor to create GymEvent from JSON
  factory GymEvent.fromJson(Map<String, dynamic> json) {
    return GymEvent(
      eventId: json['eventId'],
      title: json['title'],
      description: json['description'],
      startTime: json['startTime'],
      location: json['location'],
      eventLink: json['eventLink'],
      contactNumber: json['contactNumber'],
      email: json['email'],
      isFree: json['isFree'],
      price: json['price'] != null ? json['price'].toDouble() : null,
    );
  }

  // Convert GymEvent instance to JSON
  Map<String, dynamic> toJson() => {
        "eventId": eventId,
        "title": title,
        "description": description,
        "startTime": startTime,
        "location": location,
        "eventLink": eventLink,
        "contactNumber": contactNumber,
        "email": email,
        "isFree": isFree,
        "price": price,
      };

  // Create an empty GymOwnerModel instance
  factory GymEvent.empty() {
    return GymEvent(
      eventId: '',
      title: '',
      description: '',
      startTime: '',
      location: '',
      eventLink: '',
      contactNumber: '',
      email: '',
      isFree: false,
      price: 0,
    );
  }
}

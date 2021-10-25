part of 'models.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String address;
  final String houseNumber;
  final String phoneNumber;
  final String city;
  final String picturePath;
  static String? token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.houseNumber,
    required this.phoneNumber,
    required this.city,
    required this.picturePath,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        address,
        houseNumber,
        phoneNumber,
        city,
        picturePath,
      ];

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? address,
    String? houseNumber,
    String? phoneNumber,
    String? city,
    String? picturePath,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      houseNumber: houseNumber ?? this.houseNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      picturePath: picturePath ?? this.picturePath,
    );
  }
}

User mockUser = User(
  id: 1,
  name: "syam",
  email: "syam@syam.com",
  address: "Bekasi, Jawa Barat, Indonesia",
  houseNumber: "17",
  phoneNumber: "08777777777",
  city: "Bekasi",
  picturePath:
      "https://akcdn.detik.net.id/visual/2021/03/20/rumor-chris-evans-kembali-perankan-captain-america-ini-jawaban-marvel_169.jpeg?w=480&q=90",
);

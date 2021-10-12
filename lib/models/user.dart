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

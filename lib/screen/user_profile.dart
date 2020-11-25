import 'package:flutter/material.dart';

/// Class UserProfile digunakan untuk menampilkan profile user ke layar dengan indah
class UserProfile extends StatelessWidget {
  /// Field ini digunakan untuk menyimpan nama user
  final String name;
  final String role;
  final String photoURL;

  /// * [neme] berisi *nama user*. Nilai defaulnya adalah `No Name`
  ///
  /// * [role] berisi peran/jabatan dari user. Nilai defaulnya adalah `No Role`
  ///
  /// * [photoURL] berisi link **foto user**. Nilai defaulnya adalah `null`
  ///
  /// Contoh:
  ///
  ///```
  /// final UserProfile profile = UserProfile(
  /// name: 'nama user',
  /// role: 'peran user',
  /// photoURL: 'https://lalala.com/foto.png',
  /// );
  /// ```
  UserProfile({this.name = 'No Name', this.role = 'No Role', this.photoURL});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          width: 200,
          height: 200,
          image: AssetImage(
              (photoURL != null) ? photoURL : 'images/budyfriend.png'),
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '[' + role + ']',
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

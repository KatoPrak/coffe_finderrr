import 'package:flutter/material.dart';

class RoleDropdown extends StatelessWidget {
  final String selectedRole;
  final ValueChanged<String?> onChanged;

  const RoleDropdown({
    Key? key,
    required this.selectedRole,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color.fromARGB(255, 99, 18, 4)),
          color: const Color.fromRGBO(241, 241, 241, 1), // Warna latar belakang
        ),
        child: DropdownButton<String>(
          icon: Icon(Icons.arrow_drop_down, color: Color.fromARGB(255, 99, 18, 4)),
          iconSize: 36.0,
          isExpanded: true,
          underline: Container(), // Menghilangkan garis bawah dropdown
          value: selectedRole,
          onChanged: onChanged,
          items: <String>['Pilih Role', 'Pelanggan', 'Pemilik Toko']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  color: value == 'Pilih Role' ? Colors.grey :Colors.brown,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

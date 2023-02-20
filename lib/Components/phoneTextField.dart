// import 'package:country_pickers/country.dart';
// import 'package:country_pickers/country_pickers.dart';
// import 'package:flutter/material.dart';

// class phonetextfield extends StatefulWidget {
//   Function(String)? onchaged;
//   String? Function(String?)? validator;
//   phonetextfield({this.onchaged, this.validator});

//   @override
//   State<phonetextfield> createState() => _phonetextfieldState();
// }

// class _phonetextfieldState extends State<phonetextfield> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 50,
//         margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         padding: EdgeInsets.only(left: 10),
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(80)),
//         child: Row(
//           children: [
//             Container(
//               width: 100,
//               child: CountryPickerDropdown(
//                 initialValue: 'EG',
//                 itemBuilder: _buildDropdownItem,
//                 onValuePicked: (Country country) {
//                   print("${country.name}");
//                 },
//               ),
//             ),
//             Expanded(
//               flex: 6,
//               child: Container(
//                   width: 230,
//                   child: TextFormField(
//                     validator: widget.validator,
//                     onChanged: widget.onchaged,
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(
//                         hintText: "Phone",
//                         suffixIcon: Icon(Icons.phone, color: Colors.grey),
//                         border: InputBorder.none),
//                   )),
//             ),
//           ],
//         ));
//   }
// }

// Widget _buildDropdownItem(Country country) => Container(
//       child: Row(
//         children: <Widget>[
//           CountryPickerUtils.getDefaultFlagImage(country),
//           SizedBox(
//             width: 8.0,
//           ),
//           Text("+${country.phoneCode}"),
//         ],
//       ),
//     );

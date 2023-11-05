// import 'dart:html';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../common/app_colors.dart';
//
// class ProfileImageWidget extends StatelessWidget {
//   final String imagePath;
//   final VoidCallback onTap;
//   final bool isLoaded;
//
//   const ProfileImageWidget({
//     Key? key,
//     required this.imagePath,
//     required this.onTap,
//     this.isLoaded = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(200.0),
//             child: isLoaded
//                 ? Image.file(
//               File(imagePath),
//               height: 180.0,
//               width: 180.0,
//               fit: BoxFit.cover,
//             )
//                 : Container(
//               height: 180,
//               width: 180.0,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.7),
//                 borderRadius: BorderRadius.circular(200.0),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Icon(
//                   Icons.account_circle,
//                   color: AppColors.pink.withOpacity(0.2),
//                   size: 120,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0.0,
//             right: 0.0,
//             child: IconDecoration(),
//           ),
//         ],
//       ),
//     );
//   }
// }

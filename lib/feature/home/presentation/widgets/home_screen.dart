
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:ta9sela/core/constants/app_images.dart';
// import 'package:ta9sela/core/routes/go_router.dart';
// import 'package:ta9sela/core/routes/navigations.dart';
// import 'package:ta9sela/feature/auth/data/UserType.dart';
// import 'package:ta9sela/feature/home/data/models/userModel.dart';
// import 'package:ta9sela/feature/home/data/models/driverModel.dart';

// class homeScreen extends StatefulWidget {
//   homeScreen({super.key, required this.usertype, required this.user});
//   String? usertype;
//   var user;

//   @override
//   State<homeScreen> createState() => _homeScreenState();
// }

// class _homeScreenState extends State<homeScreen> {
//   dynamic userdata() {
//     if (widget.usertype == Usertype.driver.name.toString()) {
//       return widget.user as DriverModel;
//     } else if (widget.usertype == Usertype.user.name.toString()) {
//       return widget.user as UserModel;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//    final fallback =
//     'https://as1.ftcdn.net/v2/jpg/02/10/13/14/1000_F_210131451_583TTW0JqiSuEb8eWIjCYrzv8sy2VJBQ.jpg';

//     final String avatarUrl = widget.usertype == 'driver'
//         ? (widget.user.profileImage?.toString() ?? '')
//         : widget.usertype == 'user'
//             ? (widget.user.imageUrl?.toString() ?? '')
//             : '';

//     return SingleChildScrollView(
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             children: [
//               /// ✅ Header
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(18),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(.06),
//                       blurRadius: 16,
//                       offset: const Offset(0, 8),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(999),
//                       ),
//                       child: CircleAvatar(
//                         radius: 22,
//                         backgroundColor: Colors.white,
//                         backgroundImage:NetworkImage(avatarUrl.isEmpty ? fallback : avatarUrl),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'مرحباً 👋',
//                             style: TextStyle(fontSize: 12, color: Colors.grey),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             '${widget.user.name ?? '....'}',
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     InkWell(
//                       borderRadius: BorderRadius.circular(14),
//                       onTap: () {},
//                       child: Container(
//                         width: 42,
//                         height: 42,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                         child: Center(
//                           child: SvgPicture.asset(
//                             AppImages.notification,
//                             width: 22,
//                             height: 22,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 16),

//               /// ✅ Hero / Banner
//               Container(
//                 height: 210,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(22),
//                   image: DecorationImage(
//                     image: AssetImage(AppImages.bmw),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(22),
//                   child: Stack(
//                     children: [
//                       /// Gradient overlay
//                       Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.black.withOpacity(.10),
//                               Colors.black.withOpacity(.45),
//                             ],
//                           ),
//                         ),
//                       ),

//                       /// Text + CTA
//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Spacer(),
//                             const Text(
//                               'جاهز لمشوار جديد؟',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             ),
//                             const SizedBox(height: 6),
//                             Text(
//                               'حدد وجهتك وهنظبطلك أقرب سائق.',
//                               style: TextStyle(
//                                 color: Colors.white.withOpacity(.9),
//                                 fontSize: 13,
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             SizedBox(
//                               height: 44,
//                               child: ElevatedButton.icon(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green,
//                                   shape: const StadiumBorder(),
//                                   elevation: 0,
//                                 ),
//                                 onPressed: () {
//                                   Navigations.push(
//                                     context,
//                                     AppRouter.history,
//                                     extra: widget.user,
//                                   );
//                                 },
//                                 icon: const Icon(Icons.local_taxi, color: Colors.white),
//                                 label: const Text(
//                                   'اطلب مشوارك',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               /// ✅ Map preview (بدون imgur + مع fallback)
//               Container(
//                 height: 190,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(22),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(.06),
//                       blurRadius: 16,
//                       offset: const Offset(0, 8),
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(22),
//                   child: Stack(
//                     children: [
//                       Image.network(
//                         // حط أي صورة ثابتة أو استبدلها لاحقاً بـ map widget
//                         'https://images.unsplash.com/photo-1524661135-423995f22d0b?w=1200',
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                         height: double.infinity,
//                         errorBuilder: (_, __, ___) => Container(
//                           color: Colors.grey.shade200,
//                           child: Center(
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: const [
//                                 Icon(Icons.map_outlined, size: 36),
//                                 SizedBox(height: 6),
//                                 Text('معاينة الخريطة'),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         right: 12,
//                         top: 12,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(.92),
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           child: GestureDetector(
//                             onTap: () {
//                              Navigations.push(context, AppRouter.history,extra: widget.user);
//                             },
//                             child: Row(
//                               children:  [
//                                 Icon(Icons.my_location, size: 18),
//                                 SizedBox(width: 6),
//                                 Text(
//                                   'موقعك الحالي',
//                                   style: TextStyle(fontWeight: FontWeight.w600),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               /// ✅ Destination / Search card
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.green.shade50,
//                   borderRadius: BorderRadius.circular(22),
//                   border: Border.all(color: Colors.green.shade100),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'مرحباً "${widget.user.name ?? "....."}"\nإلى أين تريد الذهاب؟',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w800,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 12),

//                     /// Search field (ستايل أحدث)
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(.05),
//                             blurRadius: 12,
//                             offset: const Offset(0, 6),
//                           ),
//                         ],
//                       ),
//                       child: GestureDetector(
//                         onTap: () {
//                         Navigations.push(context, AppRouter.history,extra: widget.user);

//                         },
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             hintText: 'رايح فين النهاردة؟',
//                             prefixIcon: const Icon(Icons.search),
//                             suffixIcon: IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.my_location),
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(16),
//                               borderSide: BorderSide.none,
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 14,
//                               vertical: 14,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     /// Quick chips
//                     Wrap(
//                       spacing: 10,
//                       runSpacing: 10,
//                       children: [
//                         _chip('البيت', Icons.home_outlined),
//                         _chip('الشغل', Icons.work_outline),
//                         _chip('المفضلة', Icons.star_border),
//                         _chip('أقرب مكان', Icons.place_outlined),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _chip(String text, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(999),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 18),
//           const SizedBox(width: 6),
//           Text(
//             text,
//             style: const TextStyle(fontWeight: FontWeight.w600),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ta9sela/core/constants/app_images.dart';
import 'package:ta9sela/core/routes/go_router.dart';
import 'package:ta9sela/core/routes/navigations.dart';
import 'package:ta9sela/feature/auth/data/UserType.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.usertype, required this.user});

  final String? usertype; // 'driver' أو 'user'
  final dynamic user;     // DriverModel أو UserModel (زي ما عندك)

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String _fallbackAvatar =
      'https://as1.ftcdn.net/v2/jpg/02/10/13/14/1000_F_210131451_583TTW0JqiSuEb8eWIjCYrzv8sy2VJBQ.jpg';

  String _getAvatarUrl() {
    // حسب موديلك: driver.profileImage / user.imageUrl
    if (widget.usertype == Usertype.driver.name || widget.usertype == 'driver') {
      final url = widget.user?.profileImage?.toString();
      return (url == null || url.trim().isEmpty) ? '' : url;
    }

    if (widget.usertype == Usertype.user.name || widget.usertype == 'user') {
      final url = widget.user?.imageUrl?.toString();
      return (url == null || url.trim().isEmpty) ? '' : url;
    }

    return '';
  }

  String _getName() {
    final name = widget.user?.name?.toString();
    return (name == null || name.trim().isEmpty) ? '....' : name;
  }

  void _goHistory() {
    Navigations.push(context, AppRouter.history, extra: widget.user);
  }

  @override
  Widget build(BuildContext context) {
    final avatarUrl = _getAvatarUrl();
    final name = _getName();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                /// ✅ Header
                _HeaderCard(
                  name: name,
                  avatarUrl: avatarUrl.isEmpty ? _fallbackAvatar : avatarUrl,
                  onNotificationTap: () {},
                ),

                const SizedBox(height: 16),

                /// ✅ Banner
                _BannerCard(
                  onTap: _goHistory,
                ),

                const SizedBox(height: 16),

                /// ✅ Map preview
                _MapPreviewCard(
                  onTap: _goHistory,
                ),

                const SizedBox(height: 16),

                /// ✅ Destination card
                _DestinationCard(
                  name: name,
                  onTap: _goHistory,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ---------------- Widgets ----------------

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.name,
    required this.avatarUrl,
    required this.onNotificationTap,
  });

  final String name;
  final String avatarUrl;
  final VoidCallback onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(999),
            ),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(avatarUrl),
              onBackgroundImageError: (_, __) {},
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'مرحباً 👋',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 2),
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onNotificationTap,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppImages.notification,
                  width: 22,
                  height: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        image: DecorationImage(
          image: AssetImage(AppImages.bmw),
          fit: BoxFit.cover,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(.10),
                    Colors.black.withOpacity(.45),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  const Text(
                    'جاهز لمشوار جديد؟',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'حدد وجهتك وهنظبطلك أقرب سائق.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.9),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: const StadiumBorder(),
                        elevation: 0,
                      ),
                      onPressed: onTap,
                      icon: const Icon(Icons.local_taxi, color: Colors.white),
                      label: const Text(
                        'اطلب مشوارك',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapPreviewCard extends StatelessWidget {
  const _MapPreviewCard({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1524661135-423995f22d0b?w=1200',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey.shade200,
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.map_outlined, size: 36),
                      SizedBox(height: 6),
                      Text('معاينة الخريطة'),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 12,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.92),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.my_location, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'موقعك الحالي',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DestinationCard extends StatelessWidget {
  const _DestinationCard({
    required this.name,
    required this.onTap,
  });

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مرحباً "$name"\nإلى أين تريد الذهاب؟',
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),

          /// ✅ خليه readOnly عشان النقر يفتح صفحة تانية
          TextFormField(
            readOnly: true,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: 'رايح فين النهاردة؟',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.my_location),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _Chip(text: 'البيت', icon: Icons.home_outlined),
              _Chip(text: 'الشغل', icon: Icons.work_outline),
              _Chip(text: 'المفضلة', icon: Icons.star_border),
              _Chip(text: 'أقرب مكان', icon: Icons.place_outlined),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

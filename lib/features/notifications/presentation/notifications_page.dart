import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'type': 'destination',
        'title': 'Dunia Fantasi (DUFAN)',
        'date': '19 Febuari 2025',
        'subtitle': 'Transportasi Umum',
        'actionText': 'Pergi Lagi',
        'status': 'Selesai',
      },
      {
        'type': 'destination',
        'title': 'Dunia Fantasi (DUFAN)',
        'date': '19 Febuari 2025',
        'subtitle': 'Transportasi Umum',
        'actionText': 'Pergi Lagi',
        'status': 'Selesai',
      },
      {
        'type': 'destination',
        'title': 'Dunia Fantasi (DUFAN)',
        'date': '19 Febuari 2025',
        'subtitle': 'Transportasi Umum',
        'actionText': 'Pergi Lagi',
        'status': 'Selesai',
      },
      {
        'type': 'destination',
        'title': 'Dunia Fantasi (DUFAN)',
        'date': '19 Febuari 2025',
        'subtitle': 'Transportasi Umum',
        'actionText': 'Pergi Lagi',
        'status': 'Selesai',
      },
      {
        'type': 'weather',
        'title': 'Cuaca Sedang Cerah',
        'date': '19 Febuari 2025',
        'subtitle': 'Yuk keluar dan jalan-jalan !',
        'actionText': 'Lihat Destinasi Wisata',
      },
      {
        'type': 'destination',
        'title': 'Dunia Fantasi (DUFAN)',
        'date': '19 Febuari 2025',
        'subtitle': 'Transportasi Umum',
        'actionText': 'Pergi Lagi',
        'status': 'Selesai',
      },
      {
        'type': 'destination',
        'title': 'Dunia Fantasi (DUFAN)',
        'date': '19 Febuari 2025',
        'subtitle': 'Transportasi Umum',
        'actionText': 'Pergi Lagi',
        'status': 'Selesai',
      },
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A6556),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Notifikasi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          titleSpacing: 0,
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          physics: const BouncingScrollPhysics(),
          itemCount: notifications.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF0F0F0),
          ),
          itemBuilder: (context, index) {
            final item = notifications[index];
            final isWeather = item['type'] == 'weather';

            return InkWell(
              onTap: () {
                if (isWeather) {
                  Navigator.pushNamed(context, '/weatherDetail');
                } else {
                  Navigator.pushNamed(
                    context,
                    '/tripRecap',
                    arguments: {
                      'title': item['title'],
                      'date': '${item['date']} | 12:00 WIB',
                      'address': 'Jl. Lodan Timur No.7, Ancol, Kec. Pademangan, Jkt Utara, Daerah Khusus Ibukota Jakarta 14430',
                      'imagePath': 'lib/assets/images/detail_image_thumbnail.png',
                    },
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Icon or Thumbnail
                    if (isWeather)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Image.asset(
                          'lib/assets/images/Cuaca Smart City Icon-05.png',
                          width: 58,
                          height: 58,
                          fit: BoxFit.contain,
                        ),
                      )
                    else
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                    const SizedBox(width: 14),

                    // Middle Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            item['title'],
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),

                          // Date
                          Text(
                            item['date'],
                            style: TextStyle(
                              fontSize: 10.5,
                              color: Colors.grey.shade500,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Subtitle / Description
                          Text(
                            item['subtitle'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Action Link
                          GestureDetector(
                            onTap: () {
                              if (isWeather) {
                                Navigator.pushNamed(context, '/categoryDetail');
                              } else {
                                Navigator.pushNamed(
                                  context,
                                  '/detailDestination',
                                  arguments: {
                                    'title': item['title'],
                                    'location': 'Ancol, Jakarta utara',
                                    'price': 'Mulai dari Rp. 200.000',
                                  },
                                );
                              }
                            },
                            child: Text(
                              item['actionText'],
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3880EC),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Top-right Status Badge for Destinations
                    if (!isWeather && item['status'] != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF1A6556),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['status'],
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

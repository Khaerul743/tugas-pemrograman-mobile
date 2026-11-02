import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecentlyViewedPage extends StatelessWidget {
  const RecentlyViewedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Dunia Fantasi (DUFAN)',
        'rating': 4.75,
        'hours': 'Open 10:00 - 22:00',
        'location': 'Ancol, Jakarta utara',
        'price': 'Mulai dari Rp. 200.000',
        'image': 'lib/assets/images/thumbnail_content.png',
      },
      {
        'title': 'Dunia Fantasi (DUFAN)',
        'rating': 4.75,
        'hours': 'Open 10:00 - 22:00',
        'location': 'Ancol, Jakarta utara',
        'price': 'Mulai dari Rp. 200.000',
        'image': 'lib/assets/images/thumbnail_content.png',
      },
      {
        'title': 'Dunia Fantasi (DUFAN)',
        'rating': 4.75,
        'hours': 'Open 10:00 - 22:00',
        'location': 'Ancol, Jakarta utara',
        'price': 'Mulai dari Rp. 200.000',
        'image': 'lib/assets/images/thumbnail_content.png',
      },
      {
        'title': 'Dunia Fantasi (DUFAN)',
        'rating': 4.75,
        'hours': 'Open 10:00 - 22:00',
        'location': 'Ancol, Jakarta utara',
        'price': 'Mulai dari Rp. 200.000',
        'image': 'lib/assets/images/thumbnail_content.png',
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
            'Terakhir Dilihat',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          titleSpacing: 0,
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 4),
          physics: const BouncingScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF0F0F0),
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detailDestination',
                  arguments: {
                    'title': item['title'],
                    'location': item['location'],
                    'price': item['price'],
                    'imagePath': item['image'] ?? 'lib/assets/images/detail_image_thumbnail.png',
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    // Circular Placeholder
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Destination Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'],
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFFFFC107),
                                size: 13,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${item['rating']} ',
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                '| ${item['hours']}',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item['location'],
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item['price'],
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Trailing Chevron
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.black87,
                      size: 20,
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DepartureSchedulePage extends StatefulWidget {
  const DepartureSchedulePage({super.key});

  @override
  State<DepartureSchedulePage> createState() => _DepartureSchedulePageState();
}

class _DepartureSchedulePageState extends State<DepartureSchedulePage> {
  // Realistic bus departures data for Transjakarta corridors
  final List<Map<String, dynamic>> _scheduledBuses = [
    {
      'busBadge': 'Bus 2',
      'route': 'Halte Jembatan Lima ➔ Halte Kota',
      'time': '18.15',
      'status': 'Dijadwalkan',
    },
    {
      'busBadge': 'Bus 3',
      'route': 'Halte Jelambar ➔ Halte Pasar Baru',
      'time': '18.30',
      'status': 'Dijadwalkan',
    },
    {
      'busBadge': 'Bus 4',
      'route': 'Halte Duri Kepa ➔ Halte Harmoni',
      'time': '18.45',
      'status': 'Dijadwalkan',
    },
    {
      'busBadge': 'Bus 5',
      'route': 'Halte Pekojan ➔ Halte Kota Tua',
      'time': '19.00',
      'status': 'Dijadwalkan',
    },
    {
      'busBadge': 'Bus 6',
      'route': 'Halte Jembatan Lima ➔ Halte Monas',
      'time': '19.15',
      'status': 'Dijadwalkan',
    },
    {
      'busBadge': 'Bus 7',
      'route': 'Halte Grogol ➔ Halte Senayan',
      'time': '19.30',
      'status': 'Dijadwalkan',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A6556),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A6556),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Keberangkatan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // 1. Map View (map_template_2.png)
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Image.asset(
                  'lib/assets/images/map_template_2.png',
                  fit: BoxFit.cover,
                ),
              ),

              // 2. Green Container with Schedule Cards
              Container(
                width: double.infinity,
                color: const Color(0xFF1A6556),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Column(
                  children: [
                    // Card 1: Nearest / Active Live Departure Card
                    _buildActiveDepartureCard(),
                    const SizedBox(height: 12),

                    // Cards 2 to N: Scheduled Departures
                    ..._scheduledBuses.map((bus) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildScheduledBusCard(bus),
                        )),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Active / Incoming Bus Card (Card 1)
  Widget _buildActiveDepartureCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Title & Route with 'Koridor' badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Keberangkatan',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3.5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF57C00), // Orange badge
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Koridor',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Flexible(
                          child: Text(
                            'Jelambar ➔ Kota',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Right: Countdown time (11 mnt)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    '11',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.05,
                    ),
                  ),
                  Text(
                    'mnt',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Terlambat 11 mnt',
            style: TextStyle(
              color: Color(0xFFE53935),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'Bisa berubah tergantung kepadatan lalu lintas',
            style: TextStyle(
              color: Color(0xFFE53935),
              fontSize: 10.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // Scheduled Bus Card (Cards 2+)
  Widget _buildScheduledBusCard(Map<String, dynamic> item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Title & Route with 'Bus X' badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Keberangkatan',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3.5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF57C00),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item['busBadge'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            item['route'] as String,
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Right: Departure clock time (e.g. 18.15)
              Text(
                item['time'] as String,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item['status'] as String,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 11.5,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'Bisa berubah tergantung kepadatan lalu lintas',
            style: TextStyle(
              color: Color(0xFFE53935),
              fontSize: 10.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PublicTransportDetailPage extends StatefulWidget {
  final String? title;
  final String? badge;
  final String? image;

  const PublicTransportDetailPage({
    super.key,
    this.title,
    this.badge,
    this.image,
  });

  @override
  State<PublicTransportDetailPage> createState() =>
      _PublicTransportDetailPageState();
}

class _PublicTransportDetailPageState extends State<PublicTransportDetailPage> {
  // Track expanded state for each accordion item (indices 0 to 5)
  // Initially all are expanded as shown in the reference design
  final Set<int> _expandedIndices = {0, 1, 2, 3, 4, 5};

  void _toggleExpanded(int index) {
    setState(() {
      if (_expandedIndices.contains(index)) {
        _expandedIndices.remove(index);
      } else {
        _expandedIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final displayTitle =
        widget.title ?? routeArgs?['title'] ?? 'TRANSJAKARTA';
    final displayBadge =
        widget.badge ?? routeArgs?['badge'] ?? 'Rekomendasi';
    final displayImage = widget.image ??
        routeArgs?['image'] ??
        'lib/assets/images/thumbnail-transjakarta.jpg';

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
            'Transportasi Umum',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Hero Image with Floating Badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 205,
                    child: Image.asset(
                      displayImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        displayBadge,
                        style: const TextStyle(
                          color: Color(0xFF1A6556),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // 2. Transport Name Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  displayTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    letterSpacing: 0.3,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 3. Accordion Items List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Item 0: Biaya
                    _buildAccordionCard(
                      index: 0,
                      title: 'Biaya',
                      expandedBody: const Text(
                        'Rp 3.500 (tarif flat TransJakarta)',
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Item 1: Estimasi
                    _buildAccordionCard(
                      index: 1,
                      title: 'Estimasi',
                      expandedBody: const Text(
                        '±60-75 menit (tergantung kondisi lalu lintas\ndan waktu tunggu)',
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.black87,
                          height: 1.35,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Item 2: Keberangkatan
                    _buildAccordionCard(
                      index: 2,
                      title: 'Keberangkatan',
                      expandedBody: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Perkiraan keberangkatan dari Halte Duri Kepa:',
                            style: TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Pukul 18.00 WIB',
                            style: TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            'Bisa berubah tergantung kepadatan lalu lintas',
                            style: TextStyle(
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFFE53935),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/departureSchedule');
                              },
                              child: const Text(
                                'Selengkapnya',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF4FC3F7),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Item 3: Informasi Kepadatan
                    _buildAccordionCard(
                      index: 3,
                      title: 'Informasi Kepadatan',
                      expandedBody: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(text: 'Kepadatan di Halte SSSSS tergolong '),
                            TextSpan(
                              text: 'Rendah/',
                              style: TextStyle(
                                color: Color(0xFF4CAF50),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: '\n'),
                            TextSpan(
                              text: 'Sedang/',
                              style: TextStyle(
                                color: Color(0xFFFFA000),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'Tinggi',
                              style: TextStyle(
                                color: Color(0xFFE53935),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Item 4: Rute yang dilalui
                    _buildAccordionCard(
                      index: 4,
                      title: 'Rute yang dilalui',
                      expandedBody: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Dari Kedoya Selatan, naik mikrotrans atau ojek online menuju ke halte Kedoya Green Garden',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.black87,
                              height: 1.35,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              '⋮',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Text(
                            'Naik Koridor 8 TransJakarta menuju Halte Harmoni',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.black87,
                              height: 1.35,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              '⋮',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Text(
                            'Transit di Halte Harmoni, lalu naik ke Koridor 1 ke Halte Monas',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.black87,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Item 5: Kelebihan & Kekurangan (Green Background Card)
                    _buildGreenAccordionCard(index: 5),
                  ],
                ),
              ),

              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccordionCard({
    required int index,
    required String title,
    required Widget expandedBody,
  }) {
    final isExpanded = _expandedIndices.contains(index);

    return InkWell(
      onTap: () => _toggleExpanded(index),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.black87,
            width: 1.2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  if (isExpanded) ...[
                    const SizedBox(height: 4),
                    expandedBody,
                  ],
                ],
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              isExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              size: 24,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGreenAccordionCard({required int index}) {
    final isExpanded = _expandedIndices.contains(index);

    return InkWell(
      onTap: () => _toggleExpanded(index),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1A6556),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: isExpanded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Kelebihan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '• Biaya Terjangkau',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.5,
                            height: 1.35,
                          ),
                        ),
                        Text(
                          '• Jalur khusus bus mengurangi risiko terjebak macet',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.5,
                            height: 1.35,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Kekurangan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '• Perlu transit dan menunggu bus di setiap halte',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.5,
                            height: 1.35,
                          ),
                        ),
                        Text(
                          '• Kepadatan penumpang pada jam sibuk',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.5,
                            height: 1.35,
                          ),
                        ),
                      ],
                    )
                  : const Text(
                      'Kelebihan & Kekurangan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(width: 10),
            Icon(
              isExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              size: 24,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

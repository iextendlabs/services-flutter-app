import 'package:flutter/material.dart';

class TrialHomeTab extends StatelessWidget {
  final Map<String, dynamic> data;
  const TrialHomeTab({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final categories = data['categoryCarousel'] as List<dynamic>? ?? [];
    final staffMembers = data['staffMembers'] as List<dynamic>? ?? [];
    final testimonials = data['testimonials'] as List<dynamic>? ?? [];
    final faqs = data['faqs'] as List<dynamic>? ?? [];
    final newsletter = data['newsletter'] as Map<String, dynamic>? ?? {};
    final whatsappNumber = data['whatsappNumber'] as String? ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lipslay Marketplace'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories Carousel
            if (categories.isNotEmpty)
              SizedBox(
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, idx) {
                    final cat = categories[idx];
                    return Container(
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              cat['image'] ?? '',
                              height: 80,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cat['title'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            cat['description'] ?? '',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),

            // Staff Section
            if (staffMembers.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Our Staff', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 220,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: staffMembers.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, idx) {
                          final member = staffMembers[idx];
                          final specialties = (member['specialties'] as List<dynamic>? ?? []).join(', ');
                          final rating = member['rating']?.toString() ?? '5.0';
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 160,
                                margin: const EdgeInsets.only(top: 36),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.08),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 48),
                                    Text(
                                      member['name'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    if (specialties.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          specialties,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEFF6FF),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.star, color: Colors.green, size: 18),
                                          const SizedBox(width: 4),
                                          Text(
                                            rating,
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: CircleAvatar(
                                    radius: 36,
                                    backgroundColor: Colors.white,
                                    backgroundImage: member['image'] != null && member['image'].toString().isNotEmpty
                                        ? NetworkImage(member['image'])
                                        : const AssetImage('assets/images/default.png') as ImageProvider,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),

            // Testimonials
            if (testimonials.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Testimonials', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 12),
                    ...testimonials.map((t) => Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: const Icon(Icons.person, color: Colors.blue),
                            title: Text(t['name'] ?? ''),
                            subtitle: Text(t['comment'] ?? ''),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star, color: Colors.green, size: 18),
                                Text(t['rating'].toString(), style: const TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            const SizedBox(height: 24),

            // FAQs
            if (faqs.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('FAQs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 12),
                    ...faqs.map((faq) => Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ExpansionTile(
                            title: Text(faq['question'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(faq['answer'] ?? ''),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            const SizedBox(height: 24),

            // Newsletter
            if (newsletter.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  color: Colors.blue.shade50,
                  child: ListTile(
                    title: Text(newsletter['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(newsletter['description'] ?? ''),
                    trailing: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Subscribe'),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 24),

            // WhatsApp Contact
            if (whatsappNumber.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.phone, color: Colors.green),
                    const SizedBox(width: 8),
                    Text('WhatsApp: $whatsappNumber', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
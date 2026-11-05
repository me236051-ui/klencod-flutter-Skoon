import 'package:flutter/material.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  final List> azkarCategories = const [
    {
      "category": "أذكار الصباح",
      "items": [
        "أصبحنا وأصبح الملك لله والحمد لله، لا إله إلا الله وحده لا شريك له.",
        "اللهم بك أصبحنا وبك أمسينا وبك نحيا وبك نوت وإليك النشور.",
        "آية الكرسي: الله لا إله إلا هو الحي القيوم..."
      ]
    },
    {
      "category": "أذكار المساء",
      "items": [
        "أمسينا وأمسى الملك لله والحمد لله، لا إله إلا الله وحده لا شريك له.",
        "اللهم بك أمسينا وبك أصبحنا وبك نحيا وبك نموت وإليك المصير.",
        "سورة الإخلاص والمعوذات (ثلاث مرات)."
      ]
    },
    {
      "category": "أذكار الصلاة",
      "items": [
        "بعد السلام من الصلاة: أستغفر الله (ثلاثاً)، اللهم أنت السلام ومنك السلام تباركت يا ذا الجلال والإكرام.",
        "سبحان الله (33 مرة)، الحمد لله (33 مرة)، الله أكبر (33 مرة)، وتمام المائة: لا إله إلا الله وحده لا شريك له."
      ]
    },
    {
      "category": "أذكار النوم",
      "items": [
        "باسمك ربي وضعت جنبي وبك أرفعه، إن أمسكت نفسي فارحمها وإن أرسلتها فاحفظها بما تحفظ به عبادك الصالحين.",
        "جمع الكفين وقراءة سورة الإخلاص والمعوذات والنفث فيهما ومسح ما استطاع من الجسد (ثلاث مرات)."
      ]
    },
  ];

  final String dailyTip = "نصيحة اليوم: حافظ على أذكارك فهي حصنك الحصين، واجعل لسانك رطباً بذكر الله طوال يومك لتجد السكينة والطمأنينة.";

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Card(
          color: const Color(0xFFE8EFE6),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.orange),
                    SizedBox(width: 8),
                    Text("نصيحة اليوم", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(dailyTip, style: const TextStyle(fontSize: 14, height: 1.4)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        ...azkarCategories.map((cat) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ExpansionTile(
              title: Text(cat['category'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              children: (cat['items'] as List<String>).map((text) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F9F6),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(text, style: const TextStyle(fontSize: 15, height: 1.3)),
                  ),
                );
              }).toList(),
            ),
          );
        }),
      ],
    );
  }
}
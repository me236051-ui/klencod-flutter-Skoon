import 'package:flutter/material.dart';

class PrayerGuideScreen extends StatelessWidget {
  const PrayerGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9F6),
        appBar: AppBar(
          backgroundColor: const Color(0xFFE8EFE6),
          elevation: 0,
          toolbarHeight: 0, // إخفاء العنوان الإضافي والاعتماد على التبويبات
          bottom: const TabBar(
            labelColor: Color(0xFF5A7052),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF8A9A86),
            tabs: [
              Tab(text: "الوضوء الصحيح"),
              Tab(text: "كيفية الصلاة"),
              Tab(text: "سنن الصلاة"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildGuideList([
              "1. النية بقلب صادق ثم التسمية (بسم الله).",
              "2. غسل الكفين ثلاث مرات.",
              "3. المضمضة والاستنشاق ثلاث مرات.",
              "4. غسل الوجه كاملاً من طناب الأذن للأذن ومن منابت الشعر إلى الذقن ثلاث مرات.",
              "5. غسل اليدين إلى المرفقين (البداية باليمنى ثم اليسرى) ثلاث مرات.",
              "6. مسح الرأس والأذنين مرة واحدة.",
              "7. غسل الرجلين إلى الكعبين مع الكعبين ثلاث مرات."
            ]),
            _buildGuideList([
              "1. استقبال القبلة بالبدن والنية بالقلب.",
              "2. تكبيرة الإحرام (الله أكبر) مع رفع اليدين.",
              "3. قراءة دعاء الاستفتاح، ثم الاستعاذة والبسملة وقراءة سورة الفاتحة وما تيسر من القرآن.",
              "4. الركوع مع الطمأنينة وقول (سبحان ربي العظيم) ثلاث مرات.",
              "5. الاعتدال من الركوع وقول (سمع الله لمن حمده، ربنا ولك الحمد).",
              "6. السجود الأول على الأعضاء السبعة وقول (سبحان ربي الأعلى) ثلاث مرات.",
              "7. الجلوس بين السجدتين والدعاء (رب اغفر لي وارحمني).",
              "8. التشهد الأخير والتسليم يميناً ويساراً لختام الصلاة."
            ]),
            _buildGuideList([
              "• رفع اليدين حذو المنكبين عند تكبيرة الإحرام وعند الركوع وعند الرفع منه.",
              "• وضع اليد اليمنى على اليسرى فوق الصدر في الصلاة.",
              "• دعاء الاستفتاح بعد تكبيرة الإحرام.",
              "• الاستعاذة والبسملة قبل القراءة.",
              "• الجلوس للتشهد الأول في الصلاة الرباعية والثلاثية."
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideList(List<String> steps) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(steps[index], style: const TextStyle(fontSize: 16, height: 1.4)),
          ),
        );
      },
    );
  }
}

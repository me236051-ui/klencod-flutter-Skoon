import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class QuranAudioScreen extends StatefulWidget {
  const QuranAudioScreen({super.key});

  @override
  State<QuranAudioScreen> createState() => _QuranAudioScreenState();
}

class _QuranAudioScreenState extends State<QuranAudioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String? currentPlayingUrl;
  int selectedReciterIndex = 0;

  // تم تصحيح نوع البيانات هنا ليعمل بدون مشاكل
  final List> reciters = [
    {"name": "ماهر المعيقلي", "server": "https://server12.mp3quran.net/maher/"},
    {"name": "مشاري العفاسي", "server": "https://server8.mp3quran.net/afs/"},
    {"name": "عبد الباسط عبد الصمد", "server": "https://server7.mp3quran.net/basit/"},
    {"name": "سعد الغامدي", "server": "https://server7.mp3quran.net/sds/"},
    {"name": "ياسر الدوسري", "server": "https://server11.mp3quran.net/yasser/"},
    {"name": "سعود الشريم", "server": "https://server7.mp3quran.net/shur/"},
    {"name": "محمود خليل الحصري", "server": "https://server13.mp3quran.net/hssri/"},
  ];

  final List<String> surahs = [
    "الفاتحة", "البقرة", "آل عمران", "النساء", "المائدة", "الأنعام", "الأعراف", "الأنفال", "التوبة", "يونس",
    "هود", "يوسف", "الرعد", "إبراهيم", "الحجر", "النحل", "الإسراء", "الكهف", "مريم", "طه",
    "الأنبياء", "الحج", "المؤمنون", "النور", "الفرقان", "الشعراء", "النمل", "القصص", "العنكبوت", "الروم",
    "لقمان", "السجدة", "الأحزاب", "سبأ", "فاطر", "يس", "الصافات", "ص", "الزمر", "غافر",
    "فصلت", "الشورى", "الزخرف", "الدخان", "الجاثية", "الأحقاف", "محمد", "الفتح", "الحجرات", "ق",
    "الذاريات", "الطور", "النجم", "القمر", "الرحمن", "الواقعة", "الحديد", "المجادلة", "الحشر", "الممتحنة",
    "الصف", "الجمعة", "المنافقون", "التغابن", "الطلاق", "التحريم", "الملك", "القلم", "الحاقة", "المعارج",
    "نوح", "الجن", "المزمل", "المدثر", "القيامة", "الإنسان", "المرسلات", "النبأ", "النازعات", "عبس",
    "التكوير", "الإنفطار", "المطففين", "الانشقاق", "البروج", "الطارق", "الأعلى", "الغاشية", "الفجر", "البلد",
    "الشمس", "الليل", "الضحى", "الشرح", "التين", "العلق", "القدر", "البينة", "الزلزلة", "العاديات",
    "القارعة", "التكاثر", "العصر", "الهمزة", "الفيل", "قريش", "الماعون", "الكوثر", "الكافرون", "النصر",
    "المسد", "الإخلاص", "الفلق", "الناس"
  ];

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void playAudio(int surahIndex) async {
    String formattedIndex = (surahIndex + 1).toString().padLeft(3, '0');
    String audioUrl = "${reciters[selectedReciterIndex]['server']}$formattedIndex.mp3";

    if (isPlaying && currentPlayingUrl == audioUrl) {
      await _audioPlayer.pause();
      setState(() => isPlaying = false);
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(audioUrl));
      setState(() { // تم تصحيح طريقة كتابة setState هنا
        isPlaying = true;
        currentPlayingUrl = audioUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          color: const Color(0xFFE8EFE6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("اختر القارئ:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              DropdownButton<int>(
                value: selectedReciterIndex,
                items: List.generate(reciters.length, (index) {
                  return DropdownMenuItem(
                    value: index,
                    child: Text(reciters[index]['name']!),
                  );
                }),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      selectedReciterIndex = val;
                      _audioPlayer.stop();
                      isPlaying = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: surahs.length,
            itemBuilder: (context, index) {
              String formattedIndex = (index + 1).toString().padLeft(3, '0');
              String targetUrl = "${reciters[selectedReciterIndex]['server']}$formattedIndex.mp3";
              bool isThisPlaying = isPlaying && currentPlayingUrl == targetUrl;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF8A9A86),
                  child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
                ),
                title: Text(surahs[index], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(reciters[selectedReciterIndex]['name']!),
                trailing: IconButton(
                  icon: Icon(
                    isThisPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                    color: const Color(0xFF8A9A86),
                    size: 36,
                  ),
                  onPressed: () => playAudio(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

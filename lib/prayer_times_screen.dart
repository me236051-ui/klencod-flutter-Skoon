import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  PrayerTimes? prayerTimes;
  bool loading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    _getLocationAndCalculations();
  }

  Future<void> _getLocationAndCalculations() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        loading = false;
        errorMessage = "خدمة الموقع (GPS) غير مفعلة.";
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          loading = false;
          errorMessage = "تم رفض إذن الوصول للموقع.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        loading = false;
        errorMessage = "أذونات الموقع مرفوضة بشكل دائم من إعدادات الهاتف.";
      });
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;

      setState(() {
        prayerTimes = PrayerTimes.today(coordinates, params);
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
        errorMessage = "حدث خطأ أثناء جلب الموقع.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF8A9A86)));
    }

    if (prayerTimes == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(errorMessage.isNotEmpty ? errorMessage : "تعذر حساب مواقيت الصلاة.",
              textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text("مواقيت الصلاة لليوم", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF5A7052))),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildPrayerCard("الفجر", prayerTimes!.fajr),
                _buildPrayerCard("الشروق", prayerTimes!.sunrise),
                _buildPrayerCard("الظهر", prayerTimes!.dhuhr),
                _buildPrayerCard("العصر", prayerTimes!.asr),
                _buildPrayerCard("المغرب", prayerTimes!.maghrib),
                _buildPrayerCard("العشاء", prayerTimes!.isha),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerCard(String name, DateTime time) {
    String formattedTime = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 1,
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        trailing: Text(formattedTime, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF5A7052))),
      ),
    );
  }
}

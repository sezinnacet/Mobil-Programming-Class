import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();
  Map<DateTime, bool> alarmSet = {};

  final Map<DateTime, List<String>> events = {
    DateTime(2023, 12, 20): ['İstanbul - Konser'],
    DateTime(2023, 12, 22): ['Ankara - Tiyatro'],
    DateTime(2023, 12, 26): ['İzmir - Festival'],
    DateTime(2023, 12, 28): ['Eskişehir - Konser'],
    DateTime(2023, 12, 29): ['Eskişehir - Konser'],
    DateTime(2023, 12, 30): ['Antalya - Sergi'],
    DateTime(2023, 12, 31): ['Yılbaşı'],
  };

  IconData _getIconForEvent(String eventName) {
    // Etkinlik adına göre ikon belirle
    switch (eventName) {
      case 'İstanbul - Konser':
        return Icons.music_note;
      case 'Ankara - Tiyatro':
        return Icons.theater_comedy;
      case 'İzmir - Festival':
        return Icons.festival;
      case 'Antalya - Sergi':
        return Icons.art_track;
      case 'Eskişehir - Konser':
        return Icons.music_note;
      case 'Eskişehir - Konser':
        return Icons.music_note;
      default:
        return Icons.event; // Varsayılan ikon
    }
  }

  List<String> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  void _setAlarm(DateTime day) {
    bool isAlarmAlreadySet = alarmSet[day] ?? false;
    setState(() {
      alarmSet[day] = !isAlarmAlreadySet;
    });

    if (!isAlarmAlreadySet) {
      // Alarm oluşturulduğunu belirten bir pop-up göster
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alarm Oluşturuldu'),
            content: Text('Seçilen etkinlik için alarm ayarlandı.'),
            actions: <Widget>[
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Takvim'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CalendarDatePicker(
                initialDate: selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2025),
                onDateChanged: (newDate) {
                  setState(() {
                    selectedDate = newDate;
                  });
                },
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: _getEventsForDay(selectedDate)
                      .map((event) => ListTile(
                    leading: Icon(_getIconForEvent(event)),
                    title: Text(event),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: alarmSet[selectedDate] ?? false
                            ? Colors.orange
                            : Colors.grey,
                      ),
                      onPressed: () {
                        _setAlarm(selectedDate);
                      },
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

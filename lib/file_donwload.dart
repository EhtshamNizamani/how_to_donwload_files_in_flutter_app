import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DonwloadFile extends StatefulWidget {
  const DonwloadFile({super.key});

  @override
  State<DonwloadFile> createState() => _DonwloadFileState();
}

class _DonwloadFileState extends State<DonwloadFile> {
  Dio dio = Dio();
  double progress = 0.0;

  void startDownloading() async {
    const String url =
        'https://scontent.fhdd4-1.fna.fbcdn.net/v/t1.6435-9/131681334_1528384584019271_7706797049289251143_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeF4Ooe-JHPZdsXGzVgUi0scRjilapKfFvpGOKVqkp8W-pTq_O8NuQGdvnTYFIO13A8qjxzL9GFLuvJnJgmMgY3q&_nc_ohc=NPg0hq_y2WoAX8swvEs&_nc_ht=scontent.fhdd4-1.fna&oh=00_AfB3ihGRTUIsfo3YlvnTrsWqEx2c8sKOXRV-O9E23xFQmg&oe=63E3B798';
    const String fileName = 'ehtsham.JPEG';
    String path = await _getFilePath(fileName);

    await dio.download(
      url,
      path,
      onReceiveProgress: (count, total) {
        setState(() {
          progress = count / total;
        });
        print(progress);
      },
      deleteOnError: true,
    ).then((_) => Navigator.pop(context));
  }

  Future<String> _getFilePath(fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    print("${dir.path}/$fileName");
    return "${dir.path}/$fileName";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startDownloading();
  }

  @override
  Widget build(BuildContext context) {
    String donwLoadingProgress = (progress * 100).toInt().toString();
    return AlertDialog(
      backgroundColor: Colors.lightBlue,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(height: 15),
          Text(
            'Donwloading $donwLoadingProgress',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

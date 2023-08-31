import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CallApi extends StatelessWidget {
  const CallApi({super.key});

  Future<List<dynamic>> fetchApi() async {
    Dio dio = Dio();

    var response = await dio.get("http://192.168.1.44:3000/api/congviec/list");
    print(response.data.toString());

    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
          future: fetchApi(),
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text("${snapshot.data![index]['TieuDe']}"),
                      subtitle: Text("${snapshot.data![index]['NoiDung']}"),
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sql_sample_app/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    refreshData();
    super.initState();
  }

  void refreshData() async {
    await HomeController.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await HomeController.addData("luminar");
          await HomeController.getData();
          setState(() {});
        },
      ),
      appBar: AppBar(),
      backgroundColor: Colors.red,
      body: ListView.separated(
        itemCount: HomeController.datas.length,
        itemBuilder:
            (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "id : ${HomeController.datas[index][id]}  ${HomeController.datas[index][title]}",
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () async {
                      await HomeController.updateData(
                        HomeController.datas[index][id],
                        "shihab",
                      );
                      setState(() {});
                    },
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () async {
                      await HomeController.deleteData(
                        HomeController.datas[index][id],
                      );
                      setState(() {});
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ),
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}

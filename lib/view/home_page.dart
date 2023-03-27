import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/remote_services.dart';
import '../model/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Post>? post;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getPost();
  }

  getPost() async {
    post = await RemoteService().getPost();
    if(post != null){
      setState(() {
        isLoaded = true;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('APiInitgration'),

      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: post?.length,
          itemBuilder: (context, index) {
            return Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(12),
                    color: Colors.grey
                  ),
                ),
              ),
            Expanded(child: Text(post![index].title)),
            ],);



          },

        ),
      ),
    );
  }
}

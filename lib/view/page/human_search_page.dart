import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/constant.dart';

class HumanSearchPage extends StatefulWidget {
  const HumanSearchPage({Key? key}) : super(key: key);

  @override
  State<HumanSearchPage> createState() => _HumanSearchPageState();
}

class _HumanSearchPageState extends State<HumanSearchPage> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.layers_alt_fill, size: 20),
          ),
        ],
        title: Container(
          height: 45.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: whiteColor,
          ),
          child: TextFormField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
              });
            },
            decoration: const InputDecoration(
              hintText: "Search",
              border: InputBorder.none,
              prefixIcon: Icon(CupertinoIcons.search, size: 20),
            ),
          ),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

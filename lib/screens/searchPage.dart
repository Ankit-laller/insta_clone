import 'package:flutter/material.dart';

import '../models/category.dart';
import '../utils/search_json.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getSearch(),

    );
  }

  Widget getSearch() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: size.width - 30,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black.withOpacity(0.3),
                            )),
                        style: TextStyle(color: Colors.black.withOpacity(0.3)),
                        cursorColor: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                    children: List.generate(searchCategories.length, (index) {
                      return CategoryStoryItem(
                        name: searchCategories[index],
                      );
                    })),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Wrap(
              spacing: 1,
              runSpacing: 1,
              children: List.generate(searchImage.length, (index) {
                return Container(
                  width: (size.width - 3) / 3,
                  height: (size.width - 3) / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(searchImage[index]),
                          fit: BoxFit.cover)),
                );
              }),
            )
          ],
        ));
  }

}

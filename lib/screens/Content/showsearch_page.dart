import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_project/utils/constant.dart';

class ShowSearch extends StatefulWidget {
  const ShowSearch({Key? key}) : super(key: key);

  @override
  State<ShowSearch> createState() => _ShowSearchState();
}

class _ShowSearchState extends State<ShowSearch> {
  String search = '';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefualtPadding),
            child: Column(
              children: [
                Container(
                  child: TextFormField(
                    onChanged: ((value) {
                      setState(() {
                        search = value;
                      });
                    }),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                IconButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2030),
                    ).then((value) {
                      setState(() {
                        search = value.toString();
                      });
                    });
                  },
                  icon: Icon(Icons.search),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: (search != '' && search != null)
                      ? FirebaseFirestore.instance
                          .collection('records')
                          .where('date', isEqualTo: search)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('records')
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      print('le: ${snapshot.data!.docs.length}');

                      return Container(
                        width: size.width,
                        height: 500,
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot docs =
                                  snapshot.data!.docs[index];
                              return Text(docs['date']);
                            }),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

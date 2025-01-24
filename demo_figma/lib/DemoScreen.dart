import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DemoScreen extends StatefulWidget {
  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  final TextEditingController commodityController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController boxesController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  bool includeNearbyOrigin = false;
  bool includeNearbyDestination = false;
  bool isFCL = true;
  bool iscorrect = true;
  bool iswrong = true;
  String containerSize = "40' Standard";
  String commoditiesSize = "Large";

  Future<List<String>> fetchSuggestions(String query) async {
    final url =
        Uri.parse('http://universities.hipolabs.com/search?name=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => item['name'].toString()).toList();
    } else {
      return [];
    }
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      setState(() {
        dateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 1440,
            height: 64,
            color: const Color.fromRGBO(255, 255, 255, 0.5),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Search the best Freight Rates",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(230, 235, 255, 1),
                      side: const BorderSide(
                          width: 0.5, color: Color.fromRGBO(1, 57, 255, 1))),
                  child: Text("History",
                      style: GoogleFonts.publicSans(
                        color: const Color.fromRGBO(1, 57, 255, 1),
                      )),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Container(
            height: 750,
            width: 1440,
            color: const Color.fromARGB(230, 233, 248, 255),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 750,
                  width: 1440,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Autocomplete<String>(
                                  optionsBuilder:
                                      (TextEditingValue textEditingValue) {
                                    if (textEditingValue.text.isEmpty) {
                                      return const Iterable<String>.empty();
                                    }
                                    return fetchSuggestions(textEditingValue
                                        .text); // Fetch from API
                                  },
                                  onSelected: (String selection) {
                                    originController.text = selection;
                                  },
                                  fieldViewBuilder: (
                                    BuildContext context,
                                    TextEditingController textEditingController,
                                    FocusNode focusNode,
                                    VoidCallback onFieldSubmitted,
                                  ) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30, right: 8),
                                      child: TextField(
                                        cursorColor: const Color.fromRGBO(
                                            158, 158, 158, 1),
                                        controller: textEditingController,
                                        focusNode: focusNode,
                                        decoration: const InputDecoration(
                                          labelText: 'Origin',
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      158, 158, 158, 1))),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    158, 158, 158, 1)),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.location_on_outlined,
                                            color: Color.fromRGBO(
                                                158, 158, 158, 1),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Autocomplete<String>(
                                  optionsBuilder:
                                      (TextEditingValue textEditingValue) {
                                    if (textEditingValue.text.isEmpty) {
                                      return const Iterable<String>.empty();
                                    }
                                    return fetchSuggestions(textEditingValue
                                        .text); // Fetch from API
                                  },
                                  onSelected: (String selection) {
                                    destinationController.text = selection;
                                  },
                                  fieldViewBuilder: (
                                    BuildContext context,
                                    TextEditingController textEditingController,
                                    FocusNode focusNode,
                                    VoidCallback onFieldSubmitted,
                                  ) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 36, left: 8),
                                      child: TextField(
                                        cursorColor: const Color.fromRGBO(
                                            158, 158, 158, 1),
                                        controller: textEditingController,
                                        focusNode: focusNode,
                                        decoration: const InputDecoration(
                                          labelText: 'Destination',
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      158, 158, 158, 1))),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    158, 158, 158, 1)),
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.location_on_outlined,
                                            color: Color.fromRGBO(
                                                158, 158, 158, 1),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Checkbox(
                            value: iscorrect,
                            onChanged: (value) {
                              setState(() {
                                iscorrect = value!;
                              });
                            },
                          ),
                          Text("Include nearby origin ports ",
                              style: GoogleFonts.publicSans(
                                  fontSize: 14, fontWeight: FontWeight.w400)),
                          const SizedBox(
                            width: 470,
                          ),
                          Checkbox(
                            value: iswrong,
                            onChanged: (value) {
                              setState(() {
                                iswrong = value!;
                              });
                            },
                          ),
                          Text("Include nearby destination ports ",
                              style: GoogleFonts.publicSans(
                                  fontSize: 14, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            height: 56,
                            width: 652,
                            child: DropdownButtonFormField<String>(
                              value: commoditiesSize,
                              items: [
                                "Extra Large",
                                "Large",
                                "Medium",
                                "Small",
                                "Very Small"
                              ].map((size) {
                                return DropdownMenuItem<String>(
                                  value: size,
                                  child: Text(size),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  commoditiesSize = value!;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Commodities',
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(158, 158, 158, 1))),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            height: 56,
                            width: 652,
                            child: TextField(
                              cursorColor:
                                  const Color.fromRGBO(158, 158, 158, 1),
                              controller: dateController,
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              158, 158, 158, 1))),
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        _pickDate();
                                      },
                                      child: const Icon(
                                          Icons.date_range_outlined)),
                                  labelText: "Cut off Date",
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(158, 158, 158, 1)),
                                  )),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Ship Type : ",
                            style: GoogleFonts.publicSans(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 25,
                          ),
                          Checkbox(
                            value: isFCL,
                            onChanged: (value) {
                              setState(() {
                                isFCL = value!;
                              });
                            },
                          ),
                          const Text('FCL'),
                          const SizedBox(
                            width: 30,
                          ),
                          Checkbox(
                            value: !isFCL,
                            onChanged: (value) {
                              setState(() {
                                isFCL = !value!;
                              });
                            },
                          ),
                          const Text('LCL'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            height: 56,
                            width: 652,
                            child: DropdownButtonFormField<String>(
                              value: containerSize,
                              items: [
                                "40' Standard",
                                "20' Standard",
                                "40' High Cube",
                              ].map((size) {
                                return DropdownMenuItem<String>(
                                  value: size,
                                  child: Text(size),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  containerSize = value!;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Container Size',
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(158, 158, 158, 1))),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            height: 56,
                            width: 311,
                            child: const TextField(
                              cursorColor: Color.fromRGBO(158, 158, 158, 1),
                              decoration: InputDecoration(
                                labelText: "No of Boxes",
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(158, 158, 158, 1))),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Container(
                            height: 56,
                            width: 311,
                            child: const TextField(
                              cursorColor: Color.fromRGBO(158, 158, 158, 1),
                              decoration: InputDecoration(
                                labelText: "Weight(Kgs)",
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(158, 158, 158, 1))),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 25,
                          ),
                          const Icon(Icons.info_outline_rounded, size: 15),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "To obtain accurate rate for spot rate with guaranteed space and booking, please ensure your container count and weight per container is accurate.",
                            style: GoogleFonts.publicSans(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            "Container Internal Dimensions :",
                            style: GoogleFonts.publicSans(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            children: [
                              // const SizedBox(
                              //   width: 25,
                              // ),
                              Text("Length",
                                  style: GoogleFonts.publicSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              Text("Width",
                                  style: GoogleFonts.publicSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                  )),

                              const SizedBox(
                                height: 10,
                              ),
                              Text("Height",
                                  style: GoogleFonts.publicSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromRGBO(102, 102, 102, 1),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text("39.46ft",
                                  style: GoogleFonts.publicSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromRGBO(33, 33, 33, 1),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("7.70ft",
                                  style: GoogleFonts.publicSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromRGBO(33, 33, 33, 1),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("7.74ft",
                                  style: GoogleFonts.publicSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromRGBO(33, 33, 33, 1),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            width: 120,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              width: 300,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Stack(
                                children: [
                                  for (int i = 0; i < 20; i++)
                                    Positioned(
                                      left: i * 15.0,
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 5,
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                  Center(
                                    child: Text(
                                      "Container View ",
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(230, 235, 255, 1),
                              side: const BorderSide(
                                  width: 0.5,
                                  color: Color.fromRGBO(1, 57, 255, 1))),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search_rounded,
                                size: 17,
                                color: Color.fromRGBO(1, 57, 255, 1),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("Search",
                                  style: GoogleFonts.publicSans(
                                    color: const Color.fromRGBO(1, 57, 255, 1),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                      ])
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

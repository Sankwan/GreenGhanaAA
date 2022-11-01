import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'checkout_seedlings.dart';

class RequestSeedlings extends StatelessWidget {
  const RequestSeedlings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Make a Seedling Request',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: ListView(children: [
          SizedBox(
            height: 30,
          ),
          const Text('Seedlings we have'),
          DropdownSearch<String>.multiSelection(
            items: const ['Teak', 'Pear', 'Coconut', 'largent', 'sieboldii'],
            popupProps: const PopupPropsMultiSelection.menu(
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  // labelText: 'seedling selection',
                  hintText: 'select seedling(s) here',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              showSearchBox: true,
              showSelectedItems: true,
            ),
            onChanged: print,
            selectedItems: const ["Teak"],
          ),
          const SizedBox(height: 70),
          DropdownSearch<String>(
            popupProps: const PopupProps.menu(
              showSelectedItems: true,
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  // labelText: 'type location here',
                  hintText: 'type location here',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ),
            items: const [
              "Forestry HQ",
              "Accra Mall",
              "WestHills Mall",
              'Tema Central Mall',
              'Central University'
            ],
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Location to receive seedlings",
              ),
            ),
            onChanged: print,
            selectedItem: "Forestry HQ",
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, right: 60),
            child: TextButton(
              onPressed: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const CheckoutSeedlings())));
              }),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Proceed',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

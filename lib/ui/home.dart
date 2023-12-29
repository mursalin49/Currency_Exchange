import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String _selectedCurrency = "USD";

  Widget _dropDownItem(Country country) => Container(
        child: Row(
          children: [
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(
              width: 8.0,
            ),
            Text("${country.currencyName}"),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text(
            "Base Currency",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: CountryPickerDropdown(
              initialValue: 'us',
              itemBuilder: _dropDownItem,
              onValuePicked: (Country? country) {
                setState(() {
                  _selectedCurrency = country?.currencyCode ?? "";
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

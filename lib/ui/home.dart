import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_cupertino.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/currency_picker_cupertino.dart';
import 'package:country_currency_pickers/currency_picker_dialog.dart';
import 'package:country_currency_pickers/currency_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/currency_model.dart';
import '../service/api.dart';
import 'components/all_curency_listitem.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiServies apiService = ApiServies();
  String _selectedCurrency = "USD";

  Widget _buildCurrencyDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
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
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        const Text(
          "Base Currency",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: CountryPickerDropdown(
            initialValue: 'us',
            itemBuilder: _buildCurrencyDropdownItem,
            onValuePicked: (Country? country) {
              print("${country?.name}");
              setState(() {
                _selectedCurrency = country?.currencyCode ?? "";
              });
            },
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          "All Currency",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CurrencyModel> currencyModelList = snapshot.data ?? [];
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return AllCurrencyListItem(
                      currencyModel: currencyModelList[index],
                    );
                  },
                  itemCount: currencyModelList.length,
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error occured"),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            future: apiService.getLatest(_selectedCurrency),
          ),
        )
      ],
    );
  }
}

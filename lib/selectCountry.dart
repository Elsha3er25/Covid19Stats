// Import necessary Flutter packages and Liquid Pull To Refresh package.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'dart:developer' as dev; // For logging purposes

// SelectionScreen is a StatefulWidget that displays a list of countries for the user to select.
class SelectionScreen extends StatefulWidget {
  SelectionScreen({this.countries, this.selectedCountry}) : super();
  final List countries; // List of all available countries
  final String selectedCountry; // Initially selected country

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

// _SelectionScreenState is the StatefulWidget's state, which contains the functionality for the screen.
class _SelectionScreenState extends State<SelectionScreen> {
  // Variables and controllers for managing the search functionality and scrolling.
  final scrollController = ScrollController();
  final GlobalKey key = new GlobalKey();
  var countryFlags = {...}; // A map of country names to their respective flag emojis
  final TextEditingController _controller = new TextEditingController();
  FocusNode textFieldFocusNode;
  bool searchFieldVisible = false;
  List filteredCountries;
  bool newSearch = true;

  // initState() is called when the State is initialized. It sets up the initial state of the widget.
  @override
  void initState() {
    super.initState();

    filteredCountries = widget.countries;
    textFieldFocusNode = new FocusNode();
    // Set up a post-frame callback to scroll to the initially selected country.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 50), () {
        var index = widget.countries.indexOf(widget.selectedCountry);
        double height = MediaQuery.of(context).size.height - (4 * 56);
        double scrollTo = (56 * (index).toDouble() - height);
        dev.log(scrollTo.toString());
        if (scrollTo > 0)
          scrollController.animateTo(scrollTo,
              duration: Duration(milliseconds: (678 * (1 + (index / 30))).toInt()), curve: Curves.ease);
      });
    });
  }

  // dispose() is called when the State is removed from the tree. It cleans up resources used by the widget.
  @override
  void dispose() {
    textFieldFocusNode.dispose();
    super.dispose();
  }

  // toggleSearchField() toggles the visibility of the search field and resets the filtered countries list.
  void toggleSearchField() {
    setState(() {
      searchFieldVisible = !searchFieldVisible;
      filteredCountries = widget.countries;
      newSearch = true;
      _controller.clear();
    });
  }

  // build() creates the widget tree for the screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff232d37),
        appBar: AppBar(
          title: Text('Select a country'),
          actions: <Widget>[
            IconButton(
                onPressed: toggleSearchField,
                icon: Icon(Icons.search)),
          ],
        ),
        body: Stack(
          children: <Widget>[
            // Scrollbar wraps the ListView, providing a scrollbar for the list.
            Scrollbar(
              child: ListView.builder(
                key: key,
                controller: scrollController,
                shrinkWrap: true,
                itemCount: filteredCountries.length,
                itemBuilder: (context, i) {
                  // getListTile() creates a ListTile for each country in the filtered list.
                  return getListTile(context, i, firstInSearch: searchFieldVisible && i == 0, animated: newSearch && i == 0);
                },
              ),
            ),
            // AnimatedContainer manages the appearance of the search field.
            new AnimatedContainer(
              duration: Duration(milliseconds: 250),
              height: searchFieldVisible ? 80 : 0,
              onEnd: (){
                if(searchFieldVisible)
                  textFieldFocusNode.requestFocus();
              },
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: new Card(
                    child: new ListTile(
                      leading: new Icon(Icons.search),
                      title: new TextField(
                        focusNode: textFieldFocusNode,
                        enabled: searchFieldVisible,
                        controller: _controller,
                        decoration: new InputDecoration(hintText: 'Search', border: InputBorder.none),
                        onTap: (){
                          if(newSearch = true)
                            newSearch = false;
                        },
                        onChanged: (String value) {
                          setState(() {
                            newSearch = false;
                            filteredCountries = widget.countries.where((s) => s.toLowerCase().contains(value.toLowerCase())).toList();
                          });
                        },
                      ),
                      trailing: new IconButton(
                        icon: new Icon(Icons.cancel),
                        onPressed: toggleSearchField,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  // getListTile() creates a ListTile for each country in the filtered list.
  Widget getListTile(context, i, {bool firstInSearch = false, bool animated = false}) {
    return InkWell(
      onTap: () {
       

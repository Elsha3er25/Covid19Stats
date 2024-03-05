// Import necessary Flutter packages and Liquid Pull To Refresh package.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'dart:developer' as dev; // For logging purposes

// SelectionScreen is a StatefulWidget that displays a list of countries for the user to select.
class SelectionScreen extends StatefulWidget {
  SelectionScreen({this.countries, this.selectedCountry}) : super();
  
  // List of all available countries
  final List countries;
  
  // Initially selected country
  final String selectedCountry;
  
  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

// _SelectionScreenState is the StatefulWidget's state, which contains the functionality for the screen.
class _SelectionScreenState extends State<SelectionScreen> {
  // Variables and controllers for managing the search functionality and scrolling.
  final scrollController = ScrollController(); // Scroll controller for the ListView.
  final GlobalKey key = new GlobalKey(); // Global key for the ListView.
  var countryFlags = {...}; // A map of country names to their respective flag emojis
  final TextEditingController _controller = new TextEditingController(); // Text editing controller for the search field.
  FocusNode textFieldFocusNode; // Focus node for the search field.
  bool searchFieldVisible = false; // Flag to control the visibility of the search field.
  List filteredCountries; // Filtered list of countries based on search query.
  bool newSearch = true; // Flag to track if a new search has started.

  // initState() is called when the State is initialized. It sets up the initial state of the widget.
  @override
  void initState() {
    super.initState();

    filteredCountries = widget.countries; // Initialize the filtered countries list with all countries.
    textFieldFocusNode = new FocusNode(); // Initialize the search field focus node.

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
    textFieldFocusNode.dispose(); // Dispose the search field focus node.
    super.dispose();
  }

  // toggleSearchField() toggles the visibility of the search field and resets the filtered countries list.
  void toggleSearchField() {
    setState(() {
      searchFieldVisible = !searchFieldVisible; // Toggle the search field visibility.
      filteredCountries = widget.countries; // Reset the filtered countries list.
      newSearch = true; // Set newSearch flag to true.
      _controller.clear(); // Clear the search field text.
    });
  }

  // build() creates the widget tree for the screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff232d37), // Set the background color.
        appBar: AppBar(
          title: Text('Select a country'), // Set the app bar title.
          actions: <Widget>[
            IconButton(
                onPressed: toggleSearchField, // Toggle the search field visibility.
                icon: Icon(Icons.search)),
          ],
        ),
        body: Stack( // Stack to position the search field and the list of countries.
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
                  textFieldFocusNode.requestFocus(); // Request focus for the search field when it appears.
              },
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: new Card(
                    child: new ListTile(
                      leading: new Icon(Icons.search), // Search field leading icon.
                      title: new TextField(
                        focusNode: textFieldFocusNode, // Associate the search field with the focus node.
                        enabled: searchFieldVisible, // Enable the search field when the search field is visible.
                        controller: _controller, // Associate the search field with the text editing controller.
                        decoration: new InputDecoration(hintText: 'Search', border: InputBorder.none), // Set the search field hint text.
                        onTap: (){
                          if(newSearch = true)
                            newSearch = false; // Handle onTap event for the search field

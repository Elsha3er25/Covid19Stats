import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'dart:developer' as dev;

class SelectionScreen extends StatefulWidget {
  SelectionScreen({this.countries, this.selectedCountry}) : super();
  final List countries;
  final String selectedCountry;

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  final scrollController = ScrollController();
  final GlobalKey key = new GlobalKey();
  /*
      "Italy" : "🇮🇹",
    "China" : "🇨🇳",
    "Spain" : "🇪🇸",
    "USA" : "🇺🇸",
    "Germany" : "🇩🇪",
    "Iran" : "🇮🇷",
    "France" : "🇫🇷",
    "S. Korea" : "🇰🇷",
    "Switzerland" : "🇨🇭",
    "UK" : "🇬🇧",
    "Netherlands" : "🇳🇱",
    "Belgium" : "🇧🇪",
    "Austria" : "🇦🇹",
    "Norway" : "🇳🇴",
    "Sweden" : "🇸🇪",
    "Portugal" : "🇵🇹",
    "Denmark" : "🇩🇰",
    "Australia" : "🇦🇺",
   */
  var countryFlags = {
    "Diamond Princess" : "🛳",
    "Ascension Island" : "🇦🇨",
    "Andorra" : "🇦🇩",
    "UAE" : "🇦🇪",
    "Afghanistan" : "🇦🇫",
    "Antigua and Barbuda" : "🇦🇬",
    "Anguilla" : "🇦🇮",
    "Albania" : "🇦🇱",
    "Armenia" : "🇦🇲",
    "Angola" : "🇦🇴",
    "Antarctica" : "🇦🇶",
    "Argentina" : "🇦🇷",
    "American Samoa" : "🇦🇸",
    "Austria" : "🇦🇹",
    "Australia" : "🇦🇺",
    "Aruba" : "🇦🇼",
    "Åland Islands" : "🇦🇽",
    "Azerbaijan" : "🇦🇿",
    "Bosnia and Herzegovina" : "🇧🇦",
    "Barbados" : "🇧🇧",
    "Bangladesh" : "🇧🇩",
    "Belgium" : "🇧🇪",
    "Burkina Faso" : "🇧🇫",
    "Bulgaria" : "🇧🇬",
    "Bahrain" : "🇧🇭",
    "Burundi" : "🇧🇮",
    "Benin" : "🇧🇯",
    "St. Barth" : "🇧🇱",
    "Bermuda" : "🇧🇲",
    "Brunei" : "🇧🇳",
    "Bolivia" : "🇧🇴",
    "Caribbean Netherlands" : "🇧🇶",
    "Brazil" : "🇧🇷",
    "Bahamas" : "🇧🇸",
    "Bhutan" : "🇧🇹",
    "Bouvet Island" : "🇧🇻",
    "Botswana" : "🇧🇼",
    "Belarus" : "🇧🇾",
    "Belize" : "🇧🇿",
    "Canada" : "🇨🇦",
    "Cocos (Keeling) Islands" : "🇨🇨",
    "DRC" : "🇨🇩",
    "CAR" : "🇨🇫",
    "Congo" : "🇨🇬",
    "Switzerland" : "🇨🇭",
    "Côte d’Ivoire" : "🇨🇮",
    "Cook Islands" : "🇨🇰",
    "Chile" : "🇨🇱",
    "Cameroon" : "🇨🇲",
    "China" : "🇨🇳",
    "Colombia" : "🇨🇴",
    "Clipperton Island" : "🇨🇵",
    "Costa Rica" : "🇨🇷",
    "Cuba" : "🇨🇺",
    "Cabo Verde" : "🇨🇻",
    "Curaçao" : "🇨🇼",
    "Christmas Island" : "🇨🇽",
    "Cyprus" : "🇨🇾",
    "Czechia" : "🇨🇿",
    "Germany" : "🇩🇪",
    "Diego Garcia" : "🇩🇬",
    "Djibouti" : "🇩🇯",
    "Denmark" : "🇩🇰",
    "Dominica" : "🇩🇲",
    "Dominican Republic" : "🇩🇴",
    "Algeria" : "🇩🇿",
    "Ceuta & Melilla" : "🇪🇦",
    "Ecuador" : "🇪🇨",
    "Estonia" : "🇪🇪",
    "Egypt" : "🇪🇬",
    "Western Sahara" : "🇪🇭",
    "Eritrea" : "🇪🇷",
    "Spain" : "🇪🇸",
    "Ethiopia" : "🇪🇹",
    "European Union" : "🇪🇺",
    "Finland" : "🇫🇮",
    "Fiji" : "🇫🇯",
    "Falkland Islands" : "🇫🇰",
    "Micronesia" : "🇫🇲",
    "Faeroe Islands" : "🇫🇴",
    "France" : "🇫🇷",
    "Gabon" : "🇬🇦",
    "UK" : "🇬🇧",
    "Grenada" : "🇬🇩",
    "Georgia" : "🇬🇪",
    "French Guiana" : "🇬🇫",
    "Guernsey" : "🇬🇬",
    "Ghana" : "🇬🇭",
    "Gibraltar" : "🇬🇮",
    "Greenland" : "🇬🇱",
    "Gambia" : "🇬🇲",
    "Guinea" : "🇬🇳",
    "Guadeloupe" : "🇬🇵",
    "Equatorial Guinea" : "🇬🇶",
    "Greece" : "🇬🇷",
    "South Georgia & South Sandwich Islands" : "🇬🇸",
    "Guatemala" : "🇬🇹",
    "Guam" : "🇬🇺",
    "Guinea-Bissau" : "🇬🇼",
    "Guyana" : "🇬🇾",
    "Hong Kong" : "🇭🇰",
    "Heard & McDonald Islands" : "🇭🇲",
    "Honduras" : "🇭🇳",
    "Croatia" : "🇭🇷",
    "Haiti" : "🇭🇹",
    "Hungary" : "🇭🇺",
    "Canary Islands" : "🇮🇨",
    "Indonesia" : "🇮🇩",
    "Ireland" : "🇮🇪",
    "Israel" : "🇮🇱",
    "Isle of Man" : "🇮🇲",
    "India" : "🇮🇳",
    "British Indian Ocean Territory" : "🇮🇴",
    "Iraq" : "🇮🇶",
    "Iran" : "🇮🇷",
    "Iceland" : "🇮🇸",
    "Italy" : "🇮🇹",
    "Jersey" : "🇯🇪",
    "Jamaica" : "🇯🇲",
    "Jordan" : "🇯🇴",
    "Japan" : "🇯🇵",
    "Kenya" : "🇰🇪",
    "Kyrgyzstan" : "🇰🇬",
    "Cambodia" : "🇰🇭",
    "Kiribati" : "🇰🇮",
    "Comoros" : "🇰🇲",
    "St. Kitts & Nevis" : "🇰🇳",
    "North Korea" : "🇰🇵",
    "S. Korea" : "🇰🇷",
    "Kuwait" : "🇰🇼",
    "Cayman Islands" : "🇰🇾",
    "Kazakhstan" : "🇰🇿",
    "Laos" : "🇱🇦",
    "Lebanon" : "🇱🇧",
    "Saint Lucia" : "🇱🇨",
    "Liechtenstein" : "🇱🇮",
    "Sri Lanka" : "🇱🇰",
    "Liberia" : "🇱🇷",
    "Lesotho" : "🇱🇸",
    "Lithuania" : "🇱🇹",
    "Luxembourg" : "🇱🇺",
    "Latvia" : "🇱🇻",
    "Libya" : "🇱🇾",
    "Morocco" : "🇲🇦",
    "Monaco" : "🇲🇨",
    "Moldova" : "🇲🇩",
    "Montenegro" : "🇲🇪",
    "Saint Martin" : "🇲🇫",
    "Madagascar" : "🇲🇬",
    "Marshall Islands" : "🇲🇭",
    "North Macedonia" : "🇲🇰",
    "Mali" : "🇲🇱",
    "Myanmar (Burma)" : "🇲🇲",
    "Mongolia" : "🇲🇳",
    "Macao" : "🇲🇴",
    "Northern Mariana Islands" : "🇲🇵",
    "Martinique" : "🇲🇶",
    "Mauritania" : "🇲🇷",
    "Montserrat" : "🇲🇸",
    "Malta" : "🇲🇹",
    "Mauritius" : "🇲🇺",
    "Maldives" : "🇲🇻",
    "Malawi" : "🇲🇼",
    "Mexico" : "🇲🇽",
    "Malaysia" : "🇲🇾",
    "Mozambique" : "🇲🇿",
    "Namibia" : "🇳🇦",
    "New Caledonia" : "🇳🇨",
    "Niger" : "🇳🇪",
    "Norfolk Island" : "🇳🇫",
    "Nigeria" : "🇳🇬",
    "Nicaragua" : "🇳🇮",
    "Netherlands" : "🇳🇱",
    "Norway" : "🇳🇴",
    "Nepal" : "🇳🇵",
    "Nauru" : "🇳🇷",
    "Niue" : "🇳🇺",
    "New Zealand" : "🇳🇿",
    "Oman" : "🇴🇲",
    "Panama" : "🇵🇦",
    "Peru" : "🇵🇪",
    "French Polynesia" : "🇵🇫",
    "Papua New Guinea" : "🇵🇬",
    "Philippines" : "🇵🇭",
    "Pakistan" : "🇵🇰",
    "Poland" : "🇵🇱",
    "St. Pierre & Miquelon" : "🇵🇲",
    "Pitcairn Islands" : "🇵🇳",
    "Puerto Rico" : "🇵🇷",
    "Palestine" : "🇵🇸",
    "Portugal" : "🇵🇹",
    "Palau" : "🇵🇼",
    "Paraguay" : "🇵🇾",
    "Qatar" : "🇶🇦",
    "Réunion" : "🇷🇪",
    "Romania" : "🇷🇴",
    "Serbia" : "🇷🇸",
    "Russia" : "🇷🇺",
    "Rwanda" : "🇷🇼",
    "Saudi Arabia" : "🇸🇦",
    "Solomon Islands" : "🇸🇧",
    "Seychelles" : "🇸🇨",
    "Sudan" : "🇸🇩",
    "Sweden" : "🇸🇪",
    "Singapore" : "🇸🇬",
    "St. Helena" : "🇸🇭",
    "Slovenia" : "🇸🇮",
    "Svalbard & Jan Mayen" : "🇸🇯",
    "Slovakia" : "🇸🇰",
    "Sierra Leone" : "🇸🇱",
    "San Marino" : "🇸🇲",
    "Senegal" : "🇸🇳",
    "Somalia" : "🇸🇴",
    "Suriname" : "🇸🇷",
    "South Sudan" : "🇸🇸",
    "São Tomé & Príncipe" : "🇸🇹",
    "El Salvador" : "🇸🇻",
    "Sint Maarten" : "🇸🇽",
    "Syria" : "🇸🇾",
    "Eswatini" : "🇸🇿",
    "Tristan Da Cunha" : "🇹🇦",
    "Turks & Caicos Islands" : "🇹🇨",
    "Chad" : "🇹🇩",
    "French Southern Territories" : "🇹🇫",
    "Togo" : "🇹🇬",
    "Thailand" : "🇹🇭",
    "Tajikistan" : "🇹🇯",
    "Tokelau" : "🇹🇰",
    "Timor-Leste" : "🇹🇱",
    "Turkmenistan" : "🇹🇲",
    "Tunisia" : "🇹🇳",
    "Tonga" : "🇹🇴",
    "Turkey" : "🇹🇷",
    "Trinidad and Tobago" : "🇹🇹",
    "Tuvalu" : "🇹🇻",
    "Taiwan" : "🇹🇼",
    "Tanzania" : "🇹🇿",
    "Ukraine" : "🇺🇦",
    "Uganda" : "🇺🇬",
    "U.S. Outlying Islands" : "🇺🇲",
    "United Nations" : "🇺🇳",
    "USA" : "🇺🇸",
    "Uruguay" : "🇺🇾",
    "Uzbekistan" : "🇺🇿",
    "Vatican City" : "🇻🇦",
    "St. Vincent Grenadines" : "🇻🇨",
    "Venezuela" : "🇻🇪",
    "British Virgin Islands" : "🇻🇬",
    "U.S. Virgin Islands" : "🇻🇮",
    "Vietnam" : "🇻🇳",
    "Vanuatu" : "🇻🇺",
    "Wallis & Futuna" : "🇼🇫",
    "Samoa" : "🇼🇸",
    "Kosovo" : "🇽🇰",
    "Yemen" : "🇾🇪",
    "Mayotte" : "🇾🇹",
    "South Africa" : "🇿🇦",
    "Zambia" : "🇿🇲",
    "Zimbabwe" : "🇿🇼",
    "England" : "🏴󠁧",
    "Scotland" : "🏴󠁧",
    "Wales" : "🏴󠁧",
  };

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 50), () {
        var index = widget.countries.indexOf(widget.selectedCountry);
        double height = MediaQuery.of(context).size.height - (4*56);
        double scrollTo = (56 * (index).toDouble() - height);
        dev.log(scrollTo.toString());
        if(scrollTo > 0)
          scrollController.animateTo(
               scrollTo,
              duration: Duration(milliseconds: (678 * (1 + (index / 30))).toInt()),
              curve: Curves.ease);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff232d37),
        appBar: AppBar(
          title: Text('Select a country'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context, "Global");
                  },
                  child: Center(
                      child: Icon(Icons.public)
                  )
              ),
            ),
          ],
        ),
        body: Scrollbar(
          child: ListView.builder(
            key: key,
            controller: scrollController,
            shrinkWrap: true,
            itemCount: widget.countries.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context, widget.countries[i]);
                },
                child: Container(
                  height: 56,
                  padding: new EdgeInsets.symmetric(horizontal: 20),
                  decoration: new BoxDecoration(
                      color: i % 2 == 0
                          ? Colors.transparent
                          : Color.fromARGB(10, 255, 255, 255)),
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Text(
                          widget.countries[i].toString() + (countryFlags.containsKey(widget.countries[i]) ? "  " + countryFlags[widget.countries[i]] : ""),
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        widget.countries[i] == "Global"
                            ? Icon(
                                Icons.public,
                                color: Colors.white,
                              )
                            : SizedBox(),
                      ],
                    ),
                    trailing: widget.countries[i] == widget.selectedCountry
                        ? Icon(
                            Icons.check,
                            size: 30,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              );
            },
          ),
        ));
  }
}
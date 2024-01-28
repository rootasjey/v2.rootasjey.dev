import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rootasjey/components/application_bar.dart';
import 'package:rootasjey/components/buttons/dark_elevated_button.dart';
import 'package:rootasjey/globals/constants.dart';
import 'package:rootasjey/globals/utilities.dart';
import 'package:rootasjey/router/locations/home_location.dart';

class UndefinedPage extends StatefulWidget {
  const UndefinedPage({
    super.key,
    this.errorCode = "404",
  });

  final String errorCode;

  @override
  State<StatefulWidget> createState() => _UndefinedPageState();
}

class _UndefinedPageState extends State<UndefinedPage> {
  @override
  Widget build(BuildContext context) {
    String location = "";
    final history = Beamer.of(context).beamingHistory;

    if (history.isNotEmpty) {
      final beamLocation = history.last;
      location = beamLocation.state.routeInformation.location ?? "";
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const ApplicationBar(),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Lottie.asset(
                  "assets/animations/lost_in_space_astronaut.json",
                  width: 400.0,
                  height: 400.0,
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Constants.colors.palette.first.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    location,
                    style: Utilities.fonts.body(
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 500.0,
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Opacity(
                    opacity: 0.8,
                    child: Text(
                      "route_error.${widget.errorCode}".tr(),
                      textAlign: TextAlign.center,
                      style: Utilities.fonts.code(
                        textStyle: const TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ),
                ),
                DarkElevatedButton.large(
                  margin: const EdgeInsets.only(top: 24.0),
                  onPressed: () => context.beamToNamed(HomeLocation.route),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "home_return".tr(),
                      style: Utilities.fonts.body(
                        textStyle: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
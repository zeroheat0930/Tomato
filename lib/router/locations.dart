import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:zeroheatproject/screens/home_screen.dart';
import 'package:zeroheatproject/screens/input/category_input_screen.dart';
import 'package:zeroheatproject/screens/input/input_screen.dart';
import 'package:zeroheatproject/states/category_notifier.dart';
import 'package:zeroheatproject/states/select_image_notifier.dart';
import 'package:zeroheatproject/screens/search/search_screen.dart';
import 'package:zeroheatproject/screens/chat/chatroom_screen.dart';
import 'package:zeroheatproject/screens/item/item_detail_screen.dart';
import 'package:zeroheatproject/utils/logger.dart';

const LOCATION_HOME = 'home';
const LOCATION_INPUT = 'input';
const LOCATION_ITEM = 'item';
const LOCATION_SEARCH = 'search';
const LOCATION_ITEM_ID = 'item_id';
const LOCATION_CHATROOM_ID = 'chatroom_id';
const LOCATION_CATEGORY_INPUT = 'category_input';

class HomeLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(child: HomeScreen(), key: ValueKey(LOCATION_HOME)),
      if (state.pathPatternSegments.contains(LOCATION_SEARCH))
        BeamPage(key: ValueKey(LOCATION_SEARCH), child: SearchScreen()),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/', '/$LOCATION_SEARCH'];
}

class InputLocation extends BeamLocation<BeamState> {
  @override
  Widget builder(BuildContext context, Widget navigator) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: categoryNotifier),
        ChangeNotifierProvider(create: (context) => SelectImageNotifier())
      ],
      child: super.builder(context, navigator),
    );
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.pathPatternSegments.contains(LOCATION_INPUT))
        BeamPage(key: ValueKey(LOCATION_INPUT), child: InputScreen()),
      if (state.pathPatternSegments.contains(LOCATION_CATEGORY_INPUT))
        BeamPage(
            key: ValueKey(LOCATION_CATEGORY_INPUT),
            child: CategoryInputScreen()),
    ];
  }

  @override
  List<Pattern> get pathPatterns =>
      ['/$LOCATION_INPUT', '/$LOCATION_INPUT/$LOCATION_CATEGORY_INPUT'];
}

class ItemLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    logger.d('path - ${state.uriBlueprint}\n${state.uri}');
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.pathParameters.containsKey(LOCATION_ITEM_ID))
        BeamPage(
            key: ValueKey(LOCATION_ITEM_ID),
            child:
                ItemDetailScreen(state.pathParameters[LOCATION_ITEM_ID] ?? "")),
      if (state.pathParameters.containsKey(LOCATION_CHATROOM_ID))
        BeamPage(
            key: ValueKey(LOCATION_CHATROOM_ID),
            child: ChatroomScreen(
                chatroomKey: state.pathParameters[LOCATION_CHATROOM_ID] ?? "")),
    ];
  }

  @override
  List<Pattern> get pathPatterns => [
        '/$LOCATION_SEARCH/:$LOCATION_ITEM_ID/:$LOCATION_CHATROOM_ID',
        '/$LOCATION_ITEM/:$LOCATION_ITEM_ID/:$LOCATION_CHATROOM_ID',
        '/:$LOCATION_CHATROOM_ID'
      ];
}

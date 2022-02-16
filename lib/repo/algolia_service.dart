import 'package:algolia/algolia.dart';
import 'package:zeroheatproject/data/item_model.dart';

const Algolia algolia = Algolia.init(
  applicationId: 'XHMVJHF3WU',
  apiKey: 'c3c020fb1b92d2f4ebc9c99646079eca',
);

class AlgoliaService {
  static final AlgoliaService _algoliaService = AlgoliaService._internal();

  factory AlgoliaService() => _algoliaService;

  AlgoliaService._internal();

  Future<List<ItemModel>> queryItems(String queryStr) async {
    AlgoliaQuery query = algolia.instance.index('items').query(queryStr);

    // Perform multiple facetFilters
    // query = query.facetFilter('status:published');
    // query = query.facetFilter('isDelete:false');
    AlgoliaQuerySnapshot algoliaSnapshot = await query.getObjects();
    List<AlgoliaObjectSnapshot> hits = algoliaSnapshot.hits;
    List<ItemModel> items = [];
    hits.forEach((element) {
      ItemModel item =
          ItemModel.fromAlgoliaObject(element.data, element.objectID);
      items.add(item);
    });
    return items;
  }
}

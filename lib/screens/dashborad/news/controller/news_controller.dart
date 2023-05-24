// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisan_facility/model/news_list_response.dart';

import 'package:kisan_facility/screens/dashborad/news/repositary/news_repositary.dart';

final newsListProvider = FutureProvider<List<SingleNews>>((ref) async {
  final newsRepository = ref.watch(newsRepositoryProvider);
  List<SingleNews> news = [];
  final user = await newsRepository.fetchNews();
  user.fold((l) {}, (r) {
    news.addAll(r);
  });
  return news;
});

// final newsControllerProvider = StateNotifierProvider<NewsController, bool>(
//     (ref) => NewsController(
//         newsRepository: ref.watch(newsRepositoryProvider), ref: ref));

// class NewsController extends StateNotifier<bool> {
//   final Ref _ref;
//   final NewsRepository _newsRepository;

//   NewsController({
//     required Ref ref,
//     required NewsRepository newsRepository,
//   })  : _ref = ref,
//         _newsRepository = newsRepository,
//         super(false);

  // void fetchingNewsAndStore(BuildContext context) async {
  //   state = true;
  //   final user = await _newsRepository.fetchNews();
  //   user.fold((l) => showSnackBar(context, l.message), (r) {
  //     _ref.read(newsListProvider.notifier).update((state) => r);
  //   });
  //   state = false;
  // }
// }

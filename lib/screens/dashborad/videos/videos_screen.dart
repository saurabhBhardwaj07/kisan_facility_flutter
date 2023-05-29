import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kisan_facility/components/layout.dart';
import 'package:kisan_facility/components/top_widget.dart';
import 'package:kisan_facility/model/videos_list_response.dart';
import 'package:kisan_facility/screens/dashborad/videos/full_video_screen.dart';
import 'package:kisan_facility/screens/dashborad/videos/repositary/videos_repositary.dart';
import 'package:kisan_facility/utils/navigation_shortcut.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final videosListProvider = FutureProvider<List<SingleVideo>>((ref) async {
  final videosRepository = ref.watch(videosRepositoryProvider);
  List<SingleVideo> video = [];
  final user = await videosRepository.fetchVideos();
  user.fold((l) {}, (r) {
    video.addAll(r);
  });
  return video;
});

class VideosListScreen extends StatelessWidget {
  const VideosListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
        showAsset: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TopWidget(
                  centerText: "Videos",
                  trailing: const SizedBox(),
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios))),
            ),
            SizedBox(
              height: 20.h,
            ),
            Consumer(builder: (context, ref, child) {
              final news = ref.watch(videosListProvider);
              return news.when(
                  data: (List<SingleVideo> data) {
                    return data.isEmpty
                        ? const Text("No Videos Found")
                        : Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  var element = data[index];
                                  return InkWell(
                                    onTap: () {},
                                    child: SingleVideoItem(element: element),
                                  );
                                }),
                          );
                  },
                  error: (Object error, StackTrace stackTrace) {
                    return Text(error.toString());
                  },
                  loading: () => SpinKitWave(
                          itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven ? Colors.red : Colors.green,
                          ),
                        );
                      }));
            })
          ],
        ));
  }
}

class SingleVideoItem extends StatefulWidget {
  const SingleVideoItem({
    super.key,
    required this.element,
  });

  final SingleVideo element;

  @override
  State<SingleVideoItem> createState() => _SingleVideoItemState();
}

class _SingleVideoItemState extends State<SingleVideoItem> {
  String videoId = "";

  @override
  void initState() {
    videoId = YoutubePlayer.convertUrlToId(widget.element.link ?? "")!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0.h),
      child: InkWell(
        onTap: () =>
            AppNavigation.goScreen(context, FullVideoScreen(videoId: videoId)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: "https://img.youtube.com/vi/$videoId/0.jpg",
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              widget.element.title ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline),
            )
          ],
        ),
      ),
    );
  }
}

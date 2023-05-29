// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:reel_pro_app/helper/app_color.dart';

// class RetryOnConnectionChangeInterceptor extends Interceptor {
//   final Dio dio;

//   RetryOnConnectionChangeInterceptor({
//     required this.dio,
//   });

//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) async {
//     if (_shouldRetryOnHttpException(err)) {
//       try {
//         handler.resolve(await DioHttpRequestRetrier(dio: dio)
//             .requestRetry(err.requestOptions)
//             .catchError((e) {
//           handler.next(err);
//         }));
//       } catch (e) {
//         handler.next(err);
//       }
//     } else if (_checkForTheNetConnection(err)) {
//       print('do something here');
//       Fluttertoast.showToast(
//           gravity: ToastGravity.TOP,
//           toastLength: Toast.LENGTH_LONG,
//           backgroundColor: appFontColor,
//           textColor: whiteColor,
//           msg: ' Your network is not connected  ');
//       return;
//     } else {
//       handler.next(err);
//     }
//   }

//   bool _shouldRetryOnHttpException(DioError err) {
//     return err.type == DioErrorType.other &&
//         ((err.error is HttpException &&
//             err.message.contains(
//                 'Connection closed before full header was received')));
//   }

//   bool _checkForTheNetConnection(DioError err) {
//     return err.type == DioErrorType.other &&
//         ((err.error is SocketException ||
//             err.message.contains('Failed host lookup:')));
//   }
// }

// class DioHttpRequestRetrier {
//   final Dio dio;

//   DioHttpRequestRetrier({
//     required this.dio,
//   });

//   Future<Response> requestRetry(RequestOptions requestOptions) async {
//     return dio.request(
//       requestOptions.path,
//       cancelToken: requestOptions.cancelToken,
//       data: requestOptions.data,
//       onReceiveProgress: requestOptions.onReceiveProgress,
//       onSendProgress: requestOptions.onSendProgress,
//       queryParameters: requestOptions.queryParameters,
//       options: Options(
//         contentType: requestOptions.contentType,
//         headers: requestOptions.headers,
//         sendTimeout: requestOptions.sendTimeout,
//         receiveTimeout: requestOptions.receiveTimeout,
//         extra: requestOptions.extra,
//         followRedirects: requestOptions.followRedirects,
//         listFormat: requestOptions.listFormat,
//         maxRedirects: requestOptions.maxRedirects,
//         method: requestOptions.method,
//         receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
//         requestEncoder: requestOptions.requestEncoder,
//         responseDecoder: requestOptions.responseDecoder,
//         responseType: requestOptions.responseType,
//         validateStatus: requestOptions.validateStatus,
//       ),
//     );
//   }
// }

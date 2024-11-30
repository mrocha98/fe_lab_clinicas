import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/src/exceptions/exceptions.dart';
import 'package:fe_lab_clinicas_core/src/http_client/http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../__mocks__/__mocks__.dart';

void main() {
  group('HttpClientDioImpl', () {
    late HttpClientDioImpl sut;
    late MockDio dio;

    setUp(() {
      dio = MockDio();
      sut = HttpClientDioImpl(dio);
    });

    group('.auth', () {
      late BaseOptions baseOptions;

      setUp(() {
        baseOptions = BaseOptions();
        when(sut.auth).thenReturn(sut);
        when(() => dio.options).thenReturn(baseOptions);
      });

      test('should add authKey with value true in extra', () {
        sut.auth();
        expect(
          baseOptions.extra,
          containsPair(HttpClientDioImpl.authKey, true),
        );
      });

      test('should return this', () {
        expect(sut.auth(), sut);
      });
    });

    group('.unauth', () {
      late BaseOptions baseOptions;

      setUp(() {
        baseOptions = BaseOptions();
        when(sut.unAuth).thenReturn(sut);
        when(() => dio.options).thenReturn(baseOptions);
      });

      test('should add authKey with value false in extra', () {
        sut.unAuth();
        expect(
          baseOptions.extra,
          containsPair(HttpClientDioImpl.authKey, false),
        );
      });

      test('should return this', () {
        expect(sut.unAuth(), sut);
      });
    });

    group('.get', () {
      test(
        'should transform Response to HttpClientResponse '
        'then return it in Right',
        () async {
          when(
            () => dio.get<String>(
              '/ping',
              options: OptionsWithEquality(headers: {'Accept-Language': 'en'}),
              queryParameters: {'hello': 'world'},
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(),
              data: 'pong',
              statusCode: 200,
            ),
          );

          final response = (await sut.get<String>(
            '/ping',
            headers: {'Accept-Language': 'en'},
            queryParameters: {'hello': 'world'},
          ))
              .right;

          expect(
            response,
            isA<HttpClientResponse<String>>()
                .having((r) => r.data, 'data', 'pong')
                .having((r) => r.statusCode, 'statusCode', 200),
          );
        },
      );

      test(
        'should transform DioResponse to HttpClientException '
        'then return it in Left',
        () async {
          final dioException = DioException(
            requestOptions: RequestOptions(),
            message: 'message',
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 503,
              data: 'data',
            ),
          );
          when(
            () => dio.get<String>(
              '/ping',
              options: OptionsWithEquality(headers: {'Accept-Language': 'en'}),
              queryParameters: {'hello': 'world'},
            ),
          ).thenThrow(dioException);

          final httpClientException = (await sut.get<String>(
            '/ping',
            headers: {'Accept-Language': 'en'},
            queryParameters: {'hello': 'world'},
          ))
              .left;

          expect(
            httpClientException,
            isA<HttpClientException>()
                .having((e) => e.message, 'message', 'message')
                .having((e) => e.statusCode, 'statusCode', 503)
                .having((e) => e.error, 'error', dioException)
                .having(
                  (e) => e.response,
                  'response',
                  isA<HttpClientResponse<dynamic>>()
                      .having((r) => r.data, 'data', 'data')
                      .having((r) => r.statusCode, 'statusCode', 503),
                ),
          );
        },
      );
    });

    group('.post', () {
      test(
        'should transform Response to HttpClientResponse '
        'then return it in Right',
        () async {
          when(
            () => dio.post<String>(
              '/ping',
              data: 'xyz',
              options: OptionsWithEquality(headers: {'Accept-Language': 'en'}),
              queryParameters: {'hello': 'world'},
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(),
              data: 'pong',
              statusCode: 200,
            ),
          );

          final response = (await sut.post<String>(
            '/ping',
            data: 'xyz',
            headers: {'Accept-Language': 'en'},
            queryParameters: {'hello': 'world'},
          ))
              .right;

          expect(
            response,
            isA<HttpClientResponse<String>>()
                .having((r) => r.data, 'data', 'pong')
                .having((r) => r.statusCode, 'statusCode', 200),
          );
        },
      );

      test(
        'should transform DioResponse to HttpClientException '
        'then return it in Left',
        () async {
          final dioException = DioException(
            requestOptions: RequestOptions(),
            message: 'message',
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 503,
              data: 'data',
            ),
          );
          when(
            () => dio.post<String>(
              '/ping',
              data: 'xyz',
              options: OptionsWithEquality(headers: {'Accept-Language': 'en'}),
              queryParameters: {'hello': 'world'},
            ),
          ).thenThrow(dioException);

          final httpClientException = (await sut.post<String>(
            '/ping',
            data: 'xyz',
            headers: {'Accept-Language': 'en'},
            queryParameters: {'hello': 'world'},
          ))
              .left;

          expect(
            httpClientException,
            isA<HttpClientException>()
                .having((e) => e.message, 'message', 'message')
                .having((e) => e.statusCode, 'statusCode', 503)
                .having((e) => e.error, 'error', dioException)
                .having(
                  (e) => e.response,
                  'response',
                  isA<HttpClientResponse<dynamic>>()
                      .having((r) => r.data, 'data', 'data')
                      .having((r) => r.statusCode, 'statusCode', 503),
                ),
          );
        },
      );
    });
  });
}

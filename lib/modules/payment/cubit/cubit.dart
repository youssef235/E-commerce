import 'package:florida_app_store/modules/payment/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../payment_core/network/constant.dart';
import '../../../payment_core/network/dio.dart';
import '../../../models/authentication_request_model.dart';
import '../../../models/order_registration_model.dart';
import '../../../models/payment_reqeust_model.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(PaymentInitialStates());
  static PaymentCubit get(context) => BlocProvider.of(context);
  AuthenticationRequestModel? authTokenModel;
  Future<void> getAuthToken() async {
    emit(PaymentAuthLoadingStates());
    DioHelperPayment.postData(url: ApiContest.getAuthToken, data: {
      'api_key': ApiContest.paymentApiKey,
    }).then((value) {
      authTokenModel = AuthenticationRequestModel.fromJson(value.data);
      ApiContest.paymentFirstToken = authTokenModel!.token;
      print('The token 🍅');
      emit(PaymentAuthSuccessStates());
    }).catchError((error) {
      print('Error in auth token 🤦‍♂️');
      emit(
        PaymentAuthErrorStates(error.toString()),
      );
    });
  }

  Future getOrderRegistrationID({
    required String price,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String adress,
  }) async {
    emit(PaymentOrderIdLoadingStates());
    DioHelperPayment.postData(url: ApiContest.getOrderId, data: {
      'auth_token': ApiContest.paymentFirstToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "currency": "EGP",
      "items": [],
    }).then((value) {
      OrderRegistrationModel orderRegistrationModel =
          OrderRegistrationModel.fromJson(value.data);
      ApiContest.paymentOrderId = orderRegistrationModel.id.toString();
      getPaymentRequest(price, firstName, lastName, email, phone, adress);
      print('The order id 🍅 =${ApiContest.paymentOrderId}');
      emit(PaymentOrderIdSuccessStates());
    }).catchError((error) {
      print(error);
      emit(
        PaymentOrderIdErrorStates(error.toString()),
      );
    });
  }

  // for final request token

  Future<void> getPaymentRequest(
    String priceOrder,
    String firstName,
    String lastName,
    String email,
    String phone,
    String adress,
  ) async {
    emit(PaymentRequestTokenLoadingStates());
    DioHelperPayment.postData(
      url: ApiContest.getPaymentRequest,
      data: {
        "auth_token": ApiContest.paymentFirstToken,
        "amount_cents": priceOrder,
        "expiration": 3600,
        "order_id": ApiContest.paymentOrderId,
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": adress,
          "country": "NA",
          "last_name": lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": ApiContest.integrationIdCard,
        "lock_order_when_paid": "false"
      },
    ).then((value) {
      PaymentRequestModel paymentRequestModel =
          PaymentRequestModel.fromJson(value.data);
      ApiContest.finalToken = paymentRequestModel.token;
      print('Final token 🚀 ${ApiContest.finalToken}');
      emit(PaymentRequestTokenSuccessStates());
    }).catchError((error) {
      print(error);
      emit(
        PaymentRequestTokenErrorStates(error.toString()),
      );
    });
  }

  Future getRefCode() async {
    DioHelperPayment.postData(
      url: ApiContest.getRefCode,
      data: {
        "source": {
          "identifier": "AGGREGATOR",
          "subtype": "AGGREGATOR",
        },
        "payment_token": ApiContest.finalToken,
      },
    ).then((value) {
      ApiContest.refCode = value.data['id'].toString();
      print('The ref code 🍅${ApiContest.refCode}');
      emit(PaymentRefCodeSuccessStates());
    }).catchError((error) {
      print("error");
      emit(PaymentRefCodeErrorStates(error.toString()));
    });
  }
}

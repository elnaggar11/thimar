import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/feature/faqs/model/faq_model.dart';

part 'faqs_state.dart';

class FaqsCubit extends Cubit<FaqsState> {
  FaqsCubit() : super(const FaqsState());

  Future<void> getFaqs() async {
    emit(state.copyWith(state: RequestState.loading));

    final response = await ServerGate.i.getFromServer(url: '');

    if (response.success &&
        response.data != null &&
        response.data!['data'] != null) {
      final List dataList = response.data!['data'] as List;
      final faqs = dataList.map((e) => FaqModel.fromJson(e)).toList();

      if (faqs.isEmpty) {
        emit(state.copyWith(state: RequestState.done, faqs: _getMockFaqs()));
      } else {
        emit(state.copyWith(state: RequestState.done, faqs: faqs));
      }
    } else {
      // In case the API is down or not implemented yet on the server, we use mock data to keep the UI functional for the user.
      emit(state.copyWith(state: RequestState.done, faqs: _getMockFaqs()));
    }
  }

  List<FaqModel> _getMockFaqs() {
    return [
      FaqModel(
        id: 1,
        question: 'كيفية الدفع عن طريق البطاقة الإئتمانية؟',
        answer:
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة. لقد تم توليد هذا النص من مولد النص العربي، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التي يولدها التطبيق.',
      ),
      FaqModel(
        id: 2,
        question: 'كل ما تريد معرفته عن أكواد الخصم/ الكوبونات',
        answer:
            'يمكنك استخدام أكواد الخصم والكوبونات عند إتمام الطلب في سلة المشتريات للحصول على خصومات مميزة على المنتجات المختارة.',
      ),
      FaqModel(
        id: 3,
        question: 'هل يتم وضع منتجات جديدة كل فترة؟',
        answer:
            'نعم، نقوم بإضافة منتجات طازجة ومتنوعة بشكل دوري لتلبية جميع احتياجاتكم اليومية بأعلى جودة ممكنة.',
      ),
      FaqModel(
        id: 4,
        question: 'ما هي الفترة الزمنية لتحديث المخزون لديكم؟',
        answer:
            'يتم تحديث المخزون يومياً للتأكد من توفر جميع الخضروات والفواكه واللحوم والبهارات الطازجة بشكل مستمر.',
      ),
      FaqModel(
        id: 5,
        question: 'لم أستلم منتج ما، ماذا أفعل؟',
        answer:
            'إذا واجهت أي مشكلة في استلام أي منتج من طلبك، يرجى التواصل معنا فوراً عبر صفحة اتصل بنا أو الدعم الفني وسنقوم بحل المشكلة فوراً.',
      ),
    ];
  }
}

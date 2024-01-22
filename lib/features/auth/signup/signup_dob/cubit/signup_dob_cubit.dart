import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:saro/features/auth/signup/signup_dob/cubit/signup_dob_state.dart';

@injectable
class SignupDobCubit extends Cubit<SignupDobState> {
  SignupDobCubit() : super(SignupDobState());

  void submitDOB(String dob) {
    DateTime date = DateFormat('dd MMM , y').parse(dob);
    Duration difference = DateTime.now().difference(date);
    bool is13YearsApart = difference.inDays >= 13 * 365;
    if (is13YearsApart) {
      emit(
        state.copyWith(
          signupDobStatus: SignupDobStatus.success,
          dob: date.toString().split(" ")[0],
        ),
      );
      //
    } else {
      emit(
        state.copyWith(
          signupDobStatus: SignupDobStatus.failure,
          errorMsg: "User must be atleast 13 years old.",
        ),
      );
    }
  }
}

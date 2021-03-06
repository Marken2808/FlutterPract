import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tolo_timeline/auth/auth_credential.dart';

import 'package:tolo_timeline/auth/auth_cubit.dart';
import 'package:tolo_timeline/auth/auth_repository.dart';
import 'package:tolo_timeline/auth/form_submission_status.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  SigninBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(SigninState());

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    if (event is SigninUsername) {
      yield state.copyWith(username: event.username);
    } else if (event is SigninPassword) {
      yield state.copyWith(password: event.password);
    } else if (event is SigninSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final userId = await authRepo.signin(
          username: state.username,
          password: state.password,
        );
        yield state.copyWith(formStatus: SubmissionSucess());

        authCubit.launchSession(
          AuthCredential(username: state.username, userId: userId),
        );
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
      }
    }
  }
}

// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
// import 'package:bloc_logic/common/data/result.dart';
// import 'package:meta/meta.dart';
//
// part 'valid_event.dart';
//
// part 'valid_state.dart';
//
// class ValidBloc<D, U extends IUseCase<D, bool, String>>
//     extends Bloc<ValidEvent, ValidState> {
//   final U usecase;
//
//   ValidBloc({@required this.usecase}) : super(InitialValidState());
//
//   // @override
//   // Stream<ValidState> mapEventToState(ValidEvent event) async* {
//   //   if (event is ChangeValidEvent) {
//   //     Result<bool, String> valid = this.usecase.execute(event.value);
//   //     yield ChangedValidState(
//   //         result: Result<D>(
//   //             value: event.value, error: valid.value ? '' : 'Data is invalid'));
//   //   }
//   // }
// }

import 'package:bloc_logic/common/core/blocs/valid/valid_bloc.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidLogic<S, V, F> {
  ValidBloc<S, V, F> _validBloc;

  ValidBloc get validBloc => _validBloc;

  ValidLogic({@required IUseCase<S, V, F> usecase}) {
    _validBloc = ValidBloc<S, V, F>(usecase: usecase);
  }

  void validate([V value]) {
    _validBloc.add(ChangeValidEvent(value));
  }

  void initiate() {
    _validBloc.add(InitialValidEvent());
  }

  void dispose() {
    _validBloc.close();
  }

  BlocBuilder builder({
    Function(ChangedValidState) valid,
    Function() unusual,
  }) {
    return BlocBuilder<ValidBloc, ValidState>(
      cubit: _validBloc,
      builder: (BuildContext context, ValidState validState) {
        if (validState is ChangedValidState)
          return valid == null ? Container() : valid(validState);
        else
          return unusual();
      },
    );
  }

  BlocListener listener({
    Function(ChangedValidState) valid,
    Function() unusual,
    Widget child,
  }) {
    return BlocListener<ValidBloc, ValidState>(
      cubit: _validBloc,
      listener: (BuildContext context, ValidState validState) {
        if (validState is ChangedValidState)
          valid(validState);
        else
          unusual();
      },
      child: child,
    );
  }
}

import 'package:bloc_logic/bloc_logic.dart';

part 'valid_bloc.dart';
part 'valid_state.dart';

part 'valid_event.dart';

/// **1. DEFINE LOGIC**
/// ```dart
/// ValidLogic _validLogic;
/// ```
///
/// **2. INITIALIZE LOGIC**
/// ```dart
/// _validLogic = ValidLogic(usecase: ValidUseCase());
/// ```
///
/// **3. DISPOSE**
/// ```dart
/// _validLogic.dispose();
/// ```
///
/// **4. USE CASE**
///
/// ```dart
/// class ValidUseCase implements IUseCase<<String, String, String>> {
///   @override
///   Result<String, String> execute([String value]) {
///     try {
///       if (value == null) return Result(success: '');
///       if (value.isEmpty) return Result(failure: 'The value must not be empty.');
///       if (value.length > 3)
///         return Result(failure: 'The value must be less then 4.');
///       return Result(success: value);
///     } catch (e, stacktrace) {
///       print('BLOC_LOGIC: ${e.toString()} STACKTRACE: ${stacktrace.toString()}');
///       return Result(failure: e.toString());
///     }
///   }
/// }
/// ```
///
/// **5. LISTENER**
///
/// Available states:
///
/// * ValidatedValidState
///
/// Example:
///
/// ```dart
/// _validLogic.listener(
///   (context, state) {
///     if (state is ValidatedValidState)
///       print('valided');
///    },
///    child: Container(),
/// )
/// ```
///
/// **6. BUILDER**
///
/// Available states:
///
/// * ValidatedValidState
///
/// Example:
///
/// ```dart
/// _validLogic.builder(
///       (context, state) {
///     Result _result = (state as ValidatedValidState).result;
///     return TextField(
///       controller: _validController,
///       decoration: InputDecoration(
///         errorText: _result.hasFailure() ? _result.failure : null,
///       ),
///       onChanged: (value) {
///         _validLogic.validate(value);
///       },
///     );
///   },
/// ),
///```
///
/// **7. EVENTS**
///
/// * initiate()
/// * validate()
///
/// Example:
///
/// ```dart
/// _validLogic.initiate();
/// _validLogic.validate();
/// ```
///
class ValidLogic<S, V, F> {
  late ValidBloc<S, V, F> _validBloc;

  ValidBloc get validBloc => _validBloc;

  bool get validated => _validBloc is ValidatedValidState;

  ValidLogic({required IUseCase<S, V, F> usecase}) {
    _validBloc = ValidBloc<S, V, F>(usecase: usecase);
  }

  void dispose() {
    _validBloc.close();
  }

  void initiate() {
    _validBloc.add(InitialValidEvent());
  }

  void validate([V? value]) {
    _validBloc.add(ValidateValidEvent(value));
  }

  BlocListener listener(void Function(BuildContext, ValidState) listener,
      {bool Function(ValidState, ValidState)? listenWhen, required  Widget child}) {
    return BlocListener<ValidBloc, ValidState>(
      bloc: _validBloc,
      listener: (BuildContext context, ValidState validState) {
        listener(context, validState);
      },
      listenWhen: (ValidState beforeValidState, ValidState afterValidState) {
        return listenWhen!(beforeValidState, afterValidState);
      },
      child: child,
    );
  }

  BlocBuilder builder(Widget Function(BuildContext, ValidState) builder,
      {bool Function(ValidState, ValidState)? buildWhen}) {
    return BlocBuilder<ValidBloc, ValidState>(
      bloc: _validBloc,
      builder: (BuildContext context, ValidState validState) {
        return builder(context, validState);
      },
      buildWhen: (ValidState beforeValidState, ValidState afterValidState) {
        return buildWhen!(beforeValidState, afterValidState);
      },
    );
  }
}

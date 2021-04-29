# Bloc logic

I really like using bloc pattern for state management. In my opinion, it's the best decision for most tasks. This
pattern use streams and it's not bit convenient. But we have plugin flutter_bloc by Felix Angelov. That plugin is easy
for understanding and required less strings of the code. Thats why most of developer prefer to use that plugin. However,
when it is created a big project with large amount logic operations, that advantages are disappeared. We describe the
same events, states and blocs again and again. Most of that blocs have the same behavior and use the similar logic. I
has noticed that and grouped blocs' behavior. As it turned out, their amount is not too big. And we can use these
behaviors to create large logic constructions. We can use blocs' behaviors like bricks to building our projects.

### Clean code

This pattern can to use for creating clean code architecture. In the most examples for bloc it shown only two layers:
user interface and data layer. Bloc is between these two layers. It connects them. But it only controls state and
doesn't contains any logic. In my opinion, we must inject logic layer between bloc and data layer. It will allow us put
out of brackets bloc. We won't need to change bloc anymore. All changes we will make only in the logic layer. I called
them use cases.

In totally, we have next layers:

* user interface
* bloc
* use cases
* data (repository and datasource)

![clean_code](https://user-images.githubusercontent.com/9856286/109404873-3d8d8800-798c-11eb-910f-8c73994a9656.jpg)

### Use cases

All use cases have the same functionality. In the total case it send some value and get some result. That result can be
two types: success and failure. When the result is a success, it get some successful value. When the result is a
failure, it get some failure value. For example it can be a error string. So, every use case defined by three
parameters:

* S - success
* V - value
* F - failure

You can use for our use case next class with those parameters:

```
IUseCase<S, V, F>
```

You must replace generics S, V, F with types for our task. For example:

```
class ExampleUseCase implements IUseCase<List<String>, int, String>
```

What does it mean? You create new use case. When you send to it integer value, it can return strings list, if it is
success, or error string if it a failure.

There are only two types of the use cases: synchronous and asynchronous. The synchronous use case run momently. But
asynchronous use case requires a some time. For example, if you send request to server, the answer will return for
several milliseconds. If you want to use asynchronous use case, take class **IFutureUseCase** like simple **IUseCase**.

```
class ExampleFutureUseCase implements IFutureUseCase<List<String>, int, String>
```

### Result

As I’ve already said use cases return the results. These results can be two types: success and failure. Success result
returns dynamic type payload. It can be any variable what you want to get from use case. For example it can be the
clients list. Failure result also can return any types variable. In most cases I use simple String type. I return error
string and it enough for most tasks. You can use more difficult class failure which contains of not only error string
but error code.

### Logic Patterns

Most of blocs behaviors are the same ones. We are repeating them again and again. I have highlighted some of them and
have created special classes for convinient to use these patterns. Its are called blocs logics. Some of them I expose
for you below:

## Check Logic

![check_logic_parts](https://user-images.githubusercontent.com/9856286/116503358-47216680-a8cf-11eb-97b3-aaa82f1a9e70.jpg)

It is the very simple logic. This pattern does only turning on or off some switcher. For example we can see it when use
Checkbox widget. It can seem that it is unnecessary action. But it's not right. In the future you can use this logic
together with many different logics for building stonge app architecture.

![check_logic](https://user-images.githubusercontent.com/9856286/109413991-4739de80-79d2-11eb-9914-a6bb19f132cf.gif)

For beginning you must initialize and define disposing our logic. We must do it in the our **StatefulWidget**.

```
  CheckLogic _checkLogic;

  @override
  void initState() {
    super.initState();
    _checkLogic = CheckLogic();
  }

  @override
  void dispose() {
    _checkLogic.dispose();
    super.dispose();
  }
```

Lets add button which has only two states - turning on and turning off. This button is wrapped in CheckLogic, which has
module child. Button widget redraw every times when logic is switched. The logic changes with helping **turnOn()** and
**turnOff()** methods.

```
_checkLogic.builder(
  (context, state) {
    return RaisedButton(
      child:
          Text(state is CheckedCheckState ? 'Turn on' : 'Turn off'),
      color: state is CheckedCheckState
          ? Colors.deepOrange
          : Colors.green,
      textColor: Colors.white,
      onPressed: () {
        if (state is CheckedCheckState)
          _checkLogic.uncheckEvent();
        else
          _checkLogic.checkEvent();
      },
    );
  },
),
```

## Radio Logic


![radio](https://user-images.githubusercontent.com/9856286/116503390-602a1780-a8cf-11eb-806c-aa8554fcafda.jpg)


The next simple pattern is RadioLogic. You can build and control radio buttons with it for example. If you want to add
tabs in your app RadioLogic is the best way for it.

![radio_logic](https://user-images.githubusercontent.com/9856286/109422937-66029a00-79ff-11eb-8ebb-f085ba51ff67.gif)

How in the first case there is not any usecases. It is unnecessary. To start we initialize logic and dispose it:

```
  RadioLogic _radioLogic;

  @override
  void initState() {
    _radioLogic = RadioLogic();
    super.initState();
  }
  
  @override
  void dispose() {
    _radioLogic.dispose();
    super.dispose();
  }
```

For example we want create several buttons which will we work like radio buttons and will change color if it selected.
We must wrap every button with builder of radio logic. In practice we do it only one time. If we want to select current
button we use procedure select with integer index parameter. This parameter means current index in the items list.

```
_radioLogic.builder(
  (context, state) {
    if (state is SelectedRadioState) {
      print('selected ' + state.index.toString());
      return ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Center(
              child: RaisedButton(
                child: Text(list.elementAt(index)),
                color: index == state.index
                    ? Colors.deepOrange
                    : null,
                onPressed: () {
                  _radioLogic.select(index);
                },
              ),
            );
          });
    } else {
      print('failure');
      return Center(
        child: Text('Failure'),
      );
    }
  },
),
```

## Valid Logic

Next pattern consist also use case. It allows to add logic in this file and don't touch bloc files. We have next task.
We must input string value in the text field and check it. The length of this string must more then zero and less four.
If value has error it must appear below text field.

![valid_logic](https://user-images.githubusercontent.com/9856286/109423438-3bb1dc00-7a01-11eb-9d96-2d341a784e3d.gif)

In the beginning declare private ValidLogic object. And also add dispose procedure to clear this logic from the memory.
Don't initialize this logic. We will initialize one a bit later. Also declare private TextFieldController and dispose it
again.

```
ValidLogic _validLogic;
TextEditingController _validController;

@override
void dispose() {
  _validLogic.dispose();
  _validController.dispose();
  super.dispose();
}
```

After that we need create new file with name valid_use_case.dart and fill in this file next code:

```
class ValidUseCase implements IUseCase<String, String, String> {
  @override
  Result<String, String> execute([String value]) {
    try {
      if (value == null) return Result(success: '');
      if (value.isEmpty) return Result(failure: 'The value must not be empty.');
      if (value.length > 3)
        return Result(failure: 'The value must be less then 4.');
      return Result(success: value);
    } catch (e, stacktrace) {
      print('BLOC_LOGIC: ${e.toString()} STACKTRACE: ${stacktrace.toString()}');
      return Result(failure: e.toString());
    }
  }
}
```

New class is implemented from IUseCase class. It is very important to understand with types parameters of use case.
There three parameters in the IUseCase. All of them are String.

```
IUseCase<S, V, F>    ---->    IUseCase<String, String, String>
```

It means the next:

* S - success - this is success result type. We want to get String value in success case.
* V - value - this is value parameter type. We send it to the procedure. This type is String again.
* F - failure - this is failure type. Usual it is String type. But it can be a class wich can contains not only string
  message but error code.

And now we can initialize our ValidLogic. We can notice that use case was added into our logic.

```
  @override
  void initState() {
    super.initState();
    _validLogic = ValidLogic(usecase: ValidUseCase());
    _validController = TextEditingController();
  }
```

And in the end we build widgets and use ValidBloc Builder for it. Procedure Builder takes state which contains success
or failure result. If this result has failure error message appears below text field.

```
_validLogic.builder(
  (context, state) {
    Result _result = (state as ValidatedValidState).result;
    return TextField(
      controller: _validController,
      decoration: InputDecoration(
        errorText: _result.hasFailure() ? _result.failure : null,
      ),
      onChanged: (value) {
        _validLogic.validate(value);
      },
    );
  },
),
```

## Take Logic

And at last let introduce most important pattern - TakebLoc. You can solve different tasks like getting data from remote
server. 

![take_logic](https://user-images.githubusercontent.com/9856286/109535079-f2838a00-7add-11eb-8861-aca241cec157.gif)

This pattern use asynchronous use case. It allows get data from some time. And let's start.

```
  TakeLogic _takeLogic;

  @override
  void initState() {
    super.initState();
    _takeLogic = TakeLogic<List<String>, void, String>(
        usecase: TakeUseCase(repository: TakeRepository()));
  }

  @override
  void dispose() {
    _takeLogic.dispose();
    super.dispose();
  }
```

We must create async use case with repository. Create file take_use_case.dart.

```
class TakeUseCase implements IFutureUseCase<List<String>, void, String> {
  final ITakeRepository repository;

  TakeUseCase({@required this.repository});

  @override
  Future<Result<List<String>, String>> execute([void value]) async {
    try {
      List<String> result = await repository.getList();
      return Result(success: result);
    } catch (e) {
      return Result(failure: e.toString());
    }
  }
}
```

In this place we used use case with following parameters.

```
IFutureUseCase<List<String>, void, String>
```

It means that we want to get strings list, send nothing, and get string value if failed.

We use repository. It helps to get data list from datasource. We must connect to the data not directly. We must use
interface class for it. It allows to divide logic and data. Later you can change datasource without any changes in the
code. And so create file take_repository_interface.dart.

```
abstract class ITakeRepository {
  Future<List<String>> getList();
}
```

Now implement repository from this abstract class. Call it take_repository.dart.

```
class TakeRepository implements ITakeRepository {
  @override
  Future<List<String>> getList() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return ['Onion', 'Potato', 'Carrot'];
  }
}
```

Return to the main file and add button with take logic. Call procedure request() from it.

```
  RaisedButton(
    child: Text('Get vegetables'),
    onPressed: () {
      _takeLogic.request();
    },
  ),
```

And now we can create list with helping take logic builder.

```
_takeLogic.builder((context, state) {
  if (state is InitialTakeState)
    return MessageContainer(message: 'Empty');
  if (state is WaitingTakeState) return WaitingContainer();
  if (state is SuccessTakeState) {
    List<String> list = state.success as List;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(list.elementAt(index)));
      },
      separatorBuilder: (context, index) {
        return Divider(color: Colors.black);
      },
    );
  }
  if (state is FailureTakeState) print(state.failure.toString());
  return MessageContainer(message: 'Oops');
}),
```

In this example we used only initial and success path of logic. Other two - waiting and failure use default widgets. You
can use own widgets. Replace these widgets by own ones.
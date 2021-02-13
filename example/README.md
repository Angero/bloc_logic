# Bloc logic

I really like using bloc pattern for state management.  In my opinion, it's the best decision for most tasks. This pattern use streams and it's not bit convenient. But we have plugin flutter_bloc by Felix Angelov. That plugin is easy for understanding and required less strings of the code. Thats why most of developer prefer to use that plugin. However, when it is created a big project with large amount logic operations, that advantages are disappeared. We describe the same events, states and blocs again and again. Most of that blocs have the same behavior and use the similar logic. I has noticed that and grouped blocs' behavior. As it turned out, their amount is not too big. And we can use these behaviors to create large logic constructions. We can use blocs' behaviors like bricks to building our projects.

### Clean code

This pattern can to use for creating clean code architecture. In the most examples for bloc it shown only two layers: user interface and data layer. Bloc is between these two layers. It connects them. But it only controls state and doesn't contains any logic. In my opinion, we must inject logic layer between bloc and data layer. It will allow us put out of brackets bloc. We won't need to change bloc anymore. All changes we will make only in the logic layer. I called them use cases.

In totally, we have next layers:

* user interface
* bloc
* use cases
* data repository
* datasource

![clean_code](https://user-images.githubusercontent.com/9856286/109404873-3d8d8800-798c-11eb-910f-8c73994a9656.jpg)

### Use cases

All use cases have the same functionality. In the total case it send some value and get some result. That result can be two types: success and failure. When the result is a success, it get some successful value. When the result is a failure, it get some failure value. For example it can be a error string. So, every use case defined by three parameters:

* success
* value
* failure

You can use for our use case next class with those parameters:

```IUseCase<S, V, F>```

You must replace generics S, V, F with types for our task. For example:

```class ExampleUseCase implements IUseCase<List<String>, int, String>```

What does it mean? You create new use case. When you send to it integer value, it can return strings list, if it is success, or error string if it a failure.

There are only two types of the use cases: synchronous and asynchronous. The synchronous use case run momently. But asynchronous use case requires a some time. For example, if you send request to server, the answer will return for several milliseconds.  If you want to use asynchronous use case, take class IFutureUseCase like simple IUseCase.

```class ExampleFutureUseCase implements IFutureUseCase<List<String>, int, String>```

### Result

As I’ve already said use cases return the results. These results can be two types: success and failure. Success result returns dynamic type payload. It can be any variable what you want to get from use case. For example it can be the clients list. Failure result also can return any types variable. In most cases I use simple String type. I return error string and it enough for most tasks. You can use more difficult class failure which contains of not only error string but error code. 
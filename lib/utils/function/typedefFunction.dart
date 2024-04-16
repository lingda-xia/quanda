/// 无参数请求回调
typedef NoParameterCallback = dynamic Function();

/// 回调一个参数
typedef AParameterCallback<D> = dynamic Function(D data);

///   回到俩个参数
typedef TwoParameterCallback<O, T> = dynamic Function(O dataOne, T dataTwo);

///回调三个参数
typedef ThreeParameterCallback<O, T, K> = dynamic Function(
    O dataOne, T dataTwo, K threeData);

///回调五个参数
typedef FiveParameterCallback<O, T, K, P, N> = dynamic Function(
    O dataOne, T dataTwo, K threeData, P fourData, N fiveData);

///回调六个参数
typedef SixParameterCallback<O, T, K, P, N, S> = dynamic Function(
    O dataOne, T dataTwo, K threeData, P fourData, N fiveData, S six);

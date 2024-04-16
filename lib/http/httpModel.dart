// class HttpModel {
//   dynamic data;
//   int? code;
//   String? message;
//
//   HttpModel({
//     this.data,
//     this.code,
//     this.message,
//   });
//   //
//   // static HttpModel fromJson(Map<String, dynamic> map) {
//   //   return HttpModel(
//   //     data: map['data'],
//   //     code: map['code'],
//   //     message: map['message'],
//   //   );
//   // }
//   HttpModel.fromJson(Map<String, dynamic> json)
//       : code = json['code'],
//         message = json['message'],
//         data = json['data'];
// }

class Result<T> {
  int code;
  String message;
  T data;

  Result(this.code, this.message, this.data);

  Result.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'],
        data = json['data'];

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write(",\"code\":$code");
    sb.write(",\"message\":\"$message\"");
    sb.write(",\"data\":\"$data\"");
    sb.write('}');
    return sb.toString();
  }
}

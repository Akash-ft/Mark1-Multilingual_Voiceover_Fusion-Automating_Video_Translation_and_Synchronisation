abstract class BaseModel<T> {
  Map<String, dynamic> toJson();

  T fromJson(Map<String, dynamic> json);
}

typedef CreateModel<T> = T Function();
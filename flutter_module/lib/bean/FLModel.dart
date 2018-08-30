class FLModel {
  String id;
  String url;
  String createdAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  bool used = false;
  String who;
  List<String> images;

  //构造函数
  FLModel(this.id, this.url, this.createdAt, this.desc, this.publishedAt,
      this.source, this.type, this.used, this.who, this.images);

  //命名构造函数
  FLModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.url = json['url'];
    this.createdAt = json['createdAt'];
    this.desc = json['desc'];
    this.publishedAt = json['publishedAt'];
    this.source = json['source'];
    this.type = json['type'];
    this.used = json['used'];
    this.who = json['who'];

    var imageList = json['images'];
    List<String> streetsList = new List<String>.from(imageList);
    this.images = streetsList;
  }

//  FLModel.fromJson(Map<String, dynamic> json)
//      : id = json['_id'],
//        url = json['url'],
//        createdAt = json['createdAt'],
//        desc = json['desc'],
//        publishedAt = json['publishedAt'],
//        source = json['source'],
//        type = json['type'],
//        used = json['used'],
//        who = json['who'],
//        images = json['images'];

  Map<String, dynamic> toJson() => {
        'url': url,
        'id': id,
        'createdAt': createdAt,
        'desc': desc,
        'publishedAt': publishedAt,
        'source': source,
        'type': type,
        'used': used,
        'who': who,
        'images': images,
      };
}

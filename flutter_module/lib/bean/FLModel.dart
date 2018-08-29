class FLModel {

	final String url;

	const FLModel({this.url});

	//命名构造函数
	FLModel.fromJson(Map<String, dynamic> json) : url = json['url'];

	Map<String, dynamic> toJson() =>
		{
			'url': url,
		};
}

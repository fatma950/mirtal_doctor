// ignore_for_file: file_names

class CommentsModel {
  Post? post;

  CommentsModel({this.post});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (post != null) {
      data['post'] = post!.toJson();
    }
    return data;
  }
}

class Post {
  String? sId;
  String? title;
  String? content;
  Creator? creator;
  String? specialty;
  List<Comments>? comments;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Post(
      {this.sId,
      this.title,
      this.content,
      this.creator,
      this.specialty,
      this.comments,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Post.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    content = json['content'];
    creator =
        json['creator'] != null ? Creator.fromJson(json['creator']) : null;
    specialty = json['specialty'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['content'] = content;
    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
    data['specialty'] = specialty;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Creator {
  String? sId;
  String? userName;

  Creator({this.sId, this.userName});

  Creator.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    return data;
  }
}

class Comments {
  String? sId;
  String? comment;
  DoctorComment? doctorComment;
  String? time;
  int? iV;

  Comments({this.sId, this.comment, this.doctorComment, this.time, this.iV});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    comment = json['comment'];
    doctorComment = json['doctorComment'] != null
        ? DoctorComment.fromJson(json['doctorComment'])
        : null;
    time = json['time'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['comment'] = comment;
    if (doctorComment != null) {
      data['doctorComment'] = doctorComment!.toJson();
    }
    data['time'] = time;
    data['__v'] = iV;
    return data;
  }
}

class DoctorComment {
  String? sId;
  String? photo;
  String? specialty;
  String? userName;
  String? sT;

  DoctorComment({this.sId, this.photo, this.specialty, this.userName, this.sT});

  DoctorComment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    photo = json['photo'];
    specialty = json['specialty'];
    userName = json['userName'];
    sT = json['__t'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['photo'] = photo;
    data['specialty'] = specialty;
    data['userName'] = userName;
    data['__t'] = sT;
    return data;
  }
}

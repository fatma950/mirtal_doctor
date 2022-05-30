// ignore_for_file: file_names

class DoctorModel {
  String? sId;
  String? photo;
  String? city;
  String? region;
  String? specialty;
  String? title;
  String? location;
  int? price;
  List<Calender>? calender;
  int? raiting;
  int? numReviews;
  String? userName;
  String? gender;
  String? birthDate;
  String? sT;
  List<TeleCalender>? teleCalender;

  DoctorModel(
      {this.sId,
      this.photo,
      this.city,
      this.region,
      this.specialty,
      this.title,
      this.location,
      this.price,
      this.calender,
      this.raiting,
      this.numReviews,
      this.userName,
      this.gender,
      this.birthDate,
      this.sT,
      this.teleCalender});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    photo = json['photo'];
    city = json['city'];
    region = json['region'];
    specialty = json['specialty'];
    title = json['title'];
    location = json['location'];
    price = json['price'];
    if (json['calender'] != null) {
      calender = <Calender>[];
      json['calender'].forEach((v) {
        calender!.add(Calender.fromJson(v));
      });
    }

    raiting = json['raiting'];
    numReviews = json['numReviews'];
    userName = json['userName'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    sT = json['__t'];
    if (json['teleCalender'] != null) {
      teleCalender = <TeleCalender>[];
      json['teleCalender'].forEach((v) {
        teleCalender!.add(TeleCalender.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['photo'] = photo;
    data['city'] = city;
    data['region'] = region;
    data['specialty'] = specialty;
    data['title'] = title;
    data['location'] = location;
    data['price'] = price;
    if (calender != null) {
      data['calender'] = calender!.map((v) => v.toJson()).toList();
    }
    data['raiting'] = raiting;
    data['numReviews'] = numReviews;
    data['userName'] = userName;
    data['gender'] = gender;
    data['birthDate'] = birthDate;
    data['__t'] = sT;
    if (teleCalender != null) {
      data['teleCalender'] = teleCalender!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Calender {
  String? sId;
  String? weekday;
  String? startAt;
  String? endAt;
  int? duration;

  Calender({this.sId, this.weekday, this.startAt, this.endAt, this.duration});

  Calender.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    weekday = json['weekday'];
    startAt = json['startAt'];
    endAt = json['endAt'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['weekday'] = weekday;
    data['startAt'] = startAt;
    data['endAt'] = endAt;
    data['duration'] = duration;
    return data;
  }
}

class TeleCalender {
  String? sId;
  String? weekday;
  String? startAt;
  String? endAt;
  int? duration;
  String? calender;

  TeleCalender(
      {this.sId,
      this.weekday,
      this.startAt,
      this.endAt,
      this.duration,
      this.calender});

  TeleCalender.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    weekday = json['weekday'];
    startAt = json['startAt'];
    endAt = json['endAt'];
    duration = json['duration'];
    calender = json['calender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['weekday'] = weekday;
    data['startAt'] = startAt;
    data['endAt'] = endAt;
    data['duration'] = duration;
    data['calender'] = calender;
    return data;
  }
}

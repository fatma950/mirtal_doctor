// ignore_for_file: file_names

class AllDayReservationsModel {
  int? totalRes;
  List<Reservation>? reservation;

  AllDayReservationsModel({this.totalRes, this.reservation});

  AllDayReservationsModel.fromJson(Map<String, dynamic> json) {
    totalRes = json['totalRes'];
    if (json['reservation'] != null) {
      reservation = <Reservation>[];
      json['reservation'].forEach((v) {
        reservation!.add(Reservation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalRes'] = totalRes;
    if (reservation != null) {
      data['reservation'] = reservation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reservation {
  String? sId;
  Patient? patient;
  String? doctor;
  String? start;
  String? time;
  String? name;
  String? phone;
  String? reservationPlace;
  bool? reservationStatus;
  bool? isPaid;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? meeting;
  String? meetingName;
  String? paidAt;
  int? totalPaid;

  Reservation(
      {this.sId,
      this.patient,
      this.doctor,
      this.start,
      this.time,
      this.name,
      this.phone,
      this.reservationPlace,
      this.reservationStatus,
      this.isPaid,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.meeting,
      this.meetingName,
      this.paidAt,
      this.totalPaid});

  Reservation.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    doctor = json['doctor'];
    start = json['start'];
    time = json['time'];
    name = json['name'];
    phone = json['phone'];
    reservationPlace = json['reservationPlace'];
    reservationStatus = json['reservationStatus'];
    isPaid = json['isPaid'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    meeting = json['meeting'];
    meetingName = json['meetingName'];
    paidAt = json['paidAt'];
    totalPaid = json['totalPaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    data['doctor'] = doctor;
    data['start'] = start;
    data['time'] = time;
    data['name'] = name;
    data['phone'] = phone;
    data['reservationPlace'] = reservationPlace;
    data['reservationStatus'] = reservationStatus;
    data['isPaid'] = isPaid;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['meeting'] = meeting;
    data['meetingName'] = meetingName;
    data['paidAt'] = paidAt;
    data['totalPaid'] = totalPaid;
    return data;
  }
}

class Patient {
  String? sId;
  String? userName;
  String? gender;
  String? birthDate;

  Patient({this.sId, this.userName, this.gender, this.birthDate});

  Patient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    gender = json['gender'];
    birthDate = json['birthDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    data['gender'] = gender;
    data['birthDate'] = birthDate;
    return data;
  }
}

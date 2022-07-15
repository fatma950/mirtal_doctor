// ignore_for_file: file_names

class ReservationModel {
  int? totalRes;
  List<GetAllReservation>? getAllReservation;

  ReservationModel({this.totalRes, this.getAllReservation});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    totalRes = json['totalRes'];
    if (json['getAllReservation'] != null) {
      getAllReservation = <GetAllReservation>[];
      json['getAllReservation'].forEach((v) {
        getAllReservation!.add(GetAllReservation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalRes'] = totalRes;
    if (getAllReservation != null) {
      data['getAllReservation'] =
          getAllReservation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAllReservation {
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
  String? meetingId;
  String? paidAt;
  int? totalPaid;
  int? meetingStart;
  String? meetingName;

  GetAllReservation(
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
      this.meetingId,
      this.paidAt,
      this.totalPaid,
      this.meetingStart,
      this.meetingName});

  GetAllReservation.fromJson(Map<String, dynamic> json) {
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
    meetingId = json['meetingId'];
    paidAt = json['paidAt'];
    totalPaid = json['totalPaid'];
    meetingStart = json['meetingStart'];
    meetingName = json['meetingName'];
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
    data['meetingId'] = meetingId;
    data['paidAt'] = paidAt;
    data['totalPaid'] = totalPaid;
    data['meetingStart'] = meetingStart;
    data['meetingName'] = meetingName;
    return data;
  }
}

class Patient {
  String? sId;
  String? userName;
  String? gender;

  Patient({this.sId, this.userName, this.gender});

  Patient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    data['gender'] = gender;
    return data;
  }
}

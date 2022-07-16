// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mirtal_doctor/Constants/customToast.dart';
import 'package:mirtal_doctor/Constants/myNavigator.dart';
import 'package:mirtal_doctor/Screens/bottomNavigation/bottomBar.dart';
import 'package:mirtal_doctor/models/AllDayReservationsModel.dart';
import 'package:mirtal_doctor/models/commentsModel.dart';
import 'package:mirtal_doctor/models/doctorModel.dart';
import 'package:mirtal_doctor/models/postsModel.dart';
import 'package:mirtal_doctor/models/reservationModel.dart';
import 'package:mirtal_doctor/sharedWidgets/showAndHideLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/Auth/login.dart';

class ApiRequests {
  loginDoctor(String mail, String password, BuildContext context) async {
    showLoading(context);

    final prefs = await SharedPreferences.getInstance();
    //prefs.setString("test", "value");
    var headers = {'Content-Type': 'application/json'};

    /*
      POST
        PUT
        DELETE
        REMOVET => save data in server
      GET => get data from server
    */

    // var response =  http.post(Uri.parse("dd") , body: ,headers: );
    //result =  response.send;

    var request = http.Request(
        'POST', Uri.parse('https://mitral.herokuapp.com/auth/loginDoctor'));

    request.body = json.encode({"email": mail, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    hideLoading(context);

    var myResponse = await json.decode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      if (myResponse['message'] == "تسجيل الدخول بنجاح") {
        prefs.setString("doctorID", myResponse["userId"]);
        prefs.setString("doctorToken", myResponse["token"]);
        // hideLoading(context);
        MyNavigetor().push(const BottomBar(), context);
      } else {
        showFailedToast(myResponse['message']);
      }
    } else {
      showFailedToast(myResponse['message'].toString());
    }
  }

  signUpDoctor(
      BuildContext context,
      String mail,
      String password,
      String confirmPassword,
      String phone,
      String username,
      String city,
      String birthdate,
      String price,
      String specialityDescription,
      String speciality,
      String location,
      String gender,
      String region,
      File licenceImg,
      File profileImg) async {
    showLoading(context);

    var headers = {
      'Content-Type': 'multipart/form-data',
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('https://mitral.herokuapp.com/auth/signupDoctor'));

    request.fields.addAll({
      'email': mail,
      'password': password,
      'confirmPassword': confirmPassword,
      'phone': phone,
      'userName': username,
      'city': city,
      'birthDate': birthdate,
      'price': price,
      'title': specialityDescription,
      'specialty': speciality,
      'location': location,
      'gender': gender,
      'region': region
    });

//     request.files.add(await http.MultipartFile.fromPath('license', licenceImg.toString()));

//     request.files.add(http.MultipartFile.fromBytes(
//       'license',
//       licenceImg.readAsBytesSync(),
//     ));

//  request.files.add(await http.MultipartFile.fromPath('photo', profileImg.toString()));
//     request.files.add(http.MultipartFile.fromBytes(
//       'photo',
//       profileImg.readAsBytesSync(),
//     ));

    final licenseMimeTypeData =
        lookupMimeType(licenceImg.path, headerBytes: [0xFF, 0xD8])?.split('/');

    request.files.add(await http.MultipartFile.fromPath(
        'license', licenceImg.path,
        contentType:
            MediaType(licenseMimeTypeData![0], licenseMimeTypeData[1])));

    final profileMimeTypeData =
        lookupMimeType(profileImg.path, headerBytes: [0xFF, 0xD8])?.split('/');

    request.files.add(await http.MultipartFile.fromPath(
        'photo', profileImg.path,
        contentType:
            MediaType(profileMimeTypeData![0], profileMimeTypeData[1])));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    // print(await response.stream.bytesToString());

    hideLoading(context);

    if (response.statusCode == 201) {
      var myResponse = await json.decode(await response.stream.bytesToString());
      if (myResponse['message'] == "تم الستجيل بنجاح مرحبا بك في مترال") {
        showSuccessToast("تم الستجيل بنجاح مرحبا بك في مترال");
        MyNavigetor().push(const LoginPage(), context);
      } else {
        showFailedToast(myResponse['message']);
      }
    } else {
      showFailedToast(response.reasonPhrase.toString());
    }
  }

  static Future getAllPosts() async {
    List<PostsModel> postsModel = [];

    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("doctorToken");
    var headers = {'token': token!};

    var request = http.Request(
        'GET', Uri.parse('https://mitral.herokuapp.com/posts/allPosts'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = json.decode(await response.stream.bytesToString());

      for (int i = 0; i < result["totalPosts"]; i++) {
        postsModel.add(PostsModel(
            postId: result["posts"][i]["_id"].toString(),
            userId: result["posts"][i]["creator"] == null
                ? ""
                : result["posts"][i]["creator"]["_id"],
            title: result["posts"][i]["title"],
            content: result["posts"][i]["content"],
            username: result["posts"][i]["creator"] == null
                ? ""
                : result["posts"][i]["creator"]["userName"],
            speciality: result["posts"][i]["specialty"],
            time: result["posts"][i]["createdAt"]));
      }
      return postsModel;
    } else {
      showFailedToast(response.reasonPhrase.toString());
    }
  }

  static Future getUserProfile() async {
    DoctorModel? doctorModel;
    final prefs = await SharedPreferences.getInstance();
    String? docId = prefs.getString("doctorID");
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://mitral.herokuapp.com/doctor/account/profile/$docId'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final myResponse = await response.stream.bytesToString();
      doctorModel = DoctorModel.fromJson(json.decode(myResponse));
      //print(myResponse);
      return doctorModel;
    } else {
      showFailedToast(response.reasonPhrase.toString());
    }
  }

  passwordRecovery(BuildContext context, String mail) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://mitral.herokuapp.com/auth/reset'));
    request.body = json.encode({"email": mail});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final myResponse = await response.stream.bytesToString();
      showSuccessToast(myResponse);
      MyNavigetor().push(const LoginPage(), context);
    } else {
      showFailedToast(response.reasonPhrase.toString());
    }
  }

  updateProfilePhoto(File profilePHoto) async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("doctorToken");

    var headers = {
      'token': token!,
      "Content-Type": "multipart/form-data",
      'Accept': 'multipart/form-data',
    };

    var request = http.MultipartRequest('PUT',
        Uri.parse('https://mitral.herokuapp.com/doctor/account/updatePhoto'));

    final licenseMimeTypeData =
        lookupMimeType(profilePHoto.path, headerBytes: [0xFF, 0xD8])
            ?.split('/');

    request.files.add(await http.MultipartFile.fromPath(
        'photo', profilePHoto.path,
        contentType:
            MediaType(licenseMimeTypeData![0], licenseMimeTypeData[1])));

    // request.files.add(http.MultipartFile.fromBytes(
    //     'photo', profilePHoto.readAsBytesSync(),
    //     filename: profilePHoto.toString()));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    // print(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      final myResponse = await response.stream.bytesToString();

      showSuccessToast(json.decode(myResponse)['message']);
    } else {
      showFailedToast(response.reasonPhrase.toString());
    }
  }

  addOnlineCalender(String weekDay, String date, String from, String to,
      BuildContext context) async {
    showLoading(context);
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("doctorToken");
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': token!
    };

    var result = await http.post(
        Uri.parse("https://mitral.herokuapp.com/calender/create"),
        body: json.encode({
          "weekday": weekDay,
          "date": date,
          "startAt": from,
          "endAt": to,
          "type": "online"
        }),
        headers: headers);

    hideLoading(context);

    if (result.statusCode == 201) {
      showSuccessToast(json.decode(result.body)['message']);

      MyNavigetor().push(const BottomBar(), context);
    } else {
      showFailedToast("هناك خطأ");
      // print(result.reasonPhrase.toString());
    }
  }

  addOfflineCalender(String weekDay, String date, String from, String to,
      BuildContext context) async {
    showLoading(context);
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("doctorToken");
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': token!
    };

    var result = await http.post(
        Uri.parse("https://mitral.herokuapp.com/calender/create"),
        body: json.encode({
          "weekday": weekDay,
          "date": date,
          "startAt": from,
          "endAt": to,
        }),
        headers: headers);

    //print(result.body);

    hideLoading(context);

    if (result.statusCode == 201) {
      showSuccessToast(json.decode(result.body)['message']);

      MyNavigetor().push(const BottomBar(), context);
    } else {
      showFailedToast("هناك خطأ");
      // print(result.reasonPhrase.toString());
    }
  }

  addComment(String postID, String comment, BuildContext context) async {
    showLoading(context);
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("doctorToken");
    var headers = {'token': token!, 'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('https://mitral.herokuapp.com/posts/$postID/addComment'));
    request.body = json.encode({"comment": comment});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var myResponse = await response.stream.bytesToString();

      showSuccessToast(json.decode(myResponse)["message"]);
      hideLoading(context);
    } else {
      showFailedToast(response.reasonPhrase.toString());
    }
  }

  getPostComments(String postID) async {
    CommentsModel? commentsModel;
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("doctorToken");
    var headers = {'token': token!};
    var request = http.Request(
        'GET', Uri.parse('https://mitral.herokuapp.com/posts/post/$postID'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var myResonse = await response.stream.bytesToString();
      commentsModel = CommentsModel.fromJson(json.decode(myResonse));
      return commentsModel;
    } else {
      showFailedToast(response.reasonPhrase.toString());
    }
  }

  getAllReservations() async {
    ReservationModel? reservationModel;

    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("doctorToken");
    var headers = {'token': '$token'};
    var request = http.Request('GET',
        Uri.parse('https://mitral.herokuapp.com/doctor/getAllResrvationDay'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    //print(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      reservationModel = ReservationModel.fromJson(json.decode(result));

      return reservationModel;
    } else {
      showFailedToast(response.reasonPhrase.toString());
    }
  }

  gelAllDayReservations(String serachedDay) async {
    AllDayReservationsModel? allDayReservations;

    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("doctorToken");

    var headers = {'token': '$token', 'Content-Type': 'application/json'};
    var request = http.Request('GET',
        Uri.parse('https://mitral.herokuapp.com/doctor/getResrvationDay'));
    request.body = json.encode({"time": serachedDay});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    //print(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();

      allDayReservations =
          AllDayReservationsModel.fromJson(json.decode(result));

      return allDayReservations;
    } else {
      showFailedToast(response.reasonPhrase.toString());
    }
  }

  editCalender(BuildContext context, String calenderId, String weekday,
      String date, String start, String end) async {
    showLoading(context);
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("doctorToken");
    var headers = {'token': token!, 'Content-Type': 'application/json'};
    var request = http.Request(
        'PUT',
        Uri.parse(
            'https://mitral.herokuapp.com/calender/spesficDay/$calenderId'));
    request.body = json.encode(
        {"weekday": weekday, "startAt": start, "endAt": end, "date": date});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      showSuccessToast(
          json.decode(await response.stream.bytesToString())["message"]);

      MyNavigetor().push(const BottomBar(), context);
    } else {
      showFailedToast(response.reasonPhrase.toString());
    }
  }

  deleteCalender(BuildContext context, String calenderId) async {
    showLoading(context);
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("doctorToken");
    var headers = {'token': '$token'};
    var request = http.Request(
        'DELETE',
        Uri.parse(
            'https://mitral.herokuapp.com/calender/spesficDay/$calenderId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    //print(await response.stream.bytesToString());

    hideLoading(context);

    if (response.statusCode == 200) {
      showSuccessToast(
          json.decode(await response.stream.bytesToString())["message"]);

      MyNavigetor().push(const BottomBar(), context);
    } else {
      showFailedToast(response.reasonPhrase.toString());
    }
  }

  editDoctorPassword(
      BuildContext context, String password, String confirmPassword) async {
    showLoading(context);
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("doctorToken");
    var headers = {'token': token!, 'Content-Type': 'application/json'};
    var request = http.Request(
        'PUT',
        Uri.parse(
            'https://mitral.herokuapp.com/doctor/account/changePassword'));
    request.body =
        json.encode({"password": password, "confirmPassword": confirmPassword});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    // print(await response.stream.bytesToString());

    hideLoading(context);

    if (response.statusCode == 200) {
      showSuccessToast(
          json.decode(await response.stream.bytesToString())["message"]);
    } else {
      showFailedToast(response.reasonPhrase.toString());
    }
  }

  editWholeProfile(
      BuildContext context,
      String name,
      String price,
      String birthdate,
      String city,
      String region,
      String speciality,
      String specialityDescription,
      String location,
      String phone) async {
    showLoading(context);
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("doctorToken");
    var headers = {'token': token!, 'Content-Type': 'application/json'};
    var request = http.Request('PUT',
        Uri.parse('https://mitral.herokuapp.com/doctor/account/profile'));
    request.body = json.encode({
      "userName": name,
      "price": price,
      "birthDate": birthdate,
      "city": city,
      "region": region,
      "specialty": speciality,
      "title": specialityDescription,
      "location": location,
      "phone": phone
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    hideLoading(context);

    if (response.statusCode == 200) {
      showSuccessToast(
          json.decode(await response.stream.bytesToString())["message"]);
    } else {
      showFailedToast(response.reasonPhrase.toString());
    }
  }
}

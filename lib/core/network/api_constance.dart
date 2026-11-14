import 'package:ahlachat/core/utils/app_constance.dart';

class ApiConstance {
  /// Kept separate so an API gateway can be supplied if needed.
  /// Defaults to the Laravel project's configured public host.
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://kokiapi.rodyorient.com/api',
  );

  // These paths deliberately mirror the Laravel route names.  The previous
  // client was targeting an unrelated, versioned API (`auth/...`, `room/...`).
  static const String LoginByPhoneNum = "$baseUrl/login";
  static const String GoogleAuth = "$baseUrl/loginGoogle";
  static const String MyProfile = "$baseUrl/userbyToken";
  static const String LogOut = "$baseUrl/logout";
  // The backend verifies a phone-login OTP through this endpoint.  The
  // previous auth/EnterCodeLogin route no longer exists and returns 404.
  static const String EnterCodeLogin = "$baseUrl/Verifyaccount";
  static const String SendCodeAgain = "$baseUrl/auth/SendCodeAgain";

  static const String SentCodeForSignup = "$baseUrl/auth/SentCodeForSignup";
  static const String EntercodeSignup = "$baseUrl/auth/EntercodeSignup";
  static const String EntercodeAddAccount =
      "$baseUrl/auth/EntercodeAddPhoneSignup";

  static const String UnBinned = "$baseUrl/auth/UnBineedPhone";
  static const String Register = "$baseUrl/auth/Register";
  static const String SendCodeforgetpassword =
      "$baseUrl/auth/SendCodeForgetPassword";
  static const String ForgetPassword = "$baseUrl/auth/ForgetPassword";
  static const String UpdatePassword = "$baseUrl/auth/UpdatePassword";
  static const String GetMyFriend = "$baseUrl/user/GetMyFriend";

  static const String UserProfile = "$baseUrl/UserProfile";

  static const String User_Profile_Room = "$baseUrl/profile/User_Profile_Room";

  static const String DeleteProfileImag = "$baseUrl/DeleteProfileImage";

  static const String AddProfileImage = "$baseUrl/AddProfileImage";

  static const String follow_user = "$baseUrl/Followuser";

  static const String un_follow_user = "$baseUrl/RemoveUserFollow";

  static const String UpdateProfileImage = "$baseUrl/UpdateProfile";
  static const String UpdateProfile = "$baseUrl/UpdateProfile";
  static const String GetMoreMyFriend = "$baseUrl/GetMyFriends";
  static const String GetMyFollowed = "$baseUrl/Getmyfollowing";
  static const String GetMyFan = "$baseUrl/Getmyfollowers";
  static const String GetMedal = "$baseUrl/GetModels";
  static const String GetShopPackages = "$baseUrl/allitem";
  static const String GetMineItemPackages = "$baseUrl/Getmyitems";
  static const String PurchaseItem = "$baseUrl/byeitem";
  static const String SendItem = "$baseUrl/SendItem";
  static const String WearItem = "$baseUrl/shop/wearitem";
  static const String UnWearItem = "$baseUrl/shop/unwearitem";
  static const String GetVipShopPackage = "$baseUrl/GetVip";
  static const String BuyVipSPackage = "$baseUrl/ByeVip";
  static const String UseVip = "$baseUrl/UseVip";
  static const String RemoveVip = "$baseUrl/RemoveVip";

  static const String Exchangbeans = "$baseUrl/Exchangecoins";

  static const String SearchForCharge = "$baseUrl/charge/SearchForCharge";

  static const String SearchForExchange = "$baseUrl/charge/SearchForExhange";
  static const String GetLevel = "$baseUrl/GetLevels";
  static const String SubmitFeedBack = "$baseUrl/SendReport";

  static const String GetRoomConst = "$baseUrl/GetConstData";

  static const String GetVoiceRooms = "$baseUrl/ExploreRooms";

  static const String CheckVoiceRoom = "$baseUrl/CheckPasswordRoom";

  static const String JoinVoiceRoom = "$baseUrl/JoinRoom";

  static const String EnterPasswordVoiceRoom = "$baseUrl/CheckPasswordright";

  static const String UnFollow_Voice_Room = "$baseUrl/RemoveFollowRooms";
  static const String Follow_Voice_Room = "$baseUrl/FollowRoom";

  static const String Invite_For_Room = "$baseUrl/Inviteuser";
  static const String UpdateroomImage = "$baseUrl/UpdateRoom";

  static const String UpdateBackgroundImage = "$baseUrl/UpdateRoom";
  static const String UpdateRoomname = "$baseUrl/UpdateRoom";

  static const String UpdateRoomdescribe = "$baseUrl/UpdateRoom";

  static const String LeaveVoiceRoom = "$baseUrl/LeaveRoom";

  static const String GetJoinMemberRoom = "$baseUrl/Getjoinusers?page=";
  static String GetJoinMember() => '$GetJoinMemberRoom$JoinNextPage';

  static const String Search_Mmeber_Room = "$baseUrl/SearchUser";

  static const String lock_Chair = "$baseUrl/LockChair";
  static const String Un_lock_Chair = "$baseUrl/LockChair";

  static const String Take_Seat_Chair = "$baseUrl/JoinChair";
  static const String Leave_Seat_Chair = "$baseUrl/LeaveChair";
  static const String Leave_Seat_Chair_admin = "$baseUrl/LeaveChair";

  static const String Open_Mic_Chair = "$baseUrl/updatemutechair";
  static const String Close_Mic_Chair = "$baseUrl/updatemutechair";

  static const String Emoje_Call = "$baseUrl/Sendemoji";

  static const String Get_All_Emoje = "$baseUrl/Getemoji";

  static const String Send_Message_To_Room = "$baseUrl/AddChatRoom";

  static const String Kick_Host = "$baseUrl/Evictionuser";

  static const String Un_Kick_Host = "$baseUrl/unkickuser";

  static const String Get_Kicked_Host = "$baseUrl/getkickeduser";

  static const String GetCagift = "$baseUrl/GetCategory";
  static const String Sent_Gift = "$baseUrl/sendgifts";

  static const String Room_Day_Rank = "$baseUrl/GetRoomLeaderboard";

  static const String Room_Week_Rank = "$baseUrl/GetsupporterWeeklyStar";

  static const String Get_Inbox_Room = "$baseUrl/GetMyInboxRoom";
}

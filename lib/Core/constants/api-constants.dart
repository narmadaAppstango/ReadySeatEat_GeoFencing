/* Dev Server */

//String baseUrl = 'http://23.22.144.81:5000';

/* Staging Server */
String baseUrl = 'http://44.207.95.143:5000';
/* End-Points */
String signAPI = "$baseUrl/api/v1/user/login";
String signupAPI = "$baseUrl/api/v1/user/sign-up";
String resendOtpAPI = "$baseUrl/api/v1/user/resend-verification-otp";
String emailVerificationAPI = "$baseUrl/api/v1/user/verify-signup-otp";
String forgetPasswordAPI = "$baseUrl/api/v1/user/forgot-password";
String confirmForgetPasswordAPI =
    "$baseUrl/api/v1/user/confirm-forgot-password";
String changePasswordAPI = "$baseUrl/api/v1/user/change-password";
String resendOTpSignupApi = "$baseUrl/api/v1/user/resend-verification-otp";
String createUserProfileAPI = "$baseUrl/api/v1/user/update-profile";
//String updateUserProfileAPI = "$baseUrl/update-user-profile";
String getRestaurentDetailsAPI = "$baseUrl/api/v1/user/get-outlet-by-id";
String getRestaurantsAPI = "$baseUrl/api/v1/user/get-all-outlets";
String socialLoginApi = "$baseUrl/api/v1/user/social-media-login";
String deleteAccountApi = "$baseUrl/api/v1/user/delete-user";
String getSlotdetailsApi = "$baseUrl/api/v1/user/get-slots-by-outlet-id";
String slotBookingAPI = "$baseUrl/api/v1/user/book-slot-by-outlet-id";
String getreservationsApi = "$baseUrl/api/v1/user/get-all-booked-slots";
String cancelreservationsApi = "$baseUrl/api/v1/user/cancel-booked-slot";
String updatereservationsApi = "$baseUrl/api/v1/user/update-booked-slot";
String previousReservationsAPI = "$baseUrl/api/v1/user/get-booking-details";
String storeappuserdevicetokenapi =
    "$baseUrl/api/v1/user/store-app-user-device-token";
String sendPushNoticationAPI = "$baseUrl/api/v1/user/set-booking-about-to-check-in";
String verifyuser = "$baseUrl/api/v1/user/verify-booking-by-app-user";

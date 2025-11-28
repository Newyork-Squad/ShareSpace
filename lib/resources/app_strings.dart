class AppStrings {
  AppStrings._();

  static const appTitle = 'ShareSpace';

  static const actionConfirm = 'Confirm';
  static const actionResend = 'Resend';
  static const actionResendIn = 'Resend in';
  static const actionRegister = 'Register';
  static const actionCreateAccount = 'Create account';
  static const actionLogin = 'Login';

  static const noRouteDefined = 'No route defined for';

  static const otpConfirmTitle = 'Confirm your account';
  static const otpConfirmSubtitle =
      'Enter 6-digit code that sent to your phone number';
  static const otpResendPrefix = 'Didn\'t receive code? ';
  static const otpVerifiedSuccess = 'Account verified successfully!';
  static const otpResentSuccess = 'A new code has been sent.';
  static const otpIncompleteError = 'Please enter complete verification code';
  static const otpResendFailure = 'Failed to resend code. Please try again.';
  static const otpVerificationFailure =
      'Verification failed. Please try again.';

  static const success = 'Success';
  static const successBooking = 'Booking room successfully.';
  static const oops = 'Oops';
  static const failedBooking = 'Something went wrong. Please try again.';

  static const noBookingsTitle = 'There is no booking here!';
  static const noBookingsDescription = 'All your booking will view here with it’s details after you booking.';

  static const loginWelcomeBack = 'Welcome Back';
  static const loginInstructions =
      'Please enter your phone number and password to access your booking';
  static const loginRegisterPrompt = 'Don\'t have account? ';

  static const createAccountTitle = 'Create account';
  static const createAccountHeader =
      'Please enter your information to create account.';
  static const createAccountButton = 'Create account';
  static const createAccountLoading = 'Creating...';
  static const createAccountSuccess = 'Account created successfully!';
  static const createAccountLoginPrompt = 'Already have an account? ';
  static const createAccountLoginAction = 'Login';
  static const createAccountPasswordMismatch =
      'Confirm password does not match the password.';

  static const hintFullName = 'Full name';
  static const hintPhoneNumber = 'Phone number';
  static const hintEmail = 'Email';
  static const hintBio = 'Bio';
  static const hintPassword = 'Password';
  static const hintConfirmPassword = 'Confirm password';

  static const labelGender = 'Gender';
  static const labelMale = 'Male';
  static const labelFemale = 'Female';
  static const labelOther = 'Other';
  static const labelPreferNotToSay = 'Prefer not to say';

  static const validationPasswordEmpty = 'Password cannot be empty.';
  static const validationConfirmPasswordEmpty =
      'Confirm password cannot be empty.';
  static const validationPhoneInvalid = 'Invalid phone number.';
  static const validationInvalidCountryCode = 'Invalid country code';

  static String validationPhoneLength(int requiredLength) =>
      'Phone number must be $requiredLength digits';

  static String validationPhoneLengthOnlyDigits(int requiredLength) =>
      'Phone number must be $requiredLength digits only';

  static const validationEgyptPhonePrefix =
      'Egyptian numbers start with 10, 11, 12, or 15';
  static const validationSaudiPhonePrefix =
      'Saudi numbers start with 5';
  static const validationUaePhonePrefix =
      'UAE numbers start with 2, 3, 4, 5, or 6';

  static const toastSuccessTitle = 'Success';
  static const toastErrorTitle = 'Error';
  static const toastUnexpectedError = 'Unexpected error occurred.';
  static const toastUnknownError =
      'An unknown error occurred. Please try again.';

  static const homeGreeting = 'Hello';
  static const homeSearchHint = 'Search workspace';
  static const homeCategoriesTitle = 'Categories';
  static const homePopularTitle = 'Popular workspaces';

  static const searchScreenTitle = 'Search';
  static const mostSearched = 'Most Searched';
  static String resultsFound(int count) => 'Results found ($count)';
  static const bookingScreenTitle = 'Booking Screen';
  static const bookingHistoryScreenTitle = 'Booking History Screen';
  static const chatScreenTitle = 'Chat Screen';

  static const roomAboutTitle = 'About room';
  static const roomReviewsTitle = 'Reviews';
  static const roomViewAll = 'All';
  static const roomBookingButton = 'Book now';
  static const roomOwnerTitle = 'Owner';

  static const bookingSelectADateTitle = 'Select a Date';
  static const bookingThisDayIsAvailableNote = 'This day is available';
  static const bookingJanuaryMonth = "January";
  static const bookingFebruaryMonth = "February";
  static const bookingMarchMonth = "March";
  static const bookingAprilMonth = "April";
  static const bookingMayMonth = "May";
  static const bookingJuneMonth = "June";
  static const bookingJulyMonth = "July";
  static const bookingAugustMonth = "August";
  static const bookingSeptemberMonth = "September";
  static const bookingOctoberMonth = "October";
  static const bookingNovemberMonth = "November";
  static const bookingDecemberMonth = "December";
  static const bookingConfirmBookingButton = "Confirm booking";
}


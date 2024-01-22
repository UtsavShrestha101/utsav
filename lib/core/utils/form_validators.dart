mixin FormValidators {
  String? isValidEmail(String? email) {
    String? errorMessage;
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
      multiLine: false,
    );
    if (email == null || email.isEmpty) {
      errorMessage = "Please Enter an Email Address";
    } else if (!emailRegex.hasMatch(email)) {
      errorMessage = "Invalid Email";
    }
    return errorMessage;
  }

  String? isValidPassword(String? password) {
    String? errorMessage;

    if (password == null || password.isEmpty) {
      errorMessage = "Please Enter a Password";
    } else if (password.length < 5) {
      errorMessage = "Password has to be at least 6 character";
    }
    return errorMessage;
  }

  String? isCardNoValid(String? cardNo) {
    String? errorMessage;

    if (cardNo == null || cardNo.isEmpty) {
      errorMessage = "required";
    } else if (cardNo.length != 16) {
      errorMessage = "must be valid card no";
    }
    return errorMessage;
  }

  String? isCvcValid(String? cvcNo) {
    String? errorMessage;

    if (cvcNo == null || cvcNo.isEmpty) {
      errorMessage = "required";
    } else if (cvcNo.length != 3) {
      errorMessage = "must be 3 digit";
    }
    return errorMessage;
  }

  String? isStringEmpty(String? value) {
    String? errorMessage;

    if (value == null || value.isEmpty) {
      errorMessage = "required";
    }
    return errorMessage;
  }

 
  
}

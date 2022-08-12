class Validation{

 static String? validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if(value.isEmpty){
      return "Email can't be empty";
    }
    if(!regExp.hasMatch(value)) {
      return "Invalid Email";
    }
    else {
      return null;
    }
  }
}
class UserObject{
  String email="";
  String password ="";
  String confirmPassword="";
  String note ="";
  String userId ="";
  //no value passed defult constructor
  UserObject();
  UserObject.signIn(this.email, this.password);
  UserObject.signUp(this.email, this.password);
  UserObject.note(this.note);
}
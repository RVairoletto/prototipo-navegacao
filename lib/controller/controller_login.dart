class ControllerLogin {
  
  
  //Efetuar login
  Future<bool> efetuarLogin(String email, String senha) async {
    if (email == "exemplo@email.com" && senha == "123") {
      return true;
    } else {
      return false;
    }
  }
}
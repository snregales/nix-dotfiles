let
  name = "Regales, Sharlon N.";
  email = "sharlonregales@gmail.com";
in {
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
  };
}

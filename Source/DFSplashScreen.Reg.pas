{*******************************************************************************
  DFSplashScreen
  Copyright (c) 2026 DelphiFan
  Website: https://delphifan.com
  Email:   adsdelphi@gmail.com
*******************************************************************************}

unit DFSplashScreen.Reg;

interface

procedure Register;

implementation

uses
  System.Classes, DFSplashScreen;

procedure Register;
begin
  RegisterComponents('DF Controls', [TDFSplashScreen]);
end;

end.

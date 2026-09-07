program DFSplashScreenDemo;

uses
  Vcl.Forms,
  System.SysUtils,
  DFSplashScreen.Types in '..\Source\DFSplashScreen.Types.pas',
  DFSplashScreen.Form in '..\Source\DFSplashScreen.Form.pas',
  DFSplashScreen in '..\Source\DFSplashScreen.pas',
  uMain in 'uMain.pas' {frmMain};

var
  StartupSplash: TDFSplashScreen;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'DFSplashScreen Demo';
  Application.ShowMainForm := False;
  Application.CreateForm(TfrmMain, frmMain);

  StartupSplash := TDFSplashScreen.Create(nil);
  try
    StartupSplash.Theme := stDark;
    StartupSplash.Title := 'DFSplashScreen';
    StartupSplash.Subtitle := 'Professional VCL splash screen for Delphi 10.3+';
    StartupSplash.Status := 'Starting demo...';
    StartupSplash.AppVersion := 'Version ' + TDFSplashScreen.ComponentVersion;
    StartupSplash.Copyright := 'delphifan.com';
    StartupSplash.Width := 540;
    StartupSplash.Height := 300;
    StartupSplash.Opacity := 245;
    StartupSplash.CornerRadius := 16;
    StartupSplash.ShowSplash;
    StartupSplash.UpdateProgress(35, 'Creating main form...');
    StartupSplash.UpdateProgress(100, 'Ready');
    StartupSplash.HideSplash;
  finally
    StartupSplash.Free;
  end;

  Application.ShowMainForm := True;
  Application.Run;
end.

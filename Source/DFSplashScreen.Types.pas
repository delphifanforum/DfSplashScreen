{*******************************************************************************
  DFSplashScreen
  Copyright (c) 2026 DelphiFan
  Website: https://delphifan.com
  Email:   adsdelphi@gmail.com
*******************************************************************************}

unit DFSplashScreen.Types;

interface

uses
  System.UITypes;

const
  DFSplashScreenVersion = '1.0.0';
  DFSplashScreenAuthor = 'DelphiFan';
  DFSplashScreenWebsite = 'https://delphifan.com';
  DFSplashScreenEmail = 'adsdelphi@gmail.com';

type
  TDFSplashTheme = (
    stCustom,
    stDark,
    stLight,
    stMidnight,
    stOcean,
    stSunset
  );

  TDFSplashLogoPosition = (
    lpLeft,
    lpTop,
    lpHidden
  );

  TDFSplashProgressStyle = (
    psBar,
    psMarquee,
    psHidden
  );

  TDFSplashThemeColors = record
    Background: TColor;
    BackgroundAlt: TColor;
    Accent: TColor;
    Title: TColor;
    Text: TColor;
    Muted: TColor;
    Progress: TColor;
    ProgressBack: TColor;
  end;

function DFSplashThemeColors(ATheme: TDFSplashTheme): TDFSplashThemeColors;

implementation

function DFSplashThemeColors(ATheme: TDFSplashTheme): TDFSplashThemeColors;
begin
  case ATheme of
    stLight:
      begin
        Result.Background := $00F4F4F4;
        Result.BackgroundAlt := $00E8E8E8;
        Result.Accent := $00D47800;
        Result.Title := $001A1A1A;
        Result.Text := $00333333;
        Result.Muted := $00707070;
        Result.Progress := $00D47800;
        Result.ProgressBack := $00DADADA;
      end;
    stMidnight:
      begin
        Result.Background := $0017110D;
        Result.BackgroundAlt := $00261E16;
        Result.Accent := $00FFA658;
        Result.Title := $00F0F6FC;
        Result.Text := $00C9D1D9;
        Result.Muted := $008B949E;
        Result.Progress := $00FFA658;
        Result.ProgressBack := $00302A22;
      end;
    stOcean:
      begin
        Result.Background := $00331F0B;
        Result.BackgroundAlt := $00482E12;
        Result.Accent := $00AAD400;
        Result.Title := $00FFFFFF;
        Result.Text := $00E2F0EA;
        Result.Muted := $0090B8A8;
        Result.Progress := $00AAD400;
        Result.ProgressBack := $00402A18;
      end;
    stSunset:
      begin
        Result.Background := $002E1B2D;
        Result.BackgroundAlt := $003C2438;
        Result.Accent := $00356BFF;
        Result.Title := $00FFFFFF;
        Result.Text := $00E8DCE6;
        Result.Muted := $00B090A8;
        Result.Progress := $00356BFF;
        Result.ProgressBack := $00402840;
      end;
  else
    { stDark, stCustom fallback }
    Result.Background := $001E1E1E;
    Result.BackgroundAlt := $002A2A2A;
    Result.Accent := $00D47800;
    Result.Title := $00FFFFFF;
    Result.Text := $00E0E0E0;
    Result.Muted := $00A0A0A0;
    Result.Progress := $00D47800;
    Result.ProgressBack := $00333333;
  end;
end;

end.

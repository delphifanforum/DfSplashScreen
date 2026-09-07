{*******************************************************************************
  DFSplashScreen
  Copyright (c) 2026 DelphiFan
  Website: https://delphifan.com
  Email:   adsdelphi@gmail.com

  Drop TDFSplashScreen on a form, or create it in the .dpr before Application.Run.
*******************************************************************************}

unit DFSplashScreen;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.UITypes, System.Math,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls,
  DFSplashScreen.Types, DFSplashScreen.Form;

type
  TDFSplashScreen = class(TComponent)
  private
    FAccentColor: TColor;
    FAppVersion: string;
    FAutoHideInterval: Cardinal;
    FAutoHideTimer: TTimer;
    FBackgroundAlt: TColor;
    FBackgroundColor: TColor;
    FBackgroundImage: TPicture;
    FCloseOnClick: Boolean;
    FCopyright: string;
    FCornerRadius: Integer;
    FFadeInMs: Integer;
    FFadeOutMs: Integer;
    FFontName: TFontName;
    FForm: TfrmDFSplash;
    FGradient: Boolean;
    FHeight: Integer;
    FHiding: Boolean;
    FLogo: TPicture;
    FLogoPosition: TDFSplashLogoPosition;
    FLogoSize: Integer;
    FOnHide: TNotifyEvent;
    FOnShow: TNotifyEvent;
    FOnTimeout: TNotifyEvent;
    FOpacity: Byte;
    FOverlayDarken: Byte;
    FProgress: Integer;
    FProgressBackColor: TColor;
    FProgressColor: TColor;
    FProgressHeight: Integer;
    FProgressMax: Integer;
    FProgressMin: Integer;
    FProgressStyle: TDFSplashProgressStyle;
    FShowCopyright: Boolean;
    FShowShadow: Boolean;
    FShowStatus: Boolean;
    FShowTitle: Boolean;
    FShowVersion: Boolean;
    FStatus: string;
    FStayOnTop: Boolean;
    FSubtitle: string;
    FTextColor: TColor;
    FTheme: TDFSplashTheme;
    FTitle: string;
    FTitleColor: TColor;
    FWidth: Integer;
    procedure ApplyThemeColors;
    procedure AutoHideTick(Sender: TObject);
    procedure BackgroundChanged(Sender: TObject);
    procedure EnsureForm;
    procedure FormFadedOut(Sender: TObject);
    function GetShowing: Boolean;
    procedure LogoChanged(Sender: TObject);
    procedure PushToForm;
    procedure SetAccentColor(const Value: TColor);
    procedure SetAppVersion(const Value: string);
    procedure SetBackgroundAlt(const Value: TColor);
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetBackgroundImage(const Value: TPicture);
    procedure SetCloseOnClick(const Value: Boolean);
    procedure SetCopyright(const Value: string);
    procedure SetCornerRadius(const Value: Integer);
    procedure SetFontName(const Value: TFontName);
    procedure SetGradient(const Value: Boolean);
    procedure SetHeight(const Value: Integer);
    procedure SetLogo(const Value: TPicture);
    procedure SetLogoPosition(const Value: TDFSplashLogoPosition);
    procedure SetLogoSize(const Value: Integer);
    procedure SetOpacity(const Value: Byte);
    procedure SetOverlayDarken(const Value: Byte);
    procedure SetProgress(const Value: Integer);
    procedure SetProgressBackColor(const Value: TColor);
    procedure SetProgressColor(const Value: TColor);
    procedure SetProgressHeight(const Value: Integer);
    procedure SetProgressMax(const Value: Integer);
    procedure SetProgressMin(const Value: Integer);
    procedure SetProgressStyle(const Value: TDFSplashProgressStyle);
    procedure SetShowCopyright(const Value: Boolean);
    procedure SetShowShadow(const Value: Boolean);
    procedure SetShowStatus(const Value: Boolean);
    procedure SetShowTitle(const Value: Boolean);
    procedure SetShowVersion(const Value: Boolean);
    procedure SetStatus(const Value: string);
    procedure SetStayOnTop(const Value: Boolean);
    procedure SetSubtitle(const Value: string);
    procedure SetTextColor(const Value: TColor);
    procedure SetTheme(const Value: TDFSplashTheme);
    procedure SetTitle(const Value: string);
    procedure SetTitleColor(const Value: TColor);
    procedure SetWidth(const Value: Integer);
    procedure SyncIfShowing;
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute(const AWork: TProc);
    procedure HideSplash;
    procedure LoadBackground(const AFileName: string);
    procedure LoadLogo(const AFileName: string);
    procedure ShowSplash;
    procedure UpdateProgress(APosition: Integer; const AStatus: string = '');
    procedure UpdateStatus(const AStatus: string);
    class function ComponentVersion: string;
    property Showing: Boolean read GetShowing;
  published
    property AccentColor: TColor read FAccentColor write SetAccentColor default $00D47800;
    property AppVersion: string read FAppVersion write SetAppVersion;
    property AutoHideInterval: Cardinal read FAutoHideInterval write FAutoHideInterval default 0;
    property BackgroundAlt: TColor read FBackgroundAlt write SetBackgroundAlt default $002A2A2A;
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor default $001E1E1E;
    property BackgroundImage: TPicture read FBackgroundImage write SetBackgroundImage;
    property CloseOnClick: Boolean read FCloseOnClick write SetCloseOnClick default False;
    property Copyright: string read FCopyright write SetCopyright;
    property CornerRadius: Integer read FCornerRadius write SetCornerRadius default 16;
    property FadeInMs: Integer read FFadeInMs write FFadeInMs default 280;
    property FadeOutMs: Integer read FFadeOutMs write FFadeOutMs default 220;
    property FontName: TFontName read FFontName write SetFontName;
    property Gradient: Boolean read FGradient write SetGradient default True;
    property Height: Integer read FHeight write SetHeight default 300;
    property Logo: TPicture read FLogo write SetLogo;
    property LogoPosition: TDFSplashLogoPosition read FLogoPosition write SetLogoPosition default lpLeft;
    property LogoSize: Integer read FLogoSize write SetLogoSize default 72;
    property Opacity: Byte read FOpacity write SetOpacity default 245;
    property OverlayDarken: Byte read FOverlayDarken write SetOverlayDarken default 80;
    property Progress: Integer read FProgress write SetProgress default 0;
    property ProgressBackColor: TColor read FProgressBackColor write SetProgressBackColor default $00333333;
    property ProgressColor: TColor read FProgressColor write SetProgressColor default $00D47800;
    property ProgressHeight: Integer read FProgressHeight write SetProgressHeight default 4;
    property ProgressMax: Integer read FProgressMax write SetProgressMax default 100;
    property ProgressMin: Integer read FProgressMin write SetProgressMin default 0;
    property ProgressStyle: TDFSplashProgressStyle read FProgressStyle write SetProgressStyle default psBar;
    property ShowCopyright: Boolean read FShowCopyright write SetShowCopyright default True;
    property ShowShadow: Boolean read FShowShadow write SetShowShadow default True;
    property ShowStatus: Boolean read FShowStatus write SetShowStatus default True;
    property ShowTitle: Boolean read FShowTitle write SetShowTitle default True;
    property ShowVersion: Boolean read FShowVersion write SetShowVersion default True;
    property Status: string read FStatus write SetStatus;
    property StayOnTop: Boolean read FStayOnTop write SetStayOnTop default True;
    property Subtitle: string read FSubtitle write SetSubtitle;
    property TextColor: TColor read FTextColor write SetTextColor default $00E0E0E0;
    property Theme: TDFSplashTheme read FTheme write SetTheme default stDark;
    property Title: string read FTitle write SetTitle;
    property TitleColor: TColor read FTitleColor write SetTitleColor default $00FFFFFF;
    property Width: Integer read FWidth write SetWidth default 520;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnTimeout: TNotifyEvent read FOnTimeout write FOnTimeout;
  end;

implementation

function ScalePx(AValue: Integer): Integer;
begin
  Result := MulDiv(AValue, Screen.PixelsPerInch, 96);
end;

{ TDFSplashScreen }

constructor TDFSplashScreen.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWidth := 520;
  FHeight := 300;
  FOpacity := 245;
  FCornerRadius := 16;
  FLogoSize := 72;
  FLogoPosition := lpLeft;
  FFadeInMs := 280;
  FFadeOutMs := 220;
  FFontName := 'Segoe UI';
  FGradient := True;
  FStayOnTop := True;
  FShowTitle := True;
  FShowStatus := True;
  FShowVersion := True;
  FShowCopyright := True;
  FShowShadow := True;
  FProgressHeight := 4;
  FProgressMin := 0;
  FProgressMax := 100;
  FProgressStyle := psBar;
  FOverlayDarken := 80;
  FTheme := stDark;
  FTitle := 'My Application';
  FSubtitle := 'Starting services...';
  FStatus := 'Please wait';
  FAppVersion := 'Version 1.0.0';
  FCopyright := 'Copyright (c) DelphiFan';
  ApplyThemeColors;

  FLogo := TPicture.Create;
  FLogo.OnChange := LogoChanged;
  FBackgroundImage := TPicture.Create;
  FBackgroundImage.OnChange := BackgroundChanged;

  FAutoHideTimer := TTimer.Create(Self);
  FAutoHideTimer.Enabled := False;
  FAutoHideTimer.OnTimer := AutoHideTick;
end;

destructor TDFSplashScreen.Destroy;
begin
  if Assigned(FForm) then
  begin
    FForm.OnFadedOut := nil;
    FForm.Free;
    FForm := nil;
  end;
  FLogo.Free;
  FBackgroundImage.Free;
  inherited Destroy;
end;

class function TDFSplashScreen.ComponentVersion: string;
begin
  Result := DFSplashScreenVersion;
end;

procedure TDFSplashScreen.Loaded;
begin
  inherited Loaded;
  if FTheme <> stCustom then
    ApplyThemeColors;
end;

procedure TDFSplashScreen.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FForm) then
    FForm := nil;
end;

procedure TDFSplashScreen.ApplyThemeColors;
var
  C: TDFSplashThemeColors;
begin
  if FTheme = stCustom then
    Exit;
  C := DFSplashThemeColors(FTheme);
  FBackgroundColor := C.Background;
  FBackgroundAlt := C.BackgroundAlt;
  FAccentColor := C.Accent;
  FTitleColor := C.Title;
  FTextColor := C.Text;
  FProgressColor := C.Progress;
  FProgressBackColor := C.ProgressBack;
end;

procedure TDFSplashScreen.EnsureForm;
begin
  if csDesigning in ComponentState then
    Exit;
  if Assigned(FForm) then
    Exit;
  FForm := TfrmDFSplash.CreateNewSplash(nil);
  FForm.FreeNotification(Self);
  FForm.OnFadedOut := FormFadedOut;
end;

procedure TDFSplashScreen.PushToForm;
var
  C: TDFSplashThemeColors;
begin
  if not Assigned(FForm) then
    Exit;
  FForm.Caption := FTitle;
  FForm.Title := FTitle;
  FForm.Subtitle := FSubtitle;
  FForm.Status := FStatus;
  FForm.AppVersion := FAppVersion;
  FForm.CopyrightText := FCopyright;
  FForm.BackgroundColor := FBackgroundColor;
  FForm.BackgroundAlt := FBackgroundAlt;
  FForm.AccentColor := FAccentColor;
  FForm.TitleColor := FTitleColor;
  FForm.TextColor := FTextColor;
  C := DFSplashThemeColors(FTheme);
  if FTheme = stCustom then
    FForm.MutedColor := $00A0A0A0
  else
    FForm.MutedColor := C.Muted;
  FForm.ProgressColor := FProgressColor;
  FForm.ProgressBackColor := FProgressBackColor;
  FForm.Progress := FProgress;
  FForm.ProgressMin := FProgressMin;
  FForm.ProgressMax := FProgressMax;
  FForm.ProgressHeight := FProgressHeight;
  FForm.ProgressStyle := FProgressStyle;
  FForm.CornerRadius := FCornerRadius;
  FForm.LogoPosition := FLogoPosition;
  FForm.LogoSize := FLogoSize;
  FForm.FontName := FFontName;
  FForm.Gradient := FGradient;
  FForm.ShowTitle := FShowTitle;
  FForm.ShowStatus := FShowStatus;
  FForm.ShowVersion := FShowVersion;
  FForm.ShowCopyright := FShowCopyright;
  FForm.ShowShadow := FShowShadow;
  FForm.CloseOnClick := FCloseOnClick;
  FForm.OverlayDarken := FOverlayDarken;
  FForm.TargetOpacity := FOpacity;
  FForm.Logo.Assign(FLogo);
  FForm.BackgroundImage.Assign(FBackgroundImage);
  FForm.Width := ScalePx(FWidth);
  FForm.Height := ScalePx(FHeight);
  if FStayOnTop then
    FForm.FormStyle := fsStayOnTop
  else
    FForm.FormStyle := fsNormal;
  FForm.Position := poDesigned;
  FForm.DefaultMonitor := dmDesktop;
  FForm.CenterOnWorkArea;
  FForm.ApplyLayout;
end;

procedure TDFSplashScreen.SyncIfShowing;
begin
  if (csDesigning in ComponentState) or (csLoading in ComponentState) then
    Exit;
  if Assigned(FForm) and FForm.Visible then
    PushToForm;
end;

procedure TDFSplashScreen.ShowSplash;
begin
  if csDesigning in ComponentState then
    Exit;
  FHiding := False;
  EnsureForm;
  PushToForm;
  FForm.AlphaBlendValue := 0;
  FForm.Show;
  FForm.BringToFront;
  FForm.ApplyLayout;
  FForm.Update;
  FForm.StartFade(True, FFadeInMs);
  if FAutoHideInterval > 0 then
  begin
    FAutoHideTimer.Interval := FAutoHideInterval;
    FAutoHideTimer.Enabled := True;
  end;
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

procedure TDFSplashScreen.HideSplash;
var
  Limit: Cardinal;
begin
  FAutoHideTimer.Enabled := False;
  if not Assigned(FForm) or not FForm.Visible or FHiding then
  begin
    if Assigned(FForm) and not FForm.Visible and Assigned(FOnHide) then
      FOnHide(Self);
    Exit;
  end;
  FHiding := True;
  FForm.StartFade(False, FFadeOutMs);
  if FFadeOutMs <= 0 then
  begin
    FHiding := False;
    Exit;
  end;
  Limit := GetTickCount + Cardinal(FFadeOutMs) + 120;
  while FHiding and Assigned(FForm) and (GetTickCount < Limit) do
  begin
    Application.ProcessMessages;
    Sleep(10);
  end;
end;

procedure TDFSplashScreen.FormFadedOut(Sender: TObject);
begin
  FHiding := False;
  if Assigned(FOnHide) then
    FOnHide(Self);
end;

procedure TDFSplashScreen.AutoHideTick(Sender: TObject);
begin
  FAutoHideTimer.Enabled := False;
  if Assigned(FOnTimeout) then
    FOnTimeout(Self);
  HideSplash;
end;

procedure TDFSplashScreen.Execute(const AWork: TProc);
begin
  ShowSplash;
  try
    if Assigned(AWork) then
      AWork;
  finally
    HideSplash;
  end;
end;

procedure TDFSplashScreen.UpdateProgress(APosition: Integer; const AStatus: string);
begin
  if TThread.CurrentThread.ThreadID <> MainThreadID then
  begin
    TThread.Queue(nil,
      procedure
      begin
        UpdateProgress(APosition, AStatus);
      end);
    Exit;
  end;
  FProgress := APosition;
  if AStatus <> '' then
    FStatus := AStatus;
  SyncIfShowing;
  if Assigned(FForm) and FForm.Visible then
    FForm.Update;
end;

procedure TDFSplashScreen.UpdateStatus(const AStatus: string);
begin
  if TThread.CurrentThread.ThreadID <> MainThreadID then
  begin
    TThread.Queue(nil,
      procedure
      begin
        UpdateStatus(AStatus);
      end);
    Exit;
  end;
  FStatus := AStatus;
  SyncIfShowing;
  if Assigned(FForm) and FForm.Visible then
    FForm.Update;
end;

procedure TDFSplashScreen.LoadLogo(const AFileName: string);
begin
  if (AFileName <> '') and FileExists(AFileName) then
    FLogo.LoadFromFile(AFileName);
  SyncIfShowing;
end;

procedure TDFSplashScreen.LoadBackground(const AFileName: string);
begin
  if (AFileName <> '') and FileExists(AFileName) then
    FBackgroundImage.LoadFromFile(AFileName);
  SyncIfShowing;
end;

function TDFSplashScreen.GetShowing: Boolean;
begin
  Result := Assigned(FForm) and FForm.Visible and not FHiding;
end;

procedure TDFSplashScreen.LogoChanged(Sender: TObject);
begin
  SyncIfShowing;
end;

procedure TDFSplashScreen.BackgroundChanged(Sender: TObject);
begin
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetTheme(const Value: TDFSplashTheme);
begin
  FTheme := Value;
  ApplyThemeColors;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetAccentColor(const Value: TColor);
begin
  if FAccentColor = Value then
    Exit;
  FAccentColor := Value;
  FTheme := stCustom;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetBackgroundAlt(const Value: TColor);
begin
  if FBackgroundAlt = Value then
    Exit;
  FBackgroundAlt := Value;
  FTheme := stCustom;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetBackgroundColor(const Value: TColor);
begin
  if FBackgroundColor = Value then
    Exit;
  FBackgroundColor := Value;
  FTheme := stCustom;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetTitleColor(const Value: TColor);
begin
  if FTitleColor = Value then
    Exit;
  FTitleColor := Value;
  FTheme := stCustom;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetTextColor(const Value: TColor);
begin
  if FTextColor = Value then
    Exit;
  FTextColor := Value;
  FTheme := stCustom;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetProgressColor(const Value: TColor);
begin
  if FProgressColor = Value then
    Exit;
  FProgressColor := Value;
  FTheme := stCustom;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetProgressBackColor(const Value: TColor);
begin
  if FProgressBackColor = Value then
    Exit;
  FProgressBackColor := Value;
  FTheme := stCustom;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetTitle(const Value: string);
begin
  FTitle := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetSubtitle(const Value: string);
begin
  FSubtitle := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetStatus(const Value: string);
begin
  FStatus := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetAppVersion(const Value: string);
begin
  FAppVersion := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetCopyright(const Value: string);
begin
  FCopyright := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetWidth(const Value: Integer);
begin
  FWidth := Max(280, Value);
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetHeight(const Value: Integer);
begin
  FHeight := Max(160, Value);
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetOpacity(const Value: Byte);
begin
  FOpacity := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetCornerRadius(const Value: Integer);
begin
  FCornerRadius := Max(0, Value);
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetLogo(const Value: TPicture);
begin
  FLogo.Assign(Value);
end;

procedure TDFSplashScreen.SetBackgroundImage(const Value: TPicture);
begin
  FBackgroundImage.Assign(Value);
end;

procedure TDFSplashScreen.SetLogoPosition(const Value: TDFSplashLogoPosition);
begin
  FLogoPosition := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetLogoSize(const Value: Integer);
begin
  FLogoSize := Max(24, Value);
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetFontName(const Value: TFontName);
begin
  if Value = '' then
    FFontName := 'Segoe UI'
  else
    FFontName := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetGradient(const Value: Boolean);
begin
  FGradient := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetStayOnTop(const Value: Boolean);
begin
  FStayOnTop := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetShowTitle(const Value: Boolean);
begin
  FShowTitle := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetShowStatus(const Value: Boolean);
begin
  FShowStatus := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetShowVersion(const Value: Boolean);
begin
  FShowVersion := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetShowCopyright(const Value: Boolean);
begin
  FShowCopyright := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetShowShadow(const Value: Boolean);
begin
  FShowShadow := Value;
end;

procedure TDFSplashScreen.SetCloseOnClick(const Value: Boolean);
begin
  FCloseOnClick := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetOverlayDarken(const Value: Byte);
begin
  FOverlayDarken := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetProgress(const Value: Integer);
begin
  FProgress := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetProgressHeight(const Value: Integer);
begin
  FProgressHeight := Max(2, Value);
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetProgressMax(const Value: Integer);
begin
  FProgressMax := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetProgressMin(const Value: Integer);
begin
  FProgressMin := Value;
  SyncIfShowing;
end;

procedure TDFSplashScreen.SetProgressStyle(const Value: TDFSplashProgressStyle);
begin
  FProgressStyle := Value;
  SyncIfShowing;
end;

end.

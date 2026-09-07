{*******************************************************************************
  DFSplashScreen
  Copyright (c) 2026 DelphiFan
  Website: https://delphifan.com
  Email:   adsdelphi@gmail.com
*******************************************************************************}

unit DFSplashScreen.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.Math, System.Types, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.Imaging.GIFImg,
  DFSplashScreen.Types;

type
  TfrmDFSplash = class(TForm)
  private
    FAccentColor: TColor;
    FBackgroundAlt: TColor;
    FBackgroundColor: TColor;
    FBackgroundImage: TPicture;
    FCloseOnClick: Boolean;
    FCopyright: string;
    FCornerRadius: Integer;
    FFadeDuration: Integer;
    FFadeIn: Boolean;
    FFadeTimer: TTimer;
    FFontName: TFontName;
    FGradient: Boolean;
    FLogo: TPicture;
    FLogoPosition: TDFSplashLogoPosition;
    FLogoSize: Integer;
    FMarqueePos: Integer;
    FMutedColor: TColor;
    FOnFadedOut: TNotifyEvent;
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
    FSubtitle: string;
    FTargetOpacity: Byte;
    FTextColor: TColor;
    FTickTimer: TTimer;
    FTitle: string;
    FTitleColor: TColor;
    FAppVersion: string;
    procedure ApplyRegion;
    procedure DrawBackground(ACanvas: TCanvas; const ARect: TRect);
    procedure DrawContent(ACanvas: TCanvas);
    procedure DrawLogo(ACanvas: TCanvas; const ARect: TRect);
    procedure DrawProgressBar(ACanvas: TCanvas; const ARect: TRect);
    procedure FadeTimerTick(Sender: TObject);
    procedure TickTimerTick(Sender: TObject);
    function MixColor(C1, C2: TColor; ARatio: Double): TColor;
    function ScaleI(AValue: Integer): Integer;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoClose(var Action: TCloseAction); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
    procedure Resize; override;
  public
    constructor CreateNewSplash(AOwner: TComponent);
    destructor Destroy; override;
    procedure ApplyLayout;
    procedure CenterOnWorkArea;
    procedure StartFade(AFadeIn: Boolean; ADurationMs: Integer);
    procedure StopFade;
    property AccentColor: TColor read FAccentColor write FAccentColor;
    property AppVersion: string read FAppVersion write FAppVersion;
    property BackgroundAlt: TColor read FBackgroundAlt write FBackgroundAlt;
    property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor;
    property BackgroundImage: TPicture read FBackgroundImage;
    property CloseOnClick: Boolean read FCloseOnClick write FCloseOnClick;
    property CopyrightText: string read FCopyright write FCopyright;
    property CornerRadius: Integer read FCornerRadius write FCornerRadius;
    property FontName: TFontName read FFontName write FFontName;
    property Gradient: Boolean read FGradient write FGradient;
    property Logo: TPicture read FLogo;
    property LogoPosition: TDFSplashLogoPosition read FLogoPosition write FLogoPosition;
    property LogoSize: Integer read FLogoSize write FLogoSize;
    property MutedColor: TColor read FMutedColor write FMutedColor;
    property OnFadedOut: TNotifyEvent read FOnFadedOut write FOnFadedOut;
    property OverlayDarken: Byte read FOverlayDarken write FOverlayDarken;
    property Progress: Integer read FProgress write FProgress;
    property ProgressBackColor: TColor read FProgressBackColor write FProgressBackColor;
    property ProgressColor: TColor read FProgressColor write FProgressColor;
    property ProgressHeight: Integer read FProgressHeight write FProgressHeight;
    property ProgressMax: Integer read FProgressMax write FProgressMax;
    property ProgressMin: Integer read FProgressMin write FProgressMin;
    property ProgressStyle: TDFSplashProgressStyle read FProgressStyle write FProgressStyle;
    property ShowCopyright: Boolean read FShowCopyright write FShowCopyright;
    property ShowShadow: Boolean read FShowShadow write FShowShadow;
    property ShowStatus: Boolean read FShowStatus write FShowStatus;
    property ShowTitle: Boolean read FShowTitle write FShowTitle;
    property ShowVersion: Boolean read FShowVersion write FShowVersion;
    property Status: string read FStatus write FStatus;
    property Subtitle: string read FSubtitle write FSubtitle;
    property TargetOpacity: Byte read FTargetOpacity write FTargetOpacity;
    property TextColor: TColor read FTextColor write FTextColor;
    property Title: string read FTitle write FTitle;
    property TitleColor: TColor read FTitleColor write FTitleColor;
  end;

implementation

{ TfrmDFSplash }

constructor TfrmDFSplash.CreateNewSplash(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  BorderStyle := bsNone;
  BorderIcons := [];
  FormStyle := fsStayOnTop;
  Position := poDesigned;
  DefaultMonitor := dmDesktop;
  PopupMode := pmExplicit;
  DoubleBuffered := True;
  Color := clBlack;
  AlphaBlend := True;
  AlphaBlendValue := 0;
  KeyPreview := True;
  Scaled := False;

  FBackgroundImage := TPicture.Create;
  FLogo := TPicture.Create;
  FFontName := 'Segoe UI';
  FTargetOpacity := 245;
  FCornerRadius := 16;
  FLogoSize := 72;
  FLogoPosition := lpLeft;
  FProgressHeight := 4;
  FProgressMin := 0;
  FProgressMax := 100;
  FProgressStyle := psBar;
  FGradient := True;
  FShowTitle := True;
  FShowStatus := True;
  FShowVersion := True;
  FShowCopyright := True;
  FShowShadow := True;
  FOverlayDarken := 80;

  FFadeTimer := TTimer.Create(Self);
  FFadeTimer.Enabled := False;
  FFadeTimer.Interval := 16;
  FFadeTimer.OnTimer := FadeTimerTick;

  FTickTimer := TTimer.Create(Self);
  FTickTimer.Enabled := True;
  FTickTimer.Interval := 30;
  FTickTimer.OnTimer := TickTimerTick;
end;

destructor TfrmDFSplash.Destroy;
begin
  FBackgroundImage.Free;
  FLogo.Free;
  inherited Destroy;
end;

procedure TfrmDFSplash.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW;
  if FShowShadow and (FCornerRadius <= 0) then
    Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;

procedure TfrmDFSplash.DoClose(var Action: TCloseAction);
begin
  Action := caHide;
  inherited DoClose(Action);
end;

procedure TfrmDFSplash.ApplyLayout;
begin
  if HandleAllocated then
    ApplyRegion;
  Invalidate;
end;

procedure TfrmDFSplash.CenterOnWorkArea;
var
  R: TRect;
begin
  R := Screen.WorkAreaRect;
  Left := R.Left + ((R.Right - R.Left) - Width) div 2;
  Top := R.Top + ((R.Bottom - R.Top) - Height) div 2;
end;

procedure TfrmDFSplash.ApplyRegion;
var
  Rgn: HRGN;
  R: Integer;
begin
  if not HandleAllocated then
    Exit;
  if FCornerRadius <= 0 then
  begin
    SetWindowRgn(Handle, 0, True);
    Exit;
  end;
  R := ScaleI(FCornerRadius);
  Rgn := CreateRoundRectRgn(0, 0, Width + 1, Height + 1, R * 2, R * 2);
  SetWindowRgn(Handle, Rgn, True);
end;

procedure TfrmDFSplash.Resize;
begin
  inherited Resize;
  ApplyRegion;
end;

function TfrmDFSplash.ScaleI(AValue: Integer): Integer;
begin
  Result := MulDiv(AValue, Screen.PixelsPerInch, 96);
end;

function TfrmDFSplash.MixColor(C1, C2: TColor; ARatio: Double): TColor;
var
  R1, G1, B1, R2, G2, B2: Byte;
  V1, V2: Longint;
begin
  if ARatio < 0 then
    ARatio := 0
  else if ARatio > 1 then
    ARatio := 1;
  V1 := ColorToRGB(C1);
  V2 := ColorToRGB(C2);
  R1 := GetRValue(V1);
  G1 := GetGValue(V1);
  B1 := GetBValue(V1);
  R2 := GetRValue(V2);
  G2 := GetGValue(V2);
  B2 := GetBValue(V2);
  Result := RGB(
    Round(R1 + (R2 - R1) * ARatio),
    Round(G1 + (G2 - G1) * ARatio),
    Round(B1 + (B2 - B1) * ARatio));
end;

procedure TfrmDFSplash.DrawBackground(ACanvas: TCanvas; const ARect: TRect);
var
  Y: Integer;
  Ratio: Double;
  LineColor: TColor;
  Dest: TRect;
  ImgW, ImgH: Integer;
  Scale: Double;
  OverlayBmp: TBitmap;
  Blend: TBlendFunction;
begin
  if Assigned(FBackgroundImage.Graphic) and not FBackgroundImage.Graphic.Empty then
  begin
    ImgW := FBackgroundImage.Graphic.Width;
    ImgH := FBackgroundImage.Graphic.Height;
    if (ImgW > 0) and (ImgH > 0) then
    begin
      Scale := Max(ARect.Width / ImgW, ARect.Height / ImgH);
      Dest.Left := ARect.Left + (ARect.Width - Round(ImgW * Scale)) div 2;
      Dest.Top := ARect.Top + (ARect.Height - Round(ImgH * Scale)) div 2;
      Dest.Right := Dest.Left + Round(ImgW * Scale);
      Dest.Bottom := Dest.Top + Round(ImgH * Scale);
      ACanvas.StretchDraw(Dest, FBackgroundImage.Graphic);
      if FOverlayDarken > 0 then
      begin
        OverlayBmp := TBitmap.Create;
        try
          OverlayBmp.PixelFormat := pf24bit;
          OverlayBmp.SetSize(Max(1, ARect.Width), Max(1, ARect.Height));
          OverlayBmp.Canvas.Brush.Color := clBlack;
          OverlayBmp.Canvas.FillRect(Rect(0, 0, OverlayBmp.Width, OverlayBmp.Height));
          Blend.BlendOp := AC_SRC_OVER;
          Blend.BlendFlags := 0;
          Blend.SourceConstantAlpha := FOverlayDarken;
          Blend.AlphaFormat := 0;
          Winapi.Windows.AlphaBlend(ACanvas.Handle, ARect.Left, ARect.Top,
            ARect.Width, ARect.Height, OverlayBmp.Canvas.Handle, 0, 0,
            OverlayBmp.Width, OverlayBmp.Height, Blend);
        finally
          OverlayBmp.Free;
        end;
      end;
      Exit;
    end;
  end;

  if not FGradient then
  begin
    ACanvas.Brush.Style := bsSolid;
    ACanvas.Brush.Color := FBackgroundColor;
    ACanvas.FillRect(ARect);
    Exit;
  end;

  for Y := ARect.Top to ARect.Bottom - 1 do
  begin
    Ratio := (Y - ARect.Top) / Max(1, ARect.Height - 1);
    LineColor := MixColor(FBackgroundColor, FBackgroundAlt, Ratio);
    ACanvas.Pen.Color := LineColor;
    ACanvas.MoveTo(ARect.Left, Y);
    ACanvas.LineTo(ARect.Right, Y);
  end;
end;

procedure TfrmDFSplash.DrawLogo(ACanvas: TCanvas; const ARect: TRect);
var
  G: TGraphic;
begin
  if ARect.Width <= 0 then
    Exit;
  G := FLogo.Graphic;
  if not Assigned(G) or G.Empty then
    Exit;
  if G is TPngImage then
    TPngImage(G).Draw(ACanvas, ARect)
  else
    ACanvas.StretchDraw(ARect, G);
end;

procedure TfrmDFSplash.DrawProgressBar(ACanvas: TCanvas; const ARect: TRect);
var
  FillR, BlockR: TRect;
  Span, Pos, BlockW, X: Integer;
  R: Integer;
begin
  if FProgressStyle = psHidden then
    Exit;

  ACanvas.Pen.Style := psClear;
  ACanvas.Brush.Style := bsSolid;
  ACanvas.Brush.Color := FProgressBackColor;
  R := ARect.Height div 2;
  RoundRect(ACanvas.Handle, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom, R, R);

  FillR := ARect;
  if FProgressStyle = psMarquee then
  begin
    BlockW := Max(ScaleI(48), ARect.Width div 4);
    X := ARect.Left + MulDiv(ARect.Width + BlockW, FMarqueePos, 100) - BlockW;
    BlockR := Rect(Max(ARect.Left, X), ARect.Top, Min(ARect.Right, X + BlockW), ARect.Bottom);
    if BlockR.Width > 0 then
    begin
      ACanvas.Brush.Color := FProgressColor;
      RoundRect(ACanvas.Handle, BlockR.Left, BlockR.Top, BlockR.Right, BlockR.Bottom, R, R);
    end;
    Exit;
  end;

  Span := Max(1, FProgressMax - FProgressMin);
  Pos := EnsureRange(FProgress, FProgressMin, FProgressMax) - FProgressMin;
  FillR.Right := FillR.Left + MulDiv(ARect.Width, Pos, Span);
  if FillR.Width > 0 then
  begin
    ACanvas.Brush.Color := FProgressColor;
    RoundRect(ACanvas.Handle, FillR.Left, FillR.Top, FillR.Right, FillR.Bottom, R, R);
  end;
end;

procedure TfrmDFSplash.DrawContent(ACanvas: TCanvas);
var
  Pad, AccentH, LogoSz, Gap: Integer;
  Content, LogoR, TextR, BarR, FooterR: TRect;
  TitleH, SubH, StatusH, FooterH: Integer;
  Flags: Cardinal;
  RText: TRect;
begin
  Pad := ScaleI(28);
  AccentH := ScaleI(4);
  LogoSz := ScaleI(FLogoSize);
  Gap := ScaleI(18);

  ACanvas.Brush.Color := FAccentColor;
  ACanvas.Pen.Style := psClear;
  ACanvas.FillRect(Rect(0, 0, ClientWidth, AccentH));

  Content := Rect(Pad, AccentH + Pad, ClientWidth - Pad, ClientHeight - Pad);

  if (FLogoPosition <> lpHidden) and Assigned(FLogo.Graphic) and not FLogo.Graphic.Empty then
  begin
    if FLogoPosition = lpLeft then
    begin
      LogoR := Rect(Content.Left, Content.Top, Content.Left + LogoSz, Content.Top + LogoSz);
      OffsetRect(LogoR, 0, (Content.Height - LogoSz) div 2 - ScaleI(8));
      DrawLogo(ACanvas, LogoR);
      Content.Left := LogoR.Right + Gap;
    end
    else
    begin
      LogoR := Rect(Content.Left, Content.Top, Content.Left + LogoSz, Content.Top + LogoSz);
      DrawLogo(ACanvas, LogoR);
      Content.Top := LogoR.Bottom + ScaleI(12);
    end;
  end;

  FooterH := ScaleI(18);
  FooterR := Rect(Content.Left, Content.Bottom - FooterH, Content.Right, Content.Bottom);

  if FProgressStyle <> psHidden then
  begin
    BarR := Rect(Content.Left, FooterR.Top - ScaleI(14) - ScaleI(FProgressHeight),
      Content.Right, FooterR.Top - ScaleI(14));
    DrawProgressBar(ACanvas, BarR);
  end
  else
    BarR := Rect(Content.Left, FooterR.Top - ScaleI(8), Content.Right, FooterR.Top - ScaleI(8));

  TextR := Rect(Content.Left, Content.Top, Content.Right, BarR.Top - ScaleI(10));

  ACanvas.Brush.Style := bsClear;
  Flags := DT_LEFT or DT_END_ELLIPSIS or DT_NOPREFIX or DT_SINGLELINE;

  if FShowTitle and (FTitle <> '') then
  begin
    ACanvas.Font.Name := FFontName;
    ACanvas.Font.Size := 20;
    ACanvas.Font.Style := [fsBold];
    ACanvas.Font.Color := FTitleColor;
    TitleH := ACanvas.TextHeight('Ag') + ScaleI(4);
    RText := Rect(TextR.Left, TextR.Top, TextR.Right, TextR.Top + TitleH);
    DrawText(ACanvas.Handle, PChar(FTitle), -1, RText, Flags);
    TextR.Top := TextR.Top + TitleH;
  end;

  if FSubtitle <> '' then
  begin
    ACanvas.Font.Name := FFontName;
    ACanvas.Font.Size := 10;
    ACanvas.Font.Style := [];
    ACanvas.Font.Color := FMutedColor;
    SubH := ACanvas.TextHeight('Ag') + ScaleI(8);
    RText := Rect(TextR.Left, TextR.Top, TextR.Right, TextR.Top + SubH);
    DrawText(ACanvas.Handle, PChar(FSubtitle), -1, RText,
      DT_LEFT or DT_WORDBREAK or DT_NOPREFIX or DT_END_ELLIPSIS);
    TextR.Top := TextR.Top + SubH;
  end;

  if FShowStatus and (FStatus <> '') then
  begin
    ACanvas.Font.Name := FFontName;
    ACanvas.Font.Size := 9;
    ACanvas.Font.Style := [];
    ACanvas.Font.Color := FTextColor;
    StatusH := ACanvas.TextHeight('Ag');
    RText := Rect(TextR.Left, BarR.Top - StatusH - ScaleI(8), TextR.Right, BarR.Top - ScaleI(4));
    DrawText(ACanvas.Handle, PChar(FStatus), -1, RText, Flags);
  end;

  ACanvas.Font.Name := FFontName;
  ACanvas.Font.Size := 8;
  ACanvas.Font.Style := [];
  ACanvas.Font.Color := FMutedColor;
  if FShowCopyright and (FCopyright <> '') then
    DrawText(ACanvas.Handle, PChar(FCopyright), -1, FooterR,
      DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_NOPREFIX or DT_END_ELLIPSIS);
  if FShowVersion and (FAppVersion <> '') then
    DrawText(ACanvas.Handle, PChar(FAppVersion), -1, FooterR,
      DT_RIGHT or DT_VCENTER or DT_SINGLELINE or DT_NOPREFIX);
end;

procedure TfrmDFSplash.Paint;
begin
  DrawBackground(Canvas, ClientRect);
  DrawContent(Canvas);
end;

procedure TfrmDFSplash.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TfrmDFSplash.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if not FCloseOnClick then
    Message.Result := HTCAPTION;
end;

procedure TfrmDFSplash.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if FCloseOnClick and (Button = mbLeft) then
    Close;
end;

procedure TfrmDFSplash.StartFade(AFadeIn: Boolean; ADurationMs: Integer);
begin
  FFadeIn := AFadeIn;
  FFadeDuration := Max(0, ADurationMs);
  AlphaBlend := True;
  if FFadeDuration <= 0 then
  begin
    FFadeTimer.Enabled := False;
    if AFadeIn then
      AlphaBlendValue := FTargetOpacity
    else
    begin
      AlphaBlendValue := 0;
      Hide;
      if Assigned(FOnFadedOut) then
        FOnFadedOut(Self);
    end;
    Exit;
  end;
  if AFadeIn then
    AlphaBlendValue := 0
  else if AlphaBlendValue = 0 then
    AlphaBlendValue := FTargetOpacity;
  FFadeTimer.Enabled := True;
end;

procedure TfrmDFSplash.StopFade;
begin
  FFadeTimer.Enabled := False;
end;

procedure TfrmDFSplash.FadeTimerTick(Sender: TObject);
var
  Step: Integer;
begin
  Step := Max(3, FTargetOpacity div Max(1, FFadeDuration div 16));
  if FFadeIn then
  begin
    if Integer(AlphaBlendValue) + Step >= FTargetOpacity then
    begin
      AlphaBlendValue := FTargetOpacity;
      FFadeTimer.Enabled := False;
    end
    else
      AlphaBlendValue := AlphaBlendValue + Step;
  end
  else
  begin
    if Integer(AlphaBlendValue) <= Step then
    begin
      AlphaBlendValue := 0;
      FFadeTimer.Enabled := False;
      Hide;
      if Assigned(FOnFadedOut) then
        FOnFadedOut(Self);
    end
    else
      AlphaBlendValue := AlphaBlendValue - Step;
  end;
end;

procedure TfrmDFSplash.TickTimerTick(Sender: TObject);
begin
  if not Visible then
    Exit;
  if FProgressStyle = psMarquee then
  begin
    Inc(FMarqueePos, 2);
    if FMarqueePos > 100 then
      FMarqueePos := 0;
    Invalidate;
  end;
end;

end.

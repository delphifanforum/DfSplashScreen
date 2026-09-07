{*******************************************************************************
  DFSplashScreen Demo
  Copyright (c) 2026 DelphiFan
  Website: https://delphifan.com
  Email:   adsdelphi@gmail.com
*******************************************************************************}

unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.UITypes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ExtDlgs,
  DFSplashScreen, DFSplashScreen.Types;

type
  TfrmMain = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FSplash: TDFSplashScreen;
    pnlLeft: TPanel;
    pnlRight: TPanel;
    lblBrand: TLabel;
    lblHint: TLabel;
    cbTheme: TComboBox;
    cbProgress: TComboBox;
    cbLogoPos: TComboBox;
    edTitle: TEdit;
    edSubtitle: TEdit;
    edStatus: TEdit;
    edVersion: TEdit;
    edCopyright: TEdit;
    tbWidth: TTrackBar;
    tbHeight: TTrackBar;
    tbOpacity: TTrackBar;
    tbRadius: TTrackBar;
    tbProgress: TTrackBar;
    tbLogo: TTrackBar;
    lblWidth: TLabel;
    lblHeight: TLabel;
    lblOpacity: TLabel;
    lblRadius: TLabel;
    lblProg: TLabel;
    lblLogo: TLabel;
    clAccent: TColorBox;
    clBack: TColorBox;
    chkGradient: TCheckBox;
    chkStayOnTop: TCheckBox;
    chkCloseClick: TCheckBox;
    btnShow: TButton;
    btnHide: TButton;
    btnSim: TButton;
    btnMarquee: TButton;
    btnLogo: TButton;
    btnBg: TButton;
    dlgPic: TOpenPictureDialog;
    procedure BuildUi;
    procedure ApplyToSplash;
    procedure MakeSampleLogo;
    procedure ThemeChange(Sender: TObject);
    procedure FieldChange(Sender: TObject);
    procedure ShowClick(Sender: TObject);
    procedure HideClick(Sender: TObject);
    procedure SimClick(Sender: TObject);
    procedure MarqueeClick(Sender: TObject);
    procedure LogoClick(Sender: TObject);
    procedure BgClick(Sender: TObject);
    procedure TrackChange(Sender: TObject);
    procedure UpdateTrackLabels;
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

function AddLabel(AParent: TWinControl; const ACaption: string; ATop: Integer): TLabel;
begin
  Result := TLabel.Create(AParent.Owner);
  Result.Parent := AParent;
  Result.Left := 16;
  Result.Top := ATop;
  Result.Caption := ACaption;
  Result.Font.Color := $00C8C8C8;
end;

function AddEdit(AParent: TWinControl; ATop: Integer; const AText: string;
  AChange: TNotifyEvent): TEdit;
begin
  Result := TEdit.Create(AParent.Owner);
  Result.Parent := AParent;
  Result.Left := 16;
  Result.Top := ATop;
  Result.Width := 300;
  Result.Text := AText;
  Result.OnChange := AChange;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FSplash := TDFSplashScreen.Create(Self);
  MakeSampleLogo;
  BuildUi;
  ApplyToSplash;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if Assigned(FSplash) then
    FSplash.HideSplash;
end;

procedure TfrmMain.MakeSampleLogo;
var
  Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  try
    Bmp.PixelFormat := pf24bit;
    Bmp.SetSize(128, 128);
    Bmp.Canvas.Brush.Color := $00D47800;
    Bmp.Canvas.FillRect(Rect(0, 0, 128, 128));
    Bmp.Canvas.Brush.Color := $001E1E1E;
    Bmp.Canvas.RoundRect(16, 16, 112, 112, 28, 28);
    Bmp.Canvas.Font.Name := 'Segoe UI';
    Bmp.Canvas.Font.Size := 28;
    Bmp.Canvas.Font.Style := [fsBold];
    Bmp.Canvas.Font.Color := $00D47800;
    Bmp.Canvas.Brush.Style := bsClear;
    Bmp.Canvas.TextOut(28, 40, 'DF');
    FSplash.Logo.Assign(Bmp);
  finally
    Bmp.Free;
  end;
end;

procedure TfrmMain.BuildUi;
var
  Y: Integer;
begin
  Caption := 'DFSplashScreen Demo';
  Color := $00181818;
  Font.Name := 'Segoe UI';
  Font.Size := 9;
  Font.Color := clWhite;
  Position := poDesigned;
  Visible := False;
  ClientWidth := 920;
  ClientHeight := 640;
  BorderIcons := [biSystemMenu, biMinimize];

  pnlLeft := TPanel.Create(Self);
  pnlLeft.Parent := Self;
  pnlLeft.Align := alLeft;
  pnlLeft.Width := 340;
  pnlLeft.BevelOuter := bvNone;
  pnlLeft.Color := $00202020;
  pnlLeft.ParentBackground := False;

  pnlRight := TPanel.Create(Self);
  pnlRight.Parent := Self;
  pnlRight.Align := alClient;
  pnlRight.BevelOuter := bvNone;
  pnlRight.Color := $00181818;
  pnlRight.ParentBackground := False;

  lblBrand := TLabel.Create(Self);
  lblBrand.Parent := pnlRight;
  lblBrand.Left := 36;
  lblBrand.Top := 36;
  lblBrand.Caption := 'DFSplashScreen';
  lblBrand.Font.Size := 22;
  lblBrand.Font.Style := [fsBold];
  lblBrand.Font.Color := clWhite;

  lblHint := TLabel.Create(Self);
  lblHint.Parent := pnlRight;
  lblHint.Left := 36;
  lblHint.Top := 80;
  lblHint.Width := 500;
  lblHint.Height := 220;
  lblHint.WordWrap := True;
  lblHint.AutoSize := False;
  lblHint.Font.Color := $00B0B0B0;
  lblHint.Font.Size := 10;
  lblHint.Caption :=
    'VCL splash screen for Delphi 10.3 Rio and later.' + sLineBreak + sLineBreak +
    '1. Install the design-time package, or add the Source units to your project.' + sLineBreak +
    '2. Configure title, size, colors, opacity and progress.' + sLineBreak +
    '3. Call ShowSplash in the .dpr file before CreateForm, then HideSplash when ready.' + sLineBreak + sLineBreak +
    'Website: delphifan.com' + sLineBreak +
    'Email: adsdelphi@gmail.com' + sLineBreak +
    'Version: ' + TDFSplashScreen.ComponentVersion;

  AddLabel(pnlLeft, 'Theme', 16);
  cbTheme := TComboBox.Create(Self);
  cbTheme.Parent := pnlLeft;
  cbTheme.Left := 16;
  cbTheme.Top := 34;
  cbTheme.Width := 300;
  cbTheme.Style := csDropDownList;
  cbTheme.Items.AddStrings(['Custom', 'Dark', 'Light', 'Midnight', 'Ocean', 'Sunset']);
  cbTheme.ItemIndex := 1;
  cbTheme.OnChange := ThemeChange;

  AddLabel(pnlLeft, 'Title', 68);
  edTitle := AddEdit(pnlLeft, 86, 'DFSplashScreen', FieldChange);
  AddLabel(pnlLeft, 'Subtitle', 116);
  edSubtitle := AddEdit(pnlLeft, 134, 'Professional splash for Delphi 10.3+', FieldChange);
  AddLabel(pnlLeft, 'Status', 164);
  edStatus := AddEdit(pnlLeft, 182, 'Loading modules...', FieldChange);
  AddLabel(pnlLeft, 'Version', 212);
  edVersion := AddEdit(pnlLeft, 230, 'Version 1.0.0', FieldChange);
  AddLabel(pnlLeft, 'Copyright', 260);
  edCopyright := AddEdit(pnlLeft, 278, 'Copyright (c) 2026 DelphiFan', FieldChange);

  Y := 312;
  lblWidth := AddLabel(pnlLeft, 'Width: 520', Y);
  tbWidth := TTrackBar.Create(Self);
  tbWidth.Parent := pnlLeft;
  tbWidth.Left := 8;
  tbWidth.Top := Y + 16;
  tbWidth.Width := 320;
  tbWidth.Min := 360;
  tbWidth.Max := 900;
  tbWidth.Position := 520;
  tbWidth.OnChange := TrackChange;

  Y := 372;
  lblHeight := AddLabel(pnlLeft, 'Height: 300', Y);
  tbHeight := TTrackBar.Create(Self);
  tbHeight.Parent := pnlLeft;
  tbHeight.Left := 8;
  tbHeight.Top := Y + 16;
  tbHeight.Width := 320;
  tbHeight.Min := 200;
  tbHeight.Max := 600;
  tbHeight.Position := 300;
  tbHeight.OnChange := TrackChange;

  Y := 432;
  lblOpacity := AddLabel(pnlLeft, 'Opacity: 245', Y);
  tbOpacity := TTrackBar.Create(Self);
  tbOpacity.Parent := pnlLeft;
  tbOpacity.Left := 8;
  tbOpacity.Top := Y + 16;
  tbOpacity.Width := 320;
  tbOpacity.Min := 80;
  tbOpacity.Max := 255;
  tbOpacity.Position := 245;
  tbOpacity.OnChange := TrackChange;

  Y := 492;
  lblRadius := AddLabel(pnlLeft, 'Corner radius: 16', Y);
  tbRadius := TTrackBar.Create(Self);
  tbRadius.Parent := pnlLeft;
  tbRadius.Left := 8;
  tbRadius.Top := Y + 16;
  tbRadius.Width := 150;
  tbRadius.Min := 0;
  tbRadius.Max := 40;
  tbRadius.Position := 16;
  tbRadius.OnChange := TrackChange;

  lblProg := TLabel.Create(Self);
  lblProg.Parent := pnlLeft;
  lblProg.Left := 170;
  lblProg.Top := Y;
  lblProg.Caption := 'Progress: 35';
  lblProg.Font.Color := $00C8C8C8;
  tbProgress := TTrackBar.Create(Self);
  tbProgress.Parent := pnlLeft;
  tbProgress.Left := 162;
  tbProgress.Top := Y + 16;
  tbProgress.Width := 160;
  tbProgress.Min := 0;
  tbProgress.Max := 100;
  tbProgress.Position := 35;
  tbProgress.OnChange := TrackChange;

  AddLabel(pnlRight, 'Progress style', 320);
  cbProgress := TComboBox.Create(Self);
  cbProgress.Parent := pnlRight;
  cbProgress.Left := 36;
  cbProgress.Top := 338;
  cbProgress.Width := 200;
  cbProgress.Style := csDropDownList;
  cbProgress.Items.AddStrings(['Bar', 'Marquee', 'Hidden']);
  cbProgress.ItemIndex := 0;
  cbProgress.OnChange := FieldChange;

  AddLabel(pnlRight, 'Logo position', 370);
  cbLogoPos := TComboBox.Create(Self);
  cbLogoPos.Parent := pnlRight;
  cbLogoPos.Left := 36;
  cbLogoPos.Top := 388;
  cbLogoPos.Width := 200;
  cbLogoPos.Style := csDropDownList;
  cbLogoPos.Items.AddStrings(['Left', 'Top', 'Hidden']);
  cbLogoPos.ItemIndex := 0;
  cbLogoPos.OnChange := FieldChange;

  lblLogo := AddLabel(pnlRight, 'Logo size: 72', 420);
  tbLogo := TTrackBar.Create(Self);
  tbLogo.Parent := pnlRight;
  tbLogo.Left := 28;
  tbLogo.Top := 436;
  tbLogo.Width := 220;
  tbLogo.Min := 32;
  tbLogo.Max := 140;
  tbLogo.Position := 72;
  tbLogo.OnChange := TrackChange;

  AddLabel(pnlRight, 'Accent', 480);
  clAccent := TColorBox.Create(Self);
  clAccent.Parent := pnlRight;
  clAccent.Left := 36;
  clAccent.Top := 498;
  clAccent.Width := 160;
  clAccent.Style := [cbStandardColors, cbExtendedColors, cbSystemColors, cbCustomColor, cbPrettyNames];
  clAccent.Selected := $00D47800;
  clAccent.OnChange := FieldChange;

  AddLabel(pnlRight, 'Background', 480);
  clBack := TColorBox.Create(Self);
  clBack.Parent := pnlRight;
  clBack.Left := 220;
  clBack.Top := 498;
  clBack.Width := 160;
  clBack.Style := clAccent.Style;
  clBack.Selected := $001E1E1E;
  clBack.OnChange := FieldChange;

  chkGradient := TCheckBox.Create(Self);
  chkGradient.Parent := pnlRight;
  chkGradient.Left := 400;
  chkGradient.Top := 502;
  chkGradient.Caption := 'Gradient';
  chkGradient.Checked := True;
  chkGradient.Font.Color := clWhite;
  chkGradient.OnClick := FieldChange;

  chkStayOnTop := TCheckBox.Create(Self);
  chkStayOnTop.Parent := pnlRight;
  chkStayOnTop.Left := 400;
  chkStayOnTop.Top := 526;
  chkStayOnTop.Caption := 'Stay on top';
  chkStayOnTop.Checked := True;
  chkStayOnTop.Font.Color := clWhite;
  chkStayOnTop.OnClick := FieldChange;

  chkCloseClick := TCheckBox.Create(Self);
  chkCloseClick.Parent := pnlRight;
  chkCloseClick.Left := 400;
  chkCloseClick.Top := 550;
  chkCloseClick.Caption := 'Close on click';
  chkCloseClick.Font.Color := clWhite;
  chkCloseClick.OnClick := FieldChange;

  btnShow := TButton.Create(Self);
  btnShow.Parent := pnlRight;
  btnShow.Left := 36;
  btnShow.Top := 560;
  btnShow.Width := 110;
  btnShow.Height := 36;
  btnShow.Caption := 'Show splash';
  btnShow.OnClick := ShowClick;

  btnHide := TButton.Create(Self);
  btnHide.Parent := pnlRight;
  btnHide.Left := 156;
  btnHide.Top := 560;
  btnHide.Width := 90;
  btnHide.Height := 36;
  btnHide.Caption := 'Hide';
  btnHide.OnClick := HideClick;

  btnSim := TButton.Create(Self);
  btnSim.Parent := pnlRight;
  btnSim.Left := 256;
  btnSim.Top := 560;
  btnSim.Width := 120;
  btnSim.Height := 36;
  btnSim.Caption := 'Simulate load';
  btnSim.OnClick := SimClick;

  btnMarquee := TButton.Create(Self);
  btnMarquee.Parent := pnlRight;
  btnMarquee.Left := 386;
  btnMarquee.Top := 560;
  btnMarquee.Width := 90;
  btnMarquee.Height := 36;
  btnMarquee.Caption := 'Marquee';
  btnMarquee.OnClick := MarqueeClick;

  btnLogo := TButton.Create(Self);
  btnLogo.Parent := pnlRight;
  btnLogo.Left := 36;
  btnLogo.Top := 250;
  btnLogo.Width := 140;
  btnLogo.Height := 32;
  btnLogo.Caption := 'Load logo...';
  btnLogo.OnClick := LogoClick;

  btnBg := TButton.Create(Self);
  btnBg.Parent := pnlRight;
  btnBg.Left := 186;
  btnBg.Top := 250;
  btnBg.Width := 160;
  btnBg.Height := 32;
  btnBg.Caption := 'Load background...';
  btnBg.OnClick := BgClick;

  dlgPic := TOpenPictureDialog.Create(Self);
  UpdateTrackLabels;
  Left := Screen.WorkAreaRect.Left +
    ((Screen.WorkAreaRect.Right - Screen.WorkAreaRect.Left) - Width) div 2;
  Top := Screen.WorkAreaRect.Top +
    ((Screen.WorkAreaRect.Bottom - Screen.WorkAreaRect.Top) - Height) div 2;
end;

procedure TfrmMain.UpdateTrackLabels;
begin
  lblWidth.Caption := Format('Width: %d', [tbWidth.Position]);
  lblHeight.Caption := Format('Height: %d', [tbHeight.Position]);
  lblOpacity.Caption := Format('Opacity: %d', [tbOpacity.Position]);
  lblRadius.Caption := Format('Corner radius: %d', [tbRadius.Position]);
  lblProg.Caption := Format('Progress: %d', [tbProgress.Position]);
  lblLogo.Caption := Format('Logo size: %d', [tbLogo.Position]);
end;

procedure TfrmMain.ApplyToSplash;
begin
  if not Assigned(FSplash) then
    Exit;
  FSplash.Title := edTitle.Text;
  FSplash.Subtitle := edSubtitle.Text;
  FSplash.Status := edStatus.Text;
  FSplash.AppVersion := edVersion.Text;
  FSplash.Copyright := edCopyright.Text;
  FSplash.Width := tbWidth.Position;
  FSplash.Height := tbHeight.Position;
  FSplash.Opacity := tbOpacity.Position;
  FSplash.CornerRadius := tbRadius.Position;
  FSplash.Progress := tbProgress.Position;
  FSplash.LogoSize := tbLogo.Position;
  FSplash.ProgressStyle := TDFSplashProgressStyle(cbProgress.ItemIndex);
  FSplash.LogoPosition := TDFSplashLogoPosition(cbLogoPos.ItemIndex);
  FSplash.Gradient := chkGradient.Checked;
  FSplash.StayOnTop := chkStayOnTop.Checked;
  FSplash.CloseOnClick := chkCloseClick.Checked;
  if cbTheme.ItemIndex <= 0 then
  begin
    FSplash.Theme := stCustom;
    FSplash.AccentColor := clAccent.Selected;
    FSplash.BackgroundColor := clBack.Selected;
    FSplash.ProgressColor := clAccent.Selected;
  end
  else
    FSplash.Theme := TDFSplashTheme(cbTheme.ItemIndex);
end;

procedure TfrmMain.ThemeChange(Sender: TObject);
var
  C: TDFSplashThemeColors;
begin
  if cbTheme.ItemIndex > 0 then
  begin
    C := DFSplashThemeColors(TDFSplashTheme(cbTheme.ItemIndex));
    clAccent.Selected := C.Accent;
    clBack.Selected := C.Background;
  end;
  ApplyToSplash;
end;

procedure TfrmMain.FieldChange(Sender: TObject);
begin
  if Sender = clAccent then
    cbTheme.ItemIndex := 0;
  if Sender = clBack then
    cbTheme.ItemIndex := 0;
  ApplyToSplash;
end;

procedure TfrmMain.TrackChange(Sender: TObject);
begin
  UpdateTrackLabels;
  ApplyToSplash;
end;

procedure TfrmMain.ShowClick(Sender: TObject);
begin
  ApplyToSplash;
  FSplash.ShowSplash;
end;

procedure TfrmMain.HideClick(Sender: TObject);
begin
  FSplash.HideSplash;
end;

procedure TfrmMain.SimClick(Sender: TObject);
const
  Steps: array[0..4] of string = (
    'Reading configuration...',
    'Connecting services...',
    'Loading modules...',
    'Preparing UI...',
    'Done');
var
  I: Integer;
begin
  ApplyToSplash;
  FSplash.ProgressStyle := psBar;
  cbProgress.ItemIndex := 0;
  FSplash.ShowSplash;
  for I := 0 to High(Steps) do
  begin
    FSplash.UpdateProgress((I + 1) * 20, Steps[I]);
    Sleep(450);
    Application.ProcessMessages;
  end;
  Sleep(350);
  FSplash.HideSplash;
end;

procedure TfrmMain.MarqueeClick(Sender: TObject);
begin
  cbProgress.ItemIndex := 1;
  ApplyToSplash;
  FSplash.ProgressStyle := psMarquee;
  FSplash.Status := 'Working...';
  FSplash.ShowSplash;
end;

procedure TfrmMain.LogoClick(Sender: TObject);
begin
  if dlgPic.Execute then
  begin
    FSplash.LoadLogo(dlgPic.FileName);
    ApplyToSplash;
  end;
end;

procedure TfrmMain.BgClick(Sender: TObject);
begin
  if dlgPic.Execute then
  begin
    FSplash.LoadBackground(dlgPic.FileName);
    ApplyToSplash;
  end;
end;

end.

# DFSplashScreen

Professional VCL splash screen component for **Delphi 10.3 Rio and later**.

- Website: [delphifan.com](https://delphifan.com)
- Email: adsdelphi@gmail.com
- Version: 1.0.0
- License: MIT

Drop `TDFSplashScreen` on a form, or create it in your `.dpr` before the main form is created. Size, colors, opacity, rounded corners, logo, background image, progress bar, and fade in/out are all published properties.

## Requirements

- Delphi 10.3 Rio or newer
- VCL (Win32 / Win64)

## Quick start (no package install)

Add these units to your project:

- `Source/DFSplashScreen.Types.pas`
- `Source/DFSplashScreen.Form.pas`
- `Source/DFSplashScreen.pas`

Then show the splash while the application starts:

```pascal
program MyApp;

uses
  Vcl.Forms,
  DFSplashScreen in 'Source\DFSplashScreen.pas',
  DFSplashScreen.Types in 'Source\DFSplashScreen.Types.pas',
  DFSplashScreen.Form in 'Source\DFSplashScreen.Form.pas',
  uMain in 'uMain.pas' {frmMain};

var
  Splash: TDFSplashScreen;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Splash := TDFSplashScreen.Create(nil);
  try
    Splash.Theme := stDark;
    Splash.Title := 'My Application';
    Splash.Subtitle := 'Loading, please wait';
    Splash.AppVersion := 'Version 1.0.0';
    Splash.Copyright := 'Copyright (c) 2026';
    Splash.Width := 520;
    Splash.Height := 300;
    Splash.Opacity := 245;        // 0..255
    Splash.CornerRadius := 16;
    Splash.ShowSplash;

    Splash.UpdateProgress(30, 'Creating forms...');
    Application.CreateForm(TfrmMain, frmMain);
    Splash.UpdateProgress(100, 'Ready');
    Splash.HideSplash;
  finally
    Splash.Free;
  end;

  Application.Run;
end.
```

## Install into the IDE (optional)

Do **not** right-click the project **group**. Install is only on the package project.

1. In Delphi: **File → Close All**.
2. **File → Open** `Packages\DFSplashScreen.dproj` (the `.dproj`, not the `.groupproj`).
3. Confirm **32-bit Windows**.
4. **Project → Options → Description → Usage** = *Designtime and runtime*.
5. Right-click `DFSplashScreen.bpl` in Project Manager.
6. Click **Install** (Turkish IDE: **Yükle**).

`TDFSplashScreen` appears on the **DF Controls** palette.

If the menu still has **Run** instead of **Install**, the file was opened as an application: close it and open `Packages\DFSplashScreen.dproj` again.

You can still create the component in code; installing is only needed for dropping it on a form at design time.

## Demo

Open `Demo/DFSplashScreenDemo.dproj`, compile, and run. The demo starts with a splash, then lets you change theme, width, height, opacity, radius, colors, logo, background image, and progress style live.

## Themes

| Theme | Description |
| --- | --- |
| `stDark` | Default dark UI |
| `stLight` | Light UI |
| `stMidnight` | GitHub-style dark blue |
| `stOcean` | Teal accent |
| `stSunset` | Warm accent |
| `stCustom` | Your own colors |

Changing a color property automatically switches the theme to `stCustom`.

## Main properties

| Property | Default | Meaning |
| --- | --- | --- |
| `Title`, `Subtitle`, `Status` | sample text | Headline and status line |
| `AppVersion`, `Copyright` | sample text | Footer |
| `Width`, `Height` | 520 x 300 | Logical size at 96 DPI (auto-scaled) |
| `Opacity` | 245 | Window transparency (0 = invisible, 255 = opaque) |
| `CornerRadius` | 16 | Rounded corners (0 = square) |
| `AccentColor` | Windows-style blue | Top bar and progress |
| `BackgroundColor`, `BackgroundAlt` | dark | Fill / gradient end |
| `TitleColor`, `TextColor` | white / gray | Text |
| `ProgressColor`, `ProgressBackColor` | accent / track | Progress bar |
| `Progress`, `ProgressMin`, `ProgressMax` | 0 / 0 / 100 | Determinate progress |
| `ProgressStyle` | `psBar` | `psBar`, `psMarquee`, `psHidden` |
| `ProgressHeight` | 4 | Bar thickness |
| `Logo`, `LogoPosition`, `LogoSize` | left / 72 | PNG, JPEG, BMP, GIF |
| `BackgroundImage`, `OverlayDarken` | empty / 80 | Full-bleed photo with dimming |
| `Gradient` | True | Vertical background gradient |
| `FadeInMs`, `FadeOutMs` | 280 / 220 | Fade animation |
| `StayOnTop` | True | Always on top |
| `CloseOnClick` | False | Click closes the splash |
| `AutoHideInterval` | 0 | Auto hide after N milliseconds (0 = off) |
| `FontName` | Segoe UI | Title and body font |

## Main methods

```pascal
Splash.ShowSplash;
Splash.UpdateStatus('Connecting...');
Splash.UpdateProgress(60, 'Loading modules...');
Splash.LoadLogo('C:\Brand\logo.png');
Splash.LoadBackground('C:\Brand\splash.jpg');
Splash.HideSplash;

Splash.Execute(
  procedure
  begin
    // your startup work
  end);
```

`UpdateProgress` and `UpdateStatus` are safe to call from a worker thread (they marshal to the main thread).

## Events

- `OnShow` — after the splash is shown
- `OnHide` — after fade-out completes
- `OnTimeout` — when `AutoHideInterval` elapses

## Tips

- Call `ShowSplash` **before** `Application.CreateForm` so users see feedback during a slow startup.
- `HideSplash` waits for the fade-out, so it is safe to `Free` immediately afterwards in the `.dpr`.
- Prefer PNG logos with transparency.
- Values for width, height, radius, and logo size are specified at 96 DPI and scaled for the current monitor.

## Folder layout

```
Source/     Component units
Packages/   Design-time package (Install)
Demo/       Interactive demo
```

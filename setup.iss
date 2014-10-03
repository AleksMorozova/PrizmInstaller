;contribute on github.com/stfx/innodependencyinstaller or codeproject.com/Articles/20868/NET-Framework-1-1-2-0-3-5-Installer-for-InnoSetup

;comment out product defines to disable installing them
#define use_dotnetfx40

#define use_sql2008express

#define MyAppSetupName 'SetupPrism'
#define MyAppVersion '0.0.0.4'

[Setup]
AppName={#MyAppSetupName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppSetupName} {#MyAppVersion}
AppCopyright=Copyright ©
VersionInfoVersion={#MyAppVersion}
VersionInfoCompany=ISD
AppPublisher=ISD
;AppPublisherURL=http://...
;AppSupportURL=http://...
;AppUpdatesURL=http://...
OutputBaseFilename={#MyAppSetupName}-{#MyAppVersion}
DefaultGroupName={#MyAppSetupName}
DefaultDirName={pf}\{#MyAppSetupName}
UninstallDisplayIcon={app}\MyProgram.exe
OutputDir=bin
SourceDir=.
AllowNoIcons=yes
;SetupIconFile=MyProgramIcon
SolidCompression=yes

;MinVersion default value: "0,5.0 (Windows 2000+) if Unicode Inno Setup, else 4.0,4.0 (Windows 95+)"
;MinVersion=0,5.0
PrivilegesRequired=admin
ArchitecturesAllowed=x86 x64 ia64
ArchitecturesInstallIn64BitMode=x64 ia64

;Downloading and installing dependencies will only work if the memo/ready page is enabled (default behaviour)
DisableReadyPage=no
DisableReadyMemo=no
AppId={{425E1CD6-2635-4DF7-A04B-FF93B681585C}
LicenseFile=D:\GDrive\GIT\PrismSetup\lic.txt
InfoBeforeFile=D:\GDrive\GIT\PrismSetup\before.txt
InfoAfterFile=D:\GDrive\GIT\PrismSetup\after.txt
Compression=lzma2/ultra
MinVersion=0,5.01

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "de"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "D:\GDrive\GIT\PrismSetup\src\prizm.exe"; DestDir: "{app}"; DestName: "prizm.exe"

[Icons]
Name: "{group}\{#MyAppSetupName}"; Filename: "{app}\prizm.exe"
Name: "{group}\{cm:UninstallProgram,{#MyAppSetupName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppSetupName}"; Filename: "{app}\prizm.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppSetupName}"; Filename: "{app}\prizm.exe"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\prizm.exe"; Description: "{cm:LaunchProgram,{#MyAppSetupName}}"; Flags: nowait postinstall skipifsilent

#include "scripts\products.iss"

#include "scripts\products\stringversion.iss"
#include "scripts\products\winversion.iss"
#include "scripts\products\fileversion.iss"
#include "scripts\products\dotnetfxversion.iss"

#ifdef use_msi45
#include "scripts\products\msi45.iss"
#endif

#ifdef use_sql2008express
#include "scripts\products\sql2008express.iss"
#endif

[CustomMessages]
win_sp_title=Windows %1 Service Pack %2


[Code]
function InitializeSetup(): boolean;
begin
	//init windows version
	initwinversion();

#ifdef use_msi45
	msi45('4.5');
#endif

#ifdef use_dotnetfx45
    //dotnetfx45(2); // min allowed version is .netfx 4.5.2
    dotnetfx45(0); // min allowed version is .netfx 4.5.0
#endif

#ifdef use_sql2008express
	sql2008express();
#endif

	Result := true;
end;

program SynEdit;

{%ToDo 'SynEdit.todo'}

uses
  Forms,
  FrmMain in 'FrmMain.pas' {FormMain},
  UnitSyntaxMemo in 'UnitSyntaxMemo.pas',
  FrmDebug in 'FrmDebug.pas' {FormDebug},
  FrmAbout in 'FrmAbout.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.Name := 'MPSyntaxDempApp';
  Application.Title := 'MPSyntax Demo';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormDebug, FormDebug);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.

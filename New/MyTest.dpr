program MyTest;

uses
  Forms,
  main in 'main.pas' {Form1},
  UnitSyntaxMemo in 'UnitSyntaxMemo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

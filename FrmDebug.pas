unit FrmDebug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, UnitSyntaxMemo, CheckLst;

type
    TFormDebug = class(TForm)
        Pages           : TPageControl;
        PageUndo        : TTabSheet;
        PageSections    : TTabSheet;
        PageOptions     : TTabSheet;
        PageLog         : TTabSheet;
        CheckUndoList   : TCheckBox;
        LabelUndoCount  : TLabel;
        LabelUndoSize   : TLabel;
        ListUndo        : TListView;
        BtnSections     : TButton;
        MemoSections    : TMemo;
        MemoLog         : TMemo;
        CheckLog        : TCheckBox;
        CheckSaveLog    : TCheckBox;
        ListOptions     : TCheckListBox;
        procedure       CheckUndoListClick(Sender: TObject);
        procedure       BtnSectionsClick(Sender: TObject);
        procedure       FormDestroy(Sender: TObject);
        procedure       ListOptionsClickCheck(Sender: TObject);
    private
        fLogCount       : Integer;
    public
        procedure       RefreshUndoList;
        procedure       UpdateOptions;
        procedure       Log(const s: string);
    end;

var FormDebug: TFormDebug;

implementation

{$R *.dfm}
uses FrmMain;

{ TFormDebug }


// Обновляет список отката
procedure TFormDebug.RefreshUndoList;
var i, size: Integer;
const pm: array [Boolean] of Char = ('-', '+');
begin
    if not Assigned(self) or not Assigned(FormMain.Memo) then Exit;
    if CheckUndoList.Checked then begin
        ListUndo.Items.BeginUpdate;
        ListUndo.Items.Clear;
        size := 0;
        for i := FormMain.Memo.Range.UndoStack.Count - 1 downto 0 do
            with ListUndo.Items.Add, TMPSynMemoUndoItem(FormMain.Memo.Range.UndoStack[i]) do begin
                Caption := IntToStr(i);
                SubItems.Append( Format('%d,%d', [uiCaretPos.X, uiCaretPos.Y]) );
                SubItems.Append( Format('%d,%d', [uiSelStart.X, uiSelStart.Y]) );
                SubItems.Append( Format('%d,%d', [uiSelEnd.X,   uiSelEnd.Y]) );
                SubItems.Append( pm[uiSealing] );
                SubItems.Append( '"' + Copy(uiText, 1, 32) + '"' );
                SubItems.Append( IntToHex(Integer(uiSections), 6) );
                SubItems.Append( IntToStr(uiSections.RefCount) );
                Inc(size, SizeOf(TMPSynMemoUndoItem) + Length(uiText));
            end;
        ListUndo.Items.EndUpdate;
        LabelUndoCount.Caption := Format('Stack depth = %d', [FormMain.Memo.Range.UndoStack.Count]);
        LabelUndoSize.Caption  := Format('Size = %.1fkB', [size / 1024]);
    end;
end;


// Изменение статуса слежения за буфером отката
procedure TFormDebug.CheckUndoListClick(Sender: TObject);
begin
    if CheckUndoList.Checked then begin
        LabelUndoCount.Enabled  := True;
        LabelUndoSize.Enabled   := True;
        ListUndo.Enabled        := True;
        RefreshUndoList;
    end else begin
        LabelUndoCount.Enabled  := False;
        LabelUndoSize.Enabled   := False;
        ListUndo.Enabled        := False;
    end;
end;


// Обновить информацию о секциях текста
procedure TFormDebug.BtnSectionsClick(Sender: TObject);
begin
    MemoSections.Text := FormMain.Memo.Sections.AsText;
end;


// Добавляет строку в лог отладки
procedure TFormDebug.Log(const s: string);
begin
    if not Assigned(self) or not CheckLog.Checked then Exit;
    if fLogCount = 0 then begin
        MemoLog.Clear;
        MemoLog.Lines.Append('Log Begin at ' + DateTimeToStr(Now));
    end;
    MemoLog.Lines.Append(Format('%.6d %s', [fLogCount, s]));
    Inc(fLogCount);
end;


// Прерывание от деструктора
procedure TFormDebug.FormDestroy(Sender: TObject);
begin
    if CheckSaveLog.Checked then begin
        MemoLog.Lines.Append('Log Finished at ' + DateTimeToStr(Now));
        MemoLog.Lines.SaveToFile(ChangeFileExt(ParamStr(0), '.log'));
    end;
end;


// Обновление списка опций редактора
procedure TFormDebug.UpdateOptions;
var oi: TMPSynMemoOption;
begin
    if not Assigned(self) then Exit;
    for oi := Low(TMPSynMemoOption) to High(TMPSynMemoOption) do
        ListOptions.Checked[Ord(oi)] := oi in FormMain.Memo.Options;
end;


// Изменение опции редатора
procedure TFormDebug.ListOptionsClickCheck(Sender: TObject);
var oi: TMPSynMemoOption;
    os: TMPSynMemoOptions;
begin
    os := [];
    for oi := Low(TMPSynMemoOption) to High(TMPSynMemoOption) do
        if ListOptions.Checked[Ord(oi)] then
            Include(os, oi);
    FormMain.Memo.Options := os;
end;

end.

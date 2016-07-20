unit FrmMain;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
    Dialogs, UnitSyntaxMemo, ComCtrls, ExtCtrls, ToolWin, ActnMan,
    ActnCtrls, ActnMenus, ActnList, XPStyleActnCtrls, Menus, ImgList,
    AppEvnts, Contnrs, StdCtrls;

type
    TFormMain = class(TForm)
        Status          : TStatusBar;
        Actions         : TActionManager;
        ActFileNew      : TAction;
        ActFileOpen     : TAction;
        ActFileSave     : TAction;
        ActFileSaveAs   : TAction;
        ActFileClose    : TAction;
        ActCloseAll     : TAction;
        ActSaveAll      : TAction;
        ActExit         : TAction;
        ActSelAll       : TAction;
        ActSelStart     : TAction;
        ActSelEnd       : TAction;
        ActSelDelete    : TAction;
        ActAbout        : TAction;
        MainMenu        : TActionMainMenuBar;
        Pages           : TPageControl;
        PopUp           : TPopupMenu;
        ActClosePage    : TAction;
        ActBrowse       : TAction;
        ActTopic        : TAction;
        ActReadOnly     : TAction;
        ActSettings     : TAction;
        ActOpenInvoke   : TAction;
        Closepage1      : TMenuItem;
        N1              : TMenuItem;
        Browseword1     : TMenuItem;
        Openfileatcursor1: TMenuItem;
        opicsearch1     : TMenuItem;
        N2              : TMenuItem;
        Copy1           : TMenuItem;
        Cut1            : TMenuItem;
        Paste1          : TMenuItem;
        N3              : TMenuItem;
        Readonly1       : TMenuItem;
        Settings1       : TMenuItem;
        Tree            : TTreeView;
        Splitter1       : TSplitter;
        Panel1          : TPanel;
        ActCopy         : TAction;
        ActCut          : TAction;
        ActPaste        : TAction;
        ActUndo         : TAction;
        ActDebugWindow  : TAction;
        ActExportRTF    : TAction;
        ActFont         : TAction;
        Images          : TImageList;
        Events          : TApplicationEvents;
        OpenDialog      : TOpenDialog;
        SaveDialog      : TSaveDialog;
        FontDialog      : TFontDialog;
        ActRecent1      : TAction;
        ActRecent2      : TAction;
        ActRecent3      : TAction;
        ActRecent4      : TAction;
        ActRecent5      : TAction;
        ActSyntaxExport : TAction;
        ActSyntaxImport : TAction;
    PanelWordInfo: TPanel;
    LabelWordInfo: TLabel;
    MemoWInfo: TMemo;
        procedure       EventsIdle(Sender: TObject; var Done: Boolean);
        procedure       FormCreate(Sender: TObject);
        procedure       FormDestroy(Sender: TObject);
        procedure       FormActivate(Sender: TObject);
        procedure       FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure       ActFileNewExecute(Sender: TObject);
        procedure       ActFileOpenExecute(Sender: TObject);
        procedure       ActFileSaveExecute(Sender: TObject);
        procedure       ActSaveAllExecute(Sender: TObject);
        procedure       ActFileSaveAsExecute(Sender: TObject);
        procedure       ActFileCloseExecute(Sender: TObject);
        procedure       ActCloseAllExecute(Sender: TObject);
        procedure       ActExitExecute(Sender: TObject);
        procedure       ActClosePageExecute(Sender: TObject);
        procedure       ActReadOnlyExecute(Sender: TObject);
        procedure       ActSettingsExecute(Sender: TObject);
        procedure       ActCopyExecute(Sender: TObject);
        procedure       ActCutExecute(Sender: TObject);
        procedure       ActPasteExecute(Sender: TObject);
        procedure       ActUndoExecute(Sender: TObject);
        procedure       ActSelAllExecute(Sender: TObject);
        procedure       ActSelStartExecute(Sender: TObject);
        procedure       ActSelEndExecute(Sender: TObject);
        procedure       ActDebugWindowExecute(Sender: TObject);
        procedure       ActAboutExecute(Sender: TObject);
        procedure       ActExportRTFExecute(Sender: TObject);
        procedure       ActFontExecute(Sender: TObject);
        procedure       TreeDblClick(Sender: TObject);
        procedure       ActRecentExecute(Sender: TObject);
        procedure       ActSyntaxExportExecute(Sender: TObject);
        procedure       ActSyntaxImportExecute(Sender: TObject);
        procedure       EventsException(Sender: TObject; E: Exception);
        procedure       EventsHint(Sender: TObject);
    private
        fMemo           : TMPSyntaxMemo;
        fDelphiKeyWords : TStringList;
        fNavigateRow    : Integer;
        fMemos          : TObjectList;
        fRecentActions  : array [1..5] of TAction;
        function        GetMemos(const MemoIndex: Integer): TMPSyntaxMemo;
        procedure       MemoChanged(Sender: TObject; ChangedItems: TChangedItems);
        procedure       MemoWordInfo(Sender: TMPCustomSyntaxMemo; const X, Y, WordIndex, Row: Integer; Showing: Boolean);
        procedure       UpdateSectionsInfo;
        procedure       UserToken(Sender: TObject; Word: string; Pos, Line: Integer; var Token: TToken);
        procedure       LoadPascalUnit(const PasFile: string);
        procedure       DoLog(Sender: TObject; s: string);
        procedure       PageShow(Sender: TObject);
        // Операции с файлами
        procedure       SetActiveMemo(const TheMemo: TMPSyntaxMemo); overload;
        procedure       SetActiveMemo(const MemoIndex: Integer); overload;
        procedure       CreateNewMemo;
        function        LoadFile(FileName: string = ''): Boolean;
        function        SaveFile: Boolean;
        function        SaveFileWithNewName: Boolean;
        function        SaveAll: Boolean;
        function        CloseFile: Boolean;
        function        CloseAll: Boolean;
        procedure       SaveAsRTF(const FileName: string);
        function        AddRecent(const s: string): string;
    protected
        procedure       UpdateActions; override;
        // История вопроса
        procedure       LoadInits; virtual;
        procedure       SaveInits; virtual;
    public
        property        Memo: TMPSyntaxMemo read fMemo write fMemo;
        property        Memos[const MemoIndex: Integer]: TMPSyntaxMemo read GetMemos;
    end;

var FormMain: TFormMain;

implementation

{$R *.dfm}
uses Clipbrd, StrUtils, Math, FrmDebug, FrmAbout, IniFiles;

const
    tokKeyWord          = tokUser;
    tokUnit             = tokUser - 1;
    tokInterface        = tokUser - 2;
    tokImplement        = tokUser - 3;
    tokClass            = tokUser - 4;
    tokBegin            = tokUser - 5;
    tokEnd              = tokUser - 6;
    tokProcedure        = tokUser - 7;
    tokFunction         = tokProcedure;
    tokInit             = tokUser - 8;
    tokFinal            = tokUser - 9;
    tokResult           = tokUser - 100;


// Прерывание от конструктора формы
procedure TFormMain.FormCreate(Sender: TObject);
begin
    LoadInits;
    fDelphiKeyWords := TStringList.Create;
    with fDelphiKeyWords do begin
        Sorted := True;
        AddObject('and', TObject(tokKeyWord));              //  Boolean and or bitwise and of two arguments
        AddObject('array', TObject(tokKeyWord));            //  A data type holding indexable collections of data
        AddObject('as', TObject(tokKeyWord));               //  Used for casting object references
        AddObject('begin', TObject(tokBegin));              //  Keyword that starts a statement block
        AddObject('case', TObject(tokBegin));               //  A mechanism for acting upon different values of an Ordinal
        AddObject('class', TObject(tokClass));              //  Starts the declaration of a type of object class
        AddObject('const', TObject(tokKeyWord));            //  Starts the definition of fixed data values
        AddObject('constructor', TObject(tokProcedure));    //  Defines the method used to create an object from a class
        AddObject('destructor', TObject(tokProcedure));     //  Defines the method used to destroy an object
        AddObject('div', TObject(tokKeyWord));              //  Performs integer division, discarding the remainder
        AddObject('do', TObject(tokKeyWord));               //  Defines the start of some controlled action
        AddObject('downto', TObject(tokKeyWord));           //  Prefixes an decremental for loop target value
        AddObject('else', TObject(tokKeyWord));             //  Starts false section of if, case and try statements
        AddObject('end', TObject(tokEnd));                  //  Keyword that terminates statement blocks
        AddObject('except', TObject(tokKeyWord));           //  Starts the error trapping clause of a Try statement
        AddObject('file', TObject(tokKeyWord));             //  Defines a typed or untyped file
        AddObject('finalization', TObject(tokFinal));
        AddObject('finally', TObject(tokKeyWord));          //  Starts the unconditional code section of a Try statement
        AddObject('for', TObject(tokKeyWord));              //  Starts a loop that executes a finite number of times
        AddObject('function', TObject(tokFunction));        //  Defines a subroutine that returns a value
        AddObject('goto', TObject(tokKeyWord));             //  Forces a jump to a label, regardless of nesting
        AddObject('if', TObject(tokKeyWord));               //  Starts a conditional expression to determine what to do next
        AddObject('implementation', TObject(tokImplement)); //  Starts the implementation (code) section of a Unit
        AddObject('in', TObject(tokKeyWord));               //  Used to test if a value is a member of a set
        AddObject('inherited', TObject(tokKeyWord));        //  Used to call the parent class constructor or destructor method
        AddObject('initialization', TObject(tokInit));
        AddObject('interface', TObject(tokInterface));      //  Used for Unit external definitions, and as a Class skeleton
        AddObject('is', TObject(tokKeyWord));               //  Tests whether an object is a certain class or ascendant
        AddObject('mod', TObject(tokKeyWord));              //  Performs integer division, returning the remainder
        AddObject('nil', TObject(tokKeyWord));              //  Nil constant
        AddObject('not', TObject(tokKeyWord));              //  Boolean Not or bitwise not of one arguments
        AddObject('object', TObject(tokKeyWord));           //  Allows a subroutine data type to refer to an object method
        AddObject('of', TObject(tokKeyWord));               //  Linking keyword used in many places
        AddObject('on', TObject(tokKeyWord));               //  Defines exception handling in a Try Except clause
        AddObject('or', TObject(tokKeyWord));               //  Boolean or or bitwise or of two arguments
        AddObject('packed', TObject(tokKeyWord));           //  Compacts complex data types into minimal storage
        AddObject('private', TObject(tokKeyWord));          //
        AddObject('procedure', TObject(tokProcedure));      //  Defines a subroutine that does not return a value
        AddObject('program', TObject(tokKeyWord));          //  Defines the start of an application
        AddObject('property', TObject(tokKeyWord));         //  Defines controlled access to class fields
        AddObject('protected', TObject(tokKeyWord));        //
        AddObject('public', TObject(tokKeyWord));           //
        AddObject('published', TObject(tokKeyWord));        //
        AddObject('raise', TObject(tokKeyWord));            //  Raise an exception
        AddObject('record', TObject(tokKeyWord));           //  A structured data type - holding fields of data
        AddObject('repeat', TObject(tokKeyWord));           //  Repeat statements until a ternmination condition is met
        AddObject('resourcestring', TObject(tokKeyWord));   //  Resource string set
        AddObject('result', TObject(tokResult));            //  Function result word
        AddObject('set', TObject(tokKeyWord));              //  Defines a set of up to 255 distinct values
        AddObject('shl', TObject(tokKeyWord));              //  Shift an integer value left by a number of bits
        AddObject('shr', TObject(tokKeyWord));              //  Shift an integer value right by a number of bits
        AddObject('string', TObject(tokKeyWord));           //  String type
        AddObject('then', TObject(tokKeyWord));             //  Part of an if statement - starts the true clause
        AddObject('threadvar', TObject(tokKeyWord));        //  Defines variables that are given separate instances per thread
        AddObject('to', TObject(tokKeyWord));               //  Prefixes an incremental for loop target value
        AddObject('try', TObject(tokBegin));                //  Starts code that has error trapping
        AddObject('type', TObject(tokKeyWord));             //  Defines a new category of variable or process
        AddObject('unit', TObject(tokUnit));                //  Defines the start of a unit file - a Delphi module
        AddObject('until', TObject(tokKeyWord));            //  Ends a Repeat control loop
        AddObject('uses', TObject(tokKeyWord));             //  Declares a list of Units to be imported
        AddObject('var', TObject(tokKeyWord));              //  Starts the definition of a section of data variables
        AddObject('while', TObject(tokKeyWord));            //  Repeat statements whilst a continuation condition is met
        AddObject('with', TObject(tokKeyWord));             //  A means of simplifying references to structured variables
        AddObject('xor', TObject(tokKeyWord));              //  Xor bitwise operation
    end;
end;


// Прерывание от деструктора формы
procedure TFormMain.FormDestroy(Sender: TObject);
begin
    fMemos.Free;
    fDelphiKeyWords.Free;
    SaveInits;
end;


// Прерывание от активизации окна
procedure TFormMain.FormActivate(Sender: TObject);
begin
    if not Assigned(Memo) then Exit;
    Memo.SetFocus;
end;


// Экспортирует текст в формате RTF
procedure TFormMain.ActExportRTFExecute(Sender: TObject);
begin
    SaveDialog.Filter := 'RTF files (*.rtf)|*.rtf|All files (*.*)|*.*';
    SaveDialog.FilterIndex := 0;
    if SaveDialog.Execute then
        SaveAsRTF(SaveDialog.FileName);
end;


// После загрузки приложения, загрузим в него текст и посмотрим.. ;)
procedure TFormMain.EventsIdle(Sender: TObject; var Done: Boolean);
var s: string;
begin
    Events.OnIdle := nil;
    FormDebug.CheckLog.Checked := True;
    FormDebug.CheckSaveLog.Checked := True;
    CreateNewMemo;
    s := ExtractFilePath(Application.ExeName) + 'UnitSyntaxMemo.pas';
    if FileExists (s) then
        LoadPascalUnit (s);
end;


// Переключатель "только чтение"
procedure TFormMain.ActReadOnlyExecute(Sender: TObject);
begin
    if ActReadOnly.Checked
        then Memo.Options := Memo.Options + [smoReadOnly]
        else Memo.Options := Memo.Options - [smoReadOnly];
end;


// Выбор шрифта редактора
procedure TFormMain.ActFontExecute(Sender: TObject);
begin
    FontDialog.Font := Memo.Font;
    if FontDialog.Execute then
        Memo.Font := FontDialog.Font;
end;


// Запрос на закрытие формы
procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose := CloseAll;
end;


// Загружает Recent
procedure TFormMain.ActRecentExecute(Sender: TObject);
begin
    if TAction(Sender).Caption <> '' then
        LoadFile(TAction(Sender).Caption);
end;


procedure TFormMain.ActExitExecute(Sender: TObject);        begin Close end;
procedure TFormMain.ActFileNewExecute(Sender: TObject);     begin CreateNewMemo end;
procedure TFormMain.ActFileOpenExecute(Sender: TObject);    begin LoadFile end;
procedure TFormMain.ActFileSaveExecute(Sender: TObject);    begin SaveFile end;
procedure TFormMain.ActFileSaveAsExecute(Sender: TObject);  begin SaveFileWithNewName end;
procedure TFormMain.ActSaveAllExecute(Sender: TObject);     begin SaveAll end;
procedure TFormMain.ActFileCloseExecute(Sender: TObject);   begin CloseFile end;
procedure TFormMain.ActCloseAllExecute(Sender: TObject);    begin CloseAll end;
procedure TFormMain.ActClosePageExecute(Sender: TObject);   begin CloseFile end;
procedure TFormMain.ActSettingsExecute(Sender: TObject);    begin ActDebugWindow.Execute end;
procedure TFormMain.ActCopyExecute(Sender: TObject);        begin Memo.Range.CopyToClipboard end;
procedure TFormMain.ActCutExecute(Sender: TObject);         begin Memo.Range.CutToClipBoard end;
procedure TFormMain.ActPasteExecute(Sender: TObject);       begin Memo.Range.PasteFromClipboard end;
procedure TFormMain.ActUndoExecute(Sender: TObject);        begin Memo.Range.DoUndo end;
procedure TFormMain.ActSelAllExecute(Sender: TObject);      begin Memo.Range.SelectAll end;
procedure TFormMain.ActSelStartExecute(Sender: TObject);    begin Memo.Range.SelectFromStart end;
procedure TFormMain.ActSelEndExecute(Sender: TObject);      begin Memo.Range.SelectToEnd end;
procedure TFormMain.ActAboutExecute(Sender: TObject);       begin AboutBox.ShowModal end;


// Изменение параметров текущего редактора
procedure TFormMain.MemoChanged(Sender: TObject; ChangedItems: TChangedItems);
const ChangedModeStr: array [Boolean] of string = ('', 'Modified');
      InsertModeStr:  array [Boolean] of string = ('Insert', 'Overwrite');
begin
    if ciText in ChangedItems then
        Status.Panels[1].Text := ChangedModeStr[Memo.Lines.Modified];
    if ciSelection in ChangedItems then
        Status.Panels[0].Text := Format('%d:%d', [Memo.Range.PosX + 1, Memo.Range.PosY + 1]);
    if ciSections in ChangedItems then
        UpdateSectionsInfo;
    if ciUndoStack in ChangedItems then begin
        ActUndo.Enabled := Memo.Range.CanUndo;
        FormDebug.RefreshUndoList;
    end;
    if ciOptions in ChangedItems then begin
        Status.Panels[2].Text := InsertModeStr[smoOverwrite in Memo.Options];
        ActReadOnly.Checked := smoReadOnly in Memo.Options;
        FormDebug.UpdateOptions;
    end;
end;


// Определение типа токена (Pascal Keywords Analize)
procedure TFormMain.UserToken(Sender: TObject; Word: string; Pos, Line: Integer; var Token: TToken);
var n: Integer;
begin
    if fDelphiKeyWords.Find(LowerCase(Word), n) then
        Token := TToken(fDelphiKeyWords.Objects[n]);
end;


// Щелчок по заголовку секции в навигаторе -
// - переход к соответствующей строке редактора
procedure TFormMain.TreeDblClick(Sender: TObject);
var Node: TTreeNode;
begin
    Node := Tree.Selected;
    if Node <> nil then begin
        fNavigateRow := Integer(Node.Data);
        Memo.Navigate(0, fNavigateRow);
        Memo.SetFocus;
    end;
end;


// Лог отладки
procedure TFormMain.DoLog(Sender: TObject; s: string);
begin
    FormDebug.Log(s);
end;


// Изменение секций редактора
procedure TFormMain.UpdateSectionsInfo;
var Sec: TMPSynMemoSection;
    Root, SelNode: TTreeNode;
    {}
    procedure ProcessNode(Node: TTreeNode; Section: TMPSynMemoSection);
    var i: Integer;
        NestedNode: TTreeNode;
    begin
        with Section do begin
            // Обрабатываем переданную секцию
            i := EnsureRange(RowBeg, 0, Memo.Lines.Count - 1);
            Node.Text := ifThen(Memo.Lines[i] = '', '<empty>', Trim(Memo.Lines[i]));
            Node.Data := Pointer(i);
            if RowBeg = fNavigateRow then
                SelNode := Node;
            // Обрабатываем вложенные секции
            for i := 0 to Count - 1 do begin
                NestedNode := Tree.Items.AddChild(Node, '');
                ProcessNode(NestedNode, Sections[i]);
            end;
            // Свернуть/развернуть секцию
            Node.Expanded := not Collapsed;
            if Count = 0
                then Node.ImageIndex := 2
                else
                if Collapsed
                    then Node.ImageIndex := 0
                    else Node.ImageIndex := 1;
        end;
    end;
    {}
begin
    Tree.Items.BeginUpdate;
    Tree.Items.Clear;
    Root := Tree.Items.AddChild(nil, '');
    Sec := Memo.Sections.EntireSection;
    SelNode := nil;
    if Sec.Count > 0 then
        ProcessNode(Root, Sec);
    Tree.Items.EndUpdate;
    Tree.Selected := SelNode;
end;


// Загрузка текста Delphi
procedure TFormMain.LoadPascalUnit(const PasFile: string);
label NeedExit;
var Rows: array[tokFinal..tokUnit] of Integer;
    Row, i, BlockLevel: Integer;
    ProcedureStack: TStack;
    tok: TToken;
begin
    // Загружаем текст
    Memo.Lines.LoadFromFile(PasFile);

    Memo.Lines.BeginUpdate;
    // Обрабатываем текст
    ProcedureStack := TStack.Create;
    for tok := Low(Rows) to High(Rows) do Rows[tok] := -1;
    BlockLevel := 0;
    // Обрабатываем каждую строку загруженного текста
    for Row := 0 to Memo.Lines.Count - 1 do
        with Memo.Lines.Parser[Row] do
            // В каждой строке обрабатываем каждое слово
            for i := 0 to Count - 1 do
                case Tokens[i].stToken of
                // Секция модуля - весь код до <end.>
                tokUnit:
                    Rows[tokUnit] := Row;

                // Секция объявления интерфейса модуля или просто интерфейса
                tokInterface:
                    if (Rows[tokInterface] >= 0) and ((i = Count - 1) or (Tokens[i+1].stToken <> tokEndLine)) then begin
                        Rows[tokClass] := Row;
                        BlockLevel := 1;
                    end else
                        Rows[tokInterface] := Row;

                // Секция реализации интерфейса модуля
                tokImplement:
                    begin
                        Rows[tokImplement] := Row;
                        if Rows[tokImplement] > Rows[tokInterface] + 1 then
                            Memo.Sections.New(Rows[tokInterface], Row - 1);
                    end;

                // Секция загрузки модуля
                tokInit:
                    begin
                        Rows[tokInit] := Row;
                        if Rows[tokInit] > Rows[tokImplement] + 1 then
                            Memo.Sections.New(Rows[tokImplement], Row - 1);
                    end;

                // Секция выгрузки модуля
                tokFinal:
                    begin
                        Rows[tokFinal] := Row;
                        if Rows[tokInit] >= 0 then begin
                            if Rows[tokFinal] > Rows[tokInit] + 1 then
                                Memo.Sections.New(Rows[tokInit], Row - 1);
                        end else
                        if Rows[tokImplement] >= 0 then begin
                            if Rows[tokFinal] > Rows[tokImplement] + 1 then
                                Memo.Sections.New(Rows[tokImplement], Row - 1);
                        end;
                    end;

                // Секция описания класса (не Forward)
                tokClass:
                    // Убеждаемся, что это не Forward Declaration, и что это не Class Function
                    if (Rows[tokClass] = -1) and ((i = Count - 1) or (Tokens[i+1].stToken <> tokEndLine)) then begin
                        Rows[tokClass] := Row;
                        BlockLevel := 1;
                    end;

                // Реализация процедуры или функции - только в секции Implementation, первое слово в строке
                tokProcedure:
                    if (Rows[tokImplement] >= 0) and (i = 0) and (BlockLevel = 0) then begin
                        if Rows[tokProcedure] >= 0 then
                            ProcedureStack.Push(Pointer(Rows[tokProcedure]));
                        Rows[tokProcedure] := Row;
                    end;

                // Начало блока программы
                tokBegin:
                    if Rows[tokProcedure] >= 0 then
                        Inc(BlockLevel);

                // Окончание блока программы
                tokEnd:
                    // Завершения объявления класса или интерфейса
                    if Rows[tokClass] >= 0 then begin
                        if Row > Rows[tokClass] then
                            Memo.Sections.New(Rows[tokClass], Row, True);
                        Rows[tokClass] := -1;
                        BlockLevel := 0;
                    end else
                    // Завершения модуля
                    if (Rows[tokUnit] >= 0) and (BlockLevel = 0) and (i < Count - 1) and (Tokens[i+1].stToken = tokPoint) then begin
                        if Rows[tokFinal] >= 0 then begin
                            if Row > Rows[tokFinal] + 1 then
                                Memo.Sections.New(Rows[tokFinal], Row - 1);
                        end else
                        if Rows[tokInit] >= 0 then begin
                            if Row > Rows[tokInit] + 1 then
                                Memo.Sections.New(Rows[tokInit], Row - 1);
                        end else
                        if Rows[tokImplement] >= 0 then begin
                            if Row > Rows[tokImplement] + 1 then
                                Memo.Sections.New(Rows[tokImplement], Row - 1);
                        end else
                        if Rows[tokInterface] >= 0 then begin
                            if Row > Rows[tokInterface] + 1 then
                                Memo.Sections.New(Rows[tokInterface], Row - 1);
                        end;
                        Memo.Sections.New(Rows[tokUnit], Row);
                        goto NeedExit;
                    end else
                    // Завершение внутреннего блока текста
                    if Rows[tokProcedure] >= 0 then begin
                        Dec(BlockLevel);
                        if BlockLevel = 0 then begin
                            if Row > Rows[tokProcedure] then
                                Memo.Sections.New(Rows[tokProcedure], Row, True);
                            if ProcedureStack.AtLeast(1)
                                then Rows[tokProcedure] := Integer(ProcedureStack.Pop)
                                else Rows[tokProcedure] := -1;
                        end;
                    end;
                end;
NeedExit:
    ProcedureStack.Free;
    Memo.Lines.EndUpdate;
    Memo.Lines.Modified := False;
end;


// Показать/скрыть окно отладки
procedure TFormMain.ActDebugWindowExecute(Sender: TObject);
begin
    FormDebug.Visible := ActDebugWindow.Checked;
end;


// Устанавливает текущим заданный редактор (по объекту)
procedure TFormMain.SetActiveMemo(const TheMemo: TMPSyntaxMemo);
begin
    Memo := TheMemo;
    if Memo <> nil then begin
        MemoChanged(Memo, [ciText, ciSelection, ciSections, ciUndoStack, ciOptions]);
        Memo.SetFocus;
    end else
        Tree.Items.Clear;
end;


// Устанавливает текущим заданный редактор (по индексу)
procedure TFormMain.SetActiveMemo(const MemoIndex: Integer);
begin
    if InRange(MemoIndex, 0, fMemos.Count - 1)
        then SetActiveMemo(Memos[MemoIndex])
        else SetActiveMemo(nil);
end;


// Создает новое окно редактора
procedure TFormMain.CreateNewMemo;
var Page: TTabSheet;
    E: TMPSyntaxMemo;
begin
    Page := TTabSheet.Create(Pages);
    Page.PageControl := Pages;
    E := TMPSyntaxMemo.Create(Page);
    with E do begin
        Parent          := Page;
        Font.Assign(Self.Font);
        Align           := alClient;
        Color           := clWindow;
        Options         := [smoShowFileNameInTabSheet,
                            smoShowFileNameInFormCaption,
                            smoAutoGutterWidth];
        OnWordInfo      := Self.MemoWordInfo;
        OnChange        := Self.MemoChanged;
        OnLog           := DoLog;

        { User tokens }
        with SyntaxAttributes do begin
            FontColor[tokKeyWord] := clBlack;
            FontStyle[tokKeyWord] := [fsBold, fsUnderline];
            FontColor[tokResult]  := clBlue;
            CopyAttrs(tokKeyWord, [tokUnit, tokInterface, tokImplement, tokClass, tokBegin, tokEnd, tokProcedure, tokInit, tokFinal]);
            OnUserToken := Self.UserToken;
        end;
    end;
    if fMemos = nil then
        fMemos := TObjectList.Create(True);
    fMemos.Add(E);
    Page.OnShow := PageShow;
    Pages.ActivePage := Page;
    SetActiveMemo(E);
end;


// Открывает в редакторе новый файл на новой странице
// Возвращает False, если операция прервана пользователем
function TFormMain.LoadFile(FileName: string = ''): Boolean;
var i: Integer;
begin
    Result := False;
    if FileName = '' then begin
        if not OpenDialog.Execute then Exit;
        FileName := OpenDialog.FileName;
    end;

    Result := True;
    // Проверяем, не открыт ли уже этот файл
    for i := 0 to fMemos.Count - 1 do
        if Memos[i].Lines.FileName = FileName then begin
            // Если открыт - активизируем окно с этим файлом и все, пожалуй
            SetActiveMemo(i);
            Exit;
        end;
    // Создаем новое окно редактора
    CreateNewMemo;
    // В зависимости от расширения файла, грузим его соответствующим образом
    if LowerCase(ExtractFileExt(FileName)) = '.pas' then
        LoadPascalUnit(FileName)
    else
        Memo.Lines.LoadFromFile(FileName);
    // Обновляем информацию о тексте
    SetActiveMemo(fMemos.Count - 1);
    // Запоминаем открытый файл
    AddRecent(FileName);
end;


// Попытка сохранить файл
// Возвращается False, если действие было прервано пользователем
function TFormMain.SaveFile: Boolean;
begin
    Result := not Memo.Lines.VirtualFileName;
    if not Result then
        Result := SaveFileWithNewName
    else
        Memo.Lines.SaveToFile(Memo.Lines.FileName);
end;


// Сохраняет файл с новым именем
function TFormMain.SaveFileWithNewName: Boolean;
begin
    SaveDialog.Filter := 'Delphi units (*.pas)|*.pas|Text files (*.txt)|*.txt|All files (*.*)|*.*';
    SaveDialog.FilterIndex := 0;
    Result := SaveDialog.Execute;
    if Result then
        Memo.Lines.SaveToFile(SaveDialog.FileName);
end;


// Сохраняет все файлы
function TFormMain.SaveAll: Boolean;
var i: Integer;
begin
    Result := False;
    for i := fMemos.Count - 1 downto 0 do begin
        SetActiveMemo(i);
        if not SaveFile then Exit;
    end;
    Result := True;
end;


// Закрывает окно редактора
// Возвращает False, если запрос на сохранение изменений в файле был отвергнут
// пользователем (в качестве отмены процедуры было выбрано CANCEL)
function TFormMain.CloseFile: Boolean;
begin
    Result := not Memo.Lines.Modified;
    if not Result then
        case MessageDlg('Сохранить изменения в ' + Memo.Lines.FileName + ' ?' ,
                         mtWarning, mbYesNoCancel, 0) of
        mrYes:      Result := SaveFile;
        mrNo:       Result := True;
        mrCancel:   Result := False;
        end;
    if Result then begin
        fMemos.Remove(Memo);
        SetActiveMemo(nil);
        Pages.ActivePage.Free;
    end;
end;


// Пытается закрыть все файлы
function TFormMain.CloseAll: Boolean;
begin
    Result := False;
    while fMemos.Count > 0 do begin
        SetActiveMemo(fMemos.Count - 1);
        if not CloseFile then Exit;
    end;
    Result := True;
end;


// Обновляет свойство доступности акций
procedure TFormMain.UpdateActions;
var i: Integer;
    Flag: Boolean;
begin
    inherited;
    // Если хотя бы один файл изменен, доступно сохранение всех файлов
    Flag := False;
    for i := 0 to fMemos.Count - 1 do
        if Memos[i].Lines.Modified then begin
            Flag := True;
            Break;
        end;
    ActSaveAll.Enabled      := Flag;
    // Существует хотя бы один редактор
    Flag := Memo <> nil;
    ActFileNew.Enabled      := True;
    ActFileOpen.Enabled     := True;
    ActFileSave.Enabled     := Flag;
    ActFileSaveAs.Enabled   := Flag;
    ActFileClose.Enabled    := Flag;
    ActCloseAll.Enabled     := Flag;
    ActExit.Enabled         := True;
    ActReadOnly.Enabled     := Flag;
    ActSelAll.Enabled       := Flag;
    ActSelStart.Enabled     := Flag;
    ActSelEnd.Enabled       := Flag;
    ActSelDelete.Enabled    := Flag and not Memo.Range.IsEmpty;
    ActAbout.Enabled        := True;
    ActClosePage.Enabled    := Flag;
    ActCopy.Enabled         := Flag and not Memo.Range.IsEmpty;
    ActCut.Enabled          := Flag and not Memo.Range.IsEmpty;
    ActPaste.Enabled        := Flag and Clipboard.HasFormat(CF_TEXT);
    ActUndo.Enabled         := Flag and Memo.Range.CanUndo;
    ActDebugWindow.Enabled  := True;
    ActExportRTF.Enabled    := Flag;
    ActFont.Enabled         := Flag;
    ActSyntaxExport.Enabled := Flag;
    ActSyntaxImport.Enabled := Flag;
    // Не решенные вопросы
    ActSettings.Enabled     := False;
    ActBrowse.Enabled       := False;
    ActTopic.Enabled        := False;
    ActOpenInvoke.Enabled   := False;
end;


// Входим во вкладку редактора
function TFormMain.GetMemos(const MemoIndex: Integer): TMPSyntaxMemo;
begin
    Result := fMemos[MemoIndex] as TMPSyntaxMemo;
end;


// Активизируется вкладка
procedure TFormMain.PageShow(Sender: TObject);
begin
    SetActiveMemo(TTabSheet(Sender).TabIndex);
end;


// Сохраняет текст как RTF файл
procedure TFormMain.SaveAsRTF(const FileName: string);
var RTF: TRichEdit;
    i, w: Integer;
    Sp: TMPSyntaxParser;
    tok: TToken;
begin
    // Типа, на всякий случай 8(
    if Memo = nil then Exit;
    // Создаем TRichEdit
    RTF := TRichEdit.Create(self);
    RTF.Parent := self;
    RTF.Lines.BeginUpdate;
    try
        with RTF.DefAttributes do begin
            Font := Memo.Font;
            Color := clBlack;
            Style := [];
        end;
        RTF.Lines.Assign(Memo.Lines);
        // Для каждого слова каждой строки, проверяем
        // аттрибуты токена. Если они отличаются от аттрибутов
        // по умолчанию, создаем выделение этого слова в RichEdit
        // и применяем к нему эти аттрибуты
        for i := 0 to Memo.Lines.Count - 1 do begin
            Sp := Memo.Lines.Parser[i];
            for w := 0 to Sp.Count - 1 do begin
                tok := Sp[w].stToken;
                if not Memo.SyntaxAttributes.Equals(tokText, tok) then begin
                    RTF.SelStart := Memo.Lines.RCToPosition(Sp[w].stStart, i);
                    RTF.SelLength := Sp[w].stLength;
                    with RTF.SelAttributes do begin
                        Color := Memo.SyntaxAttributes.FontColor[tok];
                        Style := Memo.SyntaxAttributes.FontStyle[tok];
                    end;
                end;
            end;
        end;
        RTF.Lines.EndUpdate;
        // Потом сохраняем все это в файл
        RTF.PlainText := False;
        RTF.Lines.SaveToFile(FileName);
    finally
        RTF.Free;
    end;
end;


const RecentSection = 'Recents';
      RecentItem    = 'Recent#';

// Загружает историю
procedure TFormMain.LoadInits;
var i: Integer;
begin
    fRecentActions[1] := ActRecent1;
    fRecentActions[2] := ActRecent2;
    fRecentActions[3] := ActRecent3;
    fRecentActions[4] := ActRecent4;
    fRecentActions[5] := ActRecent5;
    with TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini')) do
        for i := Low(fRecentActions) to High(fRecentActions) do begin
            fRecentActions[i].Caption := ReadString(RecentSection, RecentItem + IntToStr(i), '');
            fRecentActions[i].Visible := fRecentActions[i].Caption <> '';
        end;
    MainMenu.Refresh;
end;


// Сохраняет историю
procedure TFormMain.SaveInits;
var i: Integer;
begin
    with TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini')) do
        for i := Low(fRecentActions) to High(fRecentActions) do
            WriteString(RecentSection, RecentItem + IntToStr(i), fRecentActions[i].Caption);
end;


// Добавляет файл
function TFormMain.AddRecent(const s: string): string;
var i: Integer;
begin
    // Может он уже есть ..
    for i := Low(fRecentActions) to High(fRecentActions) do
        if LowerCase(fRecentActions[i].Caption) = LowerCase(s) then
            Exit;
    // Если не нашли - удаляем последний и сдвигаем все назад
    for i := High(fRecentActions) downto Low(fRecentActions) + 1 do begin
        fRecentActions[i].Caption := fRecentActions[i - 1].Caption;
        fRecentActions[i].Visible := fRecentActions[i - 1].Visible;
    end;
    // Этот будет первым
    fRecentActions[Low(fRecentActions)].Caption := s;
    fRecentActions[Low(fRecentActions)].Visible := True;
    // Обновление
    MainMenu.Refresh;
end;



// Производит экспорт синтаксиса
procedure TFormMain.ActSyntaxExportExecute(Sender: TObject);
begin
    SaveDialog.Filter := 'Syntax files (*.syn)|*.syn|Text files (*.txt)|*.txt|All files (*.*)|*.*';
    SaveDialog.DefaultExt := 'syn';
    SaveDialog.FilterIndex := 0;
    if SaveDialog.Execute then
        Memo.SyntaxAttributes.SaveToFile(SaveDialog.FileName);
end;


// Импорт синтаксиса
procedure TFormMain.ActSyntaxImportExecute(Sender: TObject);
begin
    OpenDialog.Filter := 'Syntax files (*.syn)|*.syn|Text files (*.txt)|*.txt|All files (*.*)|*.*';
    OpenDialog.DefaultExt := '.syn';
    OpenDialog.FilterIndex := 0;
    if OpenDialog.Execute then
        try
            Memo.SyntaxAttributes.LoadFromFile(OpenDialog.FileName);
        except
            on E: Exception do
                ShowMessage(E.Message);
        end;
end;


// Обработка исключений
procedure TFormMain.EventsException(Sender: TObject; E: Exception);
begin
    DoLog( E, E.Message );    
end;


procedure TFormMain.EventsHint(Sender: TObject);
begin
    Status.Panels[4].Text := Application.Hint;
end;


procedure TFormMain.MemoWordInfo(Sender: TMPCustomSyntaxMemo; const X, Y, WordIndex, Row: Integer; Showing: Boolean);
var P: TPoint;
begin
    if Showing then begin
        P := Memo.ClientToScreen(Point(X, Y));
        Dec(P.X, Self.Left);
        Dec(P.Y, Self.Top);
        with PanelWordInfo do begin
            Left := P.X;
            Top := P.Y;
            with Memo.Lines.Parser[Row].Tokens[WordIndex] do begin
                LabelWordInfo.Caption := Copy(Memo.Lines[Row], stStart + 1, stLength);
                MemoWInfo.Lines.Clear;
                MemoWInfo.Lines.Append('Start at ' + IntToStr(stStart));
                MemoWInfo.Lines.Append('Length is ' + IntToStr(stLength));
                MemoWInfo.Lines.Append('Token is #' + IntToStr(stToken));
            end;
            Show;
        end
    end else
        PanelWordInfo.Hide;
end;

end.

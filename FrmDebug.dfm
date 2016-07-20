object FormDebug: TFormDebug
  Left = 182
  Top = 377
  Width = 422
  Height = 306
  Caption = 'MPSyntaxMemo RunTime Debug Info'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Pages: TPageControl
    Left = 0
    Top = 0
    Width = 414
    Height = 278
    ActivePage = PageOptions
    Align = alClient
    TabOrder = 0
    object PageUndo: TTabSheet
      Caption = 'Undo stack'
      object LabelUndoCount: TLabel
        Left = 96
        Top = 0
        Width = 80
        Height = 13
        Caption = 'LabelUndoCount'
      end
      object LabelUndoSize: TLabel
        Left = 224
        Top = 0
        Width = 72
        Height = 13
        Caption = 'LabelUndoSize'
      end
      object CheckUndoList: TCheckBox
        Left = 8
        Top = 0
        Width = 57
        Height = 17
        Caption = 'Active'
        TabOrder = 0
        OnClick = CheckUndoListClick
      end
      object ListUndo: TListView
        Left = 0
        Top = 15
        Width = 406
        Height = 235
        Align = alBottom
        Columns = <
          item
            Caption = 'Depth'
          end
          item
            Caption = 'Pos'
          end
          item
            Caption = 'SelStart'
          end
          item
            Caption = 'SelEnd'
          end
          item
            Caption = 'Sealing'
          end
          item
            Caption = 'Text'
          end
          item
            Caption = 'Sections'
          end
          item
            Caption = 'SecRefCount'
          end>
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
      end
    end
    object PageSections: TTabSheet
      Caption = 'Sections'
      ImageIndex = 1
      DesignSize = (
        406
        250)
      object BtnSections: TButton
        Left = 168
        Top = 221
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Refresh'
        TabOrder = 0
        OnClick = BtnSectionsClick
      end
      object MemoSections: TMemo
        Left = 0
        Top = 0
        Width = 406
        Height = 217
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        Lines.Strings = (
          'MemoSections')
        TabOrder = 1
      end
    end
    object PageLog: TTabSheet
      Caption = 'Log'
      ImageIndex = 2
      object MemoLog: TMemo
        Left = 0
        Top = 24
        Width = 406
        Height = 226
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Lines.Strings = (
          'MemoLog')
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object CheckLog: TCheckBox
        Left = 0
        Top = 0
        Width = 57
        Height = 17
        Caption = 'Active'
        TabOrder = 1
      end
      object CheckSaveLog: TCheckBox
        Left = 80
        Top = 0
        Width = 97
        Height = 17
        Caption = 'Save on exit'
        TabOrder = 2
      end
    end
    object PageOptions: TTabSheet
      Caption = 'Options'
      ImageIndex = 3
      object ListOptions: TCheckListBox
        Left = 0
        Top = 0
        Width = 406
        Height = 205
        OnClickCheck = ListOptionsClickCheck
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 14
        Items.Strings = (
          'ShowFileNameInTabSheet'
          'ShowFileNameInFormCaption'
          'ReadOnly'
          'Overwrite'
          'SkipSectionsInfoOnCopy'
          'SkipSectionsInfoOnPaste'
          'AutoGutterWidth'
          'WriteMarkersOnSave'
          'VSNET_SectionsStyle')
        ParentFont = False
        TabOrder = 0
      end
    end
  end
end

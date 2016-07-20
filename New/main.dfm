object Form1: TForm1
  Left = 189
  Top = 110
  Width = 483
  Height = 409
  Caption = #1055#1086#1076#1089#1074#1077#1090#1082#1072' '#1089#1080#1085#1090#1072#1082#1089#1080#1089#1072'. '#1040#1083#1100#1090#1077#1088#1085#1072#1090#1080#1074#1085#1086#1077' '#1088#1072#1079#1074#1080#1090#1080#1077'.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 475
    Height = 355
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Untitled1.txt'
      object StatusBar1: TStatusBar
        Left = 0
        Top = 308
        Width = 467
        Height = 19
        AutoHint = True
        Panels = <
          item
            Width = 50
          end>
      end
      object MPSyntaxMemo1: TMPSyntaxMemo
        Left = 0
        Top = 0
        Width = 467
        Height = 308
        Cursor = crIBeam
        Align = alClient
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        Options = [smoShowFileNameInTabSheet, smoOverwrite, smoAutoGutterWidth, smoShowCursorPos, smoShowPageScroll, smoPanning, smoVerPanningReverse, smoSolidSpecialLine, smoGroupUndo]
        SelColor = clSkyBlue
        SectionIndent = 16
        OnParseWord = MPSyntaxMemo1ParseWord
        OnBeforeBreakPointChanged = MPSyntaxMemo1BeforeBreakPointChanged
        BreakPointsPopupMenu = PopupMenu1
        PopupMenu = PopupMenu2
        OnBreakPointPopup = MPSyntaxMemo1BreakPointPopup
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'C files|*.c'
    Left = 112
  end
  object PopupMenu1: TPopupMenu
    Left = 144
    object pumSet: TMenuItem
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
      Hint = #1059#1089#1090#1072#1085#1072#1074#1083#1080#1074#1072#1077#1090' '#1073#1088#1077#1081#1082#1087#1086#1080#1085#1090' '#1085#1072' '#1076#1072#1085#1085#1091#1102' '#1089#1090#1088#1086#1082#1091
      OnClick = pumSetClick
    end
    object pumClear: TMenuItem
      Caption = #1057#1085#1103#1090#1100
      Hint = #1059#1073#1080#1088#1072#1077#1090' '#1073#1088#1077#1081#1082#1087#1086#1080#1085#1090' '#1089' '#1076#1072#1085#1085#1086#1081' '#1089#1090#1088#1086#1082#1080
      OnClick = pumClearClick
    end
    object pumDisabled: TMenuItem
      Caption = #1053#1077#1072#1082#1090#1080#1074#1085#1099#1081
      Hint = #1052#1077#1085#1103#1077#1090' '#1072#1082#1090#1080#1074#1085#1099#1081' '#1073#1088#1077#1081#1082#1087#1086#1080#1085#1090' '#1085#1072' '#1085#1077#1072#1082#1090#1080#1074#1085#1099#1081' '#1080' '#1086#1073#1088#1072#1090#1085#1086
      OnClick = pumDisabledClick
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 176
    object textPopup1: TMenuItem
      Caption = #1042#1089#1087#1083#1099#1074#1072#1102#1097#1077#1077' '#1084#1077#1085#1102' '#1076#1083#1103' '#1090#1077#1082#1089#1090#1072
    end
  end
  object MainMenu1: TMainMenu
    Left = 208
    object mnuFile: TMenuItem
      Caption = #1060#1072#1081#1083
      Hint = #1054#1087#1077#1088#1072#1094#1080#1080' '#1089' '#1092#1072#1081#1083#1072#1084#1080
      object mnuOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1085#1086#1074#1099#1081' '#1057' '#1092#1072#1081#1083' '#1076#1083#1103' '#1072#1085#1072#1083#1080#1079#1072
        OnClick = mnuOpenClick
      end
      object sep1: TMenuItem
        Caption = '-'
      end
      object mnuExit: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100
        Hint = #1042#1099#1093#1086#1076' '#1080#1079' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
        OnClick = mnuExitClick
      end
    end
    object mnuEdit: TMenuItem
      Caption = #1055#1088#1072#1074#1082#1072
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' ('#1087#1088#1086#1089#1090#1086' '#1082#1072#1082' '#1087#1088#1080#1084#1077#1088')'
      object N6: TMenuItem
        Caption = #1085#1077' '#1088#1077#1072#1083#1080#1079#1086#1074#1072#1085#1086' '#1074' '#1087#1088#1080#1084#1077#1088#1077
        Enabled = False
      end
    end
    object mnuDebug: TMenuItem
      Caption = #1054#1090#1083#1072#1076#1082#1072
      Hint = #1069#1084#1091#1083#1103#1094#1080#1103' '#1088#1072#1073#1086#1090#1099' '#1086#1090#1083#1072#1076#1095#1080#1082#1072
      object mnuStepOver: TMenuItem
        Caption = #1064#1072#1075
        Default = True
        Hint = #1069#1084#1091#1083#1103#1094#1080#1103' '#1096#1072#1075#1072' '#1086#1090#1083#1072#1076#1082#1080' ('#1073#1077#1079' '#1091#1095#1077#1090#1072' '#1095#1077#1075#1086' '#1073#1099' '#1090#1086' '#1085#1080' '#1073#1099#1083#1086')'
        ShortCut = 119
        OnClick = mnuStepOverClick
      end
      object mnuStopDebug: TMenuItem
        Caption = #1047#1072#1082#1086#1085#1095#1080#1090#1100' '#1086#1090#1083#1072#1076#1082#1091
        Hint = #1059#1073#1080#1088#1072#1077#1090' '#1083#1080#1085#1080#1102' '#1086#1090#1083#1072#1076#1082#1080
        OnClick = mnuStopDebugClick
      end
      object sep2: TMenuItem
        Caption = '-'
      end
      object mnuFreeMode: TMenuItem
        Caption = #1057#1074#1086#1073#1086#1076#1085#1099#1081' '#1088#1077#1078#1080#1084' '#1073#1088#1077#1081#1082#1086#1087#1080#1085#1090#1086#1074
        Checked = True
        Hint = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '#1084#1086#1078#1077#1090' '#1087#1086#1089#1090#1072#1074#1080#1090#1100' '#1041#1055' '#1074' '#1083#1102#1073#1086#1081' '#1089#1090#1088#1086#1082#1077
        OnClick = mnuFreeModeClick
      end
      object mnuNeedPosibility: TMenuItem
        Caption = #1047#1072#1074#1080#1089#1080#1084#1099#1081' '#1088#1077#1078#1080#1084' '#1073#1088#1077#1081#1082#1087#1086#1080#1085#1090#1086#1074
        Hint = 
          #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '#1084#1086#1078#1077#1090' '#1087#1086#1089#1090#1072#1074#1080#1090#1100' '#1041#1055' '#1090#1086#1083#1100#1082#1086' '#1090#1072#1084', '#1075#1076#1077' '#1077#1089#1090#1100' '#1041#1055' '#1090#1080#1087#1072' bkP' +
          'osible'
        OnClick = mnuNeedPosibilityClick
      end
    end
    object mnuView: TMenuItem
      Caption = #1042#1080#1076
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1080#1085#1090#1077#1088#1092#1077#1081#1089#1072
      object mnuAdditional: TMenuItem
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1101#1083#1077#1084#1077#1085#1090#1099
        Hint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1101#1083#1077#1084#1077#1085#1090#1099' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1103' '#1080' '#1080#1085#1076#1080#1082#1072#1094#1080#1080
        object mnuCursorPos: TMenuItem
          Caption = #1055#1086#1083#1086#1078#1077#1085#1080#1077' '#1082#1091#1088#1089#1086#1088#1072
          Checked = True
          Hint = #1055#1086#1083#1077' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1087#1086#1083#1086#1078#1077#1085#1080#1103' '#1082#1091#1088#1089#1086#1088#1072
          OnClick = mnuCursorPosClick
        end
        object mnuPageUpDown: TMenuItem
          Caption = #1055#1086#1089#1090#1088#1072#1085#1080#1095#1085#1072#1103' '#1087#1088#1086#1082#1088#1091#1090#1082#1072
          Checked = True
          Hint = #1069#1083#1077#1084#1077#1085#1090' '#1087#1086#1089#1090#1088#1072#1085#1080#1095#1085#1086#1081' '#1087#1088#1086#1082#1088#1091#1090#1082#1080
          OnClick = mnuPageUpDownClick
        end
      end
      object mnuNotSolidLines: TMenuItem
        Caption = #1055#1088#1086#1079#1088#1072#1095#1085#1099#1077' '#1089#1087#1077#1094#1080#1072#1083#1100#1085#1099#1077' '#1083#1080#1085#1080#1080
        Hint = 
          #1059#1089#1090#1072#1085#1072#1074#1083#1080#1074#1072#1077#1090' '#1087#1088#1086#1079#1088#1072#1095#1085#1086#1089#1090#1100' '#1083#1080#1085#1080#1081' '#1073#1088#1077#1081#1082#1087#1086#1080#1085#1090#1086#1074' '#1080' '#1083#1080#1085#1080#1080' '#1087#1086#1083#1086#1078#1077#1085#1080#1103' ' +
          #1086#1090#1083#1072#1076#1082#1080
        OnClick = mnuNotSolidLinesClick
      end
      object mnuHighlightLines: TMenuItem
        Caption = #1055#1086#1076#1089#1074#1077#1095#1080#1074#1072#1090#1100' '#1083#1080#1085#1080#1080' '#1076#1086' '#1082#1086#1085#1094#1072' '#1089#1090#1088#1086#1082#1080
        Hint = #1055#1088#1086#1076#1083#1077#1074#1072#1077#1090' '#1087#1086#1076#1089#1074#1077#1090#1082#1091' '#1083#1080#1085#1080#1081' '#1082#1086#1084#1084#1077#1085#1090#1072#1088#1080#1077#1074' '#1076#1086' '#1082#1086#1085#1094#1072' '#1089#1090#1088#1086#1082#1080
        OnClick = mnuHighlightLinesClick
      end
    end
    object mnuSettings: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      object mnuPanning: TMenuItem
        Caption = #1055#1072#1085#1086#1088#1072#1084#1080#1088#1086#1074#1072#1085#1080#1077
        Checked = True
        Hint = #1042#1082#1083#1102#1095#1072#1077#1090' '#1086#1087#1094#1080#1102' '#1087#1072#1085#1086#1088#1072#1084#1080#1088#1086#1074#1072#1085#1080#1103
        OnClick = mnuPanningClick
      end
      object mnuHorPanning: TMenuItem
        Caption = #1043#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086#1077' '#1087#1072#1085#1086#1088#1072#1084#1080#1088#1086#1074#1072#1085#1080#1077
        Hint = 
          #1042#1082#1083#1102#1095#1072#1077#1090' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1086#1077' '#1087#1072#1085#1086#1088#1072#1084#1080#1088#1086#1074#1072#1085#1080#1077' ('#1077#1089#1083#1080' '#1074#1082#1083#1102#1095#1077#1085#1086' '#1087#1072#1085#1086#1088#1072#1084#1080#1088 +
          #1086#1074#1072#1085#1080#1077' '#1074#1082#1083#1102#1095#1077#1085#1086')'
        OnClick = mnuHorPanningClick
      end
      object mnuReversePaning: TMenuItem
        Caption = #1056#1077#1074#1077#1088#1089#1080#1074#1085#1086#1077' '#1087#1072#1085#1086#1088#1072#1084#1080#1088#1086#1074#1072#1085#1080#1077
        Checked = True
        Hint = #1054#1073#1088#1072#1090#1085#1086#1077' '#1087#1072#1085#1086#1088#1072#1084#1080#1088#1086#1074#1072#1085#1080#1077
        OnClick = mnuReversePaningClick
      end
      object sep3: TMenuItem
        Caption = '-'
      end
      object mnuColors: TMenuItem
        Caption = #1062#1074#1077#1090#1072
        object mnuBPEnabledBackColor: TMenuItem
          Caption = #1060#1086#1085' '#1072#1082#1090#1080#1074#1085#1086#1075#1086' '#1073#1088#1077#1081#1082#1087#1086#1080#1085#1090#1072
          OnClick = mnuBPEnabledBackColorClick
        end
        object mnuBPEnabledForeColor: TMenuItem
          Caption = #1058#1077#1082#1089#1090' '#1072#1082#1090#1080#1074#1085#1086#1075#1086' '#1073#1088#1077#1081#1082#1087#1086#1080#1085#1090#1072
          OnClick = mnuBPEnabledForeColorClick
        end
        object sep4: TMenuItem
          Caption = '-'
        end
        object mnuBPDisabledBackColor: TMenuItem
          Caption = #1060#1086#1085' '#1085#1077#1072#1082#1090#1080#1074#1085#1086#1075#1086' '#1073#1088#1077#1081#1082#1087#1086#1080#1085#1090#1072
          OnClick = mnuBPDisabledBackColorClick
        end
        object mnuBPDisabledForeColor: TMenuItem
          Caption = #1058#1077#1082#1089#1090' '#1085#1077#1072#1082#1090#1080#1074#1085#1086#1075#1086' '#1073#1088#1077#1081#1082#1087#1086#1080#1085#1090#1072
          OnClick = mnuBPDisabledForeColorClick
        end
        object sep5: TMenuItem
          Caption = '-'
        end
        object mnuDebugLineBackColor: TMenuItem
          Caption = #1060#1086#1085' '#1089#1090#1088#1086#1082#1080' '#1086#1090#1083#1072#1076#1082#1080
          OnClick = mnuDebugLineBackColorClick
        end
        object mnuDebugLineForeColor: TMenuItem
          Caption = #1058#1077#1082#1089#1090' '#1089#1090#1088#1086#1082#1080' '#1086#1090#1083#1072#1076#1082#1080
          OnClick = mnuDebugLineForeColorClick
        end
        object sep6: TMenuItem
          Caption = '-'
        end
        object mnuSelectedWordColor: TMenuItem
          Caption = #1062#1074#1077#1090' '#1088#1072#1084#1082#1080' '#1074#1099#1076#1077#1083#1077#1085#1080#1103
          OnClick = mnuSelectedWordColorClick
        end
      end
    end
  end
  object ColorDialog1: TColorDialog
    Left = 80
  end
end

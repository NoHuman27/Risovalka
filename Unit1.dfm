object FormCreateFile: TFormCreateFile
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1056#1080#1089#1086#1074#1072#1083#1082#1072' - '#1057#1086#1079#1076#1072#1085#1080#1077' '#1083#1080#1089#1090#1072
  ClientHeight = 250
  ClientWidth = 410
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Label2: TLabel
    Left = 199
    Top = 24
    Width = 193
    Height = 15
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1080#1081' '#1088#1072#1079#1084#1077#1088':'
  end
  object Label1: TLabel
    Left = 199
    Top = 8
    Width = 138
    Height = 15
    Caption = #1042#1099' '#1089#1086#1079#1076#1072#1105#1090#1077' '#1087#1091#1089#1090#1086#1081' '#1083#1080#1089#1090'.'
  end
  object на: TLabel
    Left = 263
    Top = 48
    Width = 13
    Height = 15
    Caption = #1085#1072
  end
  object ButtonCreateCanvas: TButton
    Left = 292
    Top = 225
    Width = 110
    Height = 17
    Caption = #1057#1086#1079#1076#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = ButtonCreateCanvasClick
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 8
    Width = 185
    Height = 209
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1092#1086#1088#1084#1072#1090
    Items.Strings = (
      'A5 1748 x 2480'
      'A4 2480 x 3508'
      'A3 3508 x 4961'
      'A2 4961 x 7016'
      'A1 7016 x 9933'
      #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1080#1081)
    TabOrder = 1
    OnClick = RadioGroup1Click
  end
  object EditWidth: TEdit
    Left = 199
    Top = 45
    Width = 58
    Height = 23
    NumbersOnly = True
    TabOrder = 2
    Text = '2000'
    TextHint = #1042#1099#1089#1086#1090#1072
    OnChange = EditWidthChange
  end
  object EditHeight: TEdit
    Left = 280
    Top = 45
    Width = 57
    Height = 23
    NumbersOnly = True
    TabOrder = 3
    Text = '2000'
    TextHint = #1064#1080#1088#1080#1085#1072
    OnChange = EditHeightChange
  end
end

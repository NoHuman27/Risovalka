object MainMenu: TMainMenu
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu, biMinimize, biHelp]
  BorderStyle = bsSingle
  Caption = #1056#1080#1089#1086#1074#1072#1083#1082#1072' - '#1043#1083#1072#1074#1085#1086#1077' '#1084#1077#1085#1102
  ClientHeight = 513
  ClientWidth = 929
  Color = clMenu
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 929
    Height = 513
    BevelOuter = bvNone
    Color = clCream
    ParentBackground = False
    TabOrder = 0
    object PanelButton: TPanel
      Left = 0
      Top = 7
      Width = 233
      Height = 498
      Color = clMoneyGreen
      ParentBackground = False
      TabOrder = 0
      object ButtonEXIT: TButton
        Left = 9
        Top = 437
        Width = 216
        Height = 49
        Caption = #1042#1099#1093#1086#1076
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = ButtonEXITClick
      end
      object ButtonDRAWINGINSTRUCTIONS: TButton
        Left = 9
        Top = 174
        Width = 216
        Height = 49
        Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1080' '#1087#1086' '#1088#1080#1089#1086#1074#1072#1085#1080#1102
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = ButtonDRAWINGINSTRUCTIONSClick
      end
      object REFERENCEbutton: TButton
        Left = 9
        Top = 119
        Width = 216
        Height = 49
        Caption = #1057#1087#1088#1072#1074#1082#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = REFERENCEbuttonClick
      end
      object ButtonOPENFILE: TButton
        Left = 9
        Top = 64
        Width = 216
        Height = 49
        Caption = #1054#1090#1082#1088#1099#1090#1100
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = ButtonOPENFILEClick
      end
      object ButtonCREATEFILE: TButton
        Left = 9
        Top = 9
        Width = 216
        Height = 49
        Caption = #1057#1086#1079#1076#1072#1090#1100
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = ButtonCREATEFILEClick
      end
    end
    object PanelСapHis: TPanel
      Left = 239
      Top = 7
      Width = 697
      Height = 497
      BevelOuter = bvNone
      Caption = 'Panel'#1057'apHis'
      TabOrder = 1
      object PanelCaption: TPanel
        Left = 0
        Top = 0
        Width = 689
        Height = 40
        BevelInner = bvRaised
        BevelOuter = bvSpace
        Color = clDarkseagreen
        ParentBackground = False
        TabOrder = 0
        object LabelPI: TLabel
          Left = 8
          Top = 8
          Width = 219
          Height = 25
          Caption = #1055#1086#1089#1083#1077#1076#1085#1080#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
      object PanelHistoryPictures: TPanel
        Left = 0
        Top = 38
        Width = 689
        Height = 459
        Color = clMoneyGreen
        ParentBackground = False
        TabOrder = 1
        object FlowPanel1: TFlowPanel
          Left = 1
          Top = 1
          Width = 687
          Height = 457
          Align = alClient
          TabOrder = 0
          object Panel1: TPanel
            Left = 1
            Top = 1
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 0
            object Image1: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label1: TLabel
              Left = 8
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
          object Panel2: TPanel
            Left = 137
            Top = 1
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 1
            object Image2: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label2: TLabel
              Left = 8
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
          object Panel3: TPanel
            Left = 273
            Top = 1
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 2
            object Image3: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label3: TLabel
              Left = 9
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
          object Panel4: TPanel
            Left = 409
            Top = 1
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 3
            object Image4: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label4: TLabel
              Left = 8
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
          object Panel5: TPanel
            Left = 545
            Top = 1
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 4
            object Image5: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label5: TLabel
              Left = 8
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
          object Panel6: TPanel
            Left = 1
            Top = 153
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 5
            object Image6: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label6: TLabel
              Left = 8
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
          object Panel7: TPanel
            Left = 137
            Top = 153
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 6
            object Image7: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label7: TLabel
              Left = 8
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
          object Panel8: TPanel
            Left = 273
            Top = 153
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 7
            object Image8: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label8: TLabel
              Left = 8
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
          object Panel9: TPanel
            Left = 409
            Top = 153
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 8
            object Image9: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label9: TLabel
              Left = 8
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
          object Panel10: TPanel
            Left = 545
            Top = 153
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 9
            object Image10: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label10: TLabel
              Left = 8
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
          object Panel11: TPanel
            Left = 1
            Top = 305
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 10
            object Image11: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label11: TLabel
              Left = 8
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
          object Panel12: TPanel
            Left = 137
            Top = 305
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 11
            object Image12: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label12: TLabel
              Left = 8
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
          object Panel13: TPanel
            Left = 273
            Top = 305
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 12
            object Image13: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label13: TLabel
              Left = 8
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
          object Panel14: TPanel
            Left = 409
            Top = 305
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 13
            object Image14: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label14: TLabel
              Left = 8
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
          object Panel15: TPanel
            Left = 545
            Top = 305
            Width = 136
            Height = 152
            BevelOuter = bvNone
            TabOrder = 14
            object Image15: TImage
              Left = 8
              Top = 6
              Width = 121
              Height = 115
              Proportional = True
              Transparent = True
            end
            object Label15: TLabel
              Left = 8
              Top = 127
              Width = 121
              Height = 15
              AutoSize = False
            end
          end
        end
      end
    end
  end
end

object FormLessonDraw: TFormLessonDraw
  Left = 0
  Top = 0
  Align = alClient
  Caption = #1056#1080#1089#1086#1074#1072#1083#1082#1072' - '#1055#1088#1086#1089#1090#1099#1077' '#1091#1088#1086#1082#1080
  ClientHeight = 843
  ClientWidth = 1443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object lessonChoicePanel: TPanel
    Left = 0
    Top = 0
    Width = 1443
    Height = 142
    Align = alTop
    TabOrder = 0
    object PanelSetting: TPanel
      Left = 765
      Top = 1
      Width = 677
      Height = 140
      Align = alClient
      TabOrder = 0
      object BrushSetting: TPanel
        Left = 8
        Top = 0
        Width = 249
        Height = 141
        TabOrder = 0
        object ButtonPencil: TSpeedButton
          Left = 205
          Top = 33
          Width = 20
          Height = 20
          GroupIndex = 1
          Glyph.Data = {
            E6040000424DE604000000000000360000002800000014000000140000000100
            180000000000B0040000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000
            00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000
            000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00000000
            0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF0000
            00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF000000FFFFFF000000FFFFFF
            000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFF00
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
            00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
            000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000
            00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF}
          OnClick = ButtonPencilClick
        end
        object ButtonEraser: TSpeedButton
          Tag = 2
          Left = 179
          Top = 33
          Width = 20
          Height = 20
          GroupIndex = 1
          Glyph.Data = {
            E6040000424DE604000000000000360000002800000014000000140000000100
            180000000000B0040000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
            000000000000000000000000000000000000000000000000000000000000FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
            FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFF
            FF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000
            000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
            0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            000000000000FFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
            00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            0000000000000000000000000000000000000000000000000000000000000000
            000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            0000000000000000000000000000000000000000000000000000000000000000
            00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            0000000000000000000000000000000000000000000000000000000000000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
            00000000000000000000000000000000000000000000000000000000FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
            000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
            0000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000
            00000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF}
          OnClick = ButtonEraserClick
        end
        object PerformUndoButton: TSpeedButton
          Left = 179
          Top = 59
          Width = 20
          Height = 20
          Caption = #8617
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          OnClick = PerformUndoButtonClick
        end
        object PerformRedoButton: TSpeedButton
          Left = 207
          Top = 59
          Width = 20
          Height = 20
          Caption = #8618
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          OnClick = PerformRedoButtonClick
        end
        object shCurrentColor: TShape
          Left = 8
          Top = 39
          Width = 40
          Height = 40
          Shape = stRoundSquare
        end
        object Shape1: TShape
          Left = 54
          Top = 59
          Width = 20
          Height = 20
          Shape = stRoundSquare
          OnMouseDown = HisColorMouseDown
        end
        object Shape2: TShape
          Left = 80
          Top = 59
          Width = 20
          Height = 20
          Shape = stRoundSquare
          OnMouseDown = HisColorMouseDown
        end
        object Shape3: TShape
          Left = 132
          Top = 59
          Width = 20
          Height = 20
          Shape = stRoundSquare
          OnMouseDown = HisColorMouseDown
        end
        object Shape4: TShape
          Left = 106
          Top = 59
          Width = 20
          Height = 20
          Shape = stRoundSquare
          OnMouseDown = HisColorMouseDown
        end
        object min1: TLabel
          Left = 8
          Top = 102
          Width = 6
          Height = 13
          Caption = '1'
          Color = clDefault
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object max50: TLabel
          Left = 224
          Top = 102
          Width = 12
          Height = 13
          Caption = '50'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 16
          Top = 8
          Width = 217
          Height = 15
          Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072' '#1076#1083#1103' '#1088#1080#1089#1086#1074#1072#1085#1080#1103
        end
        object tbPenWidth: TTrackBar
          Left = 8
          Top = 85
          Width = 217
          Height = 25
          Max = 50
          Min = 1
          Position = 1
          TabOrder = 0
          OnChange = tbPenWidthChange
        end
      end
      object PanelfileSetting: TPanel
        Left = 263
        Top = 1
        Width = 413
        Height = 138
        Align = alRight
        TabOrder = 1
        object Label5: TLabel
          Left = 15
          Top = 7
          Width = 98
          Height = 15
          Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1092#1072#1081#1083#1072
        end
        object ButtonSave: TButton
          Left = 8
          Top = 96
          Width = 121
          Height = 25
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          TabOrder = 0
          OnClick = ButtonSaveClick
        end
        object ButtonCreateFile: TButton
          Left = 8
          Top = 34
          Width = 121
          Height = 25
          Caption = #1057#1086#1079#1076#1072#1090#1100
          TabOrder = 1
          OnClick = ButtonCreateFileClick
        end
        object ButtonOpen: TButton
          Left = 8
          Top = 65
          Width = 121
          Height = 25
          Caption = #1054#1090#1082#1088#1099#1090#1100
          TabOrder = 2
          OnClick = ButtonOpenClick
        end
        object Memo1: TMemo
          Left = 144
          Top = 28
          Width = 257
          Height = 93
          BorderStyle = bsNone
          Lines.Strings = (
            #1047#1072#1082#1088#1077#1087#1080#1090#1077' '#1091#1089#1087#1077#1093#1080' '#1074#1072#1096#1077#1075#1086' '#1091#1088#1086#1082#1072'! '#1042#1099' '#1084#1086#1078#1077#1090#1077' '
            #1089#1086#1093#1088#1072#1085#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1085#1072#1073#1088#1086#1089#1086#1082' '#1085#1072' '#1082#1086#1084#1087#1100#1102#1090#1077#1088' '
            #1080' '#1089#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1099#1081' '#1095#1080#1089#1090#1099#1081' '#1093#1086#1083#1089#1090' '#1076#1083#1103' '
            #1089#1074#1086#1073#1086#1076#1085#1086#1075#1086' '
            #1090#1074#1086#1088#1095#1077#1089#1090#1074#1072'.')
          ReadOnly = True
          TabOrder = 3
        end
      end
    end
    object PanelLESSONS: TPanel
      Left = 1
      Top = 1
      Width = 764
      Height = 140
      Align = alLeft
      TabOrder = 1
      object Label1: TLabel
        Left = 20
        Top = 8
        Width = 36
        Height = 15
        Caption = #1059#1088#1086#1082' 1'
      end
      object Label2: TLabel
        Left = 270
        Top = 8
        Width = 36
        Height = 15
        Caption = #1059#1088#1086#1082' 2'
      end
      object Label3: TLabel
        Left = 514
        Top = 9
        Width = 36
        Height = 15
        Caption = #1059#1088#1086#1082' 3'
      end
      object btnLesson1: TButton
        Tag = 1
        Left = 20
        Top = 29
        Width = 224
        Height = 57
        Caption = #1059#1088#1086#1082' '#1085#1072' '#1090#1077#1084#1091': '#1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1085#1072' '#1075#1083#1072#1079
        DropDownMenu = LessonMenu1
        Style = bsSplitButton
        TabOrder = 0
        OnClick = btnLesson1Click
      end
      object btnLesson2: TButton
        Tag = 2
        Left = 270
        Top = 29
        Width = 224
        Height = 57
        Caption = #1059#1088#1086#1082' '#1085#1072' '#1090#1077#1084#1091': '#1056#1080#1089#1086#1074#1072#1085#1080#1077' '#1086#1090' '#1087#1103#1090#1085#1072
        DropDownMenu = LessonMenu2
        Style = bsSplitButton
        TabOrder = 1
        OnClick = btnLesson2Click
      end
      object btnLesson3: TButton
        Tag = 3
        Left = 514
        Top = 29
        Width = 224
        Height = 57
        Caption = #1059#1088#1086#1082' '#1085#1072' '#1090#1077#1084#1091': '#1055#1086#1080#1089#1082' '#1074#1076#1086#1093#1085#1086#1074#1077#1085#1080#1103
        DropDownMenu = LessonMenu3
        Style = bsSplitButton
        TabOrder = 2
        OnClick = btnLesson3Click
      end
    end
  end
  object PanelLeft: TPanel
    Left = 0
    Top = 142
    Width = 767
    Height = 701
    Align = alLeft
    TabOrder = 1
    object PanelTxTandRef: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 11
      Width = 745
      Height = 278
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alTop
      TabOrder = 0
      object BTNRight: TSpeedButton
        Left = 694
        Top = 232
        Width = 34
        Height = 33
        Caption = '>'
        OnClick = BTNRightClick
      end
      object BTNleft: TSpeedButton
        Left = 644
        Top = 232
        Width = 49
        Height = 33
        Caption = '<'
        OnClick = BTNleftClick
      end
      object Labellesson: TLabel
        Left = 8
        Top = 8
        Width = 36
        Height = 15
        Caption = #1059#1088#1086#1082' 1'
      end
      object LabelPrimer: TLabel
        Left = 398
        Top = 8
        Width = 98
        Height = 15
        Caption = #1055#1088#1080#1084#1077#1088' '#1076#1083#1103' '#1096#1072#1075#1072
      end
      object TextLessonSteps: TRichEdit
        Tag = 1
        Left = 10
        Top = 29
        Width = 382
        Height = 240
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Panelforprimer: TPanel
        Left = 398
        Top = 29
        Width = 240
        Height = 240
        TabOrder = 1
        object ImagePrimer: TImage
          Left = 1
          Top = 1
          Width = 238
          Height = 238
          Align = alClient
          ExplicitLeft = 0
          ExplicitTop = 0
        end
      end
    end
    object PanelforRefImg: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 309
      Width = 745
      Height = 381
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      TabOrder = 1
      object ButtonRight: TSpeedButton
        Left = 711
        Top = 2
        Width = 25
        Height = 25
        Caption = '>'
        Visible = False
        OnClick = ButtonRightClick
      end
      object ButtonLeft: TSpeedButton
        Left = 680
        Top = 2
        Width = 25
        Height = 25
        Caption = '<'
        Visible = False
        OnClick = ButtonLeftClick
      end
      object LabelREF: TLabel
        Left = 10
        Top = 11
        Width = 505
        Height = 15
        Caption = 
          #1056#1077#1092#1077#1088#1077#1085#1089' ('#1053#1072#1078#1084#1080#1090#1077' '#1087#1088#1072#1074#1086#1081' '#1082#1085#1086#1087#1082#1086#1081' '#1084#1099#1096#1080' '#1095#1090#1086#1073#1099' '#1079#1072#1093#1074#1072#1090#1080#1090#1100' '#1094#1074#1077#1090' '#1089' '#1086#1087#1077 +
          #1076#1077#1083#1105#1085#1085#1086#1075#1086' '#1087#1080#1082#1089#1077#1083#1103')'
      end
      object PanelforRef: TPanel
        Left = 9
        Top = 32
        Width = 728
        Height = 495
        TabOrder = 0
        object ImageReference: TImage
          Left = 1
          Top = 1
          Width = 726
          Height = 493
          Align = alClient
          Proportional = True
          Stretch = True
          OnMouseDown = ImageReferenceMouseDown
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 598
        end
      end
    end
  end
  object PanelRight: TPanel
    Left = 767
    Top = 142
    Width = 676
    Height = 701
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object lblWidthDisplay: TLabel
      Left = 6
      Top = 27
      Width = 79
      Height = 15
      Caption = #1058#1086#1083#1097#1080#1085#1072': 2 px'
    end
    object IntrumentIND: TLabel
      Left = 6
      Top = 6
      Width = 196
      Height = 15
      Caption = #1042#1099#1073#1088#1072#1085#1085#1099#1081' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090': '#1050#1072#1088#1072#1085#1076#1072#1096
    end
    object PanelCanvas: TPanel
      AlignWithMargins = True
      Left = 232
      Top = 40
      Width = 630
      Height = 770
      Margins.Left = 50
      Margins.Right = 50
      TabOrder = 0
      object ImageCanvas: TImage
        Left = 1
        Top = 1
        Width = 628
        Height = 768
        Margins.Left = 30
        Margins.Right = 30
        Align = alClient
        OnMouseDown = ImageCanvasMouseDown
        OnMouseMove = ImageCanvasMouseMove
        OnMouseUp = ImageCanvasMouseUp
        ExplicitLeft = -1
        ExplicitTop = 0
        ExplicitWidth = 565
        ExplicitHeight = 760
      end
    end
  end
  object LessonMenu1: TPopupMenu
    Left = 200
    Top = 88
    object L1_S1: TMenuItem
      Tag = 1
      Caption = 
        #1064#1072#1075' 1: '#1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1082#1086#1085#1089#1090#1088#1091#1082#1090#1080#1074#1085#1099#1093' '#1086#1089#1077#1081' '#1080' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1094#1077#1085#1090#1088#1072' '#1092#1086#1088#1084#1099 +
        '.'
      OnClick = L1_MenuStepClick
    end
    object L1_S2: TMenuItem
      Tag = 2
      Caption = #1064#1072#1075' 2: '#1054#1087#1088#1077#1076#1077#1083#1080#1090#1077' '#1080' '#1088#1072#1079#1084#1077#1089#1090#1080#1090#1077' '#1092#1080#1075#1091#1088#1099' '#1080#1079' '#1082#1086#1090#1086#1088#1099#1093' '#1089#1086#1089#1090#1086#1080#1090' '#1087#1088#1077#1076#1084#1077#1090
      OnClick = L1_MenuStepClick
    end
    object L1_S3: TMenuItem
      Tag = 3
      Caption = #1064#1072#1075' 3: '#1055#1088#1077#1074#1088#1072#1090#1080#1090#1077' '#1092#1080#1075#1091#1088#1099' '#1074' '#1086#1095#1077#1088#1090#1072#1085#1080#1077' '#1087#1088#1077#1076#1084#1077#1090#1072
      OnClick = L1_MenuStepClick
    end
  end
  object LessonMenu2: TPopupMenu
    Left = 440
    Top = 88
    object L2_S1: TMenuItem
      Tag = 1
      Caption = #1064#1072#1075' 1: '#1057#1080#1083#1091#1101#1090' '#1080' '#1073#1072#1079#1086#1074#1099#1081' '#1094#1074#1077#1090
      OnClick = L2_MenuStepClick
    end
    object L2_S2: TMenuItem
      Tag = 2
      Caption = #1064#1072#1075' 2: '#1062#1074#1077#1090#1086#1074#1099#1077' '#1080' '#1090#1086#1085#1086#1074#1099#1077' '#1087#1103#1090#1085#1072
      OnClick = L2_MenuStepClick
    end
    object L2_S3: TMenuItem
      Tag = 3
      Caption = #1064#1072#1075' 3: '#1044#1077#1090#1072#1083#1080#1079#1072#1094#1080#1103' '#1080' '#1090#1077#1082#1089#1090#1091#1088#1072
      OnClick = L2_MenuStepClick
    end
  end
  object LessonMenu3: TPopupMenu
    Left = 656
    Top = 88
    object L3_S1: TMenuItem
      Tag = 1
      Caption = #1064#1072#1075' 1: '#1054#1094#1077#1085#1080#1090#1077' '#1087#1088#1077#1076#1084#1077#1090' '#1080#1079#1086#1073#1088#1072#1078#1105#1085#1085#1099#1081' '#1087#1077#1088#1077#1076' '#1074#1072#1084#1080
      OnClick = L3_MenuStepClick
    end
    object L3_S2: TMenuItem
      Tag = 2
      Caption = #1064#1072#1075' 2: '#1042#1099#1103#1074#1080#1090#1077' '#1095#1090#1086' '#1086#1085' '#1084#1086#1078#1077#1090' '#1074#1072#1084' '#1085#1072#1087#1086#1084#1080#1085#1072#1090#1100
      OnClick = L3_MenuStepClick
    end
    object L3_S3: TMenuItem
      Tag = 3
      Caption = #1064#1072#1075' 3: '#1054#1073#1100#1077#1076#1080#1085#1080#1090#1077' '#1074#1072#1096#1080' '#1084#1099#1089#1083#1080' '#1074' '#1086#1076#1085#1091' '#1082#1072#1088#1090#1080#1085#1091
      OnClick = L3_MenuStepClick
    end
  end
  object SavePictureDialog1: TSavePictureDialog
    DefaultExt = 'png'
    Filter = 'PNG Image (*.png)|*.png|Bitmap Image (*.bmp)|*.bmp'
    Left = 1394
    Top = 102
  end
end

object SDIAppForm: TSDIAppForm
  Left = 224
  Top = 2
  Width = 900
  Height = 705
  Caption = #35465#20975#26816#39564#20449#24687#31649#29702#31995#32479'V7.0'
  Color = clBtnFace
  Constraints.MinWidth = 130
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 460
    Top = 37
    Height = 590
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 884
    Height = 37
    AutoSize = True
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 33
        Width = 880
      end>
    Color = 16767438
    ParentColor = False
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 867
      Height = 33
      BorderWidth = 1
      ButtonWidth = 43
      Color = 16767438
      EdgeOuter = esNone
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      Images = ImageList1
      Indent = 5
      List = True
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = True
      TabOrder = 0
      Wrapable = False
      object SpeedButton1: TSpeedButton
        Left = 5
        Top = 2
        Width = 76
        Height = 22
        Hint = #26681#25454#22995#21517#23450#20301
        Caption = #26597#25214#26816#39564#21333
        OnClick = SpeedButton1Click
      end
      object ToolButton2: TToolButton
        Left = 81
        Top = 2
        Width = 3
        Caption = 'ToolButton2'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object SpeedButton5: TSpeedButton
        Left = 84
        Top = 2
        Width = 75
        Height = 22
        Caption = #26032#26816#39564#21333'F2'
        OnClick = SpeedButton5Click
      end
      object ToolButton1: TSpeedButton
        Left = 159
        Top = 2
        Width = 85
        Height = 22
        Caption = #21024#38500#26816#39564#21333'F4'
        OnClick = ToolButton1Click
      end
      object suiButton8: TSpeedButton
        Left = 244
        Top = 2
        Width = 67
        Height = 22
        Caption = #21047#26032'F5'
        Layout = blGlyphRight
        OnClick = suiButton8Click
      end
      object ToolButton4: TToolButton
        Left = 311
        Top = 2
        Width = 3
        Caption = 'ToolButton4'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object suiButton3: TSpeedButton
        Left = 314
        Top = 2
        Width = 47
        Height = 22
        Caption = #23457#26680'F6'
        OnClick = suiButton3Click
      end
      object suiButton4: TSpeedButton
        Left = 361
        Top = 2
        Width = 75
        Height = 22
        Caption = #21462#28040#23457#26680'F8'
        OnClick = suiButton4Click
      end
      object ToolButton6: TToolButton
        Left = 436
        Top = 2
        Width = 3
        Caption = 'ToolButton6'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object ToolButton8: TSpeedButton
        Left = 439
        Top = 2
        Width = 47
        Height = 22
        Caption = #25171#21360'F7'
        OnClick = ToolButton8Click
      end
      object suiButton1: TSpeedButton
        Left = 486
        Top = 2
        Width = 75
        Height = 22
        Caption = #20998#32452#25171#21360'F9'
        OnClick = suiButton1Click
      end
      object ToolButton5: TToolButton
        Left = 561
        Top = 2
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object LYLed2: TLYLed
        Left = 569
        Top = 2
        Width = 19
        Height = 22
        Cursor = crDefault
        Hint = #20307#26816#32467#35770#12289#24314#35758#29983#25104#25552#31034#28783
        Value = False
        OnColor = clRed
        OffColor = clBtnFace
        Interval = 500
        Blink = True
        BorderColor = clMaroon
        hasSound = False
        SoundString = '.\Wave\Driveby.wav'
        SoundInValue = True
      end
    end
  end
  object Panel1: TPanel
    Left = 463
    Top = 37
    Width = 421
    Height = 590
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object Panel5: TPanel
      Left = 0
      Top = 0
      Width = 421
      Height = 23
      Align = alTop
      Color = 16767438
      Font.Charset = ANSI_CHARSET
      Font.Color = 13583874
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 119
        Top = 5
        Width = 189
        Height = 13
        Caption = #36755#20837'+'#21495#34920#31034#36716#31227#21040#19979#19968#26465#26816#39564#21333
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object LabeledEdit13: TLabeledEdit
        Left = 81
        Top = 2
        Width = 33
        Height = 19
        Ctl3D = False
        EditLabel.Width = 73
        EditLabel.Height = 13
        EditLabel.Caption = #36755#20837#20195#30721'(&E)'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = #23435#20307
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 0
        OnKeyDown = LabeledEdit13KeyDown
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 23
      Width = 421
      Height = 567
      Align = alClient
      TabOrder = 1
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 419
        Height = 565
        Align = alClient
        TabOrder = 0
        object Splitter2: TSplitter
          Left = 1
          Top = 151
          Width = 417
          Height = 5
          Cursor = crVSplit
          Align = alTop
          Color = clBtnFace
          ParentColor = False
        end
        object PageControl1: TPageControl
          Left = 1
          Top = 156
          Width = 417
          Height = 408
          ActivePage = TabSheet1
          Align = alClient
          TabOrder = 0
          object TabSheet1: TTabSheet
            Caption = #26816#39564#32467#26524
            object DBGrid2: TDBGrid
              Left = 0
              Top = 0
              Width = 409
              Height = 380
              Align = alClient
              Color = 16767438
              Ctl3D = False
              DataSource = DS_dtl
              ParentCtl3D = False
              PopupMenu = PopupMenu2
              TabOrder = 0
              TitleFont.Charset = GB2312_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -13
              TitleFont.Name = #23435#20307
              TitleFont.Style = []
              OnDrawColumnCell = DBGrid2DrawColumnCell
              OnExit = DBGrid2Exit
              OnKeyDown = DBGrid2KeyDown
              OnKeyUp = DBGrid2KeyUp
            end
          end
          object TabSheet2: TTabSheet
            Caption = #22270#20687
            ImageIndex = 1
            object ScrollBoxPicture: TScrollBox
              Left = 0
              Top = 0
              Width = 409
              Height = 319
              Align = alClient
              TabOrder = 0
            end
          end
          object TabSheet3: TTabSheet
            Caption = #20108#32500#30721
            ImageIndex = 2
            object ImageBarcode2D: TImage
              Left = 0
              Top = 0
              Width = 409
              Height = 319
              Align = alClient
            end
          end
          object TabSheet4: TTabSheet
            Caption = #32467#26524#35814#24773
            ImageIndex = 3
            object meValueDesc: TMemo
              Left = 0
              Top = 40
              Width = 409
              Height = 279
              Align = alClient
              ScrollBars = ssBoth
              TabOrder = 0
            end
            object Panel4: TPanel
              Left = 0
              Top = 0
              Width = 409
              Height = 40
              Align = alTop
              TabOrder = 1
              object Label7: TLabel
                Left = 260
                Top = 23
                Width = 136
                Height = 13
                Caption = #27880':'#25442#34892#38190':Ctrl+Enter'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -13
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label8: TLabel
                Left = 260
                Top = 6
                Width = 52
                Height = 13
                Caption = #39033#30446#25552#31034
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -13
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object BitBtn1: TBitBtn
                Left = 8
                Top = 7
                Width = 100
                Height = 25
                Caption = #20445#23384#32467#26524#35814#24773
                TabOrder = 0
                OnClick = BitBtn1Click
              end
              object BitBtn2: TBitBtn
                Left = 144
                Top = 7
                Width = 75
                Height = 25
                Caption = #20307#26816#27169#26495
                TabOrder = 1
                OnClick = BitBtn2Click
              end
            end
          end
        end
        object PageControl2: TPageControl
          Left = 1
          Top = 1
          Width = 417
          Height = 150
          ActivePage = TabSheet5
          Align = alTop
          TabOrder = 1
          object TabSheet5: TTabSheet
            Caption = #24120#29992#32452#21512#39033#30446
            object clbCommUsed: TCheckListBox
              Left = 0
              Top = 0
              Width = 409
              Height = 122
              OnClickCheck = clbCommUsedClickCheck
              Align = alClient
              BevelInner = bvNone
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = 16767438
              Columns = 3
              Ctl3D = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = #23435#20307
              Font.Style = []
              ItemHeight = 13
              ParentCtl3D = False
              ParentFont = False
              PopupMenu = PopupMenu3
              TabOrder = 0
            end
          end
          object TabSheet6: TTabSheet
            Caption = #22791#29992#32452#21512#39033#30446
            ImageIndex = 1
            object clbNoCommUsed: TCheckListBox
              Left = 0
              Top = 0
              Width = 409
              Height = 122
              OnClickCheck = clbCommUsedClickCheck
              Align = alClient
              BevelInner = bvNone
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = 16767438
              Columns = 3
              Ctl3D = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = #23435#20307
              Font.Style = []
              ItemHeight = 13
              ParentCtl3D = False
              ParentFont = False
              PopupMenu = PopupMenu3
              TabOrder = 0
            end
          end
        end
      end
    end
  end
  object Panel7: TPanel
    Left = 0
    Top = 37
    Width = 460
    Height = 590
    Align = alLeft
    TabOrder = 2
    object GroupBox1: TGroupBox
      Left = 190
      Top = 1
      Width = 269
      Height = 588
      Align = alClient
      Caption = #26816#39564#21333#21015#34920'(&Q)'
      Color = 16767438
      ParentColor = False
      TabOrder = 0
      object DBGrid1: TDBGrid
        Left = 2
        Top = 42
        Width = 265
        Height = 544
        Align = alClient
        Color = 16767438
        Ctl3D = False
        DataSource = DSbasic
        ParentCtl3D = False
        PopupMenu = pmChangeGroup
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        OnDrawColumnCell = DBGrid1DrawColumnCell
      end
      object Panel6: TPanel
        Left = 2
        Top = 15
        Width = 265
        Height = 27
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16767438
        TabOrder = 1
        object Label2: TLabel
          Left = 6
          Top = 7
          Width = 65
          Height = 13
          Caption = #36873#25321#24037#20316#32452
        end
        object cbxConnChar: TComboBox
          Tag = 101
          Left = 73
          Top = 3
          Width = 122
          Height = 21
          BevelKind = bkFlat
          Ctl3D = True
          DropDownCount = 20
          ItemHeight = 13
          ParentCtl3D = False
          TabOrder = 0
          OnChange = cbxConnCharChange
          OnEnter = cbxConnCharEnter
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 1
      Width = 189
      Height = 588
      Align = alLeft
      Caption = #22522#26412#20449#24687#24405#20837
      Color = 16767438
      ParentColor = False
      PopupMenu = PopupMenu1
      TabOrder = 1
      object Label3: TLabel
        Left = 24
        Top = 308
        Width = 52
        Height = 13
        Caption = #30003#35831#26102#38388
      end
      object Label4: TLabel
        Left = 24
        Top = 350
        Width = 52
        Height = 13
        Caption = #26816#26597#26102#38388
      end
      object Label5: TLabel
        Left = 24
        Top = 288
        Width = 52
        Height = 13
        Caption = #30003#35831#26085#26399
      end
      object Label6: TLabel
        Left = 24
        Top = 330
        Width = 52
        Height = 13
        Caption = #26816#26597#26085#26399
      end
      object Label9: TLabel
        Left = 24
        Top = 16
        Width = 52
        Height = 13
        Caption = #20248#20808#32423#21035
      end
      object Label10: TLabel
        Left = 50
        Top = 118
        Width = 26
        Height = 13
        Caption = #24615#21035
      end
      object Label11: TLabel
        Left = 24
        Top = 160
        Width = 52
        Height = 13
        Caption = #36865#26816#31185#23460
      end
      object Label12: TLabel
        Left = 24
        Top = 202
        Width = 52
        Height = 13
        Caption = #36865#26816#21307#29983
      end
      object Label13: TLabel
        Left = 24
        Top = 224
        Width = 52
        Height = 13
        Caption = #26679#26412#31867#22411
      end
      object Label14: TLabel
        Left = 24
        Top = 246
        Width = 52
        Height = 13
        Caption = #26679#26412#29366#24577
      end
      object SpeedButton3: TSpeedButton
        Left = 159
        Top = 157
        Width = 20
        Height = 20
        Hint = #21047#26032
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000025160000251600000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFAFBF4EDF2D5E3EBBFE3EBBFEDF2D5FAFBF4FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFCF6DDE7B2BDCF66ADC342A8
          C037A8C036ADC342BDCF66DDE7B2FBFCF6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          F7F9EDC7D67EA7BF34A5BD30A9C039AFC549AFC549A9C039A5BD30A7BF34C7D6
          7EF7F9EDFFFFFFFFFFFFFFFFFFFBFCF6C7D67EA6BE31A9C038C4D37BE2E8C5EE
          F1E1EEF1E1E2E8C5C4D37BA9C038A6BE31C7D67EFBFCF6FFFFFFFFFFFFDDE7B2
          A7BF34A9C038D3DE9FF5F6F2E8ECD2D5DFA3D5DFA3E8ECD2F5F6F2D3DE9FA9C0
          38A7BF34DDE7B2FFFFFFFAFBF4BDCF66A5BD30C4D37BF5F6F2D6E0A6ADC343A5
          BD30A5BD30ADC343D6E0A6F5F6F2C4D37BA5BD30BDCF66FAFBF4EDF2D5ADC342
          A9C039E2E8C5E8ECD2ADC343A5BD30A6BE32A6BE32A5BD30ADC343E8ECD2E2E8
          C5A9C039ADC342EDF2D5E3EBBFA8C037AFC549EEF1E1D5DFA3A5BD30A6BE32A6
          BE32A6BE32A6BE32A5BD30D5DFA3EEF1E1AFC549A8C037E3EBBFE3EBBFA8C036
          AFC549EEF1E1D5DFA3A5BD30A6BE32A6BE32A6BE32A6BE32A5BE31D5DFA4EEF1
          E1AFC549A8C036E3EBBFEDF2D5ADC342A9C039E2E8C5E8ECD2ADC343A5BD30A6
          BE31A5BD30A6BE31AAC13CE6EBCDE3E9C6A9C039ADC342EDF2D5FAFBF4BDCF66
          A5BD30C4D37BF5F6F2D6E0A6ACC241B4C854B8CA5DA6BE32A7BF35C7D583BDCE
          69A5BE31BDCF66FAFBF4FFFFFFDDE7B2A7BF34A9C038D3DE9FF5F6F2E7ECD1E4
          E9C8F0F2E5D1DC9BB0C54AA5BD2FA5BE30A7BF35DDE7B2FFFFFFFFFFFFFBFCF6
          C7D67EA6BE31A9C038C4D37BE2E8C4F1F3E9F9F8FBEEF1E1C1D173A6BE31A6BE
          32C7D67EFBFCF6FFFFFFFFFFFFFFFFFFF7F9EDC7D67EA7BF34A5BD30A8BF37C6
          D580D8E1ACB5C855A6BE33A7BF35C7D67EF7F9EDFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFBFCF6DDE7B2BDCF66ADC342ACC240ABC13DACC241BDCF66DDE7B2FBFC
          F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFBF4EDF2D5E3
          EABEE3EBBEEDF2D5FAFBF4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton3Click
      end
      object SpeedButton4: TSpeedButton
        Left = 159
        Top = 199
        Width = 20
        Height = 20
        Hint = #21047#26032
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000025160000251600000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFAFBF4EDF2D5E3EBBFE3EBBFEDF2D5FAFBF4FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFCF6DDE7B2BDCF66ADC342A8
          C037A8C036ADC342BDCF66DDE7B2FBFCF6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          F7F9EDC7D67EA7BF34A5BD30A9C039AFC549AFC549A9C039A5BD30A7BF34C7D6
          7EF7F9EDFFFFFFFFFFFFFFFFFFFBFCF6C7D67EA6BE31A9C038C4D37BE2E8C5EE
          F1E1EEF1E1E2E8C5C4D37BA9C038A6BE31C7D67EFBFCF6FFFFFFFFFFFFDDE7B2
          A7BF34A9C038D3DE9FF5F6F2E8ECD2D5DFA3D5DFA3E8ECD2F5F6F2D3DE9FA9C0
          38A7BF34DDE7B2FFFFFFFAFBF4BDCF66A5BD30C4D37BF5F6F2D6E0A6ADC343A5
          BD30A5BD30ADC343D6E0A6F5F6F2C4D37BA5BD30BDCF66FAFBF4EDF2D5ADC342
          A9C039E2E8C5E8ECD2ADC343A5BD30A6BE32A6BE32A5BD30ADC343E8ECD2E2E8
          C5A9C039ADC342EDF2D5E3EBBFA8C037AFC549EEF1E1D5DFA3A5BD30A6BE32A6
          BE32A6BE32A6BE32A5BD30D5DFA3EEF1E1AFC549A8C037E3EBBFE3EBBFA8C036
          AFC549EEF1E1D5DFA3A5BD30A6BE32A6BE32A6BE32A6BE32A5BE31D5DFA4EEF1
          E1AFC549A8C036E3EBBFEDF2D5ADC342A9C039E2E8C5E8ECD2ADC343A5BD30A6
          BE31A5BD30A6BE31AAC13CE6EBCDE3E9C6A9C039ADC342EDF2D5FAFBF4BDCF66
          A5BD30C4D37BF5F6F2D6E0A6ACC241B4C854B8CA5DA6BE32A7BF35C7D583BDCE
          69A5BE31BDCF66FAFBF4FFFFFFDDE7B2A7BF34A9C038D3DE9FF5F6F2E7ECD1E4
          E9C8F0F2E5D1DC9BB0C54AA5BD2FA5BE30A7BF35DDE7B2FFFFFFFFFFFFFBFCF6
          C7D67EA6BE31A9C038C4D37BE2E8C4F1F3E9F9F8FBEEF1E1C1D173A6BE31A6BE
          32C7D67EFBFCF6FFFFFFFFFFFFFFFFFFF7F9EDC7D67EA7BF34A5BD30A8BF37C6
          D580D8E1ACB5C855A6BE33A7BF35C7D67EF7F9EDFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFBFCF6DDE7B2BDCF66ADC342ACC240ABC13DACC241BDCF66DDE7B2FBFC
          F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFBF4EDF2D5E3
          EABEE3EBBEEDF2D5FAFBF4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton4Click
      end
      object SpeedButton6: TSpeedButton
        Left = 159
        Top = 221
        Width = 20
        Height = 20
        Hint = #21047#26032
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000025160000251600000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFAFBF4EDF2D5E3EBBFE3EBBFEDF2D5FAFBF4FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFCF6DDE7B2BDCF66ADC342A8
          C037A8C036ADC342BDCF66DDE7B2FBFCF6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          F7F9EDC7D67EA7BF34A5BD30A9C039AFC549AFC549A9C039A5BD30A7BF34C7D6
          7EF7F9EDFFFFFFFFFFFFFFFFFFFBFCF6C7D67EA6BE31A9C038C4D37BE2E8C5EE
          F1E1EEF1E1E2E8C5C4D37BA9C038A6BE31C7D67EFBFCF6FFFFFFFFFFFFDDE7B2
          A7BF34A9C038D3DE9FF5F6F2E8ECD2D5DFA3D5DFA3E8ECD2F5F6F2D3DE9FA9C0
          38A7BF34DDE7B2FFFFFFFAFBF4BDCF66A5BD30C4D37BF5F6F2D6E0A6ADC343A5
          BD30A5BD30ADC343D6E0A6F5F6F2C4D37BA5BD30BDCF66FAFBF4EDF2D5ADC342
          A9C039E2E8C5E8ECD2ADC343A5BD30A6BE32A6BE32A5BD30ADC343E8ECD2E2E8
          C5A9C039ADC342EDF2D5E3EBBFA8C037AFC549EEF1E1D5DFA3A5BD30A6BE32A6
          BE32A6BE32A6BE32A5BD30D5DFA3EEF1E1AFC549A8C037E3EBBFE3EBBFA8C036
          AFC549EEF1E1D5DFA3A5BD30A6BE32A6BE32A6BE32A6BE32A5BE31D5DFA4EEF1
          E1AFC549A8C036E3EBBFEDF2D5ADC342A9C039E2E8C5E8ECD2ADC343A5BD30A6
          BE31A5BD30A6BE31AAC13CE6EBCDE3E9C6A9C039ADC342EDF2D5FAFBF4BDCF66
          A5BD30C4D37BF5F6F2D6E0A6ACC241B4C854B8CA5DA6BE32A7BF35C7D583BDCE
          69A5BE31BDCF66FAFBF4FFFFFFDDE7B2A7BF34A9C038D3DE9FF5F6F2E7ECD1E4
          E9C8F0F2E5D1DC9BB0C54AA5BD2FA5BE30A7BF35DDE7B2FFFFFFFFFFFFFBFCF6
          C7D67EA6BE31A9C038C4D37BE2E8C4F1F3E9F9F8FBEEF1E1C1D173A6BE31A6BE
          32C7D67EFBFCF6FFFFFFFFFFFFFFFFFFF7F9EDC7D67EA7BF34A5BD30A8BF37C6
          D580D8E1ACB5C855A6BE33A7BF35C7D67EF7F9EDFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFBFCF6DDE7B2BDCF66ADC342ACC240ABC13DACC241BDCF66DDE7B2FBFC
          F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFBF4EDF2D5E3
          EABEE3EBBEEDF2D5FAFBF4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton6Click
      end
      object SpeedButton7: TSpeedButton
        Left = 159
        Top = 243
        Width = 20
        Height = 20
        Hint = #21047#26032
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000025160000251600000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFAFBF4EDF2D5E3EBBFE3EBBFEDF2D5FAFBF4FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFCF6DDE7B2BDCF66ADC342A8
          C037A8C036ADC342BDCF66DDE7B2FBFCF6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          F7F9EDC7D67EA7BF34A5BD30A9C039AFC549AFC549A9C039A5BD30A7BF34C7D6
          7EF7F9EDFFFFFFFFFFFFFFFFFFFBFCF6C7D67EA6BE31A9C038C4D37BE2E8C5EE
          F1E1EEF1E1E2E8C5C4D37BA9C038A6BE31C7D67EFBFCF6FFFFFFFFFFFFDDE7B2
          A7BF34A9C038D3DE9FF5F6F2E8ECD2D5DFA3D5DFA3E8ECD2F5F6F2D3DE9FA9C0
          38A7BF34DDE7B2FFFFFFFAFBF4BDCF66A5BD30C4D37BF5F6F2D6E0A6ADC343A5
          BD30A5BD30ADC343D6E0A6F5F6F2C4D37BA5BD30BDCF66FAFBF4EDF2D5ADC342
          A9C039E2E8C5E8ECD2ADC343A5BD30A6BE32A6BE32A5BD30ADC343E8ECD2E2E8
          C5A9C039ADC342EDF2D5E3EBBFA8C037AFC549EEF1E1D5DFA3A5BD30A6BE32A6
          BE32A6BE32A6BE32A5BD30D5DFA3EEF1E1AFC549A8C037E3EBBFE3EBBFA8C036
          AFC549EEF1E1D5DFA3A5BD30A6BE32A6BE32A6BE32A6BE32A5BE31D5DFA4EEF1
          E1AFC549A8C036E3EBBFEDF2D5ADC342A9C039E2E8C5E8ECD2ADC343A5BD30A6
          BE31A5BD30A6BE31AAC13CE6EBCDE3E9C6A9C039ADC342EDF2D5FAFBF4BDCF66
          A5BD30C4D37BF5F6F2D6E0A6ACC241B4C854B8CA5DA6BE32A7BF35C7D583BDCE
          69A5BE31BDCF66FAFBF4FFFFFFDDE7B2A7BF34A9C038D3DE9FF5F6F2E7ECD1E4
          E9C8F0F2E5D1DC9BB0C54AA5BD2FA5BE30A7BF35DDE7B2FFFFFFFFFFFFFBFCF6
          C7D67EA6BE31A9C038C4D37BE2E8C4F1F3E9F9F8FBEEF1E1C1D173A6BE31A6BE
          32C7D67EFBFCF6FFFFFFFFFFFFFFFFFFF7F9EDC7D67EA7BF34A5BD30A8BF37C6
          D580D8E1ACB5C855A6BE33A7BF35C7D67EF7F9EDFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFBFCF6DDE7B2BDCF66ADC342ACC240ABC13DACC241BDCF66DDE7B2FBFC
          F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFBF4EDF2D5E3
          EABEE3EBBEEDF2D5FAFBF4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton7Click
      end
      object suiButton6: TBitBtn
        Left = 79
        Top = 549
        Width = 100
        Height = 22
        Caption = #20445#23384#26816#39564#21333'F3'
        TabOrder = 25
        OnClick = suiButton6Click
      end
      object LabeledEdit1: TLabeledEdit
        Left = 79
        Top = 54
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 39
        EditLabel.Height = 13
        EditLabel.Caption = #32852#26426#21495
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 1
        OnKeyDown = LabeledEdit1KeyDown
      end
      object LabeledEdit2: TLabeledEdit
        Left = 79
        Top = 74
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 72
        EditLabel.Height = 13
        EditLabel.Caption = #38376#35786'/'#20303#38498#21495
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 2
        OnKeyDown = LabeledEdit2KeyDown
      end
      object LabeledEdit3: TLabeledEdit
        Left = 79
        Top = 94
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #22995#21517
        ImeMode = imOpen
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 3
        OnChange = LabeledEdit3Change
      end
      object LabeledEdit5: TLabeledEdit
        Left = 79
        Top = 136
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #24180#40836
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 5
        OnExit = LabeledEdit5Exit
      end
      object LabeledEdit7: TLabeledEdit
        Left = 79
        Top = 178
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #24202#21495
        ImeMode = imOpen
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 7
      end
      object DateTimePicker1: TDateTimePicker
        Left = 79
        Top = 284
        Width = 100
        Height = 21
        Date = 37833.628041087960000000
        Time = 37833.628041087960000000
        TabOrder = 12
      end
      object LabeledEdit14: TLabeledEdit
        Left = 79
        Top = 264
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #20020#24202#35786#26029
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 11
        OnKeyDown = LabeledEdit14KeyDown
      end
      object LabeledEdit15: TLabeledEdit
        Left = 79
        Top = 369
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #22791#27880
        ImeMode = imOpen
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 16
        OnKeyDown = LabeledEdit15KeyDown
      end
      object DateTimePicker2: TDateTimePicker
        Left = 79
        Top = 326
        Width = 100
        Height = 21
        Date = 37833.628041087960000000
        Time = 37833.628041087960000000
        TabOrder = 14
      end
      object LabeledEdit16: TLabeledEdit
        Left = 79
        Top = 34
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 39
        EditLabel.Height = 13
        EditLabel.Caption = #27969#27700#21495
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 0
        OnExit = LabeledEdit16Exit
      end
      object DateTimePicker3: TDateTimePicker
        Left = 79
        Top = 305
        Width = 100
        Height = 21
        Date = 38238.447083333330000000
        Time = 38238.447083333330000000
        Kind = dtkTime
        TabOrder = 13
      end
      object DateTimePicker4: TDateTimePicker
        Left = 79
        Top = 347
        Width = 100
        Height = 21
        Date = 38238.447083333330000000
        Time = 38238.447083333330000000
        Kind = dtkTime
        TabOrder = 15
      end
      object CheckBox1: TCheckBox
        Left = 79
        Top = 571
        Width = 73
        Height = 17
        Caption = #36830#32493#24405#20837
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 26
      end
      object lbedtWorkID: TLabeledEdit
        Left = 79
        Top = 389
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #24037#21495
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 17
      end
      object lbedtWorkCompany: TLabeledEdit
        Left = 79
        Top = 409
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #25152#23646#20844#21496
        ImeMode = imOpen
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 18
        OnKeyDown = lbedtWorkCompanyKeyDown
      end
      object lbedtWorkDepartment: TLabeledEdit
        Left = 79
        Top = 429
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #25152#23646#37096#38376
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 19
        OnKeyDown = lbedtWorkDepartmentKeyDown
      end
      object lbedtWorkCategory: TLabeledEdit
        Left = 79
        Top = 449
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #24037#31181
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 20
        OnKeyDown = lbedtWorkCategoryKeyDown
      end
      object lbedtifMarry: TLabeledEdit
        Left = 79
        Top = 469
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #23130#21542
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 21
        OnExit = lbedtifMarryExit
      end
      object lbedtOldAddress: TLabeledEdit
        Left = 79
        Top = 489
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #31821#36143
        ImeMode = imOpen
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 22
      end
      object lbedtAddress: TLabeledEdit
        Left = 79
        Top = 509
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #20303#22336
        ImeMode = imOpen
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 23
      end
      object lbedtTelephone: TLabeledEdit
        Left = 79
        Top = 529
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #30005#35805
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 24
      end
      object LabeledEdit12: TComboBox
        Left = 79
        Top = 12
        Width = 100
        Height = 21
        BevelKind = bkFlat
        ItemHeight = 13
        TabOrder = 27
        OnKeyDown = LabeledEdit12KeyDown
      end
      object LabeledEdit4: TComboBox
        Left = 79
        Top = 114
        Width = 100
        Height = 21
        BevelKind = bkFlat
        ItemHeight = 13
        TabOrder = 4
        OnKeyDown = LabeledEdit4KeyDown
      end
      object LabeledEdit6: TComboBox
        Left = 79
        Top = 156
        Width = 78
        Height = 21
        BevelKind = bkFlat
        DropDownCount = 20
        ItemHeight = 13
        TabOrder = 6
        OnKeyDown = LabeledEdit6KeyDown
      end
      object LabeledEdit10: TComboBox
        Left = 79
        Top = 198
        Width = 78
        Height = 21
        BevelKind = bkFlat
        DropDownCount = 20
        ItemHeight = 13
        TabOrder = 8
        OnKeyDown = LabeledEdit10KeyDown
      end
      object LabeledEdit8: TComboBox
        Left = 79
        Top = 220
        Width = 78
        Height = 21
        BevelKind = bkFlat
        DropDownCount = 20
        ItemHeight = 13
        TabOrder = 9
        OnKeyDown = LabeledEdit8KeyDown
      end
      object LabeledEdit9: TComboBox
        Left = 79
        Top = 242
        Width = 78
        Height = 21
        BevelKind = bkFlat
        DropDownCount = 20
        ItemHeight = 13
        TabOrder = 10
        OnKeyDown = LabeledEdit9KeyDown
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 627
    Width = 884
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Text = #25805#20316#20154#21592#24037#21495':'
        Width = 82
      end
      item
        Width = 100
      end
      item
        Text = #25805#20316#20154#21592#22995#21517':'
        Width = 82
      end
      item
        Width = 70
      end
      item
        Text = #25480#26435#20351#29992#21333#20301':'
        Width = 82
      end
      item
        Width = 200
      end
      item
        Text = #26381#21153#21517':'
        Width = 47
      end
      item
        Width = 150
      end
      item
        Text = #25968#25454#24211':'
        Width = 47
      end
      item
        Width = 50
      end>
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 349
    Top = 375
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 114
      OnExecute = suiButton6Click
    end
    object Action2: TAction
      Caption = 'Action2'
      ShortCut = 115
      OnExecute = ToolButton1Click
    end
    object Action4: TAction
      Caption = 'Action4'
      ShortCut = 116
      OnExecute = suiButton8Click
    end
    object Action5: TAction
      Caption = 'Action5'
      ShortCut = 120
      OnExecute = suiButton1Click
    end
    object Action6: TAction
      Caption = 'Action6'
      ShortCut = 117
      OnExecute = suiButton3Click
    end
    object Action7: TAction
      Caption = 'Action7'
      ShortCut = 119
      OnExecute = suiButton4Click
    end
    object Action10: TAction
      Caption = 'Action10'
      ShortCut = 118
      OnExecute = ToolButton8Click
    end
    object Action3: TAction
      Caption = 'Action3'
      ShortCut = 113
      OnExecute = SpeedButton5Click
    end
    object Action8: TAction
      Caption = 'Action8'
      ShortCut = 123
    end
  end
  object ImageList1: TImageList
    Left = 451
    Top = 375
    Bitmap = {
      494C01010F001400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000C6C6C6008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000C6C6
      C600840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000C6C6C6008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000C6C6C600840000008400
      000084000000000000000000000000000000000000000000000084848400C6C6
      C600FFFFFF008484840000000000840000000000000000000000000000000000
      00000000840000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600FFFFFF008484840084000000840000008400
      0000000000000000000000000000000000000000000084848400C6C6C600C6C6
      C600C6C6C600FFFFFF0084848400000000000000000000000000000000000000
      84000000840000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484008484840084848400C6C6C600C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF0084848400000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00000000000000000000000000000084000000
      8400000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00000000000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      0000C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      84000000840000000000000000000000840000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00C6C6C600C6C6C60084848400000000000000000000000000000000000000
      0000000084000000000000000000000084000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600C6C6C6008484840000000000000000000000000000000000000000000000
      000000000000000000000000000000008400000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C60000000000C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFF0000FFFF0000C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C60084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000084000000840000008400000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000084848400C6C6C600C6C6C6008484
      84000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000084848400C6C6C600C6C6C600FFFF00008484
      84008484840000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      84000084840000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6C6008484
      8400C6C6C60000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      00000084840000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C6C6C600FFFF0000C6C6C600C6C6C6008484
      8400C6C6C60000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000084848400FFFF0000FFFF0000C6C6C6008484
      84008484840000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF0000000000C6C6C60000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000084848400C6C6C600C6C6C6008484
      84000000000000000000000000000000000000000000FFFFFF0000000000C6C6
      C60000000000FFFFFF0000000000C6C6C60000000000C6C6C600000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000084000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000C6C6C60000000000C6C6C60000000000C6C6C60000000000C6C6C600C6C6
      C600C6C6C6000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000000000
      0000000000008400000084000000840000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000C6C6C60000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084000000840000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000000000
      0000000000008400000084000000840000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084000000840000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000000000
      0000000000008400000084000000840000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60000000000C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00000000000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400008484000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084848400008484008484
      8400008484008484840084000000FFFFFF000000000000000000000000000000
      00000000000000000000FFFFFF00840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00840000000000000000848400848484000084
      8400848484000084840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084848400008484008484
      8400008484008484840084000000FFFFFF00000000000000000000000000FFFF
      FF00840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084000000840000008400
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00840000000000000000848400848484000084
      8400848484000084840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084000000FFFFFF0084000000000000000000000000000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084848400008484008484
      8400008484008484840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00840000008400000000000000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000FFFF
      FF00840000008400000084000000840000000000000000848400848484000084
      8400848484000084840084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084000000FFFFFF0084000000000000000000000084848400008484008484
      8400008484008484840000848400848484000084840084848400008484008484
      8400008484000000000000000000000000000000000000000000840000008400
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00840000008400000000000000000000000000000000848400848484000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000840000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000FFFFFF0000000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000084848400848484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600000000008484
      8400008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400848484000084
      84000000000000FFFF00000000000000000000FFFF0000000000848484000084
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFF3FFFFFFFF0000FFE1FF3FC0070000
      FFC1FE3F80030000FF83C07F00010000F00780F700010000C00F00E700010000
      801F00C100000000801F00E600000000000F00F680000000000F81FEC0000000
      000FC3BFE0010000000FFFB7E0070000801FFFB3F0070000801FFFC1F0030000
      C03FFFF3F8030000F0FFFFF7FFFF0000FFFFFFFFFFFFFFFFC001000C000FF9FF
      80010008000FF9FF80010001000FF3C780010003000F73C780010003000F27FF
      80010003000F07C780010003000F00C780010003000F01E380010007000403F1
      8001000F000006388001000F00000E388001000FF8001E388001001FFC003F01
      8001003FFE047F83FFFF007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFEFFDC007001FFFFFC7FFC007000FFFFFC3FBC0070007EFFFE3F7C0070003
      EF83F1E7C0070001DFC3F8CFC0070000DFE3FC1FC007001FDFD3FE3FC007001F
      EF3BFC1FC007001FF0FFF8CFC0078FF1FFFFE1E7C00FFFF9FFFFC3F3C01FFF75
      FFFFC7FDC03FFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFC00FFFF
      F6CFFE008000FFFFF6B7FE000000FFFFF6B7FE000000FFFFF8B780000000FFF7
      FE8F80000001C1F7FE3F80000003C3FBFF7F80000003C7FBFE3F80010003CBFB
      FEBF80030003DCF7FC9F80070003FF0FFDDF807F0003FFFFFDDF80FF8007FFFF
      FDDF81FFF87FFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ADObasic: TADOQuery
    CursorType = ctStatic
    AfterOpen = ADObasicAfterOpen
    AfterScroll = ADObasicAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select checkid as '#26816#39564#21333#21495',patientname as '#22995#21517',sex as '#24615#21035','
      '    age as '#24180#40836',caseno as '#30149#21382#21495',bedno as '#24202#21495',deptname as '#37096#38376#21517#31216','
      
        '    check_date as '#26816#26597#26085#26399',check_doctor as '#36865#26816#21307#29983',report_doctor as '#23457#26680#32773 +
        ','
      '    report_date as '#25253#21578#26085#26399','
      '    operator as '#25805#20316#32773',printtimes as '#25171#21360#27425#25968',diagnosetype as '#35786#26029#31867#22411','
      '    flagetype as '#26679#26412#31867#22411',diagnose as '#20020#24202#35786#26029',typeflagcase as '#26679#26412#24773#20917','
      '    issure as '#26159#21542#30830#35748',unid as '#21807#19968#32534#21495' from chk_con')
    Left = 225
    Top = 183
  end
  object DSbasic: TDataSource
    DataSet = ADObasic
    Left = 259
    Top = 183
  end
  object ADO_dtl: TADOQuery
    CursorType = ctStatic
    AfterOpen = ADO_dtlAfterOpen
    BeforeClose = ADO_dtlBeforeClose
    BeforePost = ADO_dtlBeforePost
    AfterPost = ADO_dtlAfterPost
    AfterScroll = ADO_dtlAfterScroll
    Parameters = <
      item
        Name = 'pkunid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'select name '#21517#31216',english_name as '#33521#25991#21517',itemvalue as '#26816#39564#32467#26524','
      'itemvalue_hist as '#26368#36817#26816#39564#32467#26524',check_date_hist as '#26368#36817#26816#39564#26085#26399','
      'itemvalue_hist2 as '#31532#20108#27425#26816#39564#32467#26524',check_date_hist2 as '#31532#20108#27425#26816#39564#26085#26399','
      'itemvalue_hist3 as '#31532#19968#27425#26816#39564#32467#26524',check_date_hist3 as '#31532#19968#27425#26816#39564#26085#26399',        '
      'unit as '#21333#20301',min_value as '#26368#23567#20540','
      'max_value as '#26368#22823#20540',printorder as '#25171#21360#32534#21495',issure as '#26159#21542#30830#35748','
      'itemid as '#20027#39033#30446#32534#21495',pkcombin_id as '#32452#21512#39033#30446#21495',valueid as '#39033#30446#32534#21495','
      'pkunid as '#23545#24212#21333#21495' from chk_valu')
    Left = 225
    Top = 215
  end
  object DS_dtl: TDataSource
    DataSet = ADO_dtl
    Left = 258
    Top = 216
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    Images = ImageList1
    OwnerDraw = True
    Left = 416
    Top = 375
    object File1: TMenuItem
      Caption = #25991#20214
      Hint = 'File related commands'
      object FileNewItem: TMenuItem
        Caption = #20999#25442#24080#21495
        OnClick = FileNewItemClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object N85: TMenuItem
        Caption = #20462#25913#23494#30721
        OnClick = N85Click
      end
      object N86: TMenuItem
        Caption = '-'
      end
      object FileOpenItem: TMenuItem
        Caption = #36864#20986#31995#32479
        OnClick = FileOpenItemClick
      end
    end
    object N2: TMenuItem
      Caption = #20449#24687#24405#20837
      object N3: TMenuItem
        Caption = #25209#37327#20449#24687#24405#20837
        OnClick = N3Click
      end
      object N26: TMenuItem
        Caption = #32467#26524#25209#37327#20462#25913
        OnClick = N26Click
      end
      object N34: TMenuItem
        Caption = '-'
      end
      object Excel2: TMenuItem
        Caption = #20174'Excel'#23548#20837#30149#20154#20449#24687
        OnClick = Excel2Click
      end
      object N35: TMenuItem
        Caption = '-'
      end
      object N16: TMenuItem
        Caption = #22797#21046#24037#20316#32452#30149#20154#22522#26412#20449#24687
        OnClick = N16Click
      end
      object N67: TMenuItem
        Caption = '-'
      end
      object N46: TMenuItem
        Caption = #25209#37327#21024#38500
        OnClick = N46Click
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object N4: TMenuItem
        Caption = #32467#26463#24403#25209#26816#39564#24037#20316
        OnClick = N4Click
      end
    end
    object N13: TMenuItem
      Caption = #23457#26680
      object N15: TMenuItem
        Caption = #25209#37327#23457#26680
        OnClick = N15Click
      end
    end
    object N18: TMenuItem
      Caption = #26597#35810#32479#35745
      object Q1: TMenuItem
        Caption = #26597#35810
        OnClick = Q1Click
      end
      object Excel1: TMenuItem
        Caption = #32467#26524#32437#21521#23548#20986
        OnClick = Excel1Click
      end
      object N33: TMenuItem
        Caption = #32467#26524#27178#21521#23548#20986
        OnClick = N33Click
      end
      object N27: TMenuItem
        Caption = '-'
      end
      object N20: TMenuItem
        Caption = #32479#35745
        OnClick = N20Click
      end
      object Y1: TMenuItem
        Caption = #25353#32452#21512#39033#30446#32479#35745
        OnClick = Y1Click
      end
    end
    object N5: TMenuItem
      Caption = #25171#21360#36873#25321
      object N6: TMenuItem
        AutoHotkeys = maManual
        Caption = #25209#37327#25171#21360
        OnClick = N6Click
      end
      object N44: TMenuItem
        Caption = #25171#21360#27599#26085#23384#26681
        OnClick = N44Click
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object N25: TMenuItem
        Caption = #26159#21542#25353#32452#20998#39029
        OnClick = N25Click
      end
      object N64: TMenuItem
        Caption = #25353#22995#21517#24615#21035#24180#40836#21512#24182
        OnClick = N64Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object N8: TMenuItem
        Caption = #30452#25509#25171#21360#27169#24335
        Checked = True
        RadioItem = True
        OnClick = N8Click
      end
      object N9: TMenuItem
        Caption = #25171#21360#39044#35272#27169#24335
        RadioItem = True
        OnClick = N9Click
      end
    end
    object N21: TMenuItem
      Caption = #36136#37327#25511#21046
      object LJ1: TMenuItem
        Caption = #22810#20540'L-J'#36136#25511#22270
        OnClick = LJ1Click
      end
    end
    object Edit1: TMenuItem
      Caption = #31995#32479#35774#32622
      Hint = 'Edit commands'
      object N42: TMenuItem
        Caption = #36890#29992#20195#30721
        OnClick = N42Click
      end
      object N30: TMenuItem
        Caption = #20154#21592#35774#32622
        OnClick = N30Click
      end
      object N28: TMenuItem
        Caption = #39033#30446#35774#32622
        OnClick = N28Click
      end
      object N19: TMenuItem
        Caption = #35774#22791#31649#29702
        OnClick = N19Click
      end
      object N32: TMenuItem
        Caption = #32791#26448#22522#26412#20449#24687
        OnClick = N32Click
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object N41: TMenuItem
        Caption = #23454#26102#26174#31034#20256#36755#25968#25454
        OnClick = N41Click
      end
      object O1: TMenuItem
        Caption = #36873#39033
        OnClick = O1Click
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object N50: TMenuItem
        Caption = #26174#31034#39033#30446#33521#25991#21517
        OnClick = N50Click
      end
      object N36: TMenuItem
        Caption = #26174#31034#39033#30446#19979#38480
        OnClick = N36Click
      end
      object N47: TMenuItem
        Caption = #26174#31034#39033#30446#19978#38480
        OnClick = N47Click
      end
      object N49: TMenuItem
        Caption = #26174#31034#39033#30446#21333#20301
        OnClick = N49Click
      end
      object N62: TMenuItem
        Caption = '-'
      end
      object N63: TMenuItem
        Caption = #20307#26816#27169#26495#31867#22411#35774#32622
        OnClick = N63Click
      end
      object M1: TMenuItem
        Caption = #20307#26816#27169#26495#35774#32622
        OnClick = M1Click
      end
    end
    object N65: TMenuItem
      Caption = #24037#20855
    end
    object Help1: TMenuItem
      Caption = #24110#21161
      Hint = 'Help topics'
      object N37: TMenuItem
        Caption = #27880#20876
        OnClick = N37Click
      end
      object HelpAboutItem: TMenuItem
        Caption = #20851#20110'...'
        Hint = 
          'About|Displays program information, version number, and copyrigh' +
          't'
        OnClick = HelpAbout1Execute
      end
    end
  end
  object LYAboutBox1: TLYAboutBox
    ProcuctName = 'ProductName'
    Version = 'Version'
    Copyright = 'Copyright'
    Comments = 'Comments'
    Author = 'Author'
    WebPage = 'WebPage'
    Left = 315
    Top = 375
  end
  object ADO_print: TADOQuery
    Parameters = <>
    Left = 225
    Top = 253
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 548
    Top = 376
    object N40: TMenuItem
      Caption = #21551#29992'/'#23631#34109#20449#24687#26694
    end
    object N38: TMenuItem
      Caption = '-'
    end
    object N31: TMenuItem
      Caption = #27969#27700#21495
      OnClick = N31Click
    end
    object N39: TMenuItem
      Caption = #38376#35786#20303#38498#21495
      OnClick = N39Click
    end
    object N43: TMenuItem
      Caption = #36865#26816#31185#23460
      OnClick = N43Click
    end
    object N51: TMenuItem
      Caption = #24202#21495
      OnClick = N51Click
    end
    object N52: TMenuItem
      Caption = #36865#26816#21307#29983
      OnClick = N52Click
    end
    object N53: TMenuItem
      Caption = #26679#26412#31867#22411
      OnClick = N53Click
    end
    object N54: TMenuItem
      Caption = #26679#26412#29366#24577
      OnClick = N54Click
    end
    object N55: TMenuItem
      Caption = #20020#24202#35786#26029
      OnClick = N55Click
    end
    object N56: TMenuItem
      Caption = #30003#35831#26085#26399
      OnClick = N56Click
    end
    object N57: TMenuItem
      Caption = #30003#35831#26102#38388
      OnClick = N57Click
    end
    object N58: TMenuItem
      Caption = #26816#26597#26085#26399
      OnClick = N58Click
    end
    object N59: TMenuItem
      Caption = #26816#26597#26102#38388
      OnClick = N59Click
    end
    object N61: TMenuItem
      Caption = #22791#27880
      OnClick = N61Click
    end
    object N77: TMenuItem
      Caption = #24037#21495
      OnClick = N77Click
    end
    object N78: TMenuItem
      Caption = #25152#23646#20844#21496
      OnClick = N78Click
    end
    object N79: TMenuItem
      Caption = #25152#23646#37096#38376
      OnClick = N79Click
    end
    object N80: TMenuItem
      Caption = #24037#31181
      OnClick = N80Click
    end
    object N81: TMenuItem
      Caption = #23130#21542
      OnClick = N81Click
    end
    object N82: TMenuItem
      Caption = #31821#36143
      OnClick = N82Click
    end
    object N83: TMenuItem
      Caption = #20303#22336
      OnClick = N83Click
    end
    object N84: TMenuItem
      Caption = #30005#35805
      OnClick = N84Click
    end
    object N68: TMenuItem
      Caption = '-'
    end
    object N69: TMenuItem
      Caption = #22797#21046#30149#20154#20449#24687
      OnClick = N69Click
    end
    object N70: TMenuItem
      Caption = #31896#36148#30149#20154#20449#24687
      OnClick = N70Click
    end
  end
  object pmChangeGroup: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = pmChangeGroupPopup
    Left = 584
    Top = 377
    object N29: TMenuItem
      Caption = #29983#25104#20307#26816#32467#35770
      OnClick = N29Click
    end
    object N76: TMenuItem
      Caption = #21333#20010#29983#25104#20307#26816#32467#35770
      OnClick = N76Click
    end
    object N22: TMenuItem
      Caption = '-'
    end
    object N11: TMenuItem
      Caption = #26356#25442#32452#21035
    end
    object N72: TMenuItem
      Caption = '-'
    end
  end
  object frReport1: TfrReport
    Dataset = frDB_ADO_print
    InitialZoom = pzDefault
    ModifyPrepared = False
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    ShowPrintDialog = False
    ShowProgress = False
    RebuildPrinter = False
    OnGetValue = frReport1GetValue
    OnBeforePrint = frReport1BeforePrint
    OnPrintReport = frReport1PrintReport
    Left = 483
    Top = 375
    ReportForm = {19000000}
  end
  object frDB_ADO_print: TfrDBDataSet
    DataSet = ADO_print
    Left = 483
    Top = 406
  end
  object DosMove1: TDosMove
    Active = True
    Left = 382
    Top = 375
  end
  object TimerIdleTracker: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = TimerIdleTrackerTimer
    Left = 496
    Top = 245
  end
  object PopupMenu2: TPopupMenu
    AutoHotkeys = maManual
    Left = 632
    Top = 377
    object N71: TMenuItem
      Caption = #26032#22686#22270#29255#39033#30446
      OnClick = N71Click
    end
    object N66: TMenuItem
      Caption = '-'
    end
    object N23: TMenuItem
      Caption = #20462#25913#39033#30446#22270#29255
      OnClick = N23Click
    end
    object N45: TMenuItem
      Caption = '-'
    end
    object N48: TMenuItem
      Caption = #21024#38500#39033#30446#22270#29255
      OnClick = N48Click
    end
    object N73: TMenuItem
      Caption = '-'
    end
    object N74: TMenuItem
      Caption = #26174#31034#39033#30446#22270#29255
      OnClick = N74Click
    end
    object N60: TMenuItem
      Caption = '-'
    end
    object N75: TMenuItem
      Caption = #21382#21490#32467#26524
      OnClick = N75Click
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 632
    Top = 349
  end
  object PopupMenu3: TPopupMenu
    AutoHotkeys = maManual
    Left = 477
    Top = 102
    object N17: TMenuItem
      Caption = #31227#38500
      OnClick = N17Click
    end
  end
  object TimerMakeTjDescription: TTimer
    Interval = 30000
    OnTimer = TimerMakeTjDescriptionTimer
    Left = 717
    Top = 377
  end
end

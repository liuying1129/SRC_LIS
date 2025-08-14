object frmMain: TfrmMain
  Left = 225
  Top = 78
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #26679#26412#25509#25910' - '#26631#20934#29256
  ClientHeight = 561
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 784
    Height = 376
    Align = alClient
    TabOrder = 0
    object Panel3: TPanel
      Left = 2
      Top = 50
      Width = 780
      Height = 50
      Align = alTop
      TabOrder = 1
      object LabeledEdit2: TLabeledEdit
        Left = 128
        Top = 24
        Width = 53
        Height = 21
        TabStop = False
        Color = clMenu
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #22995#21517
        ReadOnly = True
        TabOrder = 0
      end
      object LabeledEdit3: TLabeledEdit
        Left = 183
        Top = 24
        Width = 28
        Height = 21
        TabStop = False
        Color = clMenu
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #24615#21035
        ReadOnly = True
        TabOrder = 1
      end
      object LabeledEdit4: TLabeledEdit
        Left = 213
        Top = 24
        Width = 28
        Height = 21
        TabStop = False
        Color = clMenu
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #24180#40836
        ReadOnly = True
        TabOrder = 2
      end
      object LabeledEdit7: TLabeledEdit
        Left = 6
        Top = 24
        Width = 120
        Height = 21
        TabStop = False
        Color = clMenu
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #26465#30721
        ReadOnly = True
        TabOrder = 3
      end
      object LabeledEdit9: TLabeledEdit
        Left = 385
        Top = 24
        Width = 53
        Height = 21
        TabStop = False
        Color = clMenu
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #30149#20154#31867#21035
        ReadOnly = True
        TabOrder = 4
      end
      object LabeledEdit8: TLabeledEdit
        Left = 440
        Top = 24
        Width = 53
        Height = 21
        TabStop = False
        Color = clMenu
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #30003#35831#31185#23460
        ReadOnly = True
        TabOrder = 5
      end
      object LabeledEdit10: TLabeledEdit
        Left = 495
        Top = 24
        Width = 53
        Height = 21
        TabStop = False
        Color = clMenu
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #30003#35831#21307#29983
        ReadOnly = True
        TabOrder = 6
      end
      object LabeledEdit11: TLabeledEdit
        Left = 550
        Top = 24
        Width = 140
        Height = 21
        TabStop = False
        Color = clMenu
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #30003#35831#26102#38388
        ReadOnly = True
        TabOrder = 7
      end
      object LabeledEdit5: TLabeledEdit
        Left = 692
        Top = 24
        Width = 80
        Height = 21
        TabStop = False
        Color = clMenu
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #26679#26412#31867#22411
        ReadOnly = True
        TabOrder = 8
      end
      object Edit2: TEdit
        Left = 241
        Top = 24
        Width = 28
        Height = 21
        TabStop = False
        Color = clMenu
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
      end
      object LabeledEdit6: TLabeledEdit
        Left = 272
        Top = 24
        Width = 105
        Height = 21
        TabStop = False
        Color = clMenu
        EditLabel.Width = 104
        EditLabel.Height = 13
        EditLabel.Caption = #22806#37096#31995#32479#21807#19968#32534#21495
        ReadOnly = True
        TabOrder = 10
      end
    end
    object Panel4: TPanel
      Left = 2
      Top = 341
      Width = 780
      Height = 33
      Align = alBottom
      TabOrder = 2
      object Label1: TLabel
        Left = 512
        Top = 8
        Width = 254
        Height = 13
        Caption = #27880#65306'1'#12289#20462#25913#30456#21516#24037#20316#32452#31532#19968#26465#30340#32852#26426#21495#21363#21487
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object BitBtn1: TSpeedButton
        Left = 7
        Top = 6
        Width = 100
        Height = 22
        Caption = #23548#20837'LIS(F3)'
        OnClick = BitBtn1Click
      end
      object CheckBox1: TCheckBox
        Left = 156
        Top = 8
        Width = 250
        Height = 17
        TabStop = False
        Caption = #26080#38656#28857#20987#23548#20837#25353#38062','#25195#25551#21518#30452#25509#23548#20837'LIS'
        TabOrder = 0
        OnClick = CheckBox1Click
      end
    end
    object Memo1: TMemo
      Left = 2
      Top = 100
      Width = 780
      Height = 89
      Align = alTop
      Color = clMenu
      ReadOnly = True
      TabOrder = 3
    end
    object DBGrid1: TDBGridEh
      Left = 2
      Top = 189
      Width = 780
      Height = 152
      Align = alClient
      AllowedSelections = [gstRecordBookmarks, gstRectangle, gstColumns]
      DataSource = DataSource1
      DynProps = <>
      IndicatorOptions = [gioShowRowIndicatorEh, gioShowRowselCheckboxesEh]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
      TabOrder = 4
      OnKeyDown = DBGrid1KeyDown
      OnKeyUp = DBGrid1KeyUp
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 780
      Height = 35
      Align = alTop
      TabOrder = 0
      object SpeedButton1: TSpeedButton
        Left = 740
        Top = 6
        Width = 23
        Height = 22
        Hint = #26597#30475#30003#35831#21333
        Caption = #65311
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton1Click
      end
      object SpeedButton2: TSpeedButton
        Left = 704
        Top = 6
        Width = 23
        Height = 22
        Hint = #35774#32622
        Glyph.Data = {
          76030000424D7603000000000000360000002800000011000000100000000100
          18000000000040030000C30E0000C30E00000000000000000000CCFEFDCCFEFD
          CCFEFDCCFEFDCCFEFDCCFEFDCCFEFDCCFEFDCCFEFDCCFEFD0000000000000000
          00CCFEFDCCFEFDCCFEFDCCFEFD00CCFEFDCCFEFDCCFEFDCCFEFDCCFEFDCCFEFD
          CCFEFD000000000000CCFEFD000000008484000000CCFEFD000000000000CCFE
          FD00CCFEFDCCFEFDCCFEFDCCFEFDCCFEFDCCFEFD00000000FFFF008484000000
          00000000FFFF00000000000000848400848400000000CCFEFDCCFEFDCCFEFDCC
          FEFDCCFEFDCCFEFDCCFEFD00000000FFFF008484008484FFFFFF000000008484
          00FFFF000000CCFEFD00CCFEFDCCFEFDCCFEFDCCFEFDCCFEFDCCFEFD00000000
          848400000000FFFFFFFFFF00FFFFFFFFFF00FFFF00000000848400000000CCFE
          FDCCFEFDCCFEFDCCFEFDCCFEFDCCFEFD00000000848400FFFFFFFFFF00000000
          0000000000FFFFFF00FFFF00848400000000CCFEFDCCFEFD000000000000CCFE
          FD000000000000000000008484000000000000FFFFFF000000000000FFFFFF00
          000000000000CCFEFD000000FFFFFF84848400000000000084848400000000FF
          FF008484848484FFFFFF00000000FFFF008484000000CCFEFD00CCFEFDCCFEFD
          000000C6C6C6848484848484FFFFFF000000008484000000000000FFFFFF0000
          0000000000FFFF000000CCFEFD00CCFEFD000000848484000000FFFFFF848484
          FFFFFFFFFFFF000000FFFFFFC6C6C6848484CCFEFDCCFEFD000000CCFEFDCCFE
          FD00CCFEFD000000C6C6C6FFFFFFFFFFFF000000000000000000FFFFFFFFFFFF
          FFFFFF000000CCFEFDCCFEFDCCFEFDCCFEFDCCFEFD00CCFEFD84848400000084
          8484000000000000FFFFFF000000000000848484000000000000CCFEFDCCFEFD
          CCFEFDCCFEFDCCFEFD00CCFEFDCCFEFD000000FFFFFFFFFFFF000000FFFFFF00
          0000FFFFFFC6C6C6000000CCFEFDCCFEFDCCFEFDCCFEFDCCFEFDCCFEFD00CCFE
          FDCCFEFD848484C6C6C6000000FFFFFF848484000000000000FFFFFF000000CC
          FEFDCCFEFDCCFEFDCCFEFDCCFEFDCCFEFD00CCFEFDCCFEFDCCFEFD848484CCFE
          FD000000FFFFFF000000CCFEFD000000CCFEFDCCFEFDCCFEFDCCFEFDCCFEFDCC
          FEFDCCFEFD00CCFEFDCCFEFDCCFEFDCCFEFDCCFEFDCCFEFD848484CCFEFDCCFE
          FDCCFEFDCCFEFDCCFEFDCCFEFDCCFEFDCCFEFDCCFEFDCCFEFD00}
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton2Click
      end
      object SpeedButton3: TSpeedButton
        Left = 671
        Top = 6
        Width = 23
        Height = 22
        Hint = #36873#39033
        Glyph.Data = {
          4E010000424D4E01000000000000760000002800000014000000120000000100
          040000000000D8000000130B0000130B00001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333000030000000000000000003000030FFFFFFFFFFFFFFFF03000030FF
          F0FFFFFFFFFFFF03000030FF000FFFFFFFFFFF03000030F00F00FFFFFFFFFF03
          000030FFFFF00FFFFFFFFF03000030FFFFFF00FFFFFFFF03000030FFF0FFFFFF
          FFFFFF03000030FF000FFFFFFFFFFF03000030F00F00FFFFFFFFFF03000030FF
          FFF00FFFFFFFFF03000030FFFFFF00FFFFFFFF03000030FFFFFFFFFFFFFFFF03
          00003000000000000000000324003080CCCCCCCCCC0808031400300000000000
          000000030000333333333333333333330000}
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton3Click
      end
      object LabeledEdit1: TLabeledEdit
        Left = 139
        Top = 7
        Width = 120
        Height = 21
        EditLabel.Width = 131
        EditLabel.Height = 13
        EditLabel.Caption = #25195#25551#25110#36755#20837#26465#30721'('#22238#36710')'
        LabelPosition = lpLeft
        TabOrder = 0
        OnKeyDown = LabeledEdit1KeyDown
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 542
    Width = 784
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
        Width = 50
      end>
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 376
    Width = 784
    Height = 166
    Align = alBottom
    Caption = #24050#25509#25910#26679#26412#21015#34920'('#27880':'#20165#26174#31034#26410#23457#26680#26816#39564#21333')'
    TabOrder = 2
    object DBGrid2: TDBGrid
      Left = 2
      Top = 45
      Width = 780
      Height = 119
      Align = alClient
      DataSource = DataSource2
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
    end
    object Panel2: TPanel
      Left = 2
      Top = 15
      Width = 780
      Height = 30
      Align = alTop
      TabOrder = 1
      object Label2: TLabel
        Left = 7
        Top = 9
        Width = 39
        Height = 13
        Caption = #24037#20316#32452
      end
      object Label3: TLabel
        Left = 200
        Top = 9
        Width = 247
        Height = 13
        Caption = #27880#65306#20026#31354#26102#26174#31034#25152#26377#24037#20316#32452#30340#26410#23457#26680#26816#39564#21333
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object ComboBox1: TComboBox
        Left = 48
        Top = 5
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        OnChange = ComboBox1Change
        OnDropDown = ComboBox1DropDown
      end
    end
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=Yklissa123;Persist Security Info=Tr' +
      'ue;User ID=sa;Initial Catalog=YkLis;Data Source=202.96.1.105'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 282
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = VirtualTable1
    Left = 40
    Top = 211
  end
  object VirtualTable1: TVirtualTable
    AfterOpen = VirtualTable1AfterOpen
    FieldDefs = <
      item
        Name = #22806#37096#31995#32479#39033#30446#30003#35831#32534#21495
        DataType = ftString
        Size = 20
      end
      item
        Name = 'HIS'#39033#30446#20195#30721
        DataType = ftString
        Size = 50
      end
      item
        Name = 'HIS'#39033#30446#21517#31216
        DataType = ftString
        Size = 100
      end
      item
        Name = 'LIS'#39033#30446#20195#30721
        DataType = ftString
        Size = 50
      end
      item
        Name = 'LIS'#39033#30446#21517#31216
        DataType = ftString
        Size = 100
      end
      item
        Name = #24037#20316#32452
        DataType = ftString
        Size = 50
      end
      item
        Name = #32852#26426#21495
        DataType = ftString
        Size = 20
      end>
    Left = 72
    Top = 211
    Data = {
      030007001400CDE2B2BFCFB5CDB3CFEEC4BFC9EAC7EBB1E0BAC5010014000000
      00000B00484953CFEEC4BFB4FAC2EB01003200000000000B00484953CFEEC4BF
      C3FBB3C601006400000000000B004C4953CFEEC4BFB4FAC2EB01003200000000
      000B004C4953CFEEC4BFC3FBB3C601006400000000000600B9A4D7F7D7E90100
      3200000000000600C1AABBFABAC50100140000000000000000000000}
  end
  object ActionList1: TActionList
    Left = 254
    Top = 8
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 114
      OnExecute = BitBtn1Click
    end
  end
  object UniConnExtSystem: TUniConnection
    Left = 409
    Top = 8
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery2
    Left = 97
    Top = 472
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection1
    AfterOpen = ADOQuery2AfterOpen
    Parameters = <>
    Left = 129
    Top = 472
  end
end

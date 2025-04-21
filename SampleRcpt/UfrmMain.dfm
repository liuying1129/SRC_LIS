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
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000025160000251600000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFE9D3FFB66DFFE9D3FFFFFFFFFFFFFFE7CFFFB66DFFE9D3FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC78FFFAC5AFFC285FFA54CFF
          B469FFB469FFA44BFFC388FFAB58FFC892FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFDCB9FFAD5CFFFDFCFFCE9DFFCD9BFFCD9BFFC489FFFEFDFFAA56FFE3
          C8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF8FFB164FFB66FFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFDFFB062FFBE7DFFFFFEFFFFFFFFFFFFFFF5EBFFE6CD
          FFC58CFFB163FFFBF8FFFFFFFFECDAFFC388FFC994FFF3E7FFFFFFFFF9F3FFAA
          56FFCD9CFFE6CDFFF6ECFFC387FFA041FF9D3DFFEDDCFFFFFFFFD2A4FFA144FF
          C387FFBC79FF9F41FFDEBDFFFFFFFFE4C9FF9D3BFFA042FFC48AFFAE5DFFE7D0
          FFFFFFFFFFFFFFEBD8FFA043FFF2E4FFFFFFFFFFFFFFE6CEFF9F41FFF6EDFFFF
          FFFFFFFFFFE6CEFFAF5FFFB76FFFA042FFDCB9FFFFFFFFD2A6FFC387FFFFFFFF
          FFFFFFFFFFFFFFFFFFB46AFFE0C2FFFFFFFFD1A3FF9F3FFFB873FFFFFFFFD5AB
          FFC081FFFFFFFFD3A8FFC388FFFFFFFFFFFFFFFFFFFFFFFFFFB46AFFE3C8FFFF
          FFFFB266FFE3C7FFFFFFFFFFFFFFE5CBFFAB58FFFFFFFFF1E4FFA449FFF2E4FF
          FFFFFFFFFFFFE8D2FFA54CFFFBF8FFFDFBFFA144FFF2E6FFFFFFFFFFFFFFF4E9
          FF9B38FFEEDDFFFFFFFFD3A8FFA043FFC387FFBC7AFFA043FFE1C3FFFFFFFFE5
          CBFFA64FFFF7EFFFFFFFFFFFFFFFA750FFBA75FFFBF7FFFFFFFFFFFFFFEFDEFF
          D3A8FFD7AFFFF3E8FFFFFFFFFFFFFFFDFCFFBF81FFAA55FFFFFFFFFFFFFFCE9D
          FFA954FFAB57FFA44AFFDCB9FFFDFCFFFFFFFFFFFFFFFDFBFFD9B3FFA144FFAC
          5AFFA953FFD0A1FFFFFFFFFFFFFFFFFEFFB974FFB367FFCA96FF9B39FFA449FF
          E9D3FFE7CFFFA245FFAD5BFFDEBDFFB163FFBA76FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFF4EAFFB66FFFD5ABFFD4AAFFC081FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCA95FF
          9B38FF9B38FFCA96FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
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
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000025160000251600000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFEFEF9FF6F6C6FFFFFFF4F4BFEAEA7FEAEA7FEAEA7FEA
          EA7FEAEA7FEAEA7FEAEA7FEAEA7FEAEA7FEAEA7FEAEA7FEFEF9FD6D600EAEA7F
          FFFFFFE0E040D6D600D6D600D6D600D6D600D6D600D6D600D6D600D6D600D6D6
          00D6D600D6D600D6D600FCFCEAFFFFFFFFFFFFFFFFFFF4F4BFF4F4BFF4F4BFF4
          F4BFF4F4BFF4F4BFF4F4BFF4F4BFF4F4BFF4F4BFF4F4BFFBFBE6FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFE7E76AEAEA7FFFFFFFEAEA7FE0E040E0E040E0E040E0
          E040E0E040E0E040E0E040E0E040E0E040E0E040E0E040E3E34DE7E76AEAEA7F
          FFFFFFEAEA7FE0E040E0E040E0E040E0E040E0E040E0E040E0E040E0E040E0E0
          40E0E040E0E040E3E34DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCEAFFFFFF
          FFFFFFFFFFFFF4F4BFF4F4BFF4F4BFF4F4BFF4F4BFF4F4BFF4F4BFF4F4BFF4F4
          BFF4F4BFF4F4BFFBFBE6D6D600EAEA7FFFFFFFE0E040D6D600D6D600D6D600D6
          D600D6D600D6D600D6D600D6D600D6D600D6D600D6D600D6D600EFEF9FF6F6C6
          FFFFFFF4F4BFEAEA7FEAEA7FEAEA7FEAEA7FEAEA7FEAEA7FEAEA7FEAEA7FEAEA
          7FEAEA7FEAEA7FEFEF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
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
      Top = 15
      Width = 780
      Height = 149
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

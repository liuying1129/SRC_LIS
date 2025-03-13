object frmMain: TfrmMain
  Left = 189
  Top = 77
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #25171#21360#26465#30721' - '#26631#20934#29256
  ClientHeight = 561
  ClientWidth = 904
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 904
    Height = 80
    Align = alTop
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 923
      Top = 21
      Width = 23
      Height = 22
      Hint = #26597#30475#33713#22495#30003#35831#21333
      Caption = #65311
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
    end
    object Label2: TLabel
      Left = 6
      Top = 8
      Width = 52
      Height = 13
      Caption = #30003#35831#26085#26399
    end
    object Label1: TLabel
      Left = 112
      Top = 28
      Width = 7
      Height = 13
      Caption = '-'
    end
    object RadioGroup1: TRadioGroup
      Left = 506
      Top = 13
      Width = 160
      Height = 32
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        #19981#38480
        #38376#35786
        #20303#38498)
      TabOrder = 0
    end
    object DateTimePicker1: TDateTimePicker
      Left = 6
      Top = 24
      Width = 105
      Height = 21
      Date = 45271.000000000000000000
      Time = 45271.000000000000000000
      TabOrder = 1
      TabStop = False
    end
    object DateTimePicker2: TDateTimePicker
      Left = 121
      Top = 24
      Width = 105
      Height = 21
      Date = 45271.999988425920000000
      Time = 45271.999988425920000000
      TabOrder = 2
      TabStop = False
    end
    object BitBtn2: TBitBtn
      Left = 6
      Top = 48
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 3
      OnClick = BitBtn2Click
    end
    object LabeledEdit1: TLabeledEdit
      Left = 240
      Top = 24
      Width = 121
      Height = 21
      EditLabel.Width = 118
      EditLabel.Height = 13
      EditLabel.Caption = #22995#21517'('#25903#25345#27169#31946#26597#35810')'
      TabOrder = 4
    end
    object LabeledEdit2: TLabeledEdit
      Left = 376
      Top = 24
      Width = 121
      Height = 21
      EditLabel.Width = 118
      EditLabel.Height = 13
      EditLabel.Caption = #31185#23460'('#25903#25345#27169#31946#26597#35810')'
      TabOrder = 5
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 80
    Width = 904
    Height = 462
    Align = alClient
    TabOrder = 1
    object Memo1: TMemo
      Left = 2
      Top = 378
      Width = 900
      Height = 82
      Align = alBottom
      Color = clMenu
      ReadOnly = True
      TabOrder = 0
    end
    object DBGridEh1: TDBGridEh
      Left = 2
      Top = 15
      Width = 900
      Height = 322
      Align = alClient
      AllowedSelections = [gstRecordBookmarks, gstRectangle, gstColumns]
      DataSource = DataSource1
      DynProps = <>
      IndicatorOptions = [gioShowRowIndicatorEh, gioShowRowselCheckboxesEh]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ReadOnly = True
      TabOrder = 1
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 337
      Width = 900
      Height = 41
      Align = alBottom
      TabOrder = 2
      object Label3: TLabel
        Left = 315
        Top = 2
        Width = 215
        Height = 13
        Caption = #27880#65306#22810#20010#39033#30446#21512#24182#20026'1'#20010#26465#30721#30340#26465#20214#65306
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 340
        Top = 15
        Width = 497
        Height = 13
        Caption = '1'#12289#19968#27425#24615#21246#36873#22810#20010#39033#30446'                 2'#12289#35813#30003#35831#39033#30446#27809#26377#29983#25104#36807#26465#30721#25165#20250#34987#21512#24182
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 340
        Top = 27
        Width = 493
        Height = 13
        Caption = '3'#12289#39033#30446#22312'LIS'#20013#35774#32622#20102#40664#35748#24037#20316#32452#19988#30456#21516'   4'#12289#39033#30446#22312'HIS'#20013#30340#26679#26412#31867#22411#26377#20540#19988#20540#30456#21516
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object BitBtn3: TBitBtn
        Left = 6
        Top = 8
        Width = 75
        Height = 25
        Caption = #25171#21360
        TabOrder = 0
        OnClick = BitBtn3Click
      end
      object RadioGroup2: TRadioGroup
        Left = 112
        Top = 3
        Width = 185
        Height = 32
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #25171#21360#39044#35272
          #30452#25509#25171#21360)
        TabOrder = 1
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 542
    Width = 904
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
  object UniConnExtSystem: TUniConnection
    Left = 781
    Top = 8
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=Yklissa123;Persist Security Info=Tr' +
      'ue;User ID=sa;Initial Catalog=YkLis;Data Source=202.96.1.105'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 752
    Top = 8
  end
  object DosMove1: TDosMove
    Active = True
    Left = 696
    Top = 8
  end
  object UniQuery1: TUniQuery
    Connection = UniConnExtSystem
    AfterOpen = UniQuery1AfterOpen
    Left = 72
    Top = 252
  end
  object DataSource1: TDataSource
    DataSet = UniQuery1
    Left = 104
    Top = 252
  end
  object frxReport1: TfrxReport
    Version = '5.4.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #39044#35774
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45395.772976631950000000
    ReportOptions.LastChange = 45395.782752557870000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnGetValue = frxReport1GetValue
    Left = 664
    Top = 8
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object Memo1: TfrxMemoView
        Left = 41.574830000000000000
        Top = 34.015770000000000000
        Width = 94.488250000000000000
        Height = 18.897650000000000000
        Memo.UTF8 = (
          '[req_dept]')
      end
      object Memo2: TfrxMemoView
        Left = 143.622140000000000000
        Top = 34.015770000000000000
        Width = 253.228510000000000000
        Height = 18.897650000000000000
        Memo.UTF8 = (
          '[patientname] [sex] [age][ageunit]')
      end
      object Memo3: TfrxMemoView
        Left = 41.574830000000000000
        Top = 60.472480000000000000
        Width = 211.653680000000000000
        Height = 18.897650000000000000
        Memo.UTF8 = (
          '[req_time]')
      end
      object BarCode1: TfrxBarCodeView
        Left = 45.354360000000000000
        Top = 86.929190000000000000
        Width = 79.000000000000000000
        Height = 60.472480000000000000
        BarType = bcCode128
        Expression = '123456'
        Rotation = 0
        Text = '12345678'
        WideBarRatio = 2.000000000000000000
        Zoom = 1.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
      end
      object Memo4: TfrxMemoView
        Left = 41.574830000000000000
        Top = 158.740260000000000000
        Width = 211.653680000000000000
        Height = 18.897650000000000000
        Memo.UTF8 = (
          '[item_name]')
      end
    end
  end
  object VirtualTable1: TVirtualTable
    FieldDefs = <
      item
        Name = #22995#21517
        DataType = ftString
        Size = 50
      end
      item
        Name = #24615#21035
        DataType = ftString
        Size = 20
      end
      item
        Name = #24180#40836
        DataType = ftString
        Size = 20
      end
      item
        Name = #24180#40836#21333#20301
        DataType = ftString
        Size = 20
      end
      item
        Name = #30003#35831#31185#23460
        DataType = ftString
        Size = 20
      end
      item
        Name = #30003#35831#26102#38388
        DataType = ftString
        Size = 30
      end
      item
        Name = #26465#30721#21495
        DataType = ftString
        Size = 50
      end
      item
        Name = #39033#30446#21517#31216
        DataType = ftString
        Size = 200
      end>
    Left = 224
    Top = 252
    Data = {
      030008000400D0D5C3FB01003200000000000400D0D4B1F00100140000000000
      0400C4EAC1E401001400000000000800C4EAC1E4B5A5CEBB0100140000000000
      0800C9EAC7EBBFC6CAD201001400000000000800C9EAC7EBCAB1BCE401001E00
      000000000600CCF5C2EBBAC501003200000000000800CFEEC4BFC3FBB3C60100
      C80000000000000000000000}
  end
end

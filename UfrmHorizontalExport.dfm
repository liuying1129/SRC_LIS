object frmHorizontalExport: TfrmHorizontalExport
  Left = 185
  Top = 116
  Width = 870
  Height = 562
  Caption = #26816#39564#32467#26524#26597#35810#21450#23548#20986'-'#27178#21521#26684#24335
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 160
    Width = 854
    Height = 363
    Align = alClient
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 854
    Height = 160
    Align = alTop
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 10
      Width = 52
      Height = 13
      Caption = #24320#22987#26085#26399
    end
    object Label3: TLabel
      Left = 131
      Top = 10
      Width = 52
      Height = 13
      Caption = #32452#21512#39033#30446
    end
    object Label4: TLabel
      Left = 8
      Top = 82
      Width = 52
      Height = 13
      Caption = #32467#26463#26085#26399
    end
    object Label1: TLabel
      Left = 8
      Top = 141
      Width = 118
      Height = 13
      Caption = #27880':1'#12289#20165#26597#35810#24050#23457#26680
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object DateTimePicker1: TDateTimePicker
      Left = 8
      Top = 29
      Width = 100
      Height = 21
      Date = 44575.000000000000000000
      Time = 44575.000000000000000000
      TabOrder = 0
    end
    object DateTimePicker2: TDateTimePicker
      Left = 8
      Top = 100
      Width = 100
      Height = 21
      Date = 44940.999988425920000000
      Time = 44940.999988425920000000
      TabOrder = 1
    end
    object CheckListBox2: TCheckListBox
      Left = 185
      Top = 10
      Width = 580
      Height = 110
      Columns = 5
      ItemHeight = 13
      TabOrder = 2
    end
    object BitBtn1: TBitBtn
      Left = 774
      Top = 10
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 3
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 772
      Top = 94
      Width = 75
      Height = 25
      Caption = #23548#20986
      TabOrder = 4
      OnClick = BitBtn2Click
    end
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    Parameters = <>
    Left = 144
    Top = 208
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 112
    Top = 208
  end
  object LYDataToExcel1: TLYDataToExcel
    Left = 192
    Top = 208
  end
end

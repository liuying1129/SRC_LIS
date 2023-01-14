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
    Left = 233
    Top = 0
    Width = 621
    Height = 523
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
    Width = 233
    Height = 523
    Align = alLeft
    TabOrder = 1
    object Label1: TLabel
      Left = 10
      Top = 64
      Width = 39
      Height = 13
      Caption = #24037#20316#32452
    end
    object Label2: TLabel
      Left = 8
      Top = 10
      Width = 52
      Height = 13
      Caption = #24320#22987#26085#26399
    end
    object Label3: TLabel
      Left = 8
      Top = 200
      Width = 52
      Height = 13
      Caption = #32452#21512#39033#30446
    end
    object Label4: TLabel
      Left = 120
      Top = 10
      Width = 52
      Height = 13
      Caption = #32467#26463#26085#26399
    end
    object Label5: TLabel
      Left = 50
      Top = 64
      Width = 170
      Height = 13
      Caption = '('#26080#20219#20309#21246#36873#34920#31034#25152#26377#24037#20316#32452')'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object CheckListBox1: TCheckListBox
      Left = 8
      Top = 80
      Width = 210
      Height = 100
      Columns = 2
      ItemHeight = 13
      TabOrder = 0
    end
    object DateTimePicker1: TDateTimePicker
      Left = 8
      Top = 26
      Width = 100
      Height = 21
      Date = 44575.000000000000000000
      Time = 44575.000000000000000000
      TabOrder = 1
    end
    object DateTimePicker2: TDateTimePicker
      Left = 120
      Top = 26
      Width = 100
      Height = 21
      Date = 44940.999988425920000000
      Time = 44940.999988425920000000
      TabOrder = 2
    end
    object CheckListBox2: TCheckListBox
      Left = 8
      Top = 216
      Width = 210
      Height = 250
      Columns = 2
      ItemHeight = 13
      TabOrder = 3
    end
    object BitBtn1: TBitBtn
      Left = 30
      Top = 480
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 4
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 126
      Top = 480
      Width = 75
      Height = 25
      Caption = #23548#20986
      TabOrder = 5
      OnClick = BitBtn2Click
    end
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    Parameters = <>
    Left = 320
    Top = 56
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 288
    Top = 56
  end
  object LYDataToExcel1: TLYDataToExcel
    Left = 368
    Top = 56
  end
end

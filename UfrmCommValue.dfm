object frmCommValue: TfrmCommValue
  Left = 192
  Top = 122
  Width = 700
  Height = 500
  Caption = #24120#35265#32467#26524#35774#32622
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 233
    Height = 462
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 3
      Width = 39
      Height = 13
      Caption = #32467#26524#20540
    end
    object Label7: TLabel
      Left = 6
      Top = 374
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
    object BitBtn1: TBitBtn
      Left = 35
      Top = 400
      Width = 75
      Height = 25
      Caption = #26032#22686
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 110
      Top = 400
      Width = 75
      Height = 25
      Caption = #20445#23384
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 35
      Top = 424
      Width = 75
      Height = 25
      Caption = #21024#38500
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object CheckBox1: TCheckBox
      Left = 6
      Top = 350
      Width = 97
      Height = 17
      Caption = #40664#35748#32467#26524
      TabOrder = 3
    end
    object BitBtn4: TBitBtn
      Left = 110
      Top = 424
      Width = 75
      Height = 25
      Cancel = True
      Caption = #20851#38381'(ESC)'
      TabOrder = 4
      OnClick = BitBtn4Click
    end
    object LabeledEdit1: TMemo
      Left = 6
      Top = 18
      Width = 220
      Height = 320
      ScrollBars = ssBoth
      TabOrder = 5
    end
  end
  object DBGrid1: TDBGrid
    Left = 233
    Top = 0
    Width = 451
    Height = 462
    Align = alClient
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 344
    Top = 72
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    AfterScroll = ADOQuery1AfterScroll
    Parameters = <>
    Left = 376
    Top = 72
  end
end

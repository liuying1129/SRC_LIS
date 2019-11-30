object frmEquipManage: TfrmEquipManage
  Left = 192
  Top = 123
  Width = 700
  Height = 500
  Caption = #35774#22791#31649#29702
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
  object DBGrid1: TDBGrid
    Left = 289
    Top = 0
    Width = 395
    Height = 461
    Align = alClient
    DataSource = DataSource1
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
    Width = 289
    Height = 461
    Align = alLeft
    TabOrder = 1
    object Label1: TLabel
      Left = 12
      Top = 352
      Width = 65
      Height = 13
      Caption = #35774#22791#31867#22411#65306
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 12
      Top = 368
      Width = 260
      Height = 13
      Caption = #20840#33258#21160#34880#28082#32454#32990#20998#26512#20202#12289#20840#33258#21160#29983#21270#20998#26512#20202#12289
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 12
      Top = 384
      Width = 202
      Height = 13
      Caption = #23615#28082#20998#26512#20202#12289#20813#30123#21457#20809#26816#27979#20202' '#31561#31561
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object LabeledEdit1: TLabeledEdit
      Left = 32
      Top = 32
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #35774#22791#31867#22411
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 32
      Top = 80
      Width = 121
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #22411#21495
      TabOrder = 1
    end
    object LabeledEdit3: TLabeledEdit
      Left = 32
      Top = 120
      Width = 121
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #22791#27880
      TabOrder = 2
    end
    object LabeledEdit4: TLabeledEdit
      Left = 32
      Top = 168
      Width = 121
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = #20379#24212#21830
      TabOrder = 3
    end
    object LabeledEdit5: TLabeledEdit
      Left = 32
      Top = 216
      Width = 121
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #21697#29260
      TabOrder = 4
    end
    object LabeledEdit6: TLabeledEdit
      Left = 32
      Top = 256
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #29983#20135#21378#23478
      TabOrder = 5
    end
    object BitBtn1: TBitBtn
      Left = 27
      Top = 298
      Width = 75
      Height = 25
      Caption = #26032#22686
      TabOrder = 6
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 102
      Top = 298
      Width = 75
      Height = 25
      Caption = #20445#23384
      TabOrder = 7
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 177
      Top = 298
      Width = 75
      Height = 25
      Caption = #21024#38500
      TabOrder = 8
      OnClick = BitBtn3Click
    end
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    AfterScroll = ADOQuery1AfterScroll
    Parameters = <>
    Left = 328
    Top = 56
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 368
    Top = 56
  end
end

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
    Width = 289
    Height = 461
    Align = alLeft
    TabOrder = 1
    object Label4: TLabel
      Left = 32
      Top = 16
      Width = 52
      Height = 13
      Caption = #35774#22791#31867#22411
    end
    object LabeledEdit2: TLabeledEdit
      Left = 32
      Top = 80
      Width = 200
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #22411#21495
      TabOrder = 0
    end
    object LabeledEdit3: TLabeledEdit
      Left = 32
      Top = 120
      Width = 200
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #22791#27880
      TabOrder = 1
    end
    object LabeledEdit4: TLabeledEdit
      Left = 32
      Top = 168
      Width = 200
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = #20379#24212#21830
      TabOrder = 2
    end
    object LabeledEdit5: TLabeledEdit
      Left = 32
      Top = 216
      Width = 200
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #21697#29260
      TabOrder = 3
    end
    object LabeledEdit6: TLabeledEdit
      Left = 32
      Top = 256
      Width = 200
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #29983#20135#21378#23478
      TabOrder = 4
    end
    object BitBtn1: TBitBtn
      Left = 27
      Top = 336
      Width = 75
      Height = 25
      Caption = #26032#22686
      TabOrder = 5
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 102
      Top = 336
      Width = 75
      Height = 25
      Caption = #20445#23384
      TabOrder = 6
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 177
      Top = 336
      Width = 75
      Height = 25
      Caption = #21024#38500
      TabOrder = 7
      OnClick = BitBtn3Click
    end
    object ComboBox1: TComboBox
      Left = 32
      Top = 32
      Width = 200
      Height = 21
      DropDownCount = 20
      ItemHeight = 13
      TabOrder = 8
      Items.Strings = (
        #20840#33258#21160#34880#28082#20998#26512#20202
        #20840#33258#21160#29983#21270#20998#26512#20202
        #20840#33258#21160#24178#24335#29983#21270#20998#26512#20202
        #23615#28082#20998#26512#20202
        #20840#33258#21160#23615#27785#28195#20998#26512#20202
        #20813#30123#21457#20809#26816#27979#20202
        #20840#33258#21160#21270#23398#21457#20809#27979#23450#20202
        #24178#24335#33639#20809#20813#30123#20998#26512#20202
        #30005#35299#36136#20998#26512#20202
        #20840#33258#21160#34880#27969#21464#27979#35797#20202
        #34880#27668#20998#26512#20202
        #20840#33258#21160#34880#20957#20998#26512#20202
        #20840#33258#21160#31958#21270#34880#32418#34507#30333#20998#26512#20202
        #20840#33258#21160#24494#29983#29289#26816#27979#31995#32479)
    end
    object LabeledEdit1: TLabeledEdit
      Left = 32
      Top = 302
      Width = 200
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = #39034#24207#21495
      TabOrder = 9
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

object frmSJ_JBXX: TfrmSJ_JBXX
  Left = 193
  Top = 68
  Width = 800
  Height = 600
  Caption = #35797#21058#22522#26412#20449#24687
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 129
    Width = 784
    Height = 272
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
    Width = 784
    Height = 129
    Align = alTop
    TabOrder = 1
    object LabeledEdit1: TLabeledEdit
      Left = 9
      Top = 25
      Width = 60
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #20195#30721
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 72
      Top = 25
      Width = 180
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #21517#31216
      TabOrder = 1
    end
    object LabeledEdit3: TLabeledEdit
      Left = 255
      Top = 25
      Width = 70
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #22411#21495
      TabOrder = 2
    end
    object LabeledEdit4: TLabeledEdit
      Left = 330
      Top = 25
      Width = 80
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #35268#26684
      TabOrder = 3
    end
    object LabeledEdit5: TLabeledEdit
      Left = 415
      Top = 25
      Width = 180
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #29983#20135#21378#23478
      TabOrder = 4
    end
    object LabeledEdit6: TLabeledEdit
      Left = 599
      Top = 25
      Width = 175
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #25209#20934#25991#21495
      TabOrder = 5
    end
    object BitBtn1: TBitBtn
      Left = 9
      Top = 90
      Width = 75
      Height = 25
      Caption = #26032#22686
      TabOrder = 8
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 89
      Top = 90
      Width = 75
      Height = 25
      Caption = #20445#23384
      TabOrder = 7
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 169
      Top = 90
      Width = 75
      Height = 25
      Caption = #21024#38500
      TabOrder = 9
      OnClick = BitBtn3Click
    end
    object LabeledEdit7: TLabeledEdit
      Left = 9
      Top = 65
      Width = 764
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #22791#27880
      TabOrder = 6
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 401
    Width = 784
    Height = 160
    Align = alBottom
    TabOrder = 2
    object DBGrid2: TDBGrid
      Left = 1
      Top = 1
      Width = 543
      Height = 158
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
    object Panel3: TPanel
      Left = 544
      Top = 1
      Width = 239
      Height = 158
      Align = alRight
      TabOrder = 1
      object Label1: TLabel
        Left = 16
        Top = 59
        Width = 14
        Height = 13
        Caption = '1*'
      end
      object Label2: TLabel
        Left = 85
        Top = 59
        Width = 7
        Height = 13
        Caption = '='
      end
      object LabeledEdit8: TLabeledEdit
        Left = 32
        Top = 56
        Width = 50
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = #21253#35013#21333#20301
        TabOrder = 0
      end
      object LabeledEdit9: TLabeledEdit
        Left = 148
        Top = 56
        Width = 80
        Height = 21
        EditLabel.Width = 78
        EditLabel.Height = 13
        EditLabel.Caption = #19979#32423#21253#35013#21333#20301
        TabOrder = 2
      end
      object LabeledEdit10: TLabeledEdit
        Left = 96
        Top = 56
        Width = 50
        Height = 21
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #27604#29575
        TabOrder = 1
      end
      object BitBtn4: TBitBtn
        Left = 5
        Top = 104
        Width = 75
        Height = 25
        Caption = #26032#22686
        TabOrder = 4
        OnClick = BitBtn4Click
      end
      object BitBtn5: TBitBtn
        Left = 82
        Top = 104
        Width = 75
        Height = 25
        Caption = #20445#23384
        TabOrder = 3
        OnClick = BitBtn5Click
      end
      object BitBtn6: TBitBtn
        Left = 159
        Top = 104
        Width = 75
        Height = 25
        Caption = #21024#38500
        TabOrder = 5
        OnClick = BitBtn6Click
      end
    end
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    AfterScroll = ADOQuery1AfterScroll
    Parameters = <>
    Left = 104
    Top = 200
  end
  object ADOQuery2: TADOQuery
    AfterScroll = ADOQuery2AfterScroll
    Parameters = <>
    Left = 112
    Top = 404
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 136
    Top = 200
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery2
    Left = 144
    Top = 404
  end
  object DosMove1: TDosMove
    Active = True
    Left = 280
    Top = 88
  end
end

object frmdocset: Tfrmdocset
  Left = 202
  Top = 131
  BorderStyle = bsDialog
  Caption = #20154#21592#35774#32622
  ClientHeight = 471
  ClientWidth = 528
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
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
    Top = 108
    Width = 528
    Height = 223
    Align = alClient
    Color = 16767438
    DataSource = DataSourcedoclist
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
  end
  object Panel2: TPanel
    Left = 0
    Top = 76
    Width = 528
    Height = 32
    Align = alTop
    Color = clSkyBlue
    TabOrder = 1
    object Label2: TLabel
      Left = 350
      Top = 10
      Width = 104
      Height = 13
      Caption = #25805#20316#25152#26377#31185#23460#39033#30446
    end
    object LabeledEdit1: TLabeledEdit
      Left = 74
      Top = 7
      Width = 85
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #29992#25143#20195#30721
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 241
      Top = 7
      Width = 85
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #29992#25143#21517#31216
      ImeMode = imOpen
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 1
    end
    object ComboBox1: TComboBox
      Left = 456
      Top = 6
      Width = 40
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        #26159
        #21542)
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 36
    Width = 528
    Height = 40
    Align = alTop
    Color = clSkyBlue
    TabOrder = 2
    object suiButton1: TSpeedButton
      Left = 5
      Top = 7
      Width = 58
      Height = 27
      Caption = #26032#22686
      Transparent = False
      OnClick = suiButton1Click
    end
    object suiButton2: TSpeedButton
      Left = 69
      Top = 7
      Width = 58
      Height = 27
      Caption = #20445#23384
      Transparent = False
      OnClick = suiButton2Click
    end
    object suiButton3: TSpeedButton
      Left = 133
      Top = 7
      Width = 58
      Height = 27
      Caption = #21024#38500
      Transparent = False
      OnClick = suiButton3Click
    end
    object BitBtn1: TBitBtn
      Left = 382
      Top = 7
      Width = 113
      Height = 27
      Caption = #23548#20986#37096#38376#20154#21592
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 528
    Height = 36
    Align = alTop
    Color = clSkyBlue
    TabOrder = 3
    object Label1: TLabel
      Left = 18
      Top = 11
      Width = 26
      Height = 13
      Caption = #37096#38376
    end
    object ComboBox2: TComboBox
      Left = 47
      Top = 7
      Width = 145
      Height = 21
      Ctl3D = True
      DropDownCount = 20
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 0
      OnChange = ComboBox2Change
      OnDropDown = ComboBox2DropDown
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 331
    Width = 528
    Height = 140
    Align = alBottom
    Color = clSkyBlue
    TabOrder = 4
    object Image1: TImage
      Left = 88
      Top = 5
      Width = 390
      Height = 130
    end
    object Label3: TLabel
      Left = 8
      Top = 8
      Width = 65
      Height = 13
      Caption = #31614#21517#23637#31034#21306
    end
  end
  object ADOdoclist: TADOQuery
    AfterScroll = ADOdoclistAfterScroll
    Parameters = <>
    Left = 44
    Top = 136
  end
  object DataSourcedoclist: TDataSource
    DataSet = ADOdoclist
    Left = 76
    Top = 136
  end
  object DosMove1: TDosMove
    Active = True
    Left = 320
    Top = 16
  end
  object LYDataToExcel1: TLYDataToExcel
    Left = 300
    Top = 184
  end
end

object frmCriticalManage: TfrmCriticalManage
  Left = 192
  Top = 123
  Width = 750
  Height = 500
  Caption = #21361#24613#20540#31649#29702
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 240
    Height = 461
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 29
      Top = 16
      Width = 26
      Height = 13
      Caption = #24615#21035
    end
    object Label2: TLabel
      Left = 29
      Top = 124
      Width = 52
      Height = 13
      Caption = #21305#37197#26041#24335
    end
    object Label3: TLabel
      Left = 8
      Top = 243
      Width = 209
      Height = 13
      Caption = #27880':1'#12289#24615#21035#20026#31354#34920#31034#36866#29992#20110#25152#26377#24615#21035
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 28
      Top = 281
      Width = 158
      Height = 13
      Caption = '3'#12289#24180#40836#19978#38480#20026#31354#34920#31034'200'#23681
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 28
      Top = 263
      Width = 144
      Height = 13
      Caption = '2'#12289#24180#40836#19979#38480#20026#31354#34920#31034'0'#23681
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object ComboBox1: TComboBox
      Left = 29
      Top = 32
      Width = 180
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object LabeledEdit1: TLabeledEdit
      Left = 29
      Top = 84
      Width = 80
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #24180#40836#19979#38480
      TabOrder = 1
      OnExit = LabeledEdit1Exit
    end
    object LabeledEdit2: TLabeledEdit
      Left = 129
      Top = 84
      Width = 80
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #24180#40836#19978#38480
      TabOrder = 2
      OnExit = LabeledEdit2Exit
    end
    object LabeledEdit3: TLabeledEdit
      Left = 109
      Top = 140
      Width = 100
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = #21361#24613#20540
      TabOrder = 4
    end
    object ComboBox2: TComboBox
      Left = 29
      Top = 140
      Width = 75
      Height = 21
      Style = csDropDownList
      DropDownCount = 10
      ItemHeight = 13
      TabOrder = 3
      Items.Strings = (
        #27169#31946#21305#37197
        #24038#21305#37197
        #21491#21305#37197
        #20840#21305#37197
        #8804
        #65308
        #8805
        #65310
        '=')
    end
    object BitBtn1: TBitBtn
      Left = 5
      Top = 178
      Width = 75
      Height = 25
      Caption = #26032#22686
      TabOrder = 6
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 81
      Top = 178
      Width = 75
      Height = 25
      Caption = #20445#23384
      TabOrder = 5
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 157
      Top = 178
      Width = 75
      Height = 25
      Caption = #21024#38500
      TabOrder = 7
      OnClick = BitBtn3Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 240
    Top = 0
    Width = 494
    Height = 461
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
    Left = 320
    Top = 64
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    AfterScroll = ADOQuery1AfterScroll
    Parameters = <>
    Left = 352
    Top = 64
  end
  object DosMove1: TDosMove
    Active = True
    Left = 16
    Top = 208
  end
end

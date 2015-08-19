object frmExceptionValue: TfrmExceptionValue
  Left = 192
  Top = 122
  Width = 700
  Height = 500
  Caption = #38750#25968#20540#32467#26524#36229#38480#20540#31649#29702
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
      Left = 16
      Top = 64
      Width = 52
      Height = 13
      Caption = #21305#37197#26041#24335
    end
    object Label2: TLabel
      Left = 16
      Top = 168
      Width = 52
      Height = 13
      Caption = #36229#38480#26631#35782
    end
    object Label3: TLabel
      Left = 2
      Top = 232
      Width = 254
      Height = 143
      Caption = 
        #20363#22914#65292#20057#32925#34920#38754#25239#21407#65292#24076#26395#32467#26524#20540#20026#13#8220#38451#24615#8221#26102#26174#31034#20559#39640#13#35774#32622#26041#26696'1'#65306#21305#37197#26041#24335#36873#25321#8220#24038#21305#37197#8221#65292#13#32467#26524#20540#22635#8220#38451#8221#65292#36229#38480#26631#35782#36873#25321#8220#20559#39640#8221 +
        ','#13#21017#32467#26524#20540#20026#8220#38451#8221#24320#22836#26102#26174#31034#20026#20559#39640#13#35774#32622#26041#26696'2'#65306#21305#37197#26041#24335#36873#25321#8220#20840#21305#37197#8221#65292#13#32467#26524#20540#22635#8220#38451#24615#8221#65292#36229#38480#26631#35782#36873#25321#8220#20559#39640#8221','#13#21017#32467#26524#20540#31561 +
        #20110#8220#38451#24615#8221#26102#26174#31034#20026#20559#39640#13#35774#32622#26041#26696'3'#65306#21305#37197#26041#24335#36873#25321#8220#27169#31946#21305#37197#8221#65292#13#32467#26524#20540#22635#8220#38451#24615#8221#65292#36229#38480#26631#35782#36873#25321#8220#20559#39640#8221','#13#21017#32467#26524#20540#21253#21547#8220#38451#24615#8221#26102 +
        #26174#31034#20026#20559#39640
      Font.Charset = ANSI_CHARSET
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
    object BitBtn4: TBitBtn
      Left = 110
      Top = 424
      Width = 75
      Height = 25
      Cancel = True
      Caption = #20851#38381'(ESC)'
      TabOrder = 3
      OnClick = BitBtn4Click
    end
    object ComboBox1: TComboBox
      Left = 16
      Top = 80
      Width = 200
      Height = 21
      Style = csDropDownList
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        #27169#31946#21305#37197
        #24038#21305#37197
        #21491#21305#37197
        #20840#21305#37197)
    end
    object ComboBox2: TComboBox
      Left = 16
      Top = 184
      Width = 200
      Height = 21
      Style = csDropDownList
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      ItemHeight = 13
      TabOrder = 5
      Items.Strings = (
        ''
        #20559#20302
        #20559#39640)
    end
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 128
      Width = 200
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = #32467#26524#20540
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      TabOrder = 6
    end
  end
  object DBGrid1: TDBGrid
    Left = 233
    Top = 0
    Width = 451
    Height = 462
    Align = alClient
    DataSource = DataSource1
    ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
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

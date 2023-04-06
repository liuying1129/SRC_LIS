object frmCriticalManage: TfrmCriticalManage
  Left = 192
  Top = 123
  Width = 870
  Height = 450
  Caption = #21361#24613#20540#31649#29702
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
    Width = 281
    Height = 411
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 40
      Top = 16
      Width = 26
      Height = 13
      Caption = #24615#21035
    end
    object Label2: TLabel
      Left = 40
      Top = 160
      Width = 52
      Height = 13
      Caption = #21305#37197#26041#24335
    end
    object ComboBox1: TComboBox
      Left = 40
      Top = 32
      Width = 97
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object LabeledEdit1: TLabeledEdit
      Left = 40
      Top = 72
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #24180#40836#19979#38480
      TabOrder = 1
      OnExit = LabeledEdit1Exit
    end
    object LabeledEdit2: TLabeledEdit
      Left = 40
      Top = 120
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #24180#40836#19978#38480
      TabOrder = 2
      OnExit = LabeledEdit2Exit
    end
    object LabeledEdit3: TLabeledEdit
      Left = 104
      Top = 176
      Width = 65
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = #21361#24613#20540
      TabOrder = 3
    end
    object ComboBox2: TComboBox
      Left = 40
      Top = 176
      Width = 57
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        #8804
        #65308
        #8805
        #65310
        '='
        #27169#31946#21305#37197
        #24038#21305#37197
        #21491#21305#37197
        #20840#21305#37197)
    end
    object BitBtn1: TBitBtn
      Left = 16
      Top = 320
      Width = 75
      Height = 25
      Caption = #26032#22686
      TabOrder = 5
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 96
      Top = 320
      Width = 75
      Height = 25
      Caption = #20445#23384
      TabOrder = 6
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 176
      Top = 320
      Width = 75
      Height = 25
      Caption = #21024#38500
      TabOrder = 7
      OnClick = BitBtn3Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 281
    Top = 0
    Width = 573
    Height = 411
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
end

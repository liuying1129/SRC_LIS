object frmBatchSpecNo: TfrmBatchSpecNo
  Left = 194
  Top = 231
  BorderStyle = bsDialog
  Caption = #33539#22260#36755#20837
  ClientHeight = 198
  ClientWidth = 308
  Color = clSkyBlue
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
  object Label1: TLabel
    Left = 48
    Top = 10
    Width = 52
    Height = 13
    Caption = #26816#26597#26085#26399
  end
  object Label5: TLabel
    Left = 45
    Top = 165
    Width = 167
    Height = 13
    Caption = #27880#65306'1'#12289#33539#22260#26684#24335#22914'5,7-9,12'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 48
    Top = 30
    Width = 52
    Height = 13
    Caption = #20248#20808#32423#21035
  end
  object Label3: TLabel
    Left = 206
    Top = 77
    Width = 104
    Height = 13
    Caption = #23567#26694#20013#22635#32852#26426#23383#27597
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 72
    Top = 136
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 168
    Top = 136
    Width = 75
    Height = 25
    Caption = #20851#38381
    TabOrder = 1
    OnClick = BitBtn2Click
  end
  object RadioGroup1: TRadioGroup
    Left = 17
    Top = 97
    Width = 280
    Height = 36
    Caption = #25171#21360#31867#22411#36873#25321
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      #25171#21360
      #20998#32452#25171#21360)
    TabOrder = 2
  end
  object DateTimePicker1: TDateTimePicker
    Left = 112
    Top = 5
    Width = 95
    Height = 21
    Date = 37942.591355486110000000
    Time = 37942.591355486110000000
    TabOrder = 3
  end
  object ComboBox1: TComboBox
    Left = 112
    Top = 27
    Width = 95
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    Text = #24120#35268
    Items.Strings = (
      #24120#35268
      #24613#35786)
  end
  object RadioGroup2: TRadioGroup
    Left = 10
    Top = 42
    Width = 100
    Height = 50
    ItemIndex = 0
    Items.Strings = (
      #27969#27700#21495#33539#22260
      #32852#26426#21495#33539#22260)
    TabOrder = 5
    OnClick = RadioGroup2Click
  end
  object LabeledEdit3: TEdit
    Left = 112
    Top = 49
    Width = 95
    Height = 21
    TabOrder = 6
  end
  object LabeledEdit1: TEdit
    Left = 134
    Top = 72
    Width = 73
    Height = 21
    Enabled = False
    TabOrder = 7
  end
  object Edit1: TEdit
    Left = 112
    Top = 72
    Width = 21
    Height = 21
    Hint = #32852#26426#23383#27597
    Enabled = False
    TabOrder = 8
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 8
    Top = 8
  end
  object DosMove1: TDosMove
    Active = True
    Left = 264
    Top = 8
  end
end

object frmPlxg: TfrmPlxg
  Left = 272
  Top = 111
  BorderStyle = bsDialog
  Caption = #32467#26524#25209#37327#20462#25913
  ClientHeight = 433
  ClientWidth = 292
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
  object Panel1: TPanel
    Left = 0
    Top = 363
    Width = 292
    Height = 70
    Align = alBottom
    Color = clSkyBlue
    TabOrder = 0
    object Label2: TLabel
      Left = 3
      Top = 35
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
    object Label4: TLabel
      Left = 29
      Top = 52
      Width = 210
      Height = 13
      Caption = '2'#12289#35745#31639#32467#26524#20026':'#21407#32467#26524'*'#31995#25968'+'#38468#21152#20540
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 61
      Top = 5
      Width = 80
      Height = 25
      Caption = #30830#23450'(F2)'
      TabOrder = 0
      OnClick = BitBtn1Click
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 155
      Top = 5
      Width = 80
      Height = 25
      Cancel = True
      Caption = #20851#38381'(Esc)'
      TabOrder = 1
      OnClick = BitBtn2Click
      NumGlyphs = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 292
    Height = 113
    Align = alTop
    Color = clSkyBlue
    TabOrder = 1
    object Label1: TLabel
      Left = 62
      Top = 30
      Width = 52
      Height = 13
      Caption = #20248#20808#32423#21035
    end
    object Label3: TLabel
      Left = 64
      Top = 8
      Width = 52
      Height = 13
      Caption = #26816#26597#26085#26399
    end
    object Label6: TLabel
      Left = 120
      Top = 97
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
    object DateTimePicker1: TDateTimePicker
      Left = 120
      Top = 4
      Width = 95
      Height = 21
      Date = 37833.628041087960000000
      Time = 37833.628041087960000000
      TabOrder = 0
    end
    object ComboBox1: TComboBox
      Left = 120
      Top = 27
      Width = 95
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = #24120#35268
      Items.Strings = (
        #24120#35268
        #24613#35786)
    end
    object RadioGroup2: TRadioGroup
      Left = 16
      Top = 43
      Width = 100
      Height = 50
      ItemIndex = 0
      Items.Strings = (
        #27969#27700#21495#33539#22260
        #32852#26426#21495#33539#22260)
      TabOrder = 2
      OnClick = RadioGroup2Click
    end
    object LabeledEdit3: TEdit
      Left = 120
      Top = 49
      Width = 95
      Height = 21
      TabOrder = 3
    end
    object LabeledEdit1: TEdit
      Left = 142
      Top = 72
      Width = 73
      Height = 21
      Enabled = False
      TabOrder = 4
    end
    object Edit1: TEdit
      Left = 120
      Top = 72
      Width = 21
      Height = 21
      Hint = #32852#26426#23383#27597
      Enabled = False
      TabOrder = 5
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 113
    Width = 292
    Height = 250
    Align = alClient
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
  end
  object DosMove1: TDosMove
    Active = True
    Left = 16
    Top = 8
  end
  object ActionList1: TActionList
    Left = 56
    Top = 160
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 113
      OnExecute = BitBtn1Click
    end
    object Action2: TAction
      Caption = 'Action2'
      ShortCut = 27
      OnExecute = BitBtn2Click
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 176
    Top = 160
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    Parameters = <>
    Left = 216
    Top = 160
  end
end

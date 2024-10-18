object Form_pllr: TForm_pllr
  Left = 272
  Top = 111
  BorderStyle = bsDialog
  Caption = #30149#20154#20449#24687#25209#37327#24405#20837
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CheckListBox1: TCheckListBox
    Left = 0
    Top = 212
    Width = 292
    Height = 171
    Align = alClient
    Color = 16767438
    Columns = 2
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 383
    Width = 292
    Height = 50
    Align = alBottom
    Color = clSkyBlue
    TabOrder = 1
    object Label2: TLabel
      Left = 34
      Top = 34
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
    object BitBtn1: TBitBtn
      Left = 13
      Top = 5
      Width = 62
      Height = 25
      Caption = #30830#23450'(F2)'
      TabOrder = 0
      OnClick = BitBtn1Click
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 75
      Top = 5
      Width = 62
      Height = 25
      Caption = #20851#38381'(Esc)'
      TabOrder = 1
      OnClick = BitBtn2Click
      NumGlyphs = 2
    end
    object BitBtn3: TBitBtn
      Left = 147
      Top = 5
      Width = 60
      Height = 25
      Caption = #20840#36873
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 208
      Top = 5
      Width = 60
      Height = 25
      Caption = #21453#36873
      TabOrder = 3
      OnClick = BitBtn4Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 292
    Height = 212
    Align = alTop
    Color = clSkyBlue
    TabOrder = 2
    object Label1: TLabel
      Left = 62
      Top = 26
      Width = 52
      Height = 13
      Caption = #20248#20808#32423#21035
    end
    object Label3: TLabel
      Left = 62
      Top = 6
      Width = 52
      Height = 13
      Caption = #26816#26597#26085#26399
    end
    object Label4: TLabel
      Left = 120
      Top = 197
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
    object Label5: TLabel
      Left = 62
      Top = 48
      Width = 52
      Height = 13
      Caption = #36865#26816#31185#23460
    end
    object Label12: TLabel
      Left = 62
      Top = 69
      Width = 52
      Height = 13
      Caption = #36865#26816#21307#29983
    end
    object Label13: TLabel
      Left = 62
      Top = 90
      Width = 52
      Height = 13
      Caption = #26679#26412#31867#22411
    end
    object Label14: TLabel
      Left = 62
      Top = 111
      Width = 52
      Height = 13
      Caption = #26679#26412#29366#24577
    end
    object DateTimePicker1: TDateTimePicker
      Left = 120
      Top = 2
      Width = 95
      Height = 21
      Date = 37833.628041087960000000
      Time = 37833.628041087960000000
      TabOrder = 1
      OnChange = DateTimePicker1Change
    end
    object LabeledEdit15: TLabeledEdit
      Left = 120
      Top = 129
      Width = 95
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #22791#27880
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 0
    end
    object ComboBox1: TComboBox
      Left = 120
      Top = 23
      Width = 95
      Height = 21
      BevelKind = bkFlat
      ItemHeight = 13
      TabOrder = 2
      OnChange = ComboBox1Change
      OnDropDown = ComboBox1DropDown
    end
    object RadioGroup2: TRadioGroup
      Left = 17
      Top = 144
      Width = 100
      Height = 50
      ItemIndex = 0
      Items.Strings = (
        #27969#27700#21495#33539#22260
        #32852#26426#21495#33539#22260)
      TabOrder = 3
      OnClick = RadioGroup2Click
    end
    object LabeledEdit3: TEdit
      Left = 120
      Top = 150
      Width = 95
      Height = 21
      TabOrder = 4
    end
    object LabeledEdit14: TEdit
      Left = 142
      Top = 172
      Width = 73
      Height = 21
      Enabled = False
      TabOrder = 5
    end
    object Edit1: TEdit
      Left = 120
      Top = 172
      Width = 21
      Height = 21
      Hint = #32852#26426#23383#27597
      Enabled = False
      TabOrder = 6
    end
    object LabeledEdit6: TComboBox
      Left = 120
      Top = 44
      Width = 95
      Height = 21
      BevelKind = bkFlat
      DropDownCount = 20
      ItemHeight = 13
      TabOrder = 7
      OnDropDown = LabeledEdit6DropDown
    end
    object LabeledEdit10: TComboBox
      Left = 120
      Top = 65
      Width = 95
      Height = 21
      BevelKind = bkFlat
      DropDownCount = 20
      ItemHeight = 13
      TabOrder = 8
      OnDropDown = LabeledEdit10DropDown
    end
    object LabeledEdit1: TComboBox
      Left = 120
      Top = 86
      Width = 95
      Height = 21
      BevelKind = bkFlat
      DropDownCount = 20
      ItemHeight = 13
      TabOrder = 9
      OnDropDown = LabeledEdit1DropDown
    end
    object LabeledEdit5: TComboBox
      Left = 120
      Top = 107
      Width = 95
      Height = 21
      BevelKind = bkFlat
      DropDownCount = 20
      ItemHeight = 13
      TabOrder = 10
      OnDropDown = LabeledEdit5DropDown
    end
  end
  object DosMove1: TDosMove
    Active = True
    Left = 16
    Top = 8
  end
  object ActionList1: TActionList
    Left = 16
    Top = 80
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
end

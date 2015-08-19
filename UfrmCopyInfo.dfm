object frmCopyInfo: TfrmCopyInfo
  Left = 242
  Top = 182
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22797#21046#24037#20316#32452#30149#20154#22522#26412#20449#24687
  ClientHeight = 433
  ClientWidth = 462
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
  object Label1: TLabel
    Left = 204
    Top = 6
    Width = 65
    Height = 13
    Caption = #30446#26631#24037#20316#32452
  end
  object Label2: TLabel
    Left = 189
    Top = 73
    Width = 78
    Height = 13
    Caption = #30446#26631#26679#26412#31867#22411
  end
  object Label5: TLabel
    Left = 176
    Top = 376
    Width = 222
    Height = 13
    Caption = #27880':1'#12289#20165#22797#21046#24038#36793#21015#34920#26694#20013#36873#20013#30340#30149#20154
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 196
    Top = 392
    Width = 165
    Height = 13
    Caption = '2'#12289#25353#20303'CTRL'#28857#20987#21487#23454#29616#22810#36873
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 196
    Top = 408
    Width = 241
    Height = 13
    Caption = '3'#12289#24403#25972#26465#35760#24405#21464#34013#26102#25165#34920#31034#35813#30149#20154#34987#36873#20013
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object ComboBox1: TComboBox
    Left = 272
    Top = 3
    Width = 145
    Height = 21
    Style = csDropDownList
    ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
    ItemHeight = 13
    TabOrder = 0
  end
  object LabeledEdit1: TLabeledEdit
    Left = 272
    Top = 25
    Width = 145
    Height = 21
    EditLabel.Width = 78
    EditLabel.Height = 13
    EditLabel.Caption = #30446#26631#32852#26426#23383#27597
    ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
    LabelPosition = lpLeft
    TabOrder = 1
    OnChange = LabeledEdit1Change
  end
  object BitBtn1: TBitBtn
    Left = 224
    Top = 328
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 312
    Top = 328
    Width = 75
    Height = 25
    Cancel = True
    Caption = #21462#28040
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object LabeledEdit2: TLabeledEdit
    Left = 272
    Top = 47
    Width = 145
    Height = 21
    EditLabel.Width = 91
    EditLabel.Height = 13
    EditLabel.Caption = #30446#26631#24320#22987#32852#26426#21495
    Enabled = False
    ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
    LabelPosition = lpLeft
    TabOrder = 4
  end
  object ComboBox2: TComboBox
    Left = 272
    Top = 69
    Width = 145
    Height = 21
    ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
    ItemHeight = 13
    TabOrder = 5
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 162
    Height = 433
    Align = alLeft
    Caption = #35831#36873#25321#35201#22797#21046#30340#30149#20154
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    object DBGrid1: TDBGrid
      Left = 2
      Top = 45
      Width = 158
      Height = 386
      Align = alClient
      DataSource = DataSource1
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
    end
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 158
      Height = 30
      Align = alTop
      TabOrder = 1
      object CheckBox1: TCheckBox
        Left = 3
        Top = 6
        Width = 97
        Height = 17
        Caption = #20840#36873
        TabOrder = 0
        OnClick = CheckBox1Click
      end
    end
  end
  object CheckListBox1: TCheckListBox
    Left = 168
    Top = 104
    Width = 289
    Height = 209
    Columns = 2
    Ctl3D = False
    ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 7
  end
  object DataSource1: TDataSource
    Left = 32
    Top = 64
  end
end

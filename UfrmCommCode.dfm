object frmCommCode: TfrmCommCode
  Left = 190
  Top = 176
  Width = 700
  Height = 500
  Caption = #36890#29992#20195#30721
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
  object DBGrid1: TDBGrid
    Left = 225
    Top = 0
    Width = 459
    Height = 462
    Align = alClient
    Color = 16767438
    DataSource = DataSource1
    ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
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
    Width = 225
    Height = 462
    Align = alLeft
    Color = clSkyBlue
    TabOrder = 1
    object Label1: TLabel
      Left = 15
      Top = 36
      Width = 52
      Height = 13
      Caption = #20195#30721#31867#22411
    end
    object Label2: TLabel
      Left = 3
      Top = 441
      Width = 216
      Height = 13
      Caption = #27880':'#35774#32622'"'#31995#32479#20195#30721'"'#38656#37325#21551#31243#24207#25165#29983#25928
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object LabeledEdit2: TLabeledEdit
      Left = 69
      Top = 85
      Width = 145
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #21517#31216
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 2
    end
    object BitBtn1: TBitBtn
      Left = 62
      Top = 379
      Width = 76
      Height = 25
      Caption = #26032#22686
      TabOrder = 15
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 138
      Top = 379
      Width = 75
      Height = 25
      Caption = #20445#23384
      TabOrder = 14
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 62
      Top = 403
      Width = 76
      Height = 25
      Caption = #21024#38500
      TabOrder = 16
      OnClick = BitBtn3Click
    end
    object LabeledEdit1: TLabeledEdit
      Left = 69
      Top = 61
      Width = 145
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #20195#30721
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 1
    end
    object LabeledEdit3: TLabeledEdit
      Left = 69
      Top = 109
      Width = 145
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #22791#27880
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 3
    end
    object ComboBox1: TComboBox
      Left = 69
      Top = 32
      Width = 145
      Height = 21
      Style = csDropDownList
      DropDownCount = 20
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      ItemHeight = 13
      TabOrder = 0
      OnChange = ComboBox1Change
    end
    object BitBtn4: TBitBtn
      Left = 138
      Top = 403
      Width = 75
      Height = 25
      Caption = #23548#20986
      TabOrder = 17
      OnClick = BitBtn4Click
    end
    object LabeledEdit4: TLabeledEdit
      Left = 69
      Top = 133
      Width = 145
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = #20445#30041#23383#27573'1'
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 4
    end
    object LabeledEdit5: TLabeledEdit
      Left = 69
      Top = 157
      Width = 145
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = #20445#30041#23383#27573'2'
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 5
    end
    object LabeledEdit6: TLabeledEdit
      Left = 69
      Top = 181
      Width = 145
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = #20445#30041#23383#27573'3'
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 6
    end
    object LabeledEdit7: TLabeledEdit
      Left = 69
      Top = 205
      Width = 145
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = #20445#30041#23383#27573'4'
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 7
    end
    object LabeledEdit8: TLabeledEdit
      Left = 69
      Top = 229
      Width = 145
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = #20445#30041#23383#27573'5'
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 8
    end
    object LabeledEdit9: TLabeledEdit
      Left = 69
      Top = 253
      Width = 145
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = #20445#30041#23383#27573'6'
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 9
    end
    object LabeledEdit10: TLabeledEdit
      Left = 69
      Top = 277
      Width = 145
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = #20445#30041#23383#27573'7'
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 10
    end
    object LabeledEdit11: TLabeledEdit
      Left = 69
      Top = 301
      Width = 145
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = #20445#30041#23383#27573'8'
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 11
    end
    object DateTimePicker1: TDateTimePicker
      Left = 192
      Top = 325
      Width = 22
      Height = 21
      Date = 40647.679042129630000000
      Time = 40647.679042129630000000
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      TabOrder = 18
      OnChange = DateTimePicker1Change
    end
    object DateTimePicker2: TDateTimePicker
      Left = 192
      Top = 351
      Width = 22
      Height = 21
      Date = 40647.690831944440000000
      Time = 40647.690831944440000000
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      TabOrder = 19
      OnChange = DateTimePicker2Change
    end
    object LabeledEdit12: TLabeledEdit
      Left = 69
      Top = 326
      Width = 123
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = #20445#30041#23383#27573'9'
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 12
    end
    object LabeledEdit13: TLabeledEdit
      Left = 69
      Top = 352
      Width = 123
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 66
      EditLabel.Height = 13
      EditLabel.Caption = #20445#30041#23383#27573'10'
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 13
    end
    object BitBtn5: TBitBtn
      Left = 69
      Top = 3
      Width = 145
      Height = 25
      Caption = #22686#21152#20195#30721#31867#22411
      TabOrder = 20
      OnClick = BitBtn5Click
    end
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    AfterScroll = ADOQuery1AfterScroll
    Parameters = <>
    Left = 544
    Top = 56
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 576
    Top = 56
  end
  object DosMove1: TDosMove
    Active = True
    Left = 336
    Top = 16
  end
end
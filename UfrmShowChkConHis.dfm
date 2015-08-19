object frmShowChkConHis: TfrmShowChkConHis
  Left = 192
  Top = 122
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #30003#35831#21333#26597#35810
  ClientHeight = 462
  ClientWidth = 684
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
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 684
    Height = 90
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 80
      Top = 73
      Width = 366
      Height = 13
      Caption = #27880':'#26465#30721#25195#25551#33258#21160#23548#20837#26102#21462#32852#26426#21495'(1)'#65292#21542#21017#21462#39044#32422#30331#35760#30340#32852#26426#21495
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object BitBtnCommQry: TBitBtn
      Left = 277
      Top = 1
      Width = 110
      Height = 25
      Caption = #36873#21462#26597#35810#26465#20214'(&Q)'
      TabOrder = 0
      OnClick = BitBtnCommQryClick
    end
    object BitBtn2: TBitBtn
      Left = 277
      Top = 27
      Width = 110
      Height = 25
      Caption = #30830#23450
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object CheckBox1: TCheckBox
      Left = 477
      Top = 6
      Width = 161
      Height = 17
      Caption = #24378#21046#35206#30422#24403#21069#25351#23450#30149#20154
      TabOrder = 2
    end
    object CheckBox2: TCheckBox
      Left = 477
      Top = 32
      Width = 196
      Height = 17
      Caption = #20165#36873#25321#24403#21069#24037#20316#32452#30340#32452#21512#39033#30446
      TabOrder = 3
    end
    object LabeledEdit2: TLabeledEdit
      Left = 81
      Top = 4
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #26465#30721#25195#25551
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      TabOrder = 4
      OnKeyDown = LabeledEdit2KeyDown
    end
    object CheckBox3: TCheckBox
      Left = 477
      Top = 56
      Width = 140
      Height = 17
      Caption = '"'#30830#23450'"'#21518#20851#38381#31383#21475
      TabOrder = 5
    end
    object LabeledEdit3: TLabeledEdit
      Left = 81
      Top = 50
      Width = 121
      Height = 21
      EditLabel.Width = 65
      EditLabel.Height = 13
      EditLabel.Caption = #26679#26412#36865#20132#20154
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      TabOrder = 6
    end
    object LabeledEdit1: TLabeledEdit
      Left = 81
      Top = 27
      Width = 121
      Height = 21
      EditLabel.Width = 60
      EditLabel.Height = 13
      EditLabel.Caption = #32852#26426#21495'(1)'
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      TabOrder = 7
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 90
    Width = 684
    Height = 203
    Align = alClient
    DataSource = DataSource1
    ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnExit = DBGrid1Exit
    OnKeyDown = DBGrid1KeyDown
    OnKeyUp = DBGrid1KeyUp
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 293
    Width = 684
    Height = 169
    Align = alBottom
    DataSource = DataSource2
    ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    OnCellClick = DBGrid2CellClick
    OnDrawColumnCell = DBGrid2DrawColumnCell
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    AfterScroll = ADOQuery1AfterScroll
    Parameters = <>
    Left = 136
    Top = 96
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 168
    Top = 96
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery2
    Left = 176
    Top = 328
  end
  object ADOQuery2: TADOQuery
    AfterOpen = ADOQuery2AfterOpen
    Parameters = <>
    Left = 144
    Top = 328
  end
  object DosMove1: TDosMove
    Active = True
    Left = 344
    Top = 104
  end
end

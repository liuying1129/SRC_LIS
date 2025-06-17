object frmBatchSpecNo: TfrmBatchSpecNo
  Left = 194
  Top = 231
  BorderStyle = bsDialog
  Caption = #25209#37327#21024#38500'/'#23457#26680' - '#33539#22260#36873#25321
  ClientHeight = 198
  ClientWidth = 308
  Color = clSkyBlue
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 21
    Top = 14
    Width = 78
    Height = 13
    Caption = #24320#22987#30340#26816#39564#21333
  end
  object Label2: TLabel
    Left = 21
    Top = 77
    Width = 78
    Height = 13
    Caption = #32467#26463#30340#26816#39564#21333
  end
  object Label3: TLabel
    Left = 24
    Top = 174
    Width = 26
    Height = 13
    Caption = #27880#65306
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
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
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 168
    Top = 136
    Width = 75
    Height = 25
    Caption = #20851#38381
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object LabeledEdit3: TEdit
    Left = 21
    Top = 31
    Width = 180
    Height = 21
    ReadOnly = True
    TabOrder = 0
    OnEnter = LabeledEdit3Enter
  end
  object LabeledEdit1: TEdit
    Left = 21
    Top = 93
    Width = 180
    Height = 21
    ReadOnly = True
    TabOrder = 1
    OnEnter = LabeledEdit1Enter
  end
  object Edit1: TEdit
    Left = 203
    Top = 93
    Width = 73
    Height = 21
    Hint = #32852#26426#23383#27597
    Enabled = False
    TabOrder = 4
  end
  object Edit2: TEdit
    Left = 203
    Top = 31
    Width = 73
    Height = 21
    Hint = #32852#26426#23383#27597
    Enabled = False
    TabOrder = 5
  end
end

object frmModifyPwd: TfrmModifyPwd
  Left = 364
  Top = 168
  BorderStyle = bsDialog
  Caption = #20462#25913#23494#30721
  ClientHeight = 261
  ClientWidth = 284
  Color = clSkyBlue
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object LabeledEdit1: TLabeledEdit
    Left = 88
    Top = 32
    Width = 121
    Height = 19
    Ctl3D = False
    EditLabel.Width = 39
    EditLabel.Height = 13
    EditLabel.Caption = #21407#23494#30721
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 0
  end
  object LabeledEdit2: TLabeledEdit
    Left = 88
    Top = 88
    Width = 121
    Height = 19
    Ctl3D = False
    EditLabel.Width = 39
    EditLabel.Height = 13
    EditLabel.Caption = #26032#23494#30721
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 1
  end
  object LabeledEdit3: TLabeledEdit
    Left = 88
    Top = 144
    Width = 121
    Height = 19
    Ctl3D = False
    EditLabel.Width = 65
    EditLabel.Height = 13
    EditLabel.Caption = #26032#23494#30721#30830#35748
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 48
    Top = 200
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 3
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 168
    Top = 200
    Width = 75
    Height = 25
    Caption = #20851#38381
    TabOrder = 4
    OnClick = BitBtn2Click
  end
end

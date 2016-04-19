object frmSmallItemPick: TfrmSmallItemPick
  Left = 49
  Top = 83
  Width = 696
  Height = 480
  Caption = #26410#20998#32452#39033#30446#36873#25321
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object CheckListBox1: TCheckListBox
    Left = 0
    Top = 0
    Width = 680
    Height = 408
    Align = alClient
    Color = clInfoBk
    Columns = 5
    ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
    ItemHeight = 14
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 408
    Width = 680
    Height = 34
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 105
      Top = 7
      Width = 62
      Height = 20
      Caption = #30830#23450
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 184
      Top = 7
      Width = 62
      Height = 20
      Caption = #20851#38381
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object LabeledEdit1: TLabeledEdit
      Left = 408
      Top = 8
      Width = 41
      Height = 20
      Color = clInfoBk
      Ctl3D = False
      EditLabel.Width = 70
      EditLabel.Height = 14
      EditLabel.Caption = #32452#21512#39033#30446#21495
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = clRed
      EditLabel.Font.Height = -14
      EditLabel.Font.Name = #23435#20307
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      LabelPosition = lpLeft
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
    end
  end
end

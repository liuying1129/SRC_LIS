object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #26356#26032#26816#26597#26085#26399
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 16
  object Label1: TLabel
    Left = 80
    Top = 240
    Width = 448
    Height = 16
    Caption = #27880#65306#23558#12304#25152#23646#20844#21496#12305#20013#30340#26085#26399#26102#38388#20889#20837#26816#26597#26085#26399#21450#26816#26597#26102#38388#23383#27573
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 168
    Top = 160
    Width = 249
    Height = 25
    Caption = #26356#26032#26816#26597#26085#26399
    TabOrder = 0
    OnClick = Button1Click
  end
  object FDConnection1: TFDConnection
    Left = 48
    Top = 32
  end
end

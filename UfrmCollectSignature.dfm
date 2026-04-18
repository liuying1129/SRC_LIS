object frmCollectSignature: TfrmCollectSignature
  Left = 192
  Top = 123
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #37319#38598#31614#21517
  ClientHeight = 411
  ClientWidth = 524
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
    Left = 24
    Top = 16
    Width = 39
    Height = 13
    Caption = #37319#38598#21306
  end
  object Label2: TLabel
    Left = 24
    Top = 208
    Width = 137
    Height = 13
    Caption = #23637#31034#21306'-'#37319#38598#25104#21151#30340#32467#26524
  end
  object Image1: TImage
    Left = 24
    Top = 232
    Width = 390
    Height = 130
  end
  object PaintBox1: TPaintBox
    Left = 24
    Top = 32
    Width = 390
    Height = 130
    OnMouseDown = PaintBox1MouseDown
    OnMouseMove = PaintBox1MouseMove
    OnMouseUp = PaintBox1MouseUp
    OnPaint = PaintBox1Paint
  end
  object SpeedButton1: TSpeedButton
    Left = 448
    Top = 32
    Width = 49
    Height = 22
    Caption = #28165#38500
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 448
    Top = 136
    Width = 49
    Height = 22
    Caption = #25552#20132
    OnClick = SpeedButton2Click
  end
  object Label3: TLabel
    Left = 80
    Top = 16
    Width = 26
    Height = 13
    Caption = #35831#12304
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 216
    Top = 16
    Width = 91
    Height = 13
    Caption = #12305#22312#37319#38598#21306#31614#21517
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 108
    Top = 16
    Width = 26
    Height = 13
    Caption = #22995#21517
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
end

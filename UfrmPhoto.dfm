object frmPhoto: TfrmPhoto
  Left = 192
  Top = 110
  Width = 780
  Height = 580
  Caption = 'frmPhoto'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 764
    Height = 542
    Align = alClient
    TabOrder = 0
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 760
      Height = 538
      Align = alClient
      Stretch = True
      OnDblClick = Image1DblClick
    end
  end
end

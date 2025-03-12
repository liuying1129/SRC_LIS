object frmRequestInfo: TfrmRequestInfo
  Left = 192
  Top = 123
  Width = 950
  Height = 506
  Caption = #26465#30721#26597#35810
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 934
    Height = 169
    Align = alTop
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 24
      Top = 40
      Width = 793
      Height = 120
      DataSource = DataSource1
      PopupMenu = PopupMenu1
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
    end
    object LabeledEdit1: TLabeledEdit
      Left = 120
      Top = 16
      Width = 121
      Height = 21
      EditLabel.Width = 91
      EditLabel.Height = 13
      EditLabel.Caption = 'req_header_id'
      LabelPosition = lpLeft
      TabOrder = 1
    end
    object BitBtn1: TBitBtn
      Left = 251
      Top = 14
      Width = 75
      Height = 25
      Caption = #26597#35810#26465#30721
      TabOrder = 2
      OnClick = BitBtn1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 169
    Width = 934
    Height = 224
    Align = alTop
    TabOrder = 1
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 184
    Top = 72
  end
  object PopupMenu1: TPopupMenu
    Left = 248
    Top = 72
    object N1: TMenuItem
      Caption = #21024#38500#26465#30721
      OnClick = N1Click
    end
  end
  object ADOQuery1: TADOQuery
    Connection = frmMain.ADOConnection1
    Parameters = <>
    Left = 152
    Top = 72
  end
end

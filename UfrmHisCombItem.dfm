object frmHisCombItem: TfrmHisCombItem
  Left = 192
  Top = 122
  Width = 700
  Height = 500
  Caption = '项目对照'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 233
    Height = 462
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 128
      Width = 78
      Height = 13
      Caption = '外部系统标识'
    end
    object BitBtn1: TBitBtn
      Left = 35
      Top = 400
      Width = 75
      Height = 25
      Caption = '新增'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 110
      Top = 400
      Width = 75
      Height = 25
      Caption = '保存'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 35
      Top = 424
      Width = 75
      Height = 25
      Caption = '删除'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object LabeledEdit1: TLabeledEdit
      Left = 24
      Top = 24
      Width = 177
      Height = 21
      EditLabel.Width = 130
      EditLabel.Height = 13
      EditLabel.Caption = '外部系统收费项目代码'
      TabOrder = 3
    end
    object BitBtn4: TBitBtn
      Left = 110
      Top = 424
      Width = 75
      Height = 25
      Cancel = True
      Caption = '关闭(ESC)'
      TabOrder = 4
      OnClick = BitBtn4Click
    end
    object LabeledEdit2: TLabeledEdit
      Left = 24
      Top = 80
      Width = 177
      Height = 21
      EditLabel.Width = 130
      EditLabel.Height = 13
      EditLabel.Caption = '外部系统收费项目名称'
      TabOrder = 5
    end
    object ComboBox1: TComboBox
      Left = 24
      Top = 144
      Width = 177
      Height = 21
      ItemHeight = 13
      TabOrder = 6
      Items.Strings = (
        'HIS'
        'PEIS')
    end
  end
  object DBGrid1: TDBGrid
    Left = 233
    Top = 0
    Width = 451
    Height = 462
    Align = alClient
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = '宋体'
    TitleFont.Style = []
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 344
    Top = 72
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    AfterScroll = ADOQuery1AfterScroll
    Parameters = <>
    Left = 376
    Top = 72
  end
end

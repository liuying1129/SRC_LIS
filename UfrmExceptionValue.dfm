object frmExceptionValue: TfrmExceptionValue
  Left = 192
  Top = 122
  Width = 700
  Height = 500
  Caption = '非数值结果超限值管理'
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
      Left = 16
      Top = 64
      Width = 52
      Height = 13
      Caption = '匹配方式'
    end
    object Label2: TLabel
      Left = 16
      Top = 168
      Width = 52
      Height = 13
      Caption = '超限标识'
    end
    object Label3: TLabel
      Left = 2
      Top = 232
      Width = 254
      Height = 143
      Caption = 
        '例如，乙肝表面抗原，希望结果值为'#13'“阳性”时显示偏高'#13'设置方案1：匹配方式选择“左匹配”，'#13'结果值填“阳”，超限标识选择“偏高”' +
        ','#13'则结果值为“阳”开头时显示为偏高'#13'设置方案2：匹配方式选择“全匹配”，'#13'结果值填“阳性”，超限标识选择“偏高”,'#13'则结果值等' +
        '于“阳性”时显示为偏高'#13'设置方案3：匹配方式选择“模糊匹配”，'#13'结果值填“阳性”，超限标识选择“偏高”,'#13'则结果值包含“阳性”时' +
        '显示为偏高'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
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
    object BitBtn4: TBitBtn
      Left = 110
      Top = 424
      Width = 75
      Height = 25
      Cancel = True
      Caption = '关闭(ESC)'
      TabOrder = 3
      OnClick = BitBtn4Click
    end
    object ComboBox1: TComboBox
      Left = 16
      Top = 80
      Width = 200
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        '模糊匹配'
        '左匹配'
        '右匹配'
        '全匹配')
    end
    object ComboBox2: TComboBox
      Left = 16
      Top = 184
      Width = 200
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      Items.Strings = (
        ''
        '偏低'
        '偏高')
    end
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 128
      Width = 200
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = '结果值'
      TabOrder = 6
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

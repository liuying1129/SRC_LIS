object frmExceptionValue: TfrmExceptionValue
  Left = 192
  Top = 122
  Width = 700
  Height = 500
  Caption = '����ֵ�������ֵ����'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = '����'
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
      Caption = 'ƥ�䷽ʽ'
    end
    object Label2: TLabel
      Left = 16
      Top = 168
      Width = 52
      Height = 13
      Caption = '���ޱ�ʶ'
    end
    object Label3: TLabel
      Left = 2
      Top = 232
      Width = 254
      Height = 143
      Caption = 
        '���磬�Ҹα��濹ԭ��ϣ�����ֵΪ'#13'�����ԡ�ʱ��ʾƫ��'#13'���÷���1��ƥ�䷽ʽѡ����ƥ�䡱��'#13'���ֵ����������ޱ�ʶѡ��ƫ�ߡ�' +
        ','#13'����ֵΪ��������ͷʱ��ʾΪƫ��'#13'���÷���2��ƥ�䷽ʽѡ��ȫƥ�䡱��'#13'���ֵ����ԡ������ޱ�ʶѡ��ƫ�ߡ�,'#13'����ֵ��' +
        '�ڡ����ԡ�ʱ��ʾΪƫ��'#13'���÷���3��ƥ�䷽ʽѡ��ģ��ƥ�䡱��'#13'���ֵ����ԡ������ޱ�ʶѡ��ƫ�ߡ�,'#13'����ֵ���������ԡ�ʱ' +
        '��ʾΪƫ��'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 35
      Top = 400
      Width = 75
      Height = 25
      Caption = '����'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 110
      Top = 400
      Width = 75
      Height = 25
      Caption = '����'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 35
      Top = 424
      Width = 75
      Height = 25
      Caption = 'ɾ��'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 110
      Top = 424
      Width = 75
      Height = 25
      Cancel = True
      Caption = '�ر�(ESC)'
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
        'ģ��ƥ��'
        '��ƥ��'
        '��ƥ��'
        'ȫƥ��')
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
        'ƫ��'
        'ƫ��')
    end
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 128
      Width = 200
      Height = 21
      EditLabel.Width = 39
      EditLabel.Height = 13
      EditLabel.Caption = '���ֵ'
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
    TitleFont.Name = '����'
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

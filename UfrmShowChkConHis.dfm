object frmShowChkConHis: TfrmShowChkConHis
  Left = 192
  Top = 122
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '���뵥��ѯ'
  ClientHeight = 462
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = '����'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 684
    Height = 90
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 80
      Top = 73
      Width = 366
      Height = 13
      Caption = 'ע:����ɨ���Զ�����ʱȡ������(1)������ȡԤԼ�Ǽǵ�������'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
    end
    object BitBtnCommQry: TBitBtn
      Left = 277
      Top = 1
      Width = 110
      Height = 25
      Caption = 'ѡȡ��ѯ����(&Q)'
      TabOrder = 0
      OnClick = BitBtnCommQryClick
    end
    object BitBtn2: TBitBtn
      Left = 277
      Top = 27
      Width = 110
      Height = 25
      Caption = 'ȷ��'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object CheckBox1: TCheckBox
      Left = 477
      Top = 6
      Width = 161
      Height = 17
      Caption = 'ǿ�Ƹ��ǵ�ǰָ������'
      TabOrder = 2
    end
    object CheckBox2: TCheckBox
      Left = 477
      Top = 32
      Width = 196
      Height = 17
      Caption = '��ѡ��ǰ������������Ŀ'
      TabOrder = 3
    end
    object LabeledEdit2: TLabeledEdit
      Left = 81
      Top = 4
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = '����ɨ��'
      LabelPosition = lpLeft
      TabOrder = 4
      OnKeyDown = LabeledEdit2KeyDown
    end
    object CheckBox3: TCheckBox
      Left = 477
      Top = 56
      Width = 140
      Height = 17
      Caption = '"ȷ��"��رմ���'
      TabOrder = 5
    end
    object LabeledEdit3: TLabeledEdit
      Left = 81
      Top = 50
      Width = 121
      Height = 21
      EditLabel.Width = 65
      EditLabel.Height = 13
      EditLabel.Caption = '�����ͽ���'
      LabelPosition = lpLeft
      TabOrder = 6
    end
    object LabeledEdit1: TLabeledEdit
      Left = 81
      Top = 27
      Width = 121
      Height = 21
      EditLabel.Width = 60
      EditLabel.Height = 13
      EditLabel.Caption = '������(1)'
      LabelPosition = lpLeft
      TabOrder = 7
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 90
    Width = 684
    Height = 203
    Align = alClient
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = '����'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnExit = DBGrid1Exit
    OnKeyDown = DBGrid1KeyDown
    OnKeyUp = DBGrid1KeyUp
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 293
    Width = 684
    Height = 169
    Align = alBottom
    DataSource = DataSource2
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = '����'
    TitleFont.Style = []
    OnCellClick = DBGrid2CellClick
    OnDrawColumnCell = DBGrid2DrawColumnCell
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    AfterScroll = ADOQuery1AfterScroll
    Parameters = <>
    Left = 136
    Top = 96
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 168
    Top = 96
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery2
    Left = 176
    Top = 328
  end
  object ADOQuery2: TADOQuery
    AfterOpen = ADOQuery2AfterOpen
    Parameters = <>
    Left = 144
    Top = 328
  end
  object DosMove1: TDosMove
    Active = True
    Left = 344
    Top = 104
  end
end

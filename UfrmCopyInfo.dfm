object frmCopyInfo: TfrmCopyInfo
  Left = 242
  Top = 182
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '���ƹ����鲡�˻�����Ϣ'
  ClientHeight = 433
  ClientWidth = 462
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
  object Label1: TLabel
    Left = 204
    Top = 6
    Width = 65
    Height = 13
    Caption = 'Ŀ�깤����'
  end
  object Label2: TLabel
    Left = 189
    Top = 73
    Width = 78
    Height = 13
    Caption = 'Ŀ����������'
  end
  object Label5: TLabel
    Left = 176
    Top = 376
    Width = 222
    Height = 13
    Caption = 'ע:1������������б����ѡ�еĲ���'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = '����'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 196
    Top = 392
    Width = 165
    Height = 13
    Caption = '2����סCTRL�����ʵ�ֶ�ѡ'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = '����'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 196
    Top = 408
    Width = 241
    Height = 13
    Caption = '3����������¼����ʱ�ű�ʾ�ò��˱�ѡ��'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = '����'
    Font.Style = []
    ParentFont = False
  end
  object ComboBox1: TComboBox
    Left = 272
    Top = 3
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object LabeledEdit1: TLabeledEdit
    Left = 272
    Top = 25
    Width = 145
    Height = 21
    EditLabel.Width = 78
    EditLabel.Height = 13
    EditLabel.Caption = 'Ŀ��������ĸ'
    LabelPosition = lpLeft
    TabOrder = 1
    OnChange = LabeledEdit1Change
  end
  object BitBtn1: TBitBtn
    Left = 224
    Top = 328
    Width = 75
    Height = 25
    Caption = 'ȷ��'
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 312
    Top = 328
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'ȡ��'
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object LabeledEdit2: TLabeledEdit
    Left = 272
    Top = 47
    Width = 145
    Height = 21
    EditLabel.Width = 91
    EditLabel.Height = 13
    EditLabel.Caption = 'Ŀ�꿪ʼ������'
    Enabled = False
    LabelPosition = lpLeft
    TabOrder = 4
  end
  object ComboBox2: TComboBox
    Left = 272
    Top = 69
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 5
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 162
    Height = 433
    Align = alLeft
    Caption = '��ѡ��Ҫ���ƵĲ���'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = '����'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    object DBGrid1: TDBGrid
      Left = 2
      Top = 45
      Width = 158
      Height = 386
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -13
      TitleFont.Name = '����'
      TitleFont.Style = []
    end
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 158
      Height = 30
      Align = alTop
      TabOrder = 1
      object CheckBox1: TCheckBox
        Left = 3
        Top = 6
        Width = 97
        Height = 17
        Caption = 'ȫѡ'
        TabOrder = 0
        OnClick = CheckBox1Click
      end
    end
  end
  object CheckListBox1: TCheckListBox
    Left = 168
    Top = 104
    Width = 289
    Height = 209
    Columns = 2
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 7
  end
  object DataSource1: TDataSource
    Left = 32
    Top = 64
  end
end

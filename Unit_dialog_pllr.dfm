object Form_pllr: TForm_pllr
  Left = 272
  Top = 111
  BorderStyle = bsDialog
  Caption = '病人信息批量录入'
  ClientHeight = 433
  ClientWidth = 292
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = '宋体'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CheckListBox1: TCheckListBox
    Left = 0
    Top = 212
    Width = 292
    Height = 171
    Align = alClient
    Color = 16767438
    Columns = 2
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 383
    Width = 292
    Height = 50
    Align = alBottom
    Color = clSkyBlue
    TabOrder = 1
    object Label2: TLabel
      Left = 34
      Top = 34
      Width = 167
      Height = 13
      Caption = '注：1、范围格式如5,7-9,12'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 13
      Top = 5
      Width = 62
      Height = 25
      Caption = '确定(F2)'
      TabOrder = 0
      OnClick = BitBtn1Click
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 75
      Top = 5
      Width = 62
      Height = 25
      Caption = '关闭(Esc)'
      TabOrder = 1
      OnClick = BitBtn2Click
      NumGlyphs = 2
    end
    object BitBtn3: TBitBtn
      Left = 147
      Top = 5
      Width = 60
      Height = 25
      Caption = '全选'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 208
      Top = 5
      Width = 60
      Height = 25
      Caption = '反选'
      TabOrder = 3
      OnClick = BitBtn4Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 292
    Height = 212
    Align = alTop
    Color = clSkyBlue
    TabOrder = 2
    object Label1: TLabel
      Left = 62
      Top = 28
      Width = 52
      Height = 13
      Caption = '优先级别'
    end
    object Label3: TLabel
      Left = 62
      Top = 8
      Width = 52
      Height = 13
      Caption = '检查日期'
    end
    object Label4: TLabel
      Left = 120
      Top = 197
      Width = 104
      Height = 13
      Caption = '小框中填联机字母'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object DateTimePicker1: TDateTimePicker
      Left = 120
      Top = 4
      Width = 95
      Height = 21
      Date = 37833.628041087960000000
      Time = 37833.628041087960000000
      TabOrder = 5
      OnChange = DateTimePicker1Change
    end
    object LabeledEdit1: TLabeledEdit
      Left = 120
      Top = 88
      Width = 95
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = '样本类型'
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 2
      OnKeyDown = LabeledEdit1KeyDown
    end
    object LabeledEdit5: TLabeledEdit
      Left = 120
      Top = 108
      Width = 95
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = '样本状态'
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 3
      OnKeyDown = LabeledEdit5KeyDown
    end
    object LabeledEdit6: TLabeledEdit
      Left = 120
      Top = 48
      Width = 95
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = '送检科室'
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 0
      OnKeyDown = LabeledEdit6KeyDown
    end
    object LabeledEdit10: TLabeledEdit
      Left = 120
      Top = 68
      Width = 95
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = '送检医生'
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 1
      OnKeyDown = LabeledEdit10KeyDown
    end
    object LabeledEdit15: TLabeledEdit
      Left = 120
      Top = 128
      Width = 95
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = '备注'
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 4
      OnKeyDown = LabeledEdit15KeyDown
    end
    object ComboBox1: TComboBox
      Left = 120
      Top = 25
      Width = 95
      Height = 21
      ItemHeight = 13
      TabOrder = 6
      Text = '常规'
      OnChange = ComboBox1Change
      Items.Strings = (
        '常规'
        '急诊')
    end
    object RadioGroup2: TRadioGroup
      Left = 17
      Top = 144
      Width = 100
      Height = 50
      ItemIndex = 0
      Items.Strings = (
        '流水号范围'
        '联机号范围')
      TabOrder = 7
      OnClick = RadioGroup2Click
    end
    object LabeledEdit3: TEdit
      Left = 120
      Top = 150
      Width = 95
      Height = 21
      TabOrder = 8
    end
    object LabeledEdit14: TEdit
      Left = 142
      Top = 172
      Width = 73
      Height = 21
      Enabled = False
      TabOrder = 9
    end
    object Edit1: TEdit
      Left = 120
      Top = 172
      Width = 21
      Height = 21
      Hint = '联机字母'
      Enabled = False
      TabOrder = 10
    end
  end
  object DosMove1: TDosMove
    Active = True
    Left = 16
    Top = 8
  end
  object ActionList1: TActionList
    Left = 16
    Top = 80
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 113
      OnExecute = BitBtn1Click
    end
    object Action2: TAction
      Caption = 'Action2'
      ShortCut = 27
      OnExecute = BitBtn2Click
    end
  end
end

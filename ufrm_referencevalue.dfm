object frm_referencevalue: Tfrm_referencevalue
  Left = 238
  Top = 154
  BorderStyle = bsDialog
  Caption = '参考值设置'
  ClientHeight = 466
  ClientWidth = 692
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 692
    Height = 177
    Align = alTop
    TabOrder = 0
    object Label4: TLabel
      Left = 8
      Top = 40
      Width = 52
      Height = 13
      Caption = '样本类型'
    end
    object Label6: TLabel
      Left = 299
      Top = 43
      Width = 39
      Height = 13
      Caption = '最小值'
    end
    object Label7: TLabel
      Left = 497
      Top = 43
      Width = 39
      Height = 13
      Caption = '最大值'
    end
    object BitBtn1: TBitBtn
      Left = 19
      Top = 10
      Width = 90
      Height = 25
      Caption = '新增F2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 110
      Top = 10
      Width = 90
      Height = 25
      Caption = '保存F3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 201
      Top = 10
      Width = 90
      Height = 25
      Caption = '删除F5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = BitBtn3Click
    end
    object LabeledEdit1: TLabeledEdit
      Left = 100
      Top = 58
      Width = 45
      Height = 19
      Color = clWhite
      Ctl3D = False
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = '性别'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = '宋体'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      OnKeyDown = LabeledEdit1KeyDown
    end
    object LabeledEdit2: TLabeledEdit
      Left = 149
      Top = 58
      Width = 70
      Height = 19
      Color = clWhite
      Ctl3D = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = '年龄下限'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = '宋体'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
      OnExit = LabeledEdit2Exit
    end
    object LabeledEdit3: TLabeledEdit
      Left = 222
      Top = 58
      Width = 70
      Height = 19
      Color = clWhite
      Ctl3D = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = '年龄上限'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = '宋体'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
      OnExit = LabeledEdit3Exit
    end
    object BitBtn6: TBitBtn
      Left = 292
      Top = 10
      Width = 90
      Height = 25
      Cancel = True
      Caption = '关闭(Esc)'
      TabOrder = 9
      OnClick = BitBtn6Click
      NumGlyphs = 2
    end
    object ComboBox1: TComboBox
      Left = 6
      Top = 56
      Width = 89
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object LabeledEdit4: TMemo
      Left = 297
      Top = 58
      Width = 190
      Height = 105
      ScrollBars = ssBoth
      TabOrder = 4
      WordWrap = False
    end
    object LabeledEdit5: TMemo
      Left = 495
      Top = 58
      Width = 190
      Height = 105
      ScrollBars = ssBoth
      TabOrder = 5
      WordWrap = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 177
    Width = 692
    Height = 289
    Align = alClient
    Color = clSkyBlue
    TabOrder = 1
    object DBGrid2: TDBGrid
      Left = 1
      Top = 1
      Width = 690
      Height = 217
      Align = alClient
      Color = 16767438
      DataSource = DataSource2
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = '宋体'
      TitleFont.Style = []
    end
    object Panel2: TPanel
      Left = 1
      Top = 218
      Width = 690
      Height = 70
      Align = alBottom
      Color = clSkyBlue
      TabOrder = 1
      object Label1: TLabel
        Left = 28
        Top = 4
        Width = 209
        Height = 13
        Caption = '注:1、性别为空表示适用于所有性别'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 48
        Top = 20
        Width = 269
        Height = 13
        Caption = '2、年龄下限为空表示0岁，上限为空表示200岁'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 48
        Top = 37
        Width = 189
        Height = 13
        Caption = '3、最大值、最小值不要输入单位'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 48
        Top = 53
        Width = 241
        Height = 13
        Caption = '4、样本类型为空表示适用于所有样本类型'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 376
        Top = 4
        Width = 244
        Height = 13
        Caption = '5、最小/大值框，Ctrl+回车，可换行输入'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object ADOQuery2: TADOQuery
    CursorType = ctStatic
    AfterScroll = ADOQuery2AfterScroll
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 33
    Top = 216
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery2
    Left = 65
    Top = 216
  end
  object DosMove1: TDosMove
    Active = True
    Left = 297
    Top = 224
  end
  object ActionList1: TActionList
    Left = 265
    Top = 224
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 113
      OnExecute = BitBtn1Click
    end
    object Action2: TAction
      Caption = 'Action2'
      ShortCut = 114
      OnExecute = BitBtn2Click
    end
    object Action3: TAction
      Caption = 'Action3'
      ShortCut = 116
      OnExecute = BitBtn3Click
    end
    object Action4: TAction
      Caption = 'Action4'
      ShortCut = 117
    end
  end
end

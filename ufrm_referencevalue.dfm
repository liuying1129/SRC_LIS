object frm_referencevalue: Tfrm_referencevalue
  Left = 238
  Top = 154
  BorderStyle = bsDialog
  Caption = #21442#32771#20540#35774#32622
  ClientHeight = 466
  ClientWidth = 692
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
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
      Caption = #26679#26412#31867#22411
    end
    object Label6: TLabel
      Left = 299
      Top = 43
      Width = 39
      Height = 13
      Caption = #26368#23567#20540
    end
    object Label7: TLabel
      Left = 497
      Top = 43
      Width = 39
      Height = 13
      Caption = #26368#22823#20540
    end
    object BitBtn1: TBitBtn
      Left = 19
      Top = 10
      Width = 90
      Height = 25
      Caption = #26032#22686'F2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
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
      Caption = #20445#23384'F3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
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
      Caption = #21024#38500'F5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
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
      EditLabel.Caption = #24615#21035
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = #23435#20307
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
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
      EditLabel.Caption = #24180#40836#19979#38480
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = #23435#20307
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
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
      EditLabel.Caption = #24180#40836#19978#38480
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = #23435#20307
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
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
      Caption = #20851#38381'(Esc)'
      TabOrder = 9
      OnClick = BitBtn6Click
      NumGlyphs = 2
    end
    object ComboBox1: TComboBox
      Left = 6
      Top = 56
      Width = 89
      Height = 21
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      ItemHeight = 13
      TabOrder = 0
    end
    object LabeledEdit4: TMemo
      Left = 297
      Top = 58
      Width = 190
      Height = 105
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      ScrollBars = ssBoth
      TabOrder = 4
      WordWrap = False
    end
    object LabeledEdit5: TMemo
      Left = 495
      Top = 58
      Width = 190
      Height = 105
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
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
      ImeName = #20013#25991'('#31616#20307') - '#19975#33021#20116#31508#36755#20837#27861
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
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
        Caption = #27880':1'#12289#24615#21035#20026#31354#34920#31034#36866#29992#20110#25152#26377#24615#21035
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 48
        Top = 20
        Width = 269
        Height = 13
        Caption = '2'#12289#24180#40836#19979#38480#20026#31354#34920#31034'0'#23681#65292#19978#38480#20026#31354#34920#31034'200'#23681
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 48
        Top = 37
        Width = 189
        Height = 13
        Caption = '3'#12289#26368#22823#20540#12289#26368#23567#20540#19981#35201#36755#20837#21333#20301
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 48
        Top = 53
        Width = 241
        Height = 13
        Caption = '4'#12289#26679#26412#31867#22411#20026#31354#34920#31034#36866#29992#20110#25152#26377#26679#26412#31867#22411
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 376
        Top = 4
        Width = 244
        Height = 13
        Caption = '5'#12289#26368#23567'/'#22823#20540#26694#65292'Ctrl+'#22238#36710#65292#21487#25442#34892#36755#20837
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = #23435#20307
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

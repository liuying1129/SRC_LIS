object frmPlxg: TfrmPlxg
  Left = 272
  Top = 111
  BorderStyle = bsDialog
  Caption = #32467#26524#25209#37327#20462#25913
  ClientHeight = 433
  ClientWidth = 308
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 378
    Width = 308
    Height = 55
    Align = alBottom
    Color = clSkyBlue
    TabOrder = 0
    object Label4: TLabel
      Left = 29
      Top = 37
      Width = 236
      Height = 13
      Caption = #27880#65306'1'#12289#35745#31639#32467#26524#20026':'#21407#32467#26524'*'#31995#25968'+'#38468#21152#20540
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 61
      Top = 5
      Width = 80
      Height = 25
      Caption = #30830#23450
      TabOrder = 0
      OnClick = BitBtn1Click
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 155
      Top = 5
      Width = 80
      Height = 25
      Cancel = True
      Caption = #20851#38381
      TabOrder = 1
      OnClick = BitBtn2Click
      NumGlyphs = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 308
    Height = 129
    Align = alTop
    Color = clSkyBlue
    TabOrder = 1
    object Label3: TLabel
      Left = 21
      Top = 104
      Width = 26
      Height = 13
      Caption = #27880#65306
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 21
      Top = 11
      Width = 78
      Height = 13
      Caption = #24320#22987#30340#26816#39564#21333
    end
    object Label2: TLabel
      Left = 21
      Top = 59
      Width = 78
      Height = 13
      Caption = #32467#26463#30340#26816#39564#21333
    end
    object LabeledEdit3: TEdit
      Left = 21
      Top = 28
      Width = 180
      Height = 21
      ReadOnly = True
      TabOrder = 0
      OnEnter = LabeledEdit3Enter
    end
    object Edit2: TEdit
      Left = 203
      Top = 28
      Width = 73
      Height = 21
      Hint = #32852#26426#23383#27597
      Enabled = False
      TabOrder = 1
    end
    object LabeledEdit1: TEdit
      Left = 21
      Top = 75
      Width = 180
      Height = 21
      ReadOnly = True
      TabOrder = 2
      OnEnter = LabeledEdit1Enter
    end
    object Edit1: TEdit
      Left = 203
      Top = 75
      Width = 73
      Height = 21
      Hint = #32852#26426#23383#27597
      Enabled = False
      TabOrder = 3
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 129
    Width = 308
    Height = 249
    Align = alClient
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 176
    Top = 160
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    Parameters = <>
    Left = 216
    Top = 160
  end
end

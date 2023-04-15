object frmCriticalValueDetail: TfrmCriticalValueDetail
  Left = 192
  Top = 123
  Width = 745
  Height = 362
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #21361#24613#20540#21578#35686#35814#24773
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 729
    Height = 323
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #24403#21069#21578#35686
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 721
        Height = 254
        Align = alClient
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
      object Panel2: TPanel
        Left = 0
        Top = 254
        Width = 721
        Height = 41
        Align = alBottom
        TabOrder = 1
        object Label3: TLabel
          Left = 16
          Top = 16
          Width = 171
          Height = 13
          Caption = #27880':'#21491#38190'->'#24050#25253#21578','#21487#28040#38500#21578#35686
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #24050#25253#21578#21361#24613#20540'-'#26597#35810
      ImageIndex = 1
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 721
        Height = 52
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 263
          Top = 28
          Width = 13
          Height = 13
          Caption = #33267
        end
        object Label2: TLabel
          Left = 161
          Top = 8
          Width = 52
          Height = 13
          Caption = #25253#21578#26085#26399
        end
        object DateTimePicker1: TDateTimePicker
          Left = 160
          Top = 24
          Width = 100
          Height = 21
          Date = 45031.000000000000000000
          Time = 45031.000000000000000000
          TabOrder = 0
        end
        object DateTimePicker2: TDateTimePicker
          Left = 280
          Top = 24
          Width = 100
          Height = 21
          Date = 45031.999988425920000000
          Time = 45031.999988425920000000
          TabOrder = 1
        end
        object BitBtn1: TBitBtn
          Left = 395
          Top = 22
          Width = 75
          Height = 25
          Caption = #26597#35810
          TabOrder = 2
          OnClick = BitBtn1Click
        end
      end
      object DBGrid2: TDBGrid
        Left = 0
        Top = 52
        Width = 721
        Height = 243
        Align = alClient
        DataSource = DataSource2
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
      end
    end
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    Parameters = <>
    Left = 56
    Top = 48
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 24
    Top = 48
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 88
    Top = 48
    object N1: TMenuItem
      Caption = #24050#25253#21578
      OnClick = N1Click
    end
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery2
    Left = 28
    Top = 120
  end
  object ADOQuery2: TADOQuery
    AfterOpen = ADOQuery2AfterOpen
    Parameters = <>
    Left = 60
    Top = 120
  end
end

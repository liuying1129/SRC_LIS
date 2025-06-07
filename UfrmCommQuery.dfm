object frmCommQuery: TfrmCommQuery
  Left = 181
  Top = 122
  Width = 794
  Height = 450
  Caption = #26597#35810
  Color = clSkyBlue
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 273
    Width = 778
    Height = 5
    Cursor = crVSplit
    Align = alTop
  end
  object pnlCommQryTop: TPanel
    Left = 0
    Top = 0
    Width = 778
    Height = 35
    Align = alTop
    Color = 16767438
    TabOrder = 0
    object Label1: TLabel
      Left = 732
      Top = 16
      Width = 33
      Height = 13
      Caption = #20154#27425':'
    end
    object Label2: TLabel
      Left = 766
      Top = 16
      Width = 7
      Height = 13
      Caption = '0'
    end
    object BitBtnCommQry: TBitBtn
      Left = 11
      Top = 5
      Width = 110
      Height = 25
      Caption = #36873#21462#26597#35810#26465#20214'(&Q)'
      TabOrder = 0
      OnClick = BitBtnCommQryClick
    end
    object BitBtnCommQryClose: TBitBtn
      Left = 401
      Top = 5
      Width = 70
      Height = 25
      Cancel = True
      Caption = #20851#38381'(&R)'
      TabOrder = 1
      OnClick = BitBtnCommQryCloseClick
    end
    object BitBtn6: TBitBtn
      Left = 261
      Top = 5
      Width = 70
      Height = 25
      Caption = #25171#21360
      TabOrder = 2
      OnClick = BitBtn6Click
    end
    object BitBtn7: TBitBtn
      Left = 331
      Top = 5
      Width = 70
      Height = 25
      Caption = #20998#32452#25171#21360
      TabOrder = 3
      OnClick = BitBtn7Click
    end
  end
  object DBGridResult: TDBGrid
    Left = 0
    Top = 35
    Width = 778
    Height = 238
    Align = alTop
    Color = 16767438
    Ctl3D = False
    DataSource = MasterDataSource
    ParentCtl3D = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
  end
  object pnlCommQryBotton: TPanel
    Left = 0
    Top = 385
    Width = 778
    Height = 26
    Align = alBottom
    Color = 16767438
    TabOrder = 2
    object Label3: TLabel
      Left = 197
      Top = 7
      Width = 563
      Height = 13
      Caption = #20462#25913#26041#27861':1'#12289#28857#20987#8220#20462#25913#8221#25353#38062'  2'#12289#22312#20449#24687#26694#20013#30452#25509#20462#25913'  3'#12289#28857#20987#21521#19979#38190#65292#20351#20809#26631#31163#24320#24050#20462#25913#34892
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object BitBtn4: TBitBtn
      Left = 99
      Top = 1
      Width = 87
      Height = 25
      Caption = #20462#25913#26816#39564#32467#26524
      TabOrder = 0
      OnClick = BitBtn4Click
    end
    object BitBtn2: TBitBtn
      Left = 11
      Top = 1
      Width = 87
      Height = 25
      Caption = #20462#25913#22522#26412#20449#24687
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 278
    Width = 778
    Height = 107
    Align = alClient
    Color = 16767438
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
  end
  object ADOQuery1: TADOQuery
    CursorType = ctStatic
    AfterOpen = ADOQuery1AfterOpen
    Parameters = <>
    Left = 304
    Top = 280
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 336
    Top = 280
  end
  object ADObasic: TADOQuery
    CursorType = ctStatic
    AfterOpen = ADObasicAfterOpen
    AfterScroll = ADObasicAfterScroll
    Parameters = <>
    Left = 304
    Top = 136
  end
  object ADO_print: TADOQuery
    Parameters = <>
    Left = 504
    Top = 104
  end
  object LYQuery1: TADOLYQuery
    DataBaseType = dbtMSSQL
    Left = 536
    Top = 104
  end
  object MasterDataSource: TDataSource
    DataSet = ADObasic
    Left = 336
    Top = 136
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 464
    Top = 160
    object Excel1: TMenuItem
      Caption = #23548#20986'Excel'
      OnClick = Excel1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
  end
  object LYDataToExcel1: TLYDataToExcel
    Left = 440
    Top = 104
  end
end

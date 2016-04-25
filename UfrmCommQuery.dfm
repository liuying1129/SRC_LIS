object frmCommQuery: TfrmCommQuery
  Left = 181
  Top = 122
  Width = 794
  Height = 450
  Caption = '查询'
  Color = clSkyBlue
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = '宋体'
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
      Caption = '人次:'
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
      Caption = '选取查询条件(&Q)'
      TabOrder = 0
      OnClick = BitBtnCommQryClick
    end
    object BitBtnCommQryClose: TBitBtn
      Left = 261
      Top = 5
      Width = 70
      Height = 25
      Cancel = True
      Caption = '关闭(&R)'
      TabOrder = 1
      OnClick = BitBtnCommQryCloseClick
    end
    object BitBtn1: TBitBtn
      Left = 121
      Top = 5
      Width = 70
      Height = 25
      Caption = '打印(&P)'
      TabOrder = 2
      OnClick = BitBtn1Click
    end
    object BitBtn3: TBitBtn
      Left = 191
      Top = 5
      Width = 70
      Height = 25
      Caption = '分组打印'
      TabOrder = 3
      OnClick = BitBtn3Click
    end
    object BitBtn5: TBitBtn
      Left = 432
      Top = 5
      Width = 70
      Height = 25
      Caption = '批量打印'
      TabOrder = 4
      OnClick = BitBtn5Click
    end
    object RadioGroup1: TRadioGroup
      Left = 503
      Top = 1
      Width = 210
      Height = 30
      Caption = '批打选项(表示查询内容全部打印)'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        '打印'
        '分组打印')
      TabOrder = 5
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
    TitleFont.Name = '宋体'
    TitleFont.Style = []
  end
  object pnlCommQryBotton: TPanel
    Left = 0
    Top = 386
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
      Caption = '修改方法:1、点击“修改”按钮  2、在信息框中直接修改  3、点击向下键，使光标离开已修改行'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
    end
    object BitBtn4: TBitBtn
      Left = 99
      Top = 1
      Width = 87
      Height = 25
      Caption = '修改检验结果'
      TabOrder = 0
      OnClick = BitBtn4Click
    end
    object BitBtn2: TBitBtn
      Left = 11
      Top = 1
      Width = 87
      Height = 25
      Caption = '修改基本信息'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 278
    Width = 778
    Height = 108
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
    TitleFont.Name = '宋体'
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
  object frReport1: TfrReport
    Dataset = frDBDataSet2
    InitialZoom = pzDefault
    ModifyPrepared = False
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    ShowPrintDialog = False
    RebuildPrinter = False
    OnGetValue = frReport1GetValue
    OnBeforePrint = frReport1BeforePrint
    Left = 304
    Top = 80
    ReportForm = {19000000}
  end
  object ADObasic: TADOQuery
    CursorType = ctStatic
    AfterOpen = ADObasicAfterOpen
    AfterScroll = ADObasicAfterScroll
    Parameters = <>
    Left = 304
    Top = 136
  end
  object frDBDataSet2: TfrDBDataSet
    DataSet = ADO_print
    Left = 472
    Top = 104
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
      Caption = '导出Excel'
      OnClick = Excel1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
  end
  object LYDataToExcel1: TLYDataToExcel
    Left = 360
    Top = 80
  end
end

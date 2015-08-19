object frmXDepict: TfrmXDepict
  Left = 403
  Top = 152
  Width = 700
  Height = 500
  Caption = #20307#26816#25551#36848#35774#32622
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter
    Left = 211
    Top = 34
    Height = 428
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 684
    Height = 34
    Align = alTop
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 6
      Top = 4
      Width = 88
      Height = 25
      Caption = #26032#22686'F2'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn3: TBitBtn
      Left = 94
      Top = 4
      Width = 88
      Height = 25
      Caption = #20445#23384'F3'
      TabOrder = 1
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 182
      Top = 4
      Width = 88
      Height = 25
      Caption = #21024#38500'F4'
      TabOrder = 2
      OnClick = BitBtn4Click
    end
    object BitBtn6: TBitBtn
      Left = 270
      Top = 4
      Width = 88
      Height = 25
      Caption = #36864#20986'(Esc)'
      TabOrder = 3
      OnClick = BitBtn6Click
    end
    object BitBtn2: TBitBtn
      Left = 358
      Top = 4
      Width = 88
      Height = 25
      Caption = #26597#25214'F5'
      TabOrder = 4
      OnClick = BitBtn2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 34
    Width = 211
    Height = 428
    Align = alLeft
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 175
      Width = 209
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 209
      Height = 174
      Align = alTop
      Caption = #31867#21035
      TabOrder = 0
      object tvWareHouse: TTreeView
        Left = 2
        Top = 15
        Width = 205
        Height = 157
        Align = alClient
        HideSelection = False
        Indent = 19
        ReadOnly = True
        TabOrder = 0
        OnChange = tvWareHouseChange
        OnDeletion = tvWareHouseDeletion
      end
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 178
      Width = 209
      Height = 249
      Align = alClient
      DataSource = DataSource1
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
    end
  end
  object Panel3: TPanel
    Left = 214
    Top = 34
    Width = 470
    Height = 428
    Align = alClient
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 468
      Height = 41
      Align = alTop
      TabOrder = 0
      object LabeledEdit1: TLabeledEdit
        Left = 37
        Top = 12
        Width = 137
        Height = 21
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #32534#21495
        LabelPosition = lpLeft
        TabOrder = 0
      end
      object LabeledEdit2: TLabeledEdit
        Left = 221
        Top = 12
        Width = 289
        Height = 21
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = #21517#31216
        ImeMode = imOpen
        LabelPosition = lpLeft
        TabOrder = 1
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 42
      Width = 468
      Height = 385
      Align = alClient
      Caption = #25551#36848
      TabOrder = 1
      object Memo1: TMemo
        Left = 2
        Top = 15
        Width = 464
        Height = 368
        Align = alClient
        ImeMode = imOpen
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    AfterScroll = ADOQuery1AfterScroll
    Parameters = <>
    Left = 128
    Top = 257
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    OnDataChange = DataSource1DataChange
    Left = 168
    Top = 257
  end
  object ActionList1: TActionList
    Left = 48
    Top = 72
    object ActAdd: TAction
      Caption = 'ActAdd'
      ShortCut = 113
      OnExecute = BitBtn1Click
    end
    object ActSave: TAction
      Caption = 'ActSave'
      ShortCut = 114
      OnExecute = BitBtn3Click
    end
    object ActDel: TAction
      Caption = 'ActDel'
      ShortCut = 115
      OnExecute = BitBtn4Click
    end
    object ActEsc: TAction
      Caption = 'ActEsc'
      ShortCut = 27
      OnExecute = BitBtn6Click
    end
    object ActSearch: TAction
      Caption = 'ActSearch'
      ShortCut = 116
      OnExecute = BitBtn2Click
    end
  end
end

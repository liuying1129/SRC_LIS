object SDIAppForm: TSDIAppForm
  Left = 226
  Top = 21
  Width = 900
  Height = 705
  Caption = '����������Ϣ����ϵͳV7.0'
  Color = clBtnFace
  Constraints.MinWidth = 130
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = '����'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 460
    Top = 37
    Height = 591
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 884
    Height = 37
    AutoSize = True
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 33
        Width = 880
      end>
    Color = 16767438
    ParentColor = False
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 867
      Height = 33
      BorderWidth = 1
      ButtonWidth = 43
      Color = 16767438
      EdgeOuter = esNone
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = '����'
      Font.Style = []
      Images = ImageList1
      Indent = 5
      List = True
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = True
      TabOrder = 0
      Wrapable = False
      object SpeedButton1: TSpeedButton
        Left = 5
        Top = 2
        Width = 76
        Height = 22
        Hint = '����������λ'
        Caption = '���Ҽ��鵥'
        OnClick = SpeedButton1Click
      end
      object ToolButton2: TToolButton
        Left = 81
        Top = 2
        Width = 3
        Caption = 'ToolButton2'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object SpeedButton5: TSpeedButton
        Left = 84
        Top = 2
        Width = 75
        Height = 22
        Caption = '�¼��鵥F2'
        OnClick = SpeedButton5Click
      end
      object ToolButton1: TSpeedButton
        Left = 159
        Top = 2
        Width = 85
        Height = 22
        Caption = 'ɾ�����鵥F4'
        OnClick = ToolButton1Click
      end
      object suiButton8: TSpeedButton
        Left = 244
        Top = 2
        Width = 47
        Height = 22
        Caption = 'ˢ��F5'
        OnClick = suiButton8Click
      end
      object ToolButton4: TToolButton
        Left = 291
        Top = 2
        Width = 3
        Caption = 'ToolButton4'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object suiButton3: TSpeedButton
        Left = 294
        Top = 2
        Width = 47
        Height = 22
        Caption = '���F6'
        OnClick = suiButton3Click
      end
      object suiButton4: TSpeedButton
        Left = 341
        Top = 2
        Width = 75
        Height = 22
        Caption = 'ȡ�����F8'
        OnClick = suiButton4Click
      end
      object ToolButton6: TToolButton
        Left = 416
        Top = 2
        Width = 3
        Caption = 'ToolButton6'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object ToolButton8: TSpeedButton
        Left = 419
        Top = 2
        Width = 47
        Height = 22
        Caption = '��ӡF7'
        OnClick = ToolButton8Click
      end
      object suiButton1: TSpeedButton
        Left = 466
        Top = 2
        Width = 75
        Height = 22
        Caption = '�����ӡF9'
        OnClick = suiButton1Click
      end
      object ToolButton3: TToolButton
        Left = 541
        Top = 2
        Width = 3
        Caption = 'ToolButton3'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object SpeedButton2: TSpeedButton
        Left = 544
        Top = 2
        Width = 95
        Height = 22
        Caption = 'ѡȡ���뵥F12'
        OnClick = SpeedButton2Click
      end
    end
  end
  object Panel1: TPanel
    Left = 463
    Top = 37
    Width = 421
    Height = 591
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object Panel5: TPanel
      Left = 0
      Top = 0
      Width = 421
      Height = 23
      Align = alTop
      Color = 16767438
      Font.Charset = ANSI_CHARSET
      Font.Color = 13583874
      Font.Height = -13
      Font.Name = '����'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 119
        Top = 5
        Width = 189
        Height = 13
        Caption = '����+�ű�ʾת�Ƶ���һ�����鵥'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
      end
      object suiButton7: TSpeedButton
        Left = 310
        Top = 0
        Width = 100
        Height = 22
        Caption = 'ѡȡδ������Ŀ'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = '����'
        Font.Style = []
        ParentFont = False
        OnClick = suiButton7Click
      end
      object LabeledEdit13: TLabeledEdit
        Left = 81
        Top = 2
        Width = 33
        Height = 19
        Ctl3D = False
        EditLabel.Width = 73
        EditLabel.Height = 13
        EditLabel.Caption = '�������(&E)'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = '����'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 0
        OnKeyDown = LabeledEdit13KeyDown
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 23
      Width = 421
      Height = 568
      Align = alClient
      TabOrder = 1
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 419
        Height = 566
        Align = alClient
        TabOrder = 0
        object Splitter2: TSplitter
          Left = 1
          Top = 151
          Width = 417
          Height = 5
          Cursor = crVSplit
          Align = alTop
          Color = clBtnFace
          ParentColor = False
        end
        object PageControl1: TPageControl
          Left = 1
          Top = 156
          Width = 417
          Height = 409
          ActivePage = TabSheet1
          Align = alClient
          TabOrder = 0
          object TabSheet1: TTabSheet
            Caption = '������'
            object DBGrid2: TDBGrid
              Left = 0
              Top = 0
              Width = 409
              Height = 381
              Align = alClient
              Color = 16767438
              Ctl3D = False
              DataSource = DS_dtl
              ParentCtl3D = False
              PopupMenu = PopupMenu2
              TabOrder = 0
              TitleFont.Charset = GB2312_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -13
              TitleFont.Name = '����'
              TitleFont.Style = []
              OnDrawColumnCell = DBGrid2DrawColumnCell
              OnDblClick = DBGrid2DblClick
              OnExit = DBGrid2Exit
              OnKeyDown = DBGrid2KeyDown
              OnKeyUp = DBGrid2KeyUp
            end
          end
          object TabSheet2: TTabSheet
            Caption = 'ͼ��'
            ImageIndex = 1
            object ScrollBoxPicture: TScrollBox
              Left = 0
              Top = 0
              Width = 409
              Height = 319
              Align = alClient
              TabOrder = 0
            end
          end
          object TabSheet3: TTabSheet
            Caption = '��ά��'
            ImageIndex = 2
            object ImageBarcode2D: TImage
              Left = 0
              Top = 0
              Width = 409
              Height = 319
              Align = alClient
            end
          end
          object TabSheet4: TTabSheet
            Caption = '�������'
            ImageIndex = 3
            object meValueDesc: TMemo
              Left = 0
              Top = 40
              Width = 409
              Height = 279
              Align = alClient
              ScrollBars = ssBoth
              TabOrder = 0
            end
            object Panel4: TPanel
              Left = 0
              Top = 0
              Width = 409
              Height = 40
              Align = alTop
              TabOrder = 1
              object Label7: TLabel
                Left = 260
                Top = 23
                Width = 136
                Height = 13
                Caption = 'ע:���м�:Ctrl+Enter'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -13
                Font.Name = '����'
                Font.Style = []
                ParentFont = False
              end
              object Label8: TLabel
                Left = 260
                Top = 6
                Width = 52
                Height = 13
                Caption = '��Ŀ��ʾ'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -13
                Font.Name = '����'
                Font.Style = []
                ParentFont = False
              end
              object BitBtn1: TBitBtn
                Left = 8
                Top = 7
                Width = 100
                Height = 25
                Caption = '����������'
                TabOrder = 0
                OnClick = BitBtn1Click
              end
              object BitBtn2: TBitBtn
                Left = 144
                Top = 7
                Width = 75
                Height = 25
                Caption = '���ģ��'
                TabOrder = 1
                OnClick = BitBtn2Click
              end
            end
          end
        end
        object PageControl2: TPageControl
          Left = 1
          Top = 1
          Width = 417
          Height = 150
          ActivePage = TabSheet6
          Align = alTop
          TabOrder = 1
          object TabSheet5: TTabSheet
            Caption = '���������Ŀ'
            object clbCommUsed: TCheckListBox
              Left = 0
              Top = 0
              Width = 409
              Height = 122
              OnClickCheck = clbCommUsedClickCheck
              Align = alClient
              BevelInner = bvNone
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = 16767438
              Columns = 3
              Ctl3D = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = '����'
              Font.Style = []
              ItemHeight = 13
              ParentCtl3D = False
              ParentFont = False
              PopupMenu = PopupMenu3
              TabOrder = 0
            end
          end
          object TabSheet6: TTabSheet
            Caption = '���������Ŀ'
            ImageIndex = 1
            object clbNoCommUsed: TCheckListBox
              Left = 0
              Top = 0
              Width = 409
              Height = 122
              OnClickCheck = clbCommUsedClickCheck
              Align = alClient
              BevelInner = bvNone
              BevelKind = bkFlat
              BorderStyle = bsNone
              Color = 16767438
              Columns = 3
              Ctl3D = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = '����'
              Font.Style = []
              ItemHeight = 13
              ParentCtl3D = False
              ParentFont = False
              PopupMenu = PopupMenu3
              TabOrder = 0
            end
          end
        end
      end
    end
  end
  object Panel7: TPanel
    Left = 0
    Top = 37
    Width = 460
    Height = 591
    Align = alLeft
    TabOrder = 2
    object GroupBox1: TGroupBox
      Left = 190
      Top = 1
      Width = 269
      Height = 589
      Align = alClient
      Caption = '���鵥�б�(&Q)'
      Color = 16767438
      ParentColor = False
      TabOrder = 0
      object DBGrid1: TDBGrid
        Left = 2
        Top = 42
        Width = 265
        Height = 545
        Align = alClient
        Color = 16767438
        Ctl3D = False
        DataSource = DSbasic
        ParentCtl3D = False
        PopupMenu = pmChangeGroup
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = '����'
        TitleFont.Style = []
        OnDrawColumnCell = DBGrid1DrawColumnCell
      end
      object Panel6: TPanel
        Left = 2
        Top = 15
        Width = 265
        Height = 27
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16767438
        TabOrder = 1
        object Label2: TLabel
          Left = 6
          Top = 7
          Width = 65
          Height = 13
          Caption = 'ѡ������'
        end
        object cbxConnChar: TComboBox
          Tag = 101
          Left = 73
          Top = 3
          Width = 122
          Height = 21
          BevelKind = bkFlat
          Ctl3D = True
          DropDownCount = 20
          ItemHeight = 13
          ParentCtl3D = False
          TabOrder = 0
          OnChange = cbxConnCharChange
          OnEnter = cbxConnCharEnter
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 1
      Width = 189
      Height = 589
      Align = alLeft
      Caption = '������Ϣ¼��'
      Color = 16767438
      ParentColor = False
      PopupMenu = PopupMenu1
      TabOrder = 1
      object Label3: TLabel
        Left = 24
        Top = 297
        Width = 52
        Height = 13
        Caption = '����ʱ��'
      end
      object Label4: TLabel
        Left = 24
        Top = 339
        Width = 52
        Height = 13
        Caption = '���ʱ��'
      end
      object Label5: TLabel
        Left = 24
        Top = 277
        Width = 52
        Height = 13
        Caption = '��������'
      end
      object Label6: TLabel
        Left = 24
        Top = 319
        Width = 52
        Height = 13
        Caption = '�������'
      end
      object suiButton6: TBitBtn
        Left = 79
        Top = 539
        Width = 100
        Height = 22
        Caption = '������鵥F3'
        TabOrder = 25
        OnClick = suiButton6Click
      end
      object LabeledEdit1: TLabeledEdit
        Left = 79
        Top = 53
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 39
        EditLabel.Height = 13
        EditLabel.Caption = '������'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 1
        OnKeyDown = LabeledEdit1KeyDown
      end
      object LabeledEdit2: TLabeledEdit
        Left = 79
        Top = 73
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 72
        EditLabel.Height = 13
        EditLabel.Caption = '����/סԺ��'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 2
        OnKeyDown = LabeledEdit2KeyDown
      end
      object LabeledEdit3: TLabeledEdit
        Left = 79
        Top = 93
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = '����'
        ImeMode = imOpen
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 3
        OnChange = LabeledEdit3Change
      end
      object LabeledEdit5: TLabeledEdit
        Left = 79
        Top = 133
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = '����'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 5
        OnExit = LabeledEdit5Exit
      end
      object LabeledEdit6: TLabeledEdit
        Left = 79
        Top = 153
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = '�ͼ����'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 6
        OnKeyDown = LabeledEdit6KeyDown
      end
      object LabeledEdit7: TLabeledEdit
        Left = 79
        Top = 173
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = '����'
        ImeMode = imOpen
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 7
      end
      object LabeledEdit8: TLabeledEdit
        Left = 79
        Top = 213
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = '��������'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 9
        OnKeyDown = LabeledEdit8KeyDown
      end
      object LabeledEdit9: TLabeledEdit
        Left = 79
        Top = 233
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = '����״̬'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 10
        OnKeyDown = LabeledEdit9KeyDown
      end
      object LabeledEdit10: TLabeledEdit
        Left = 79
        Top = 193
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = '�ͼ�ҽ��'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 8
        OnKeyDown = LabeledEdit10KeyDown
      end
      object DateTimePicker1: TDateTimePicker
        Left = 79
        Top = 273
        Width = 100
        Height = 21
        Date = 37833.628041087960000000
        Time = 37833.628041087960000000
        TabOrder = 12
      end
      object LabeledEdit14: TLabeledEdit
        Left = 79
        Top = 253
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = '�ٴ����'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 11
        OnKeyDown = LabeledEdit14KeyDown
      end
      object LabeledEdit4: TLabeledEdit
        Left = 79
        Top = 113
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = '�Ա�'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 4
        OnKeyDown = LabeledEdit4KeyDown
      end
      object LabeledEdit15: TLabeledEdit
        Left = 79
        Top = 358
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = '��ע'
        ImeMode = imOpen
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 16
        OnKeyDown = LabeledEdit15KeyDown
      end
      object DateTimePicker2: TDateTimePicker
        Left = 79
        Top = 315
        Width = 100
        Height = 21
        Date = 37833.628041087960000000
        Time = 37833.628041087960000000
        TabOrder = 14
      end
      object LabeledEdit16: TLabeledEdit
        Left = 79
        Top = 33
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 39
        EditLabel.Height = 13
        EditLabel.Caption = '��ˮ��'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 0
        OnExit = LabeledEdit16Exit
      end
      object DateTimePicker3: TDateTimePicker
        Left = 79
        Top = 294
        Width = 100
        Height = 21
        Date = 38238.447083333330000000
        Time = 38238.447083333330000000
        Kind = dtkTime
        TabOrder = 13
      end
      object DateTimePicker4: TDateTimePicker
        Left = 79
        Top = 336
        Width = 100
        Height = 21
        Date = 38238.447083333330000000
        Time = 38238.447083333330000000
        Kind = dtkTime
        TabOrder = 15
      end
      object CheckBox1: TCheckBox
        Left = 79
        Top = 563
        Width = 73
        Height = 17
        Caption = '����¼��'
        TabOrder = 26
      end
      object LabeledEdit12: TLabeledEdit
        Left = 79
        Top = 13
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = '���ȼ���'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 27
        OnKeyDown = LabeledEdit12KeyDown
      end
      object lbedtWorkID: TLabeledEdit
        Left = 79
        Top = 378
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = '����'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 17
      end
      object lbedtWorkCompany: TLabeledEdit
        Left = 79
        Top = 398
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = '������˾'
        ImeMode = imOpen
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 18
        OnKeyDown = lbedtWorkCompanyKeyDown
      end
      object lbedtWorkDepartment: TLabeledEdit
        Left = 79
        Top = 418
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = '��������'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 19
        OnKeyDown = lbedtWorkDepartmentKeyDown
      end
      object lbedtWorkCategory: TLabeledEdit
        Left = 79
        Top = 438
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = '����'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 20
        OnKeyDown = lbedtWorkCategoryKeyDown
      end
      object lbedtifMarry: TLabeledEdit
        Left = 79
        Top = 458
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = '���'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 21
        OnExit = lbedtifMarryExit
      end
      object lbedtOldAddress: TLabeledEdit
        Left = 79
        Top = 478
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = '����'
        ImeMode = imOpen
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 22
      end
      object lbedtAddress: TLabeledEdit
        Left = 79
        Top = 498
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = 'סַ'
        ImeMode = imOpen
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 23
      end
      object lbedtTelephone: TLabeledEdit
        Left = 79
        Top = 518
        Width = 100
        Height = 19
        Ctl3D = False
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = '�绰'
        LabelPosition = lpLeft
        ParentCtl3D = False
        TabOrder = 24
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 628
    Width = 884
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Text = '������Ա����:'
        Width = 90
      end
      item
        Width = 100
      end
      item
        Text = '������Ա����:'
        Width = 100
      end
      item
        Width = 70
      end
      item
        Text = '��Ȩʹ�õ�λ:'
        Width = 100
      end
      item
        Width = 300
      end
      item
        Width = 30
      end>
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 349
    Top = 375
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 114
      OnExecute = suiButton6Click
    end
    object Action2: TAction
      Caption = 'Action2'
      ShortCut = 115
      OnExecute = ToolButton1Click
    end
    object Action4: TAction
      Caption = 'Action4'
      ShortCut = 116
      OnExecute = suiButton8Click
    end
    object Action5: TAction
      Caption = 'Action5'
      ShortCut = 120
      OnExecute = suiButton1Click
    end
    object Action6: TAction
      Caption = 'Action6'
      ShortCut = 117
      OnExecute = suiButton3Click
    end
    object Action7: TAction
      Caption = 'Action7'
      ShortCut = 119
      OnExecute = suiButton4Click
    end
    object Action10: TAction
      Caption = 'Action10'
      ShortCut = 118
      OnExecute = ToolButton8Click
    end
    object Action3: TAction
      Caption = 'Action3'
      ShortCut = 113
      OnExecute = SpeedButton5Click
    end
    object Action8: TAction
      Caption = 'Action8'
      ShortCut = 123
      OnExecute = SpeedButton2Click
    end
  end
  object ImageList1: TImageList
    Left = 451
    Top = 375
    Bitmap = {
      494C01010F001400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000C6C6C6008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000C6C6
      C600840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000C6C6C6008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000C6C6C600840000008400
      000084000000000000000000000000000000000000000000000084848400C6C6
      C600FFFFFF008484840000000000840000000000000000000000000000000000
      00000000840000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600FFFFFF008484840084000000840000008400
      0000000000000000000000000000000000000000000084848400C6C6C600C6C6
      C600C6C6C600FFFFFF0084848400000000000000000000000000000000000000
      84000000840000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484008484840084848400C6C6C600C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF0084848400000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00000000000000000000000000000084000000
      8400000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00000000000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      0000C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      84000000840000000000000000000000840000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00C6C6C600C6C6C60084848400000000000000000000000000000000000000
      0000000084000000000000000000000084000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600C6C6C6008484840000000000000000000000000000000000000000000000
      000000000000000000000000000000008400000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C60000000000C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFF0000FFFF0000C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C60084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000084000000840000008400000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000084848400C6C6C600C6C6C6008484
      84000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000084848400C6C6C600C6C6C600FFFF00008484
      84008484840000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      84000084840000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6C6008484
      8400C6C6C60000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      00000084840000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C6C6C600FFFF0000C6C6C600C6C6C6008484
      8400C6C6C60000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000084848400FFFF0000FFFF0000C6C6C6008484
      84008484840000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF0000000000C6C6C60000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000084848400C6C6C600C6C6C6008484
      84000000000000000000000000000000000000000000FFFFFF0000000000C6C6
      C60000000000FFFFFF0000000000C6C6C60000000000C6C6C600000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000084000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000C6C6C60000000000C6C6C60000000000C6C6C60000000000C6C6C600C6C6
      C600C6C6C6000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000000000
      0000000000008400000084000000840000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000C6C6C60000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084000000840000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000000000
      0000000000008400000084000000840000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084000000840000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000000000
      0000000000008400000084000000840000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60000000000C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00000000000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400008484000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084848400008484008484
      8400008484008484840084000000FFFFFF000000000000000000000000000000
      00000000000000000000FFFFFF00840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00840000000000000000848400848484000084
      8400848484000084840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084848400008484008484
      8400008484008484840084000000FFFFFF00000000000000000000000000FFFF
      FF00840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084000000840000008400
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00840000000000000000848400848484000084
      8400848484000084840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084000000FFFFFF0084000000000000000000000000000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000084848400008484008484
      8400008484008484840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00840000008400000000000000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000FFFF
      FF00840000008400000084000000840000000000000000848400848484000084
      8400848484000084840084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084000000FFFFFF0084000000000000000000000084848400008484008484
      8400008484008484840000848400848484000084840084848400008484008484
      8400008484000000000000000000000000000000000000000000840000008400
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00840000008400000000000000000000000000000000848400848484000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000840000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000FFFFFF0000000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000084848400848484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600000000008484
      8400008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400848484000084
      84000000000000FFFF00000000000000000000FFFF0000000000848484000084
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFF3FFFFFFFF0000FFE1FF3FC0070000
      FFC1FE3F80030000FF83C07F00010000F00780F700010000C00F00E700010000
      801F00C100000000801F00E600000000000F00F680000000000F81FEC0000000
      000FC3BFE0010000000FFFB7E0070000801FFFB3F0070000801FFFC1F0030000
      C03FFFF3F8030000F0FFFFF7FFFF0000FFFFFFFFFFFFFFFFC001000C000FF9FF
      80010008000FF9FF80010001000FF3C780010003000F73C780010003000F27FF
      80010003000F07C780010003000F00C780010003000F01E380010007000403F1
      8001000F000006388001000F00000E388001000FF8001E388001001FFC003F01
      8001003FFE047F83FFFF007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFEFFDC007001FFFFFC7FFC007000FFFFFC3FBC0070007EFFFE3F7C0070003
      EF83F1E7C0070001DFC3F8CFC0070000DFE3FC1FC007001FDFD3FE3FC007001F
      EF3BFC1FC007001FF0FFF8CFC0078FF1FFFFE1E7C00FFFF9FFFFC3F3C01FFF75
      FFFFC7FDC03FFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFC00FFFF
      F6CFFE008000FFFFF6B7FE000000FFFFF6B7FE000000FFFFF8B780000000FFF7
      FE8F80000001C1F7FE3F80000003C3FBFF7F80000003C7FBFE3F80010003CBFB
      FEBF80030003DCF7FC9F80070003FF0FFDDF807F0003FFFFFDDF80FF8007FFFF
      FDDF81FFF87FFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ADObasic: TADOQuery
    CursorType = ctStatic
    AfterOpen = ADObasicAfterOpen
    AfterScroll = ADObasicAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select checkid as ���鵥��,patientname as ����,sex as �Ա�,'
      '    age as ����,caseno as ������,bedno as ����,deptname as ��������,'
      
        '    check_date as �������,check_doctor as �ͼ�ҽ��,report_doctor as �����' +
        ','
      '    report_date as ��������,'
      '    operator as ������,printtimes as ��ӡ����,diagnosetype as �������,'
      '    flagetype as ��������,diagnose as �ٴ����,typeflagcase as �������,'
      '    issure as �Ƿ�ȷ��,unid as Ψһ��� from chk_con')
    Left = 225
    Top = 183
  end
  object DSbasic: TDataSource
    DataSet = ADObasic
    Left = 259
    Top = 183
  end
  object ADO_dtl: TADOQuery
    CursorType = ctStatic
    AfterOpen = ADO_dtlAfterOpen
    BeforeClose = ADO_dtlBeforeClose
    BeforePost = ADO_dtlBeforePost
    AfterPost = ADO_dtlAfterPost
    AfterScroll = ADO_dtlAfterScroll
    Parameters = <
      item
        Name = 'pkunid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'select name ����,english_name as Ӣ����,itemvalue as ������,'
      'itemvalue_hist as ���������,check_date_hist as �����������,'
      'itemvalue_hist2 as �ڶ��μ�����,check_date_hist2 as �ڶ��μ�������,'
      'itemvalue_hist3 as ��һ�μ�����,check_date_hist3 as ��һ�μ�������,        '
      'unit as ��λ,min_value as ��Сֵ,'
      'max_value as ���ֵ,printorder as ��ӡ���,issure as �Ƿ�ȷ��,'
      'itemid as ����Ŀ���,pkcombin_id as �����Ŀ��,valueid as ��Ŀ���,'
      'pkunid as ��Ӧ���� from chk_valu')
    Left = 225
    Top = 215
  end
  object DS_dtl: TDataSource
    DataSet = ADO_dtl
    Left = 258
    Top = 216
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    Images = ImageList1
    OwnerDraw = True
    Left = 416
    Top = 375
    object File1: TMenuItem
      Caption = '�ļ�'
      Hint = 'File related commands'
      object FileNewItem: TMenuItem
        Caption = '���µ�¼'
        OnClick = FileNewItemClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object N32: TMenuItem
        Caption = '���ݿⱸ��'
        OnClick = N32Click
      end
      object N19: TMenuItem
        Caption = '���ݿ�ָ�'
        OnClick = N19Click
      end
      object N33: TMenuItem
        Caption = '-'
      end
      object FileOpenItem: TMenuItem
        Caption = '�˳�ϵͳ'
        OnClick = FileOpenItemClick
      end
    end
    object N2: TMenuItem
      Caption = '��Ϣ¼��'
      object N3: TMenuItem
        Caption = '������Ϣ¼��'
        OnClick = N3Click
      end
      object N26: TMenuItem
        Caption = '��������޸�'
        OnClick = N26Click
      end
      object N34: TMenuItem
        Caption = '-'
      end
      object Excel2: TMenuItem
        Caption = '��Excel���벡����Ϣ'
        OnClick = Excel2Click
      end
      object N35: TMenuItem
        Caption = '-'
      end
      object N16: TMenuItem
        Caption = '���ƹ����鲡�˻�����Ϣ'
        OnClick = N16Click
      end
      object N67: TMenuItem
        Caption = '-'
      end
      object N46: TMenuItem
        Caption = '����ɾ��'
        OnClick = N46Click
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object N4: TMenuItem
        Caption = '�����������鹤��'
        OnClick = N4Click
      end
    end
    object N13: TMenuItem
      Caption = '���'
      object N15: TMenuItem
        Caption = '�������'
        OnClick = N15Click
      end
    end
    object N18: TMenuItem
      Caption = '��ѯͳ��'
      object Q1: TMenuItem
        Caption = '��ѯ'
        OnClick = Q1Click
      end
      object Excel1: TMenuItem
        Caption = 'Excel��ʽ��ѯ'
        OnClick = Excel1Click
      end
      object N27: TMenuItem
        Caption = '-'
      end
      object N20: TMenuItem
        Caption = 'ͳ��'
        OnClick = N20Click
      end
      object Y1: TMenuItem
        Caption = '�������Ŀͳ��'
        OnClick = Y1Click
      end
    end
    object N5: TMenuItem
      Caption = '��ӡѡ��'
      object N6: TMenuItem
        AutoHotkeys = maManual
        Caption = '������ӡ'
        OnClick = N6Click
      end
      object N44: TMenuItem
        Caption = '��ӡÿ�մ��'
        OnClick = N44Click
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object N25: TMenuItem
        Caption = '�Ƿ����ҳ'
        OnClick = N25Click
      end
      object N64: TMenuItem
        Caption = '�������Ա�����ϲ�'
        OnClick = N64Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object N8: TMenuItem
        Caption = 'ֱ�Ӵ�ӡģʽ'
        Checked = True
        RadioItem = True
        OnClick = N8Click
      end
      object N9: TMenuItem
        Caption = '��ӡԤ��ģʽ'
        RadioItem = True
        OnClick = N9Click
      end
    end
    object N21: TMenuItem
      Caption = '��������'
      object LJ1: TMenuItem
        Caption = '��ֵL-J�ʿ�ͼ'
        OnClick = LJ1Click
      end
    end
    object Edit1: TMenuItem
      Caption = 'ϵͳ����'
      Hint = 'Edit commands'
      object N42: TMenuItem
        Caption = 'ͨ�ô���'
        OnClick = N42Click
      end
      object N30: TMenuItem
        Caption = '��Ա����'
        OnClick = N30Click
      end
      object N28: TMenuItem
        Caption = '��Ŀ����'
        OnClick = N28Click
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object N41: TMenuItem
        Caption = 'ʵʱ��ʾ��������'
        OnClick = N41Click
      end
      object O1: TMenuItem
        Caption = 'ѡ��'
        OnClick = O1Click
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object N50: TMenuItem
        Caption = '��ʾ��ĿӢ����'
        OnClick = N50Click
      end
      object N36: TMenuItem
        Caption = '��ʾ��Ŀ����'
        OnClick = N36Click
      end
      object N47: TMenuItem
        Caption = '��ʾ��Ŀ����'
        OnClick = N47Click
      end
      object N49: TMenuItem
        Caption = '��ʾ��Ŀ��λ'
        OnClick = N49Click
      end
      object N62: TMenuItem
        Caption = '-'
      end
      object N63: TMenuItem
        Caption = '���ģ����������'
        OnClick = N63Click
      end
      object M1: TMenuItem
        Caption = '���ģ������'
        OnClick = M1Click
      end
    end
    object N65: TMenuItem
      Caption = '����'
    end
    object Help1: TMenuItem
      Caption = '����'
      Hint = 'Help topics'
      object N37: TMenuItem
        Caption = 'ע��'
        OnClick = N37Click
      end
      object HelpAboutItem: TMenuItem
        Caption = '����...'
        Hint = 
          'About|Displays program information, version number, and copyrigh' +
          't'
        OnClick = HelpAbout1Execute
      end
    end
  end
  object LYAboutBox1: TLYAboutBox
    ProcuctName = 'ProductName'
    Version = 'Version'
    Copyright = 'Copyright'
    Comments = 'Comments'
    Author = 'Author'
    WebPage = 'WebPage'
    Left = 315
    Top = 375
  end
  object ADO_print: TADOQuery
    Parameters = <>
    Left = 225
    Top = 253
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 548
    Top = 376
    object N40: TMenuItem
      Caption = '����/������Ϣ��'
    end
    object N38: TMenuItem
      Caption = '-'
    end
    object N31: TMenuItem
      Caption = '��ˮ��'
      OnClick = N31Click
    end
    object N39: TMenuItem
      Caption = '����סԺ��'
      OnClick = N39Click
    end
    object N43: TMenuItem
      Caption = '�ͼ����'
      OnClick = N43Click
    end
    object N51: TMenuItem
      Caption = '����'
      OnClick = N51Click
    end
    object N52: TMenuItem
      Caption = '�ͼ�ҽ��'
      OnClick = N52Click
    end
    object N53: TMenuItem
      Caption = '��������'
      OnClick = N53Click
    end
    object N54: TMenuItem
      Caption = '����״̬'
      OnClick = N54Click
    end
    object N55: TMenuItem
      Caption = '�ٴ����'
      OnClick = N55Click
    end
    object N56: TMenuItem
      Caption = '��������'
      OnClick = N56Click
    end
    object N57: TMenuItem
      Caption = '����ʱ��'
      OnClick = N57Click
    end
    object N58: TMenuItem
      Caption = '�������'
      OnClick = N58Click
    end
    object N59: TMenuItem
      Caption = '���ʱ��'
      OnClick = N59Click
    end
    object N61: TMenuItem
      Caption = '��ע'
      OnClick = N61Click
    end
    object N77: TMenuItem
      Caption = '����'
      OnClick = N77Click
    end
    object N78: TMenuItem
      Caption = '������˾'
      OnClick = N78Click
    end
    object N79: TMenuItem
      Caption = '��������'
      OnClick = N79Click
    end
    object N80: TMenuItem
      Caption = '��������'
      OnClick = N80Click
    end
    object N81: TMenuItem
      Caption = '���'
      OnClick = N81Click
    end
    object N82: TMenuItem
      Caption = '����'
      OnClick = N82Click
    end
    object N83: TMenuItem
      Caption = 'סַ'
      OnClick = N83Click
    end
    object N84: TMenuItem
      Caption = '�绰'
      OnClick = N84Click
    end
    object N68: TMenuItem
      Caption = '-'
    end
    object N69: TMenuItem
      Caption = '���Ʋ�����Ϣ'
      OnClick = N69Click
    end
    object N70: TMenuItem
      Caption = 'ճ��������Ϣ'
      OnClick = N70Click
    end
  end
  object pmChangeGroup: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = pmChangeGroupPopup
    Left = 584
    Top = 377
    object N29: TMenuItem
      Caption = '����������'
      OnClick = N29Click
    end
    object N76: TMenuItem
      Caption = '��������������'
      OnClick = N76Click
    end
    object N22: TMenuItem
      Caption = '-'
    end
    object N11: TMenuItem
      Caption = '�������'
    end
    object N72: TMenuItem
      Caption = '-'
    end
  end
  object frReport1: TfrReport
    Dataset = frDB_ADO_print
    InitialZoom = pzDefault
    ModifyPrepared = False
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    ShowPrintDialog = False
    ShowProgress = False
    RebuildPrinter = False
    OnGetValue = frReport1GetValue
    OnBeforePrint = frReport1BeforePrint
    Left = 483
    Top = 375
    ReportForm = {19000000}
  end
  object frDB_ADO_print: TfrDBDataSet
    DataSet = ADO_print
    Left = 483
    Top = 406
  end
  object DosMove1: TDosMove
    Active = True
    Left = 382
    Top = 375
  end
  object TimerIdleTracker: TTimer
    Enabled = False
    OnTimer = TimerIdleTrackerTimer
    Left = 496
    Top = 245
  end
  object PopupMenu2: TPopupMenu
    AutoHotkeys = maManual
    Left = 632
    Top = 377
    object N71: TMenuItem
      Caption = '����ͼƬ��Ŀ'
      OnClick = N71Click
    end
    object N66: TMenuItem
      Caption = '-'
    end
    object N23: TMenuItem
      Caption = '�޸���ĿͼƬ'
      OnClick = N23Click
    end
    object N45: TMenuItem
      Caption = '-'
    end
    object N48: TMenuItem
      Caption = 'ɾ����ĿͼƬ'
      OnClick = N48Click
    end
    object N73: TMenuItem
      Caption = '-'
    end
    object N74: TMenuItem
      Caption = '��ʾ��ĿͼƬ'
      OnClick = N74Click
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 632
    Top = 349
  end
  object PopupMenu3: TPopupMenu
    AutoHotkeys = maManual
    Left = 477
    Top = 102
    object N17: TMenuItem
      Caption = '�Ƴ�'
      OnClick = N17Click
    end
  end
end

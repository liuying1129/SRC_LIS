object SDIAppForm: TSDIAppForm
  Left = 226
  Top = 21
  Width = 900
  Height = 705
  Caption = '誉凯检验信息管理系统V7.0'
  Color = clBtnFace
  Constraints.MinWidth = 130
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = '宋体'
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
      Font.Name = '宋体'
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
        Hint = '根据姓名定位'
        Caption = '查找检验单'
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
        Caption = '新检验单F2'
        OnClick = SpeedButton5Click
      end
      object ToolButton1: TSpeedButton
        Left = 159
        Top = 2
        Width = 85
        Height = 22
        Caption = '删除检验单F4'
        OnClick = ToolButton1Click
      end
      object suiButton8: TSpeedButton
        Left = 244
        Top = 2
        Width = 47
        Height = 22
        Caption = '刷新F5'
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
        Caption = '审核F6'
        OnClick = suiButton3Click
      end
      object suiButton4: TSpeedButton
        Left = 341
        Top = 2
        Width = 75
        Height = 22
        Caption = '取消审核F8'
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
        Caption = '打印F7'
        OnClick = ToolButton8Click
      end
      object suiButton1: TSpeedButton
        Left = 466
        Top = 2
        Width = 75
        Height = 22
        Caption = '分组打印F9'
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
        Caption = '选取申请单F12'
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
      Font.Name = '宋体'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 119
        Top = 5
        Width = 189
        Height = 13
        Caption = '输入+号表示转移到下一条检验单'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = '宋体'
        Font.Style = []
        ParentFont = False
      end
      object suiButton7: TSpeedButton
        Left = 310
        Top = 0
        Width = 100
        Height = 22
        Caption = '选取未分组项目'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = '宋体'
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
        EditLabel.Caption = '输入代码(&E)'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clBlack
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = '宋体'
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
            Caption = '检验结果'
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
              TitleFont.Name = '宋体'
              TitleFont.Style = []
              OnDrawColumnCell = DBGrid2DrawColumnCell
              OnDblClick = DBGrid2DblClick
              OnExit = DBGrid2Exit
              OnKeyDown = DBGrid2KeyDown
              OnKeyUp = DBGrid2KeyUp
            end
          end
          object TabSheet2: TTabSheet
            Caption = '图像'
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
            Caption = '二维码'
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
            Caption = '结果详情'
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
                Caption = '注:换行键:Ctrl+Enter'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -13
                Font.Name = '宋体'
                Font.Style = []
                ParentFont = False
              end
              object Label8: TLabel
                Left = 260
                Top = 6
                Width = 52
                Height = 13
                Caption = '项目提示'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -13
                Font.Name = '宋体'
                Font.Style = []
                ParentFont = False
              end
              object BitBtn1: TBitBtn
                Left = 8
                Top = 7
                Width = 100
                Height = 25
                Caption = '保存结果详情'
                TabOrder = 0
                OnClick = BitBtn1Click
              end
              object BitBtn2: TBitBtn
                Left = 144
                Top = 7
                Width = 75
                Height = 25
                Caption = '体检模板'
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
            Caption = '常用组合项目'
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
              Font.Name = '宋体'
              Font.Style = []
              ItemHeight = 13
              ParentCtl3D = False
              ParentFont = False
              PopupMenu = PopupMenu3
              TabOrder = 0
            end
          end
          object TabSheet6: TTabSheet
            Caption = '备用组合项目'
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
              Font.Name = '宋体'
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
      Caption = '检验单列表(&Q)'
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
        TitleFont.Name = '宋体'
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
          Caption = '选择工作组'
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
      Caption = '基本信息录入'
      Color = 16767438
      ParentColor = False
      PopupMenu = PopupMenu1
      TabOrder = 1
      object Label3: TLabel
        Left = 24
        Top = 297
        Width = 52
        Height = 13
        Caption = '申请时间'
      end
      object Label4: TLabel
        Left = 24
        Top = 339
        Width = 52
        Height = 13
        Caption = '检查时间'
      end
      object Label5: TLabel
        Left = 24
        Top = 277
        Width = 52
        Height = 13
        Caption = '申请日期'
      end
      object Label6: TLabel
        Left = 24
        Top = 319
        Width = 52
        Height = 13
        Caption = '检查日期'
      end
      object suiButton6: TBitBtn
        Left = 79
        Top = 539
        Width = 100
        Height = 22
        Caption = '保存检验单F3'
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
        EditLabel.Caption = '联机号'
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
        EditLabel.Caption = '门诊/住院号'
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
        EditLabel.Caption = '姓名'
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
        EditLabel.Caption = '年龄'
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
        EditLabel.Caption = '送检科室'
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
        EditLabel.Caption = '床号'
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
        EditLabel.Caption = '样本类型'
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
        EditLabel.Caption = '样本状态'
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
        EditLabel.Caption = '送检医生'
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
        EditLabel.Caption = '临床诊断'
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
        EditLabel.Caption = '性别'
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
        EditLabel.Caption = '备注'
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
        EditLabel.Caption = '流水号'
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
        Caption = '连续录入'
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
        EditLabel.Caption = '优先级别'
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
        EditLabel.Caption = '工号'
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
        EditLabel.Caption = '所属公司'
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
        EditLabel.Caption = '所属部门'
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
        EditLabel.Caption = '工种'
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
        EditLabel.Caption = '婚否'
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
        EditLabel.Caption = '籍贯'
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
        EditLabel.Caption = '住址'
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
        EditLabel.Caption = '电话'
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
        Text = '操作人员工号:'
        Width = 90
      end
      item
        Width = 100
      end
      item
        Text = '操作人员姓名:'
        Width = 100
      end
      item
        Width = 70
      end
      item
        Text = '授权使用单位:'
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
      'select checkid as 检验单号,patientname as 姓名,sex as 性别,'
      '    age as 年龄,caseno as 病历号,bedno as 床号,deptname as 部门名称,'
      
        '    check_date as 检查日期,check_doctor as 送检医生,report_doctor as 审核者' +
        ','
      '    report_date as 报告日期,'
      '    operator as 操作者,printtimes as 打印次数,diagnosetype as 诊断类型,'
      '    flagetype as 样本类型,diagnose as 临床诊断,typeflagcase as 样本情况,'
      '    issure as 是否确认,unid as 唯一编号 from chk_con')
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
      'select name 名称,english_name as 英文名,itemvalue as 检验结果,'
      'itemvalue_hist as 最近检验结果,check_date_hist as 最近检验日期,'
      'itemvalue_hist2 as 第二次检验结果,check_date_hist2 as 第二次检验日期,'
      'itemvalue_hist3 as 第一次检验结果,check_date_hist3 as 第一次检验日期,        '
      'unit as 单位,min_value as 最小值,'
      'max_value as 最大值,printorder as 打印编号,issure as 是否确认,'
      'itemid as 主项目编号,pkcombin_id as 组合项目号,valueid as 项目编号,'
      'pkunid as 对应单号 from chk_valu')
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
      Caption = '文件'
      Hint = 'File related commands'
      object FileNewItem: TMenuItem
        Caption = '重新登录'
        OnClick = FileNewItemClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object N32: TMenuItem
        Caption = '数据库备份'
        OnClick = N32Click
      end
      object N19: TMenuItem
        Caption = '数据库恢复'
        OnClick = N19Click
      end
      object N33: TMenuItem
        Caption = '-'
      end
      object FileOpenItem: TMenuItem
        Caption = '退出系统'
        OnClick = FileOpenItemClick
      end
    end
    object N2: TMenuItem
      Caption = '信息录入'
      object N3: TMenuItem
        Caption = '批量信息录入'
        OnClick = N3Click
      end
      object N26: TMenuItem
        Caption = '结果批量修改'
        OnClick = N26Click
      end
      object N34: TMenuItem
        Caption = '-'
      end
      object Excel2: TMenuItem
        Caption = '从Excel导入病人信息'
        OnClick = Excel2Click
      end
      object N35: TMenuItem
        Caption = '-'
      end
      object N16: TMenuItem
        Caption = '复制工作组病人基本信息'
        OnClick = N16Click
      end
      object N67: TMenuItem
        Caption = '-'
      end
      object N46: TMenuItem
        Caption = '批量删除'
        OnClick = N46Click
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object N4: TMenuItem
        Caption = '结束当批检验工作'
        OnClick = N4Click
      end
    end
    object N13: TMenuItem
      Caption = '审核'
      object N15: TMenuItem
        Caption = '批量审核'
        OnClick = N15Click
      end
    end
    object N18: TMenuItem
      Caption = '查询统计'
      object Q1: TMenuItem
        Caption = '查询'
        OnClick = Q1Click
      end
      object Excel1: TMenuItem
        Caption = 'Excel格式查询'
        OnClick = Excel1Click
      end
      object N27: TMenuItem
        Caption = '-'
      end
      object N20: TMenuItem
        Caption = '统计'
        OnClick = N20Click
      end
      object Y1: TMenuItem
        Caption = '按组合项目统计'
        OnClick = Y1Click
      end
    end
    object N5: TMenuItem
      Caption = '打印选择'
      object N6: TMenuItem
        AutoHotkeys = maManual
        Caption = '批量打印'
        OnClick = N6Click
      end
      object N44: TMenuItem
        Caption = '打印每日存根'
        OnClick = N44Click
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object N25: TMenuItem
        Caption = '是否按组分页'
        OnClick = N25Click
      end
      object N64: TMenuItem
        Caption = '按姓名性别年龄合并'
        OnClick = N64Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object N8: TMenuItem
        Caption = '直接打印模式'
        Checked = True
        RadioItem = True
        OnClick = N8Click
      end
      object N9: TMenuItem
        Caption = '打印预览模式'
        RadioItem = True
        OnClick = N9Click
      end
    end
    object N21: TMenuItem
      Caption = '质量控制'
      object LJ1: TMenuItem
        Caption = '多值L-J质控图'
        OnClick = LJ1Click
      end
    end
    object Edit1: TMenuItem
      Caption = '系统设置'
      Hint = 'Edit commands'
      object N42: TMenuItem
        Caption = '通用代码'
        OnClick = N42Click
      end
      object N30: TMenuItem
        Caption = '人员设置'
        OnClick = N30Click
      end
      object N28: TMenuItem
        Caption = '项目设置'
        OnClick = N28Click
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object N41: TMenuItem
        Caption = '实时显示传输数据'
        OnClick = N41Click
      end
      object O1: TMenuItem
        Caption = '选项'
        OnClick = O1Click
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object N50: TMenuItem
        Caption = '显示项目英文名'
        OnClick = N50Click
      end
      object N36: TMenuItem
        Caption = '显示项目下限'
        OnClick = N36Click
      end
      object N47: TMenuItem
        Caption = '显示项目上限'
        OnClick = N47Click
      end
      object N49: TMenuItem
        Caption = '显示项目单位'
        OnClick = N49Click
      end
      object N62: TMenuItem
        Caption = '-'
      end
      object N63: TMenuItem
        Caption = '体检模板类型设置'
        OnClick = N63Click
      end
      object M1: TMenuItem
        Caption = '体检模板设置'
        OnClick = M1Click
      end
    end
    object N65: TMenuItem
      Caption = '工具'
    end
    object Help1: TMenuItem
      Caption = '帮助'
      Hint = 'Help topics'
      object N37: TMenuItem
        Caption = '注册'
        OnClick = N37Click
      end
      object HelpAboutItem: TMenuItem
        Caption = '关于...'
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
      Caption = '启用/屏蔽信息框'
    end
    object N38: TMenuItem
      Caption = '-'
    end
    object N31: TMenuItem
      Caption = '流水号'
      OnClick = N31Click
    end
    object N39: TMenuItem
      Caption = '门诊住院号'
      OnClick = N39Click
    end
    object N43: TMenuItem
      Caption = '送检科室'
      OnClick = N43Click
    end
    object N51: TMenuItem
      Caption = '床号'
      OnClick = N51Click
    end
    object N52: TMenuItem
      Caption = '送检医生'
      OnClick = N52Click
    end
    object N53: TMenuItem
      Caption = '样本类型'
      OnClick = N53Click
    end
    object N54: TMenuItem
      Caption = '样本状态'
      OnClick = N54Click
    end
    object N55: TMenuItem
      Caption = '临床诊断'
      OnClick = N55Click
    end
    object N56: TMenuItem
      Caption = '申请日期'
      OnClick = N56Click
    end
    object N57: TMenuItem
      Caption = '申请时间'
      OnClick = N57Click
    end
    object N58: TMenuItem
      Caption = '检查日期'
      OnClick = N58Click
    end
    object N59: TMenuItem
      Caption = '检查时间'
      OnClick = N59Click
    end
    object N61: TMenuItem
      Caption = '备注'
      OnClick = N61Click
    end
    object N77: TMenuItem
      Caption = '工号'
      OnClick = N77Click
    end
    object N78: TMenuItem
      Caption = '所属公司'
      OnClick = N78Click
    end
    object N79: TMenuItem
      Caption = '所属部门'
      OnClick = N79Click
    end
    object N80: TMenuItem
      Caption = '所属工种'
      OnClick = N80Click
    end
    object N81: TMenuItem
      Caption = '婚否'
      OnClick = N81Click
    end
    object N82: TMenuItem
      Caption = '籍贯'
      OnClick = N82Click
    end
    object N83: TMenuItem
      Caption = '住址'
      OnClick = N83Click
    end
    object N84: TMenuItem
      Caption = '电话'
      OnClick = N84Click
    end
    object N68: TMenuItem
      Caption = '-'
    end
    object N69: TMenuItem
      Caption = '复制病人信息'
      OnClick = N69Click
    end
    object N70: TMenuItem
      Caption = '粘贴病人信息'
      OnClick = N70Click
    end
  end
  object pmChangeGroup: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = pmChangeGroupPopup
    Left = 584
    Top = 377
    object N29: TMenuItem
      Caption = '生成体检结论'
      OnClick = N29Click
    end
    object N76: TMenuItem
      Caption = '单个生成体检结论'
      OnClick = N76Click
    end
    object N22: TMenuItem
      Caption = '-'
    end
    object N11: TMenuItem
      Caption = '更换组别'
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
      Caption = '新增图片项目'
      OnClick = N71Click
    end
    object N66: TMenuItem
      Caption = '-'
    end
    object N23: TMenuItem
      Caption = '修改项目图片'
      OnClick = N23Click
    end
    object N45: TMenuItem
      Caption = '-'
    end
    object N48: TMenuItem
      Caption = '删除项目图片'
      OnClick = N48Click
    end
    object N73: TMenuItem
      Caption = '-'
    end
    object N74: TMenuItem
      Caption = '显示项目图片'
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
      Caption = '移除'
      OnClick = N17Click
    end
  end
end

object Formstatic: TFormstatic
  Left = 197
  Top = 104
  Width = 780
  Height = 580
  Caption = #24037#20316#37327#32479#35745
  Color = clSkyBlue
  Constraints.MinWidth = 130
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object suiFormstatic: TPanel
    Left = 0
    Top = 0
    Width = 764
    Height = 542
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BorderWidth = 1
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 363
      Top = 3
      Width = 398
      Height = 536
      Align = alClient
      Caption = #32479#35745#21450#32467#26524
      Color = clSkyBlue
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 1
      object tsDBGrid1: TDBGrid
        Left = 2
        Top = 173
        Width = 394
        Height = 212
        Align = alClient
        Color = 16767438
        DataSource = ds_temp
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        OnDblClick = tsDBGrid1DblClick
      end
      object Panel1: TPanel
        Left = 2
        Top = 15
        Width = 394
        Height = 158
        Align = alTop
        Color = clSkyBlue
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object DateTimePicker1: TDateTimePicker
          Left = 172
          Top = 8
          Width = 21
          Height = 21
          Date = 37835.598986354170000000
          Time = 37835.598986354170000000
          DateFormat = dfLong
          TabOrder = 0
          OnChange = DateTimePicker1Change
        end
        object DateTimePicker2: TDateTimePicker
          Left = 353
          Top = 9
          Width = 21
          Height = 21
          Date = 37835.599070810180000000
          Time = 37835.599070810180000000
          DateFormat = dfLong
          TabOrder = 1
          OnChange = DateTimePicker2Change
        end
        object RadioGroup1: TRadioGroup
          Left = 35
          Top = 34
          Width = 338
          Height = 94
          Caption = #32479#35745#26041#24335
          Color = clSkyBlue
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            #25353#26816#39564#32773#32479#35745
            #25353#36865#26816#31185#23460#32479#35745
            #25353#26816#39564#39033#30446#32479#35745
            #25353#36865#26816#32773#32479#35745
            #25353#25253#21578#26085#26399#32479#35745
            #25353#37096#38376#32479#35745
            #25353#24037#31181#32479#35745)
          ParentColor = False
          TabOrder = 2
        end
        object BitBtn1: TBitBtn
          Left = 36
          Top = 130
          Width = 165
          Height = 25
          Caption = #32479#35745
          TabOrder = 3
          OnClick = BitBtn1Click
        end
        object BitBtn2: TBitBtn
          Left = 201
          Top = 130
          Width = 171
          Height = 25
          Caption = #23548#20986
          TabOrder = 4
          OnClick = BitBtn2Click
        end
        object LabeledEdit1: TLabeledEdit
          Left = 91
          Top = 8
          Width = 80
          Height = 21
          EditLabel.Width = 52
          EditLabel.Height = 13
          EditLabel.Caption = #24320#22987#26085#26399
          LabelPosition = lpLeft
          TabOrder = 5
        end
        object LabeledEdit2: TLabeledEdit
          Left = 272
          Top = 9
          Width = 80
          Height = 21
          EditLabel.Width = 52
          EditLabel.Height = 13
          EditLabel.Caption = #32467#26463#26085#26399
          LabelPosition = lpLeft
          TabOrder = 6
        end
      end
      object Chart1: TChart
        Left = 2
        Top = 385
        Width = 394
        Height = 149
        BackWall.Brush.Color = clWhite
        Title.Text.Strings = (
          #24322#24120#29575#26609#29366#22270)
        Legend.Visible = False
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        Align = alBottom
        TabOrder = 2
        object Series1: TBarSeries
          Marks.ArrowLength = 20
          Marks.Style = smsValue
          Marks.Visible = True
          SeriesColor = clRed
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Bar'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
        end
      end
    end
    object Panel2: TPanel
      Left = 3
      Top = 3
      Width = 360
      Height = 536
      Align = alLeft
      Color = clSkyBlue
      TabOrder = 0
      object GroupBox3: TGroupBox
        Left = 181
        Top = 1
        Width = 178
        Height = 534
        Align = alClient
        Caption = #24050#36873#32479#35745#39033#30446
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object DBGrid2: TDBGrid
          Left = 2
          Top = 56
          Width = 174
          Height = 476
          Align = alClient
          Color = 16767438
          DataSource = DS_static
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          OnDblClick = DBGrid2DblClick
        end
        object Panel3: TPanel
          Left = 2
          Top = 15
          Width = 174
          Height = 41
          Align = alTop
          TabOrder = 1
          object SpeedButton1: TSpeedButton
            Left = 0
            Top = 8
            Width = 78
            Height = 22
            Caption = #28155#21152#20840#37096#39033#30446
            OnClick = SpeedButton1Click
          end
          object SpeedButton2: TSpeedButton
            Left = 78
            Top = 8
            Width = 100
            Height = 22
            Caption = #28165#38500#20840#37096#24050#36873#39033#30446
            OnClick = SpeedButton2Click
          end
        end
      end
      object GroupBox2: TGroupBox
        Left = 1
        Top = 1
        Width = 180
        Height = 534
        Align = alLeft
        Caption = #25152#26377#39033#30446
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object DBGrid1: TDBGrid
          Left = 2
          Top = 15
          Width = 176
          Height = 517
          Align = alClient
          Color = 16767438
          DataSource = DScombin_dtl
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          OnDblClick = DBGrid1DblClick
        end
      end
    end
  end
  object ADOcombin_dtl: TADOQuery
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'combinitem'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 3
        Value = Null
      end>
    SQL.Strings = (
      'select distinct name as '#39033#30446#21517#31216',itemid as '#39033#30446#20195#30721' from chk_valu_bak')
    Left = 241
    Top = 184
  end
  object DScombin_dtl: TDataSource
    DataSet = ADOcombin_dtl
    Left = 274
    Top = 184
  end
  object DS_static: TDataSource
    DataSet = ADO_static
    Left = 274
    Top = 272
  end
  object ADO_static: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select name as '#39033#30446#21517#31216',itemid as '#39033#30446#20195#30721' from static_temp order by nam' +
        'e')
    Left = 241
    Top = 272
  end
  object ADO_temp: TADOQuery
    CursorType = ctStatic
    AfterOpen = ADO_tempAfterOpen
    CommandTimeout = 0
    Parameters = <>
    Left = 385
    Top = 240
  end
  object ds_temp: TDataSource
    DataSet = ADO_temp
    Left = 418
    Top = 240
  end
  object LYDataToExcel1: TLYDataToExcel
    Left = 538
    Top = 280
  end
end

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
    Height = 541
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
    object Panel1: TPanel
      Left = 3
      Top = 3
      Width = 758
      Height = 120
      Align = alTop
      Color = clSkyBlue
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 15
        Top = 12
        Width = 52
        Height = 13
        Caption = #24320#22987#26085#26399
      end
      object Label2: TLabel
        Left = 198
        Top = 13
        Width = 52
        Height = 13
        Caption = #32467#26463#26085#26399
      end
      object DateTimePicker1: TDateTimePicker
        Left = 72
        Top = 8
        Width = 100
        Height = 21
        Date = 37835.000000000000000000
        Time = 37835.000000000000000000
        TabOrder = 0
      end
      object DateTimePicker2: TDateTimePicker
        Left = 255
        Top = 9
        Width = 100
        Height = 21
        Date = 37835.999988425920000000
        Time = 37835.999988425920000000
        TabOrder = 1
      end
      object RadioGroup1: TRadioGroup
        Left = 13
        Top = 39
        Width = 740
        Height = 40
        Caption = #32479#35745#26041#24335
        Color = clSkyBlue
        Columns = 7
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
        Left = 14
        Top = 88
        Width = 165
        Height = 25
        Caption = #32479#35745
        TabOrder = 3
        OnClick = BitBtn1Click
      end
      object BitBtn2: TBitBtn
        Left = 179
        Top = 88
        Width = 171
        Height = 25
        Caption = #23548#20986
        TabOrder = 4
        OnClick = BitBtn2Click
      end
    end
    object tsDBGrid1: TDBGrid
      Left = 3
      Top = 123
      Width = 758
      Height = 415
      Align = alClient
      Color = 16767438
      DataSource = ds_temp
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
    end
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
    Left = 450
    Top = 240
  end
end

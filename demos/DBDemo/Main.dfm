object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 401
  ClientWidth = 1210
  Caption = 'MainForm'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'border'
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniPanel1: TUniPanel
    Left = 32
    Top = 96
    Width = 297
    Height = 233
    Hint = ''
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = 'UniPanel1'
    Layout = 'vbox'
    LayoutConfig.Split = True
    LayoutConfig.Region = 'west'
    object UniButton1: TUniButton
      Left = 104
      Top = 0
      Width = 75
      Height = 25
      Hint = ''
      Caption = '<i class="fas fa-sync-alt"></i> Refresh Chart'
      TabOrder = 2
      LayoutConfig.Width = '100%'
      OnClick = UniButton1Click
    end
    object UniDBGrid1: TUniDBGrid
      Left = 53
      Top = 31
      Width = 209
      Height = 160
      Hint = ''
      ClicksToEdit = 1
      DataSource = DataSource1
      WebOptions.Paged = False
      LoadMask.Message = 'Loading data...'
      ForceFit = True
      LayoutConfig.Flex = 1
      LayoutConfig.Width = '100%'
      BorderStyle = ubsNone
      TabOrder = 1
    end
  end
  object UniPanel2: TUniPanel
    Left = 368
    Top = 99
    Width = 785
    Height = 273
    Hint = ''
    TabOrder = 1
    BorderStyle = ubsNone
    Caption = 'UniPanel1'
    Layout = 'fit'
    LayoutConfig.Region = 'center'
    object uniGChartsFrame1: TuniGChartsFrame
      Left = 80
      Top = 16
      Width = 673
      Height = 240
      Hint = ''
      TabOrder = 1
      AutoResize = True
      OnSelect = uniGChartsFrame1Select
    end
  end
  object DataSource1: TDataSource
    Left = 32
    Top = 16
  end
end

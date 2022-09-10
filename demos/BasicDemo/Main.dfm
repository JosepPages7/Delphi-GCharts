object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 409
  ClientWidth = 695
  Caption = 'MainForm'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object uniGChartsFrame1: TuniGChartsFrame
    Left = 96
    Top = 40
    Width = 529
    Height = 305
    Hint = ''
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    TabOrder = 0
    AutoResize = True
    OnSelect = uniGChartsFrame1Select
  end
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 695
    Height = 29
    Hint = ''
    ButtonWidth = 60
    ShowCaptions = True
    ButtonAutoWidth = True
    TabOrder = 1
    ParentColor = False
    Color = clBtnFace
    ExplicitLeft = 200
    ExplicitTop = 8
    ExplicitWidth = 150
    object btnPrintChart: TUniToolButton
      Left = 0
      Top = 0
      Hint = ''
      Caption = 'Print Chart'
      TabOrder = 1
      OnClick = btnPrintChartClick
    end
  end
end

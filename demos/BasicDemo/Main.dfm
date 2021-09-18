object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 389
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
end

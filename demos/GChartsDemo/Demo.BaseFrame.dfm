object DemoBaseFrame: TDemoBaseFrame
  Left = 0
  Top = 0
  Width = 1007
  Height = 698
  OnCreate = UniFrameCreate
  Layout = 'fit'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  TabOrder = 0
  ParentColor = False
  ParentBackground = False
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 1007
    Height = 29
    Hint = ''
    ButtonWidth = 303
    BorderWidth = 1
    ShowCaptions = True
    ButtonAutoWidth = True
    ScreenMask.Enabled = True
    ScreenMask.ShowMessage = False
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    object UniToolButton1: TUniToolButton
      Left = 0
      Top = 0
      Action = actShowDelphiCode
      TabOrder = 0
    end
    object UniToolButton6: TUniToolButton
      Left = 303
      Top = 0
      Width = 3
      Hint = ''
      Style = tbsSeparator
      Caption = ''
      TabOrder = 1
    end
    object UniToolButton5: TUniToolButton
      Left = 306
      Top = 0
      Action = actGoogleGuide
      TabOrder = 2
    end
    object UniToolButton2: TUniToolButton
      Left = 609
      Top = 0
      Width = 3
      Hint = ''
      Style = tbsSeparator
      Caption = ''
      TabOrder = 3
    end
    object UniToolButton3: TUniToolButton
      Left = 612
      Top = 0
      Action = actRefresh
      TabOrder = 5
    end
  end
  object MainPanel: TUniPanel
    Left = 10
    Top = 48
    Width = 977
    Height = 633
    Hint = ''
    TabOrder = 1
    BorderStyle = ubsNone
    ShowCaption = False
    Caption = 'MainPanel'
    Layout = 'border'
    object ResultPanel: TUniPanel
      Left = 27
      Top = 18
      Width = 449
      Height = 599
      Hint = ''
      TabOrder = 1
      BorderStyle = ubsNone
      ShowCaption = False
      Caption = 'ResultPanel'
      Layout = 'border'
      LayoutConfig.Flex = 1
      LayoutConfig.Region = 'center'
      object SourhPanel: TUniPanel
        Left = 43
        Top = 480
        Width = 262
        Height = 126
        Hint = ''
        TabOrder = 1
        ToolButtons = <
          item
            Action = actClearMemo
            ButtonId = 0
            IconCls = 'trash'
          end
          item
            Action = actShowHTML
            ButtonId = 1
            IconCls = 'info'
          end>
        BorderStyle = ubsNone
        ShowCaption = False
        Title = 'Events'
        Caption = 'SourhPanel'
        Collapsible = True
        Layout = 'fit'
        LayoutConfig.Split = True
        LayoutConfig.Region = 'south'
        object panEvents: TUniPanel
          Left = 35
          Top = 27
          Width = 206
          Height = 53
          Hint = ''
          TabOrder = 1
          ScreenMask.Enabled = True
          ScreenMask.ShowMessage = False
          ShowCaption = False
          TitleAlign = taRightJustify
          Caption = ''
          Layout = 'fit'
          LayoutConfig.Flex = 1
          LayoutConfig.Height = '100%'
          object EventsMemo: TUniMemo
            Left = 32
            Top = 18
            Width = 81
            Height = 89
            Hint = ''
            BorderStyle = ubsNone
            ReadOnly = True
            TabOrder = 1
            OnMouseDown = EventsMemoMouseDown
          end
        end
      end
      object CenterPanel: TUniPanel
        Left = 43
        Top = 16
        Width = 318
        Height = 434
        Hint = ''
        TabOrder = 2
        BorderStyle = ubsNone
        Caption = 'CenterPanel'
        Layout = 'border'
        LayoutConfig.Region = 'center'
        object ChartsPanel: TUniPanel
          Left = 35
          Top = 26
          Width = 252
          Height = 167
          Hint = ''
          TabOrder = 1
          ShowCaption = False
          Caption = ''
          Layout = 'fit'
          LayoutConfig.Region = 'center'
        end
      end
    end
    object DelphiPanel: TUniPanel
      Left = 423
      Top = 18
      Width = 567
      Height = 625
      Hint = ''
      TabOrder = 2
      ShowCaption = False
      TitleVisible = True
      Title = 'Delphi Code'
      Caption = ''
      Collapsible = True
      Collapsed = True
      Layout = 'fit'
      LayoutConfig.Split = True
      LayoutConfig.Region = 'east'
      object panDelphiCode: TUniPanel
        Left = 59
        Top = 16
        Width = 502
        Height = 434
        Hint = ''
        TabOrder = 1
        BorderStyle = ubsNone
        ShowCaption = False
        Caption = ''
        Layout = 'fit'
        LayoutConfig.Region = 'center'
        object DelphiCode: TUniSyntaxEditEx
          Left = 32
          Top = 40
          Width = 216
          Height = 233
          Hint = ''
          Lines.Strings = (
            '')
          ReadOnly = True
          Font.Name = 'Courier New'
        end
      end
    end
  end
  object ActionList1: TActionList
    Left = 96
    Top = 424
    object actRun: TAction
      Caption = 'actRun'
    end
    object actShowDelphiCode: TAction
      Caption = '<i class="fas fa-code"></i> &nbsp;Delphi Code &nbsp;'
      OnExecute = actShowDelphiCodeExecute
    end
    object actGoogleGuide: TAction
      Caption = '<i class="fab fa-google"></i>&nbsp; Google Guide &nbsp;'
      OnExecute = actGoogleGuideExecute
    end
    object actShowHTML: TAction
      Caption = 'Show HTML Document Code'
      Hint = 'Show HTML Document Code'
      OnExecute = actShowHTMLExecute
    end
    object actClearMemo: TAction
      Caption = 'Clear'
      OnExecute = actClearMemoExecute
    end
    object actRefresh: TAction
      Caption = '<i class="fas fa-sync-alt"></i>&nbsp;  Refresh&nbsp; '
      OnExecute = actRefreshExecute
    end
  end
  object UniPopupMenu: TUniPopupMenu
    Left = 184
    Top = 426
    object iclassfabfahtml5inbspHTMLnbsp1: TUniMenuItem
      Action = actShowHTML
    end
  end
end

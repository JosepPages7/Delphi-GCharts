unit Demo.BaseFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, DB, uniGUIBaseClasses, uniPanel, System.Actions, Vcl.ActnList, uniMemo, uniSyntaxEditorEx,
  uniSyntaxEditorBase, uniToolBar, cfs.GCharts.uniGUI, Vcl.Menus,
  uniMainMenu;

type
  TDemoBaseFrame = class(TUniFrame)
    ActionList1: TActionList;
    actRun: TAction;
    actShowDelphiCode: TAction;
    UniToolBar1: TUniToolBar;
    UniToolButton1: TUniToolButton;
    UniToolButton2: TUniToolButton;
    MainPanel: TUniPanel;
    ResultPanel: TUniPanel;
    DelphiPanel: TUniPanel;
    panDelphiCode: TUniPanel;
    DelphiCode: TUniSyntaxEditEx;
    actGoogleGuide: TAction;
    SourhPanel: TUniPanel;
    panEvents: TUniPanel;
    EventsMemo: TUniMemo;
    CenterPanel: TUniPanel;
    ChartsPanel: TUniPanel;
    UniToolButton5: TUniToolButton;
    actShowHTML: TAction;
    UniToolButton6: TUniToolButton;
    actClearMemo: TAction;
    UniPopupMenu: TUniPopupMenu;
    iclassfabfahtml5inbspHTMLnbsp1: TUniMenuItem;
    actRefresh: TAction;
    UniToolButton3: TUniToolButton;
    actPrint: TAction;
    procedure UniFrameCreate(Sender: TObject);
    procedure actShowDelphiCodeExecute(Sender: TObject);
    procedure actGoogleGuideExecute(Sender: TObject);
    procedure actShowHTMLExecute(Sender: TObject);
    procedure actClearMemoExecute(Sender: TObject);
    procedure EventsMemoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actRefreshExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
  private
    FGChartsFrame: TuniGChartsFrame;
    FGoogleGuideLink: string;
    FHtml: string;
    procedure LoadUnitName(const UnitName: string);
    procedure BeforeDocumentPost(Sender: TComponent; var HTMLDocument: string);
    procedure OnSelectEvent(Sender: TuniGChartsFrame; const ChartId, Row, Column, Value, Category: string);
  protected
    procedure CreateDynamicComponents; dynamic;
    procedure GenerateChart; dynamic; abstract;

    property GChartsFrame: TuniGChartsFrame read FGChartsFrame;
  public
    property GoogleGuideLink: string read FGoogleGuideLink write FGoogleGuideLink;
  end;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication;

procedure TDemoBaseFrame.UniFrameCreate(Sender: TObject);
begin
  LoadUnitName(UnitName);
  FGChartsFrame := TuniGChartsFrame.Create(Self);
  FGChartsFrame.Parent := ChartsPanel;
  FGChartsFrame.OnSelect := OnSelectEvent;
  FGChartsFrame.BeforeDocumentPost := BeforeDocumentPost;
  FGChartsFrame.AutoResize := True;
  //FGChartsFrame.BorderStyle := TUniBorderStyle.ubsNone;

  DelphiCode.BorderStyle := TUniBorderStyle.ubsNone;

  CreateDynamicComponents;
  GenerateChart;
end;

procedure TDemoBaseFrame.actClearMemoExecute(Sender: TObject);
begin
  EventsMemo.Lines.Text := '';
end;

procedure TDemoBaseFrame.actGoogleGuideExecute(Sender: TObject);
begin
  if GoogleGuideLink <> '' then
    UniSession.AddJS('window.open(' + GoogleGuideLink.QuotedString + ', ''_blank'');');
end;

procedure TDemoBaseFrame.actPrintExecute(Sender: TObject);
begin
  FGChartsFrame.DocumentPrint;
end;

procedure TDemoBaseFrame.actRefreshExecute(Sender: TObject);
begin
  GenerateChart;
end;

procedure TDemoBaseFrame.actShowDelphiCodeExecute(Sender: TObject);
begin
  DelphiPanel.Collapsed := not DelphiPanel.Collapsed;
end;

procedure TDemoBaseFrame.actShowHTMLExecute(Sender: TObject);
begin
  if SourhPanel.Collapsed then
    SourhPanel.Collapsed := False;
  EventsMemo.Lines.Text := FHtml + sLineBreak +  sLineBreak;
end;

procedure TDemoBaseFrame.BeforeDocumentPost(Sender: TComponent; var HTMLDocument: string);
begin
  FHtml := HTMLDocument;
end;

procedure TDemoBaseFrame.CreateDynamicComponents;
begin

end;

procedure TDemoBaseFrame.EventsMemoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    uniPopupMenu.Popup(X, Y, EventsMemo);
end;

procedure TDemoBaseFrame.LoadUnitName(const UnitName: string);
var
  UN: string;
  FileName: string;
begin
  UN := UnitName + '.pas';
  DelphiPanel.Title := 'Delphi Code';

  {$ifdef RELEASE}
    FileName := ExpandFileName(ExtractFileDir(Application.ExeName) + '\GChartsDemoSamplesSource\' + UN);
  {$else}
    FileName := ExpandFileName(ExtractFileDir(Application.ExeName) + '\..\..\' + UN);
  {$endif}


  if FileExists(FileName) then
    Self.DelphiCode.Lines.LoadFromFile(FileName)
  else
    Self.DelphiCode.Lines.Text := '// Source file not found: ' + FileName;
end;

procedure TDemoBaseFrame.OnSelectEvent(Sender: TuniGChartsFrame; const ChartId, Row, Column, Value, Category: string);
begin
  EventsMemo.Lines.Add(Format('Select: ChartId=%s, Row=%s, Column=%s, Value=%s, Category=%s', [ChartId, Row, Column, Value, Category]));
  if SourhPanel.Collapsed then
    SourhPanel.Collapsed := False;
end;

end.

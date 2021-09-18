unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, Vcl.Menus, uniMainMenu, uniGUIFrame,
  uniTreeView, uniLabel, uniGUIBaseClasses, uniPanel, Generics.Collections,
  cfs.GCharts.uniGUI;

type
  TModule = class
    Level: Byte;
    ClassName: string;
    Title: string;
    GoogleLink: string;
    constructor Create(Level: Byte; const ClassName, Title, GoogleLink: string);
  end;

  TMainForm = class(TUniForm)
    UniPanel2: TUniPanel;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    panCenter: TUniPanel;
    UniPanel1: TUniPanel;
    TreeView: TUniTreeView;
    panFrame: TUniPanel;
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
    procedure TreeViewClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
  private
    FSep: string;
    FModules: TObjectList<TModule>;
    FCurrentFrame: TuniFrame;
    procedure LoadModules;
    procedure LoadViewTree;
    function LoadFrame(const Name: string): TUniFrame;
  public
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, Demo.BaseFrame;

{ TModule }

constructor TModule.Create(Level: Byte; const ClassName, Title, GoogleLink: string);
begin
  Self.Level := Level;
  Self.ClassName := ClassName;
  Self.Title := Title;
  Self.GoogleLink := GoogleLink;
end;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

{ TMainForm }

procedure TMainForm.UniFormCreate(Sender: TObject);
begin
  FModules := TObjectList<TModule>.Create;

  FSep := '    ' + StringOfChar(Char($2501), 10);

  LoadModules;
  LoadViewTree;
end;

procedure TMainForm.UniFormDestroy(Sender: TObject);
begin
  FModules.Free;
end;

procedure TMainForm.UniFormShow(Sender: TObject);
begin
  TreeView.Selected := TreeView.Items[0];
  LoadFrame('TDemo_Overview');
end;

procedure TMainForm.LoadModules;

  procedure AddModule(Level: Byte; const ClassName, Title, GoogleLink: string);
  begin
    FModules.Add(TModule.Create(Level, ClassName, Title, GoogleLink));
  end;

begin
  AddModule(0, 'TDemo_Overview', 'Overview', 'https://developers.google.com/chart/interactive/docs');
  AddModule(0, '', FSep, '');

  AddModule(0, 'TDemo_AnnotationChart_Sample', 'Annotation', 'https://developers.google.com/chart/interactive/docs/gallery/annotationchart#overview');

  AddModule(0, 'TDemo_AreaChart_Sample', 'Area', 'https://developers.google.com/chart/interactive/docs/gallery/areachart#a-simple-example');
    AddModule(1, 'TDemo_AreaChart_Stacking', 'Stacked', 'https://developers.google.com/chart/interactive/docs/gallery/areachart#stacking-areas');

  AddModule(0, 'TDemo_BarChart_Sample', 'Bar', 'https://developers.google.com/chart/interactive/docs/gallery/barchart#overview');
    AddModule(1, 'TDemo_BarChart_Series', 'Series', 'https://developers.google.com/chart/interactive/docs/gallery/barchart#overview');
    AddModule(1, 'TDemo_BarChart_Stacked', 'Stacked', 'https://developers.google.com/chart/interactive/docs/gallery/barchart#overview');
    AddModule(1, 'TDemo_BarChart_Stacking', 'Stacked vs Stacked 100%', 'https://developers.google.com/chart/interactive/docs/gallery/barchart#stacked-bar-charts');
    AddModule(1, 'TDemo_BarChart_Annotations', 'Annotations', 'https://developers.google.com/chart/interactive/docs/gallery/barchart#overview');
    AddModule(1, 'TDemo_BarChart_Customizable', 'Customizable', 'https://developers.google.com/chart/interactive/docs/gallery/barchart#overview');
    AddModule(1, 'TDemo_BarChart_BarStyles', 'Bar Styles', 'https://developers.google.com/chart/interactive/docs/gallery/barchart#bar-styles');
    AddModule(1, 'TDemo_BarChart_ColoringBars', 'Coloring Bars', 'https://developers.google.com/chart/interactive/docs/gallery/barchart#coloring-bars');
    AddModule(1, 'TDemo_BarChart_LabelingBars', 'Labeling Bars', 'https://developers.google.com/chart/interactive/docs/gallery/barchart#labeling-bars');
    AddModule(1, 'TDemo_MaterialBarChart_Sample', 'Material Design', 'https://developers.google.com/chart/interactive/docs/gallery/barchart#creating-material-bar-charts');
      AddModule(2, 'TDemo_MaterialBarChart_DualX', 'Dual X-axes', 'https://developers.google.com/chart/interactive/docs/gallery/barchart#dual-x-charts');
      AddModule(2, 'TDemo_MaterialBarChart_RightY', 'Right Y-axis', 'https://developers.google.com/chart/interactive/docs/gallery/barchart#dual-x-charts');
      AddModule(2, 'TDemo_MaterialBarChart_TopX', 'Top X', 'https://developers.google.com/chart/interactive/docs/gallery/barchart#top-x-charts');

  AddModule(0, 'TDemo_BubbleChart_Sample', 'Bubble', 'https://developers.google.com/chart/interactive/docs/gallery/bubblechart#example');
    AddModule(1, 'TDemo_BubbleChart_ColorByNumbers', 'Color By Numbers', 'https://developers.google.com/chart/interactive/docs/gallery/bubblechart#color-by-numbers');
    AddModule(1, 'TDemo_BubbleChart_CustomizingLabels', 'Customizing Labels', ' https://developers.google.com/chart/interactive/docs/gallery/bubblechart#customizing-labels');

  AddModule(0, 'TDemo_CalendarChart_Sample', 'Calendar', 'https://developers.google.com/chart/interactive/docs/gallery/calendar#a-simple-example');
    AddModule(1, 'TDemo_CalendarChart_MultiLanguage', 'Language (uniSession)', 'https://developers.google.com/chart/interactive/docs/gallery/calendar#weeks');

  AddModule(0, 'TDemo_CandlestickChart_Sample', 'Candlestick', 'https://developers.google.com/chart/interactive/docs/gallery/candlestickchart#overview');
    AddModule(1, 'TDemo_CandlestickChart_Waterfall', 'Waterfall', 'https://developers.google.com/chart/interactive/docs/gallery/candlestickchart#waterfall-charts');

  AddModule(0, 'TDemo_ColumnChart_Sample', 'Column', 'https://developers.google.com/chart/interactive/docs/gallery/columnchart#examples');
    AddModule(1, 'TDemo_ColumnChart_Series', 'Series', 'https://developers.google.com/chart/interactive/docs/gallery/columnchart#examples');
    AddModule(1, 'TDemo_ColumnChart_Stacked', 'Stacked', 'https://developers.google.com/chart/interactive/docs/gallery/columnchart#examples');
    AddModule(1, 'TDemo_ColumnChart_Stacking', 'Stacked vs Stacked 100%', 'https://developers.google.com/chart/interactive/docs/gallery/columnchart#stacked-column-charts');
    AddModule(1, 'TDemo_ColumnChart_Annotations', 'Annotations', 'https://developers.google.com/chart/interactive/docs/gallery/columnchart#examples');
    AddModule(1, 'TDemo_ColumnChart_Customizable', 'Customizable', 'https://developers.google.com/chart/interactive/docs/gallery/ColumnChart#overview');
    AddModule(1, 'TDemo_ColumnChart_Trendlines', 'Trendlines', 'https://developers.google.com/chart/interactive/docs/gallery/columnchart#examples');
    AddModule(1, 'TDemo_ColumnChart_ColumnStyles', 'Column Styles', 'https://developers.google.com/chart/interactive/docs/gallery/columnchart#column-styles');
    AddModule(1, 'TDemo_ColumnChart_ColoringColumns', 'Coloring Columns', 'https://developers.google.com/chart/interactive/docs/gallery/columnchart#coloring-columns');
    AddModule(1, 'TDemo_ColumnChart_LabelingColumns', 'Labeling Columns', 'https://developers.google.com/chart/interactive/docs/gallery/columnchart#labeling-columns');
    AddModule(1, 'TDemo_MaterialColumnChart_Sample', 'Material Design', 'https://developers.google.com/chart/interactive/docs/gallery/columnchart#creating-material-column-charts');
      AddModule(2, 'TDemo_MaterialColumnChart_DualY', 'Dual Y-axes', 'https://developers.google.com/chart/interactive/docs/gallery/columnchart#dual-y-charts');
      AddModule(2, 'TDemo_MaterialColumnChart_RightY', 'Right Y-axis', 'https://developers.google.com/chart/interactive/docs/gallery/columnchart#examples');
      AddModule(2, 'TDemo_MaterialColumnChart_TopX', 'Top X', 'https://developers.google.com/chart/interactive/docs/gallery/columnchart#top-x-charts');

  AddModule(0, 'TDemo_ComboChart_Sample', 'Combo', 'https://developers.google.com/chart/interactive/docs/gallery/combochart#example');

  AddModule(0, 'TDemo_DiffChart_Pie', 'Diff', 'https://developers.google.com/chart/interactive/docs/gallery/diffchart#diff-pie-charts');
    AddModule(1, 'TDemo_DiffChart_Column', 'Column', 'https://developers.google.com/chart/interactive/docs/gallery/diffchart#diff-bar-and-column-charts');

  AddModule(0, 'TDemo_PieChart_Donut', 'Donut', 'https://developers.google.com/chart/interactive/docs/gallery/piechart#making-a-donut-chart');

  AddModule(0, 'TDemo_GanttChart_Sample', 'Gantt', 'https://developers.google.com/chart/interactive/docs/gallery/ganttchart#a-simple-example');
    AddModule(1, 'TDemo_GanttChart_NoDependencies', 'No Dependencies', 'https://developers.google.com/chart/interactive/docs/gallery/ganttchart#no-dependencies');
    AddModule(1, 'TDemo_GanttChart_GroupingResources', 'Grouping Resources', 'https://developers.google.com/chart/interactive/docs/gallery/ganttchart#grouping-resources');
    AddModule(1, 'TDemo_GanttChart_ComputingStartEndDuration', 'Computing start/end/duration', 'https://developers.google.com/chart/interactive/docs/gallery/ganttchart#computing-startendduration');
    AddModule(1, 'TDemo_GanttChart_CriticalPath', 'Critical Path', 'https://developers.google.com/chart/interactive/docs/gallery/ganttchart#critical-path');
    AddModule(1, 'TDemo_GanttChart_StylingArrows', 'Styling Arrows', 'https://developers.google.com/chart/interactive/docs/gallery/ganttchart#styling-arrows');
    AddModule(1, 'TDemo_GanttChart_StylingTracks', 'Styling Tracks', 'https://developers.google.com/chart/interactive/docs/gallery/ganttchart#styling-tracks');

  AddModule(0, 'TDemo_GaugeChart_Sample', 'Gauge', 'https://developers.google.com/chart/interactive/docs/gallery/gauge#example');

  AddModule(0, 'TDemo_GeoChart_Sample', 'Geo', 'https://developers.google.com/chart/interactive/docs/gallery/geochart#region-geocharts');
    AddModule(1, 'TDemo_GeoChart_Coloring', 'Coloring', 'https://developers.google.com/chart/interactive/docs/gallery/geochart#coloring-your-chart');
    AddModule(1, 'TDemo_GeoChart_Marker', 'Marker', 'https://developers.google.com/chart/interactive/docs/gallery/geochart#marker-geocharts');
    AddModule(1, 'TDemo_GeoChart_ProportionalMarkers', 'Proportional Markers', 'https://developers.google.com/chart/interactive/docs/gallery/geochart#displaying-proportional-markers');

  AddModule(0, 'TDemo_Histogram_Sample', 'Histogram', 'https://developers.google.com/chart/interactive/docs/gallery/histogram#overview');
    AddModule(1, 'TDemo_Histogram_MultipleSeries', 'Multiple Series', 'https://developers.google.com/chart/interactive/docs/gallery/histogram#multiple-series');

  AddModule(0, 'TDemo_Intervals_Sample', 'Intervals', 'https://developers.google.com/chart/interactive/docs/gallery/intervals#overview');
    AddModule(1, 'TDemo_Intervals_Styles', 'Styles', 'https://developers.google.com/chart/interactive/docs/gallery/intervals#overview');

  AddModule(0, 'TDemo_LineChart_Sample', 'Line', 'https://developers.google.com/chart/interactive/docs/gallery/linechart#overview');
    AddModule(1, 'TDemo_LineChart_Styles', 'Styles', 'https://developers.google.com/chart/interactive/docs/gallery/linechart#overview');
    AddModule(1, 'TDemo_LineChart_Crosshairs', 'Crosshairs', 'https://developers.google.com/chart/interactive/docs/gallery/linechart#overview');
    AddModule(1, 'TDemo_LineChart_TrendLines', 'Trend Lines', 'https://developers.google.com/chart/interactive/docs/gallery/linechart#overview');
    AddModule(1, 'TDemo_LineChart_LogScales', 'Log Scales', 'https://developers.google.com/chart/interactive/docs/gallery/linechart#overview');
    AddModule(1, 'TDemo_LineChart_CurvingLines', 'Curving the Lines', 'https://developers.google.com/chart/interactive/docs/gallery/linechart#curving-the-lines');
    AddModule(1, 'TDemo_MaterialLineChart_Sample', 'Material Design', 'https://developers.google.com/chart/interactive/docs/gallery/linechart#creating-material-line-charts');
      AddModule(2, 'TDemo_MaterialLineChart_TopX', 'Top X', 'https://developers.google.com/chart/interactive/docs/gallery/linechart#top-x-charts');
      AddModule(2, 'TDemo_MaterialLineChart_DualY', 'Dual Y', 'https://developers.google.com/chart/interactive/docs/gallery/linechart#dual-y-charts');

  AddModule(0, 'TDemo_OrgChart_Sample', 'Organization', 'https://developers.google.com/chart/interactive/docs/gallery/orgchart#example');

  AddModule(0, 'TDemo_PieChart_Sample', 'Pie', 'https://developers.google.com/chart/interactive/docs/gallery/piechart#example');
    AddModule(1, 'TDemo_PieChart_3D', '3D', 'https://developers.google.com/chart/interactive/docs/gallery/piechart#making-a-3d-pie-chart');
    AddModule(1, 'TDemo_PieChart_Donut', 'Donut', 'https://developers.google.com/chart/interactive/docs/gallery/piechart#making-a-donut-chart');
    AddModule(1, 'TDemo_PieChart_Rotating', 'Rotating', 'https://developers.google.com/chart/interactive/docs/gallery/piechart#rotating-a-pie-chart');
    AddModule(1, 'TDemo_PieChart_Exploding_a_Slice', 'Exploding a Slice', 'https://developers.google.com/chart/interactive/docs/gallery/piechart#exploding-a-slice');
    AddModule(1, 'TDemo_PieChart_Removing_Slices', 'Removing Slices', 'https://developers.google.com/chart/interactive/docs/gallery/piechart#removing-slices');

  AddModule(0, 'TDemo_SankeyDiagram_Sample', 'Sankey Diagram', 'https://developers.google.com/chart/interactive/docs/gallery/sankey#a-simple-example');
    AddModule(1, 'TDemo_SankeyDiagram_MultiLevels', 'Multilevel', 'https://developers.google.com/chart/interactive/docs/gallery/sankey#multilevel-sankeys');

  AddModule(0, 'TDemo_ScatterChart_Sample', 'Scatter', 'https://developers.google.com/chart/interactive/docs/gallery/scatterchart#overview');
    AddModule(1, 'TDemo_ScatterChart_DualY', 'Dual Y', 'https://developers.google.com/chart/interactive/docs/gallery/scatterchart#dual-y-charts');
    AddModule(1, 'TDemo_MaterialScatterChart_Sample', 'Material Design', 'https://developers.google.com/chart/interactive/docs/gallery/scatterchart#creating-material-scatter-charts');
      AddModule(2, 'TDemo_MaterialScatterChart_DualY', 'Dual Y', 'https://developers.google.com/chart/interactive/docs/gallery/scatterchart#dual-y-charts');
      AddModule(2, 'TDemo_MaterialScatterChart_TopX', 'Top X', 'https://developers.google.com/chart/interactive/docs/gallery/scatterchart#top-x-charts');

  AddModule(0, 'TDemo_SteppedAreaChart_Sample', 'Stepped Area', 'https://developers.google.com/chart/interactive/docs/gallery/steppedareachart#overview');
    AddModule(1, 'TDemo_SteppedAreaChart_Custom', 'Custom', 'https://developers.google.com/chart/interactive/docs/gallery/steppedareachart#some-common-options');
    AddModule(1, 'TDemo_AreaChart_Stacked', 'Stacked vs Stacked 100%', 'https://developers.google.com/chart/interactive/docs/gallery/steppedareachart#stacked-stepped-area-charts');

  AddModule(0, 'TDemo_TableChart_Sample', 'Table', 'https://developers.google.com/chart/interactive/docs/gallery/table#overview');
    AddModule(1, 'TDemo_Miscellaneous_Formatters', 'Formatters', 'https://developers.google.com/chart/interactive/docs/reference#arrowformat');

  AddModule(0, 'TDemo_TimelineChart_Sample', 'Timeline', 'https://developers.google.com/chart/interactive/docs/gallery/timeline#a-simple-example');
    AddModule(1, 'TDemo_TimelineChart_LabelingTheBars', 'Labeling the Bars', 'https://developers.google.com/chart/interactive/docs/gallery/timeline#labeling-the-bars');
    AddModule(1, 'TDemo_TimelineChart_Advanced', 'Advanced example', 'https://developers.google.com/chart/interactive/docs/gallery/timeline#an-advanced-example');
    AddModule(1, 'TDemo_TimelineChart_ClassroomSchedules', 'Classroom Schedules', 'https://developers.google.com/chart/interactive/docs/gallery/timeline#controlling-the-colors');
      AddModule(2, 'TDemo_TimelineChart_ClassroomSchedulesCtrlColors', 'Controlling the colors', 'https://developers.google.com/chart/interactive/docs/gallery/timeline#controlling-the-colors');
      AddModule(2, 'TDemo_TimelineChart_ClassroomSchedulesSingleColor', 'Single Color', 'https://developers.google.com/chart/interactive/docs/gallery/timeline#controlling-the-colors');

  AddModule(0, 'TDemo_TreeMapChart_Sample', 'Tree Maps', 'https://developers.google.com/chart/interactive/docs/gallery/treemap#overview');

  AddModule(0, 'TDemo_Trendlines_Sample', 'Trendlines', 'https://developers.google.com/chart/interactive/docs/gallery/trendlines');
    AddModule(1, 'TDemo_Trendlines_Exponential', 'Exponential', 'https://developers.google.com/chart/interactive/docs/gallery/trendlines#exponential-trendlines');
    AddModule(1, 'TDemo_Trendlines_Polynomial', 'Polynomial', 'https://developers.google.com/chart/interactive/docs/gallery/trendlines#polynomial-trendlines');

  AddModule(0, 'TDemo_CandlestickChart_Waterfall', 'Waterfall', 'https://developers.google.com/chart/interactive/docs/gallery/candlestickchart#waterfall-charts');

  AddModule(0, 'TDemo_WordTrees_Sample', 'Word Trees', 'https://developers.google.com/chart/interactive/docs/gallery/wordtree#a-simple-example');

  AddModule(0, '', FSep, '');

  AddModule(0, 'TDemo_Miscellaneous_Overlays', 'Customize Charts', 'https://developers.google.com/chart/interactive/docs/overlays#overview');
    AddModule(1, 'TDemo_Miscellaneous_Animation', 'Animation', 'https://developers.google.com/chart/interactive/docs/animation#overview');
    AddModule(1, 'TDemo_Miscellaneous_AxisNumberFormat', 'Axis Number Formats', 'https://developers.google.com/chart/interactive/docs/customizing_axes#number-formats');
      AddModule(2, 'TDemo_Miscellaneous_AxisNumberFormatLang', 'Language (uniSession)', '');
    AddModule(1, 'TDemo_Miscellaneous_DateTimes', 'Axis Dates & Times', 'https://developers.google.com/chart/interactive/docs/datesandtimes#formatting-axis,-gridline,-and-tick-labels');
    AddModule(1, 'TDemo_Miscellaneous_AxisScale', 'Axis Scales', 'https://developers.google.com/chart/interactive/docs/customizing_axes#axis-scale');
    AddModule(1, 'TDemo_Miscellaneous_Customize', 'Colors & Fonts', 'https://developers.google.com/chart/interactive/docs/customizing_charts');
    AddModule(1, 'TDemo_Miscellaneous_Crosshairs', 'Crosshairs', 'https://developers.google.com/chart/interactive/docs/crosshairs#simple_example');
    AddModule(1, 'TDemo_Miscellaneous_CustomizeLines', 'Lines', 'https://developers.google.com/chart/interactive/docs/lines#overview');
    AddModule(1, 'TDemo_Miscellaneous_Formatters', 'Formatters', 'https://developers.google.com/chart/interactive/docs/reference#arrowformat');
    AddModule(1, 'TDemo_Miscellaneous_CustomizePoints', 'Points', 'https://developers.google.com/chart/interactive/docs/points#overview');
    AddModule(1, 'TDemo_Miscellaneous_CustomizeTooltips', 'Tooltips', 'https://developers.google.com/chart/interactive/docs/customizing_tooltip_content#customizing-tooltip-content');

end;

procedure TMainForm.LoadViewTree;
var
  M: TModule;
  Node: TUniTreeNode;
  ChildNode1: TUniTreeNode;
  ChildNode2: TUniTreeNode;
begin
  Node := nil;
  ChildNode1 := nil;
  TreeView.BeginUpdate;
  try
    for M in FModules do
    begin
      if M.Level = 0 then
      begin
        Node := TreeView.Items.Add(nil, M.Title);
        Node.ImageIndex := -1;
        Node.Data := M;
        Node.Font.Assign(TreeView.Font);
        if M.Title = FSep then
          Node.Font.Color := clSilver
        else
          Node.Font.Style := [fsBold];
      end
      else if (M.Level = 1) and (Node <> nil) then
      begin
        ChildNode1 := TreeView.Items.AddChild(Node, M.Title);
        ChildNode1.ImageIndex := -1;
        ChildNode1.Data := M;
      end
      else if (M.Level = 2) and (ChildNode1 <> nil) then
      begin
        ChildNode2 := TreeView.Items.AddChild(ChildNode1, M.Title);
        ChildNode2.ImageIndex := -1;
        ChildNode2.Data := M;
      end;
    end;
  finally
    TreeView.EndUpdate;
  end;
end;

procedure TMainForm.TreeViewClick(Sender: TObject);
var
  N : TUniTreeNode;
  F: TUniFrame;
begin
  N := TreeView.Selected;
  if Assigned(N) and (N.Data <> nil) then
  begin
    if N.Text = FSep then
      Exit;
    if Assigned(FCurrentFrame) then
      FreeAndNil(FCurrentFrame);
    F := LoadFrame(TModule(N.Data).ClassName);
    if Assigned(F) and (F is TDemoBaseFrame) then
      (F as TDemoBaseFrame).GoogleGuideLink := TModule(N.Data).GoogleLink;
  end;
end;

function TMainForm.LoadFrame(const Name: string): TUniFrame;
begin
  Result := nil;
  if Name = '' then
    Exit;

  if Assigned(FCurrentFrame) then
    FreeAndNil(FCurrentFrame);

  Result := TUniFrameClass(FindClass(Name)).Create(Self);
  FCurrentFrame := Result;
  Result.Parent := panFrame;
end;

initialization
  RegisterAppFormClass(TMainForm);

end.

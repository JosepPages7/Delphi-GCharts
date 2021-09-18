unit Demo.GanttChart.StylingTracks;

interface

uses
  System.Classes, System.SysUtils, System.Variants, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_GanttChart_StylingTracks = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_GanttChart_StylingTracks.GenerateChart;

  function DaysToMilliseconds(Days: Integer): Integer;
  begin
    Result := Days * 24 * 60 * 60 * 1000;
  end;

var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_GANTT_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Task ID'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Task Name'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Start Date'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'End  Date'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Duration'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Percent Complete'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Dependencies')
  ]);

  Chart.Data.AddRow(['Research', 'Find sources', EncodeDate(2015, 1, 1), EncodeDate(2015, 1, 5), null, 100, null]);
  Chart.Data.AddRow(['Write', 'Write paper', null, EncodeDate(2015, 1, 9), DaysToMilliseconds(3), 25, 'Research,Outline']);
  Chart.Data.AddRow(['Cite', 'Create bibliography', null, EncodeDate(2015, 1, 7), DaysToMilliseconds(1), 20, 'Research']);
  Chart.Data.AddRow(['Complete', 'Hand in paper', null, EncodeDate(2015, 1, 10), DaysToMilliseconds(1), 0, 'Cite,Write']);
  Chart.Data.AddRow(['Outline', 'Outline paper', null, EncodeDate(2015, 1, 6), DaysToMilliseconds(1), 100, 'Research']);

  // Options
  Chart.Options.Gantt('criticalPathEnabled', false);
  Chart.Options.Gantt('innerGridHorizLine', '{stroke: ''#ffe0b2'', strokeWidth: 2}');
  Chart.Options.Gantt('innerGridTrack', '{fill: ''#fff3e0''}');
  Chart.Options.Gantt('innerGridDarkTrack', '{fill: ''#ffcc80''}');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="margin: auto; width: 80%; height: 100%; padding: 100px;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_GanttChart_StylingTracks);

end.

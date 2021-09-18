unit Demo.GanttChart.GroupingResources;

interface

uses
  System.Classes, System.SysUtils, System.Variants, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_GanttChart_GroupingResources = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_GanttChart_GroupingResources.GenerateChart;

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
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Resource'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Start Date'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'End  Date'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Duration'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Percent Complete'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Dependencies')
  ]);

  Chart.Data.AddRow(['Research', 'Find sources', null, EncodeDate(2015, 1, 1), EncodeDate(2015, 1, 5), null,  100, null]);
  Chart.Data.AddRow(['Write', 'Write paper', 'write', null, EncodeDate(2015, 1, 9), daysToMilliseconds(3), 25, 'Research,Outline']);
  Chart.Data.AddRow(['Cite', 'Create bibliography', 'write', null, EncodeDate(2015, 1, 7), daysToMilliseconds(1), 20, 'Research']);
  Chart.Data.AddRow(['Complete', 'Hand in paper', 'complete', null, EncodeDate(2015, 1, 10), daysToMilliseconds(1), 0, 'Cite,Write']);
  Chart.Data.AddRow(['Outline', 'Outline paper', 'write', null, EncodeDate(2015, 1, 6), daysToMilliseconds(1), 100, 'Research']);

  // Options

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="margin: auto; width: 80%; height: 100%; padding: 100px;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_GanttChart_GroupingResources);

end.

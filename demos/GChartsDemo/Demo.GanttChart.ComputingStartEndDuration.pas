unit Demo.GanttChart.ComputingStartEndDuration;

interface

uses
  System.Classes, System.SysUtils, System.Variants, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_GanttChart_ComputingStartEndDuration = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_GanttChart_ComputingStartEndDuration.GenerateChart;

  function ToMilliseconds(Minutes: Integer): Integer;
  begin
    Result := Minutes * 60 * 1000;
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
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Start'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'End'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Duration'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Percent Complete'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Dependencies')
  ]);

  Chart.Data.AddRow(['toTrain', 'Walk to train stop', 'walk', null, null, toMilliseconds(5), 100, null]);
  Chart.Data.AddRow(['music', 'Listen to music', 'music', null, null, toMilliseconds(70), 100, null]);
  Chart.Data.AddRow(['wait', 'Wait for train', 'wait', null, null, toMilliseconds(10), 100, 'toTrain']);
  Chart.Data.AddRow(['train', 'Train ride', 'train', null, null, toMilliseconds(45), 75, 'wait']);
  Chart.Data.AddRow(['toWork', 'Walk to work', 'walk', null, null, toMilliseconds(10), 0, 'train']);
  Chart.Data.AddRow(['work', 'Sit down at desk', null, null, null, toMilliseconds(2), 0, 'toWork']);

  // Options
  Chart.Options.Gantt('defaultStartDateMillis', EncodeDate(2015, 4, 28));

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="margin: auto; width: 80%; height: 100%; padding: 100px;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_GanttChart_ComputingStartEndDuration);

end.

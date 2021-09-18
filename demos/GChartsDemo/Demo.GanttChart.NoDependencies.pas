unit Demo.GanttChart.NoDependencies;

interface

uses
  System.Classes, System.SysUtils, System.Variants, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_GanttChart_NoDependencies = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_GanttChart_NoDependencies.GenerateChart;
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

  Chart.Data.AddRow(['2014Spring', 'Spring 2014', 'spring', EncodeDate(2014, 3, 22), EncodeDate(2014, 6, 20), null, 100, null]);
  Chart.Data.AddRow(['2014Summer', 'Summer 2014', 'summer', EncodeDate(2014, 6, 21), EncodeDate(2014, 9, 20), null, 100, null]);
  Chart.Data.AddRow(['2014Autumn', 'Autumn 2014', 'autumn', EncodeDate(2014, 9, 21), EncodeDate(2014, 12, 20), null, 100, null]);
  Chart.Data.AddRow(['2014Winter', 'Winter 2014', 'winter', EncodeDate(2014, 12, 21), EncodeDate(2015, 3, 21), null, 100, null]);
  Chart.Data.AddRow(['2015Spring', 'Spring 2015', 'spring', EncodeDate(2015, 3, 22), EncodeDate(2015, 6, 20), null, 50, null]);
  Chart.Data.AddRow(['2015Summer', 'Summer 2015', 'summer', EncodeDate(2015, 6, 21), EncodeDate(2015, 9, 20), null, 0, null]);
  Chart.Data.AddRow(['2015Autumn', 'Autumn 2015', 'autumn', EncodeDate(2015, 9, 21), EncodeDate(2015, 12, 20), null, 0, null]);
  Chart.Data.AddRow(['2015Winter', 'Winter 2015', 'winter', EncodeDate(2015, 12, 21), EncodeDate(2016, 3, 21), null, 0, null]);
  Chart.Data.AddRow(['Football', 'Football Season', 'sports', EncodeDate(2014, 9, 4), EncodeDate(2015, 2, 1), null, 100, null]);
  Chart.Data.AddRow(['Baseball', 'Baseball Season', 'sports', EncodeDate(2015, 3, 31), EncodeDate(2015, 10, 20), null, 14, null]);
  Chart.Data.AddRow(['Basketball', 'Basketball Season', 'sports', EncodeDate(2014, 10, 28), EncodeDate(2015, 6, 20), null, 86, null]);
  Chart.Data.AddRow(['Hockey', 'Hockey Season', 'sports', EncodeDate(2014, 10, 8), EncodeDate(2015, 6, 21), null, 89, null]);

  // Options
  Chart.Options.Gantt('trackHeight', 30);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="margin: auto; width: 80%; height: 100%; padding: 100px;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_GanttChart_NoDependencies);

end.

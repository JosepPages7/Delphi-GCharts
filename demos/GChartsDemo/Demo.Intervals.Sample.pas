unit Demo.Intervals.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Intervals_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_Intervals_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'x'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'values'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i0'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i1'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i2'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i2'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i2'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i2')
  ]);

  Chart.Data.AddRow([1, 100, 90, 110, 85, 96, 104, 120]);
  Chart.Data.AddRow([2, 120, 95, 130, 90, 113, 124, 140]);
  Chart.Data.AddRow([3, 130, 105, 140, 100, 117, 133, 139]);
  Chart.Data.AddRow([4, 90, 85, 95, 85, 88, 92, 95]);
  Chart.Data.AddRow([5, 70, 74, 63, 67, 69, 70, 72]);
  Chart.Data.AddRow([6, 30, 39, 22, 21, 28, 34, 40]);
  Chart.Data.AddRow([7, 80, 77, 83, 70, 77, 85, 90]);
  Chart.Data.AddRow([8, 100, 90, 110, 85, 95, 102, 110]);

  // Options
  Chart.Options.Title('Line intervals, default');
  Chart.Options.CurveType('function');
  Chart.Options.LineWidth(4);
  Chart.Options.Intervals('style', 'line');
  Chart.Options.Legend('position', 'none');


  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Intervals_Sample);

end.

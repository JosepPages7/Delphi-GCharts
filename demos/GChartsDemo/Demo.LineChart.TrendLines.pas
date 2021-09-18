unit Demo.LineChart.TrendLines;

interface

uses
  System.Classes, System.SysUtils, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_LineChart_TrendLines = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_LineChart_TrendLines.GenerateChart;
var
  //Defined as TInterfacedObject. No need try..finally
  Chart: IcfsGChartProducer;
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'X'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Dogs'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Cats')
  ]);
  Chart.Data.AddRow([0, 0, 0]);
  Chart.Data.AddRow([1, 10, 5]);
  Chart.Data.AddRow([2, 23, 15]);
  Chart.Data.AddRow([3, 17, 9]);
  Chart.Data.AddRow([4, 18, 10]);
  Chart.Data.AddRow([5, 9, 5]);
  Chart.Data.AddRow([6, 11, 3]);
  Chart.Data.AddRow([7, 27, 19]);
  Chart.Data.AddRow([8, 33, 25]);
  Chart.Data.AddRow([9, 40, 32]);
  Chart.Data.AddRow([10, 32, 24]);
  Chart.Data.AddRow([11, 35, 27]);
  Chart.Data.AddRow([12, 30, 22]);
  Chart.Data.AddRow([13, 40, 32]);
  Chart.Data.AddRow([14, 42, 34]);
  Chart.Data.AddRow([15, 47, 39]);
  Chart.Data.AddRow([16, 44, 36]);
  Chart.Data.AddRow([17, 48, 40]);
  Chart.Data.AddRow([18, 52, 44]);
  Chart.Data.AddRow([19, 54, 46]);
  Chart.Data.AddRow([20, 42, 34]);
  Chart.Data.AddRow([21, 55, 47]);
  Chart.Data.AddRow([22, 56, 48]);
  Chart.Data.AddRow([23, 57, 49]);
  Chart.Data.AddRow([24, 60, 52]);
  Chart.Data.AddRow([25, 50, 42]);
  Chart.Data.AddRow([26, 52, 44]);
  Chart.Data.AddRow([27, 51, 43]);
  Chart.Data.AddRow([28, 49, 41]);
  Chart.Data.AddRow([29, 53, 45]);
  Chart.Data.AddRow([30, 55, 47]);
  Chart.Data.AddRow([31, 60, 52]);
  Chart.Data.AddRow([32, 61, 53]);
  Chart.Data.AddRow([33, 59, 51]);
  Chart.Data.AddRow([34, 62, 54]);
  Chart.Data.AddRow([35, 65, 57]);
  Chart.Data.AddRow([36, 62, 54]);
  Chart.Data.AddRow([37, 58, 50]);
  Chart.Data.AddRow([38, 55, 47]);
  Chart.Data.AddRow([39, 61, 53]);
  Chart.Data.AddRow([40, 64, 56]);
  Chart.Data.AddRow([41, 65, 57]);
  Chart.Data.AddRow([42, 63, 55]);
  Chart.Data.AddRow([43, 66, 58]);
  Chart.Data.AddRow([44, 67, 59]);
  Chart.Data.AddRow([45, 69, 61]);
  Chart.Data.AddRow([46, 69, 61]);
  Chart.Data.AddRow([47, 70, 62]);
  Chart.Data.AddRow([48, 72, 64]);
  Chart.Data.AddRow([49, 68, 60]);
  Chart.Data.AddRow([50, 66, 58]);
  Chart.Data.AddRow([51, 65, 57]);
  Chart.Data.AddRow([52, 67, 59]);
  Chart.Data.AddRow([53, 70, 62]);
  Chart.Data.AddRow([54, 71, 63]);
  Chart.Data.AddRow([55, 72, 64]);
  Chart.Data.AddRow([56, 73, 65]);
  Chart.Data.AddRow([57, 75, 67]);
  Chart.Data.AddRow([58, 70, 62]);
  Chart.Data.AddRow([59, 68, 60]);
  Chart.Data.AddRow([60, 64, 56]);
  Chart.Data.AddRow([61, 60, 52]);
  Chart.Data.AddRow([62, 65, 57]);
  Chart.Data.AddRow([63, 67, 59]);
  Chart.Data.AddRow([64, 68, 60]);
  Chart.Data.AddRow([65, 69, 61]);
  Chart.Data.AddRow([66, 70, 62]);
  Chart.Data.AddRow([67, 72, 64]);
  Chart.Data.AddRow([68, 75, 67]);
  Chart.Data.AddRow([69, 80, 72]);

  Chart.Options.Title('Trend Lines');
  Chart.Options.HAxis('title', 'time');
  Chart.Options.VAxis('title', 'Popularity');
  Chart.Options.TrendLines(['type: ''exponential'', color: ''#333'', opacity: 1', 'type: ''linear'', color: ''#111'', opacity: .3']);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart" style="width:100%;height:100%;"></div>');

  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_LineChart_TrendLines);

end.

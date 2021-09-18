unit Demo.Trendlines.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Trendlines_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_Trendlines_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer;  // Defined as TInterfacedObject No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_SCATTER_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Diameter'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Age')
  ]);

  Chart.Data.AddRow([8, 37]);
  Chart.Data.AddRow([4, 19.5]);
  Chart.Data.AddRow([11, 52]);
  Chart.Data.AddRow([4, 22]);
  Chart.Data.AddRow([3, 16.5]);
  Chart.Data.AddRow([6.5, 32.8]);
  Chart.Data.AddRow([14, 72]);

  // Options
  Chart.Options.Title('Age of sugar maples vs. trunk diameter, in inches');
  Chart.Options.HAxis('title', 'Diameter');
  Chart.Options.VAxis('title', 'Age');
  Chart.Options.Legend('position', 'none');
  Chart.Options.TrendLines(['0: {}']); // Draw a trendline for data series 0.

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="chart_div" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('chart_div', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Trendlines_Sample);

end.

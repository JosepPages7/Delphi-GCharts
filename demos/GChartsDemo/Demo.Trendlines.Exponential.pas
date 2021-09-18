unit Demo.Trendlines.Exponential;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Trendlines_Exponential = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_Trendlines_Exponential.GenerateChart;
var
  Chart: IcfsGChartProducer;  // Defined as TInterfacedObject No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_SCATTER_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Generation'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Descendants')
  ]);

  Chart.Data.AddRow([0, 1]);
  Chart.Data.AddRow([1, 33]);
  Chart.Data.AddRow([2, 269]);
  Chart.Data.AddRow([3, 2013]);

  // Options
  Chart.Options.Title('Descendants by Generation');
  Chart.Options.HAxis('title', 'Generation');
  Chart.Options.HAxis('minValue', 0);
  Chart.Options.HAxis('maxValue', 3);
  Chart.Options.VAxis('title', 'Descendants');
  Chart.Options.VAxis('minValue', 3);
  Chart.Options.VAxis('maxValue', 2100);
  Chart.Options.TrendLines(['0: {type: ''exponential'', visibleInLegend: true, color: ''green''}']); // Draw a trendline for data series 0.

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="chart_div" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('chart_div', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Trendlines_Exponential);

end.

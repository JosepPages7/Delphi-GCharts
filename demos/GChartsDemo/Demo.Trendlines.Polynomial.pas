unit Demo.Trendlines.Polynomial;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Trendlines_Polynomial = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_Trendlines_Polynomial.GenerateChart;
var
  Chart: IcfsGChartProducer;  // Defined as TInterfacedObject No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_SCATTER_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Age'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Weight')
  ]);

  Chart.Data.AddRow([ 8,      12]);
  Chart.Data.AddRow([ 4,      5.5]);
  Chart.Data.AddRow([ 11,     14]);
  Chart.Data.AddRow([ 4,      5]);
  Chart.Data.AddRow([ 3,      3.5]);
  Chart.Data.AddRow([ 6.5,    7]);

  // Options
  Chart.Options.Title('Age vs. Weight comparison');
  Chart.Options.Legend('position', 'none');
  Chart.Options.Crosshair('trigger', 'both');
  Chart.Options.Crosshair('orientation', 'both');
  Chart.Options.TrendLines(['0: {type: ''polynomial'', degree: 3, visibleInLegend: true, color: ''purple'', lineWidth: 10, opacity: 0.2}']); // Draw a trendline for data series 0.

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="chart_div" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('chart_div', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Trendlines_Polynomial);

end.

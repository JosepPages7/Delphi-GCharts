unit Demo.BarChart.BarStyles;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_BarChart_BarStyles = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_BarChart_BarStyles.GenerateChart;
var
  Chart: IcfsGChartProducer;
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_BAR_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Year'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Visitations'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_STYLE)
  ]);
  Chart.Data.AddRow(['2010', 10, 'color: gray']);
  Chart.Data.AddRow(['2020', 14, 'color: #76A7FA']);
  Chart.Data.AddRow(['2030', 16, 'opacity: 0.2']);
  Chart.Data.AddRow(['2040', 22, 'stroke-color: #703593; stroke-width: 4; fill-color: #C5A5CF']);
  Chart.Data.AddRow(['2050', 28, 'stroke-color: #871B47; stroke-opacity: 0.6; stroke-width: 8; fill-color: #BC5679; fill-opacity: 0.2']);

  // Options
  Chart.Options.Legend('position', 'none');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_BarChart_BarStyles);

end.

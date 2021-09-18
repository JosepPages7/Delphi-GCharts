unit Demo.CandlestickChart.Waterfall;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_CandlestickChart_Waterfall = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_CandlestickChart_Waterfall.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_CANDLESTICK_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Month'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, ''),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, ''),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, ''),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '')
  ]);
  Chart.Data.AddRow(['Mon', 28, 28, 38, 38]);
  Chart.Data.AddRow(['Tue', 38, 38, 55, 55]);
  Chart.Data.AddRow(['Wed', 55, 55, 77, 77]);
  Chart.Data.AddRow(['Thu', 77, 77, 66, 66]);
  Chart.Data.AddRow(['Fri', 66, 66, 22, 22]);

  // Options
  Chart.Options.Legend('position', 'none');
  Chart.Options.Bar('groupWidth', '100%');
  Chart.Options.Candlestick('fallingColor', '{ strokeWidth: 0, fill: ''#a52714'' }'); // red
  Chart.Options.Candlestick('risingColor', '{ strokeWidth: 0, fill: ''#0f9d58'' }');  // green

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_CandlestickChart_Waterfall);

end.

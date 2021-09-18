unit Demo.CandlestickChart.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_CandlestickChart_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_CandlestickChart_Sample.GenerateChart;
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

  Chart.Data.AddRow(['Mon', 20, 28, 38, 45]);
  Chart.Data.AddRow(['Tue', 31, 38, 55, 66]);
  Chart.Data.AddRow(['Wed', 50, 55, 77, 80]);
  Chart.Data.AddRow(['Thu', 77, 77, 66, 50]);
  Chart.Data.AddRow(['Fri', 68, 66, 22, 15]);

  // Options
  Chart.Options.Legend('position', 'none');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_CandlestickChart_Sample);

end.

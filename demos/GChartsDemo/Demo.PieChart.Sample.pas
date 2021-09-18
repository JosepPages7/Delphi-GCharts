unit Demo.PieChart.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_PieChart_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_PieChart_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_PIE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Topping'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Slices')
  ]);

  Chart.Data.AddRow(['Mushrooms', 3]);
  Chart.Data.AddRow(['Onions', 1]);
  Chart.Data.AddRow(['Olives', 1]);
  Chart.Data.AddRow(['Zucchini', 1]);
  Chart.Data.AddRow(['Pepperoni', 2]);

  // Options
  Chart.Options.Title('How Much Pizza I Ate Last Night');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_PieChart_Sample);

end.

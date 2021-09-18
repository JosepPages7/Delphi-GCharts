unit Demo.PieChart.Donut;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_PieChart_Donut = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_PieChart_Donut.GenerateChart;
var
  Chart: IcfsGChartProducer; // Defined as TInterfacedObject No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_PIE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Tasks'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Hours per Day')
  ]);
  Chart.Data.AddRow(['Work', 11]);
  Chart.Data.AddRow(['Eat', 2]);
  Chart.Data.AddRow(['Commute', 2]);
  Chart.Data.AddRow(['Watch TV', 2]);
  Chart.Data.AddRow(['Sleep', 7]);

  // Options
  Chart.Options.Title('My Daily Activities');
  Chart.Options.PieHole(0.4);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_PieChart_Donut);

end.

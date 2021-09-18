unit Demo.ScatterChart.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_ScatterChart_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_ScatterChart_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
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
  Chart.Options.HAxis('title', 'Age');
  Chart.Options.HAxis('minValue', 0);
  Chart.Options.HAxis('maxValue', 15);
  Chart.Options.VAxis('title', 'Weight');
  Chart.Options.VAxis('minValue', 0);
  Chart.Options.VAxis('maxValue', 15);
  Chart.Options.Legend('position', 'none');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_ScatterChart_Sample);

end.

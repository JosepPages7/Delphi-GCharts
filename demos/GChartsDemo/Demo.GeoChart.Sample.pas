unit Demo.GeoChart.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_GeoChart_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_GeoChart_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_GEO_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Country'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Popularity')
  ]);
  Chart.Data.AddRow(['Germany', 200]);
  Chart.Data.AddRow(['United States', 300]);
  Chart.Data.AddRow(['Brazil', 400]);
  Chart.Data.AddRow(['Canada', 500]);
  Chart.Data.AddRow(['France', 600]);
  Chart.Data.AddRow(['RU', 700]);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_GeoChart_Sample);

end.

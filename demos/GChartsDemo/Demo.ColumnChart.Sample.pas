unit Demo.ColumnChart.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_ColumnChart_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_ColumnChart_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; // Defined as TInterfacedObject No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'City'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '2010 Population')
  ]);
  Chart.Data.AddRow(['New York City, NY', 8175000]);
  Chart.Data.AddRow(['Los Angeles, CA', 3792000]);
  Chart.Data.AddRow(['Chicago, IL', 2695000]);
  Chart.Data.AddRow(['Houston, TX', 2099000]);
  Chart.Data.AddRow(['Philadelphia, PA', 1526000]);

  // Options
  Chart.Options.Title('Population of Largest U.S. Cities');
  Chart.Options.ChartArea('width', '50%');
  Chart.Options.hAxis('title', 'Total Population');
  Chart.Options.hAxis('minValue', 0);
  Chart.Options.vAxis('title', 'City');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_ColumnChart_Sample);

end.

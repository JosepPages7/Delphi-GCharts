unit Demo.Material.LineChart.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_MaterialLineChart_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_MaterialLineChart_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_MATERIAL_LINE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Day'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Guardians of the Galaxy'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'The Avengers'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Transformers: Age of Extinction')
  ]);

  Chart.Data.AddRow([1,  37.8, 80.8, 41.8]);
  Chart.Data.AddRow([2,  30.9, 69.5, 32.4]);
  Chart.Data.AddRow([3,  25.4,   57, 25.7]);
  Chart.Data.AddRow([4,  11.7, 18.8, 10.5]);
  Chart.Data.AddRow([5,  11.9, 17.6, 10.4]);
  Chart.Data.AddRow([6,   8.8, 13.6,  7.7]);
  Chart.Data.AddRow([7,   7.6, 12.3,  9.6]);
  Chart.Data.AddRow([8,  12.3, 29.2, 10.6]);
  Chart.Data.AddRow([9,  16.9, 42.9, 14.8]);
  Chart.Data.AddRow([10, 12.8, 30.9, 11.6]);
  Chart.Data.AddRow([11,  5.3,  7.9,  4.7]);
  Chart.Data.AddRow([12,  6.6,  8.4,  5.2]);
  Chart.Data.AddRow([13,  4.8,  6.3,  3.6]);
  Chart.Data.AddRow([14,  4.2,  6.2,  3.4]);

  // Options
  Chart.Options.Title('Box Office Earnings in First Two Weeks of Opening');
  Chart.Options.Subtitle('in millions of dollars (USD)');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
    '<div  style="width:80%; height:10%"></div>' +
    '<div id="Chart" style="width:80%; height:80%;margin: auto"></div>' +
    '<div  style="width:80%; height:10%"></div>'
  );
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_MaterialLineChart_Sample);

end.

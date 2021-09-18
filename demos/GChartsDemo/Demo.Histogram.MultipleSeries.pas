unit Demo.Histogram.MultipleSeries;

interface

uses
  System.Classes, System.Variants, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Histogram_MultipleSeries = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_Histogram_MultipleSeries.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_HISTOGRAM_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Quarks'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Leptons'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Gauge Bosons'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Scalar Bosons')
  ]);

  Chart.Data.AddRow([2/3, -1, 0, 0]);
  Chart.Data.AddRow([2/3, -1, 0, null]);
  Chart.Data.AddRow([2/3, -1, 0, null]);
  Chart.Data.AddRow([-1/3, 0, 1, null]);
  Chart.Data.AddRow([-1/3, 0, -1, null]);
  Chart.Data.AddRow([-1/3, 0, null, null]);
  Chart.Data.AddRow([-1/3, 0, null, null]);

  // Options
  Chart.Options.Title('Charges of subatomic particles');
  Chart.Options.Legend('position', 'top');
  Chart.Options.Legend('maxLines', 2);
  Chart.Options.Colors(['#5C3292', '#1A8763', '#871B47', '#999999']);
  Chart.Options.InterpolateNulls(false);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Histogram_MultipleSeries);

end.

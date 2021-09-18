unit Demo.LineChart.CurvingLines;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_LineChart_CurvingLines = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_LineChart_CurvingLines.GenerateChart;
var
  Chart: IcfsGChartProducer;  // Defined as TInterfacedObject No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Year'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Sales'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Expenses')
  ]);
  Chart.Data.AddRow(['2013',  1000,      400]);
  Chart.Data.AddRow(['2014',  1170,      460]);
  Chart.Data.AddRow(['2015',  660,       1120]);
  Chart.Data.AddRow(['2016',  1030,      540]);

  // Options
  Chart.Options.Title('Company Performance');
  Chart.Options.VAxis('title', 'Year');
  Chart.Options.CurveType('function');
  Chart.Options.Legend('position', 'bottom');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="chart_div" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('chart_div', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_LineChart_CurvingLines);

end.

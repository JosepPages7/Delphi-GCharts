unit Demo.Material.LineChart.DualY;

interface

uses
  System.Classes, System.SysUtils, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_MaterialLineChart_DualY = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_MaterialLineChart_DualY.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_MATERIAL_LINE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Month'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Average Temperature'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Average Hours of Daylight')
  ]);

  Chart.Data.AddRow([EncodeDate(2014, 1, 1),  -0.5,  5.7]);
  Chart.Data.AddRow([EncodeDate(2014, 2, 1),   0.4,  8.7]);
  Chart.Data.AddRow([EncodeDate(2014, 3, 1),   0.5,   12]);
  Chart.Data.AddRow([EncodeDate(2014, 4, 1),  2.9, 15.3]);
  Chart.Data.AddRow([EncodeDate(2014, 5, 1),  6.3, 18.6]);
  Chart.Data.AddRow([EncodeDate(2014, 6, 1),    9, 20.9]);
  Chart.Data.AddRow([EncodeDate(2014, 7, 1), 10.6, 19.8]);
  Chart.Data.AddRow([EncodeDate(2014, 8, 1), 10.3, 16.6]);
  Chart.Data.AddRow([EncodeDate(2014, 9, 1),  7.4, 13.3]);
  Chart.Data.AddRow([EncodeDate(2014, 10, 1),  4.4,  9.9]);
  Chart.Data.AddRow([EncodeDate(2014, 11, 1), 1.1,  6.6]);
  Chart.Data.AddRow([EncodeDate(2014, 12, 1), -0.2,  4.5]);

  // Options
  Chart.Options.Title('Average Temperatures and Daylight in Iceland Throughout the Year');
  Chart.Options.Series(['0: {targetAxisIndex: 0}', '1: {targetAxisIndex: 1}']);
  Chart.Options.VAxes(['0: {title: ''Temps (Celsius)''}', '1: {title: ''Daylight''}']);
  Chart.Options.VAxis('viewWindow', '{max: 30}');
  Chart.Options.HAxis('ticks', '['
     + 'new Date(2014, 0), new Date(2014, 1), new Date(2014, 2), new Date(2014, 3),'
     + 'new Date(2014, 4),  new Date(2014, 5), new Date(2014, 6), new Date(2014, 7),'
     + 'new Date(2014, 8), new Date(2014, 9), new Date(2014, 10), new Date(2014, 11)'
     + ']'
  );
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
  RegisterClass(TDemo_MaterialLineChart_DualY);

end.

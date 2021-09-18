unit Demo.MaterialBarChart.DualX;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_MaterialBarChart_DualX = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_MaterialBarChart_DualX.GenerateChart;
var
  Chart: IcfsGChartProducer;   // Defined as TInterfacedObject No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_MATERIAL_BAR_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'City'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '2010 Population'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '2000 Population')
  ]);
  Chart.Data.AddRow(['New York City, NY', 8175000, 8008000]);
  Chart.Data.AddRow(['Los Angeles, CA', 3792000, 3694000]);
  Chart.Data.AddRow(['Chicago, IL', 2695000, 2896000]);
  Chart.Data.AddRow(['Houston, TX', 2099000, 1953000]);
  Chart.Data.AddRow(['Philadelphia, PA', 1526000, 1517000]);

  // Options
  Chart.Options.Title('Population of Largest U.S. Cities');
  Chart.Options.Subtitle('Based on most recent and previous census data');
  Chart.Options.hAxis('title', 'Total Population');
  Chart.Options.hAxis('minValue', 0);
  Chart.Options.vAxis('title', 'City');
  Chart.Options.Series(['0: {axis: ''2010''}', '1: {axis: ''2000''}']);
  Chart.Options.Axes('x', '{2010: {label: ''2010 Population (in millions)'', side: ''top''}, 2000: {label: ''2000 Population''}}');
  Chart.Options.SetAsQuotedStr('bars', 'horizontal');

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
  RegisterClass(TDemo_MaterialBarChart_DualX);

end.

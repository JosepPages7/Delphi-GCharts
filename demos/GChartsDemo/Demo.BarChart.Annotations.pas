unit Demo.BarChart.Annotations;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_BarChart_Annotations = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_BarChart_Annotations.GenerateChart;
var
  Chart: IcfsGChartProducer;
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_BAR_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'City'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '2010 Population'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '2000 Population'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION)
  ]);
  Chart.Data.AddRow(['New York City, NY', 8175000, '8.1M', 8008000, '8M']);
  Chart.Data.AddRow(['Los Angeles, CA', 3792000, '3.8M', 3694000, '3.7M']);
  Chart.Data.AddRow(['Chicago, IL', 2695000, '2.7M', 2896000, '2.9M']);
  Chart.Data.AddRow(['Houston, TX', 2099000, '2.1M', 1953000, '2.0M']);
  Chart.Data.AddRow(['Philadelphia, PA', 1526000, '1.5M', 1517000, '1.5M']);

  // Options
  Chart.Options.Title('Population of Largest U.S. Cities');
  Chart.Options.ChartArea('width', '50%');
  Chart.Options.Annotations('alwaysOutside', True);
  Chart.Options.Annotations('textStyle', '{fontSize: 12, auraColor: ''none'', color: ''#555''}');
  Chart.Options.Annotations('boxStyle', '{stroke: ''#ccc'', strokeWidth: 1, gradient: {color1: ''#f3e5f5'', color2: ''#f3e5f5'', x1: ''0%'', y1: ''0%'', x2: ''100%'', y2: ''100%'' }}');
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
  RegisterClass(TDemo_BarChart_Annotations);

end.

unit Demo.SteppedAreaChart.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_SteppedAreaChart_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_SteppedAreaChart_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_STEPPED_AREA_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Director (Year)'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Rotten Tomatoes'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'IMDB')
  ]);

  Chart.Data.AddRow(['Alfred Hitchcock (1935)', 8.4,         7.9]);
  Chart.Data.AddRow(['Ralph Thomas (1959)',     6.9,         6.5]);
  Chart.Data.AddRow(['Don Sharp (1978)',        6.5,         6.4]);
  Chart.Data.AddRow(['James Hawes (2008)',      4.4,         6.2]);


  // Options
  Chart.Options.Title('The decline of ''The 39 Steps''');
  Chart.Options.VAxis('title', 'Accumulated Rating');
  Chart.Options.IsStacked(True);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_SteppedAreaChart_Sample);

end.

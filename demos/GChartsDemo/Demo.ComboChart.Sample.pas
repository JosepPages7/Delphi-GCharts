unit Demo.ComboChart.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_ComboChart_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_ComboChart_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
  Series: TArray<string>;
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_COMBO_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Month'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Bolivia'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Ecuador'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Madagascar'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Papua New Guinea'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Rwanda'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Average')
  ]);

  Chart.Data.AddRow(['2004/05',  165,      938,         522,             998,           450,      614.6]);
  Chart.Data.AddRow(['2005/06',  135,      1120,        599,             1268,          288,      682]);
  Chart.Data.AddRow(['2006/07',  157,      1167,        587,             807,           397,      623]);
  Chart.Data.AddRow(['2007/08',  139,      1110,        615,             968,           215,      609.4]);
  Chart.Data.AddRow(['2008/09',  136,      691,         629,             1026,          366,      569.6]);

  // Options
  Chart.Options.Title('Monthly Coffee Production by Country');
  Chart.Options.VAxis('title', 'Cups');
  Chart.Options.HAxis('title', 'Month');
  Chart.Options.SeriesType('bars');

  SetLength(Series, 6);
  Series[5] := 'type: ''line''';
  Chart.Options.Series(Series);


  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_ComboChart_Sample);

end.

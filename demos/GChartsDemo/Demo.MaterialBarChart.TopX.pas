unit Demo.MaterialBarChart.TopX;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_MaterialBarChart_TopX = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_MaterialBarChart_TopX.GenerateChart;
var
  Chart: IcfsGChartProducer;   // Defined as TInterfacedObject No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_MATERIAL_BAR_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Move'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Percentage')
  ]);

  Chart.Data.AddRow(['King''s pawn (e4)', 44]);
  Chart.Data.AddRow(['Queen''s pawn (d4)', 31]);
  Chart.Data.AddRow(['Knight to King 3 (Nf3)', 12]);
  Chart.Data.AddRow(['Queen''s bishop pawn (c4)', 10]);
  Chart.Data.AddRow(['Other', 3]);

  // Options
  Chart.Options.Title('Chess opening moves');
  Chart.Options.Subtitle('popularity by percentage');
  Chart.Options.Legend('position', 'none');
  Chart.Options.Axes('x', '{0: {side: ''top'', label: ''Percentage''}}');
  Chart.Options.Bar('groupWidth', '90%');
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
  RegisterClass(TDemo_MaterialBarChart_TopX);

end.

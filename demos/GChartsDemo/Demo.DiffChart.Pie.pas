unit Demo.DiffChart.Pie;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_DiffChart_Pie = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_DiffChart_Pie.GenerateChart;
var
  OldData: IcfsGChartData;
  NewData: IcfsGChartData;
  ChartBefore: IcfsGChartProducer;
  ChartAfter: IcfsGChartProducer;
  ChartDiff: IcfsGChartProducer;
begin
  // Old Data
  OldData := TcfsGChartData.Create;
  OldData.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Major'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Degrees')
  ]);
  OldData.AddRow(['Business', 256070]);
  OldData.AddRow(['Education', 108034]);
  OldData.AddRow(['Social Sciences & History', 127101]);
  OldData.AddRow(['Health', 81863]);
  OldData.AddRow(['Psychology', 74194]);

  // New Data
  NewData := TcfsGChartData.Create;
  NewData.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Major'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Degrees')
  ]);
  NewData.AddRow(['Business', 358293]);
  NewData.AddRow(['Education', 101265]);
  NewData.AddRow(['Social Sciences & History', 172780]);
  NewData.AddRow(['Health', 129634]);
  NewData.AddRow(['Psychology', 97216]);

  // Chart Before
  ChartBefore := TcfsGChartProducer.Create;
  ChartBefore.ClassChartType := TcfsGChartProducer.CLASS_PIE_CHART;
  ChartBefore.Data.Assign(OldData);
  ChartBefore.Options.Title('2000');
  ChartBefore.Options.PieSliceText('none');

  // Chart After
  ChartAfter := TcfsGChartProducer.Create;
  ChartAfter.ClassChartType := TcfsGChartProducer.CLASS_PIE_CHART;
  ChartAfter.Data.Assign(NewData);
  ChartAfter.Options.Title('2010');
  ChartAfter.Options.PieSliceText('none');

  // Chart Diff
  ChartDiff := TcfsGChartProducer.Create;
  ChartDiff.ClassChartType := TcfsGChartProducer.CLASS_PIE_CHART;
  ChartDiff.OldData.Assign(OldData);
  ChartDiff.Data.Assign(NewData);
  ChartDiff.Options.Title('Popularity of the top five U.S. college majors between 2000 and 2010');
  ChartDiff.Options.PieSliceText('none');
  //ChartDiff.Options.Diff('innerCircle', '{ radiusFactor: 0.3 }');
  ChartDiff.Options.Diff('innerCircle', '{ borderFactor: 0.08 }');
  //ChartDiff.Options.Diff('oldData', '{opacity: 0.15}');
  //ChartDiff.Options.Diff('oldData', '{inCenter: false}');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 50%;">'
    +   '<div id="ChartBefore" style="width: 50%"></div>'
    +   '<div id="ChartAfter" style="flex-grow: 1;"></div>'
    + '</div>'
    +  '<div style="display: flex; width: 100%; height: 50%;">'
    +   '<div id="ChartDiff" style="width: 100%"></div>'
    + '</div>'
  );
  GChartsFrame.DocumentGenerate('ChartBefore', ChartBefore);
  GChartsFrame.DocumentGenerate('ChartAfter', ChartAfter);
  GChartsFrame.DocumentGenerate('ChartDiff', ChartDiff);

  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_DiffChart_Pie);

end.

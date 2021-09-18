unit Demo.DiffChart.Column;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_DiffChart_Column = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_DiffChart_Column.GenerateChart;
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
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Name'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Popularity')
  ]);
  OldData.AddRow(['Cesar', 250]);
  OldData.AddRow(['Rachel', 4200]);
  OldData.AddRow(['Patrick', 2900]);
  OldData.AddRow(['Eric', 8200]);

  // New Data
  NewData := TcfsGChartData.Create;
  NewData.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Name'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Popularity')
  ]);
  NewData.AddRow(['Cesar', 370]);
  NewData.AddRow(['Rachel', 600]);
  NewData.AddRow(['Patrick', 700]);
  NewData.AddRow(['Eric', 1500]);

  // Chart Before
  ChartBefore := TcfsGChartProducer.Create;
  ChartBefore.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  ChartBefore.Data.Assign(OldData);
  ChartBefore.Options.Title('Popularity of some names in 1980s');
  //ChartBefore.Options.Legend('position', 'top');

  // Chart After
  ChartAfter := TcfsGChartProducer.Create;
  ChartAfter.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  ChartAfter.Data.Assign(NewData);
  ChartAfter.Options.Title('Present popularity of some names');
  //ChartAfter.Options.Legend('position', 'top');

  // Chart Diff
  ChartDiff := TcfsGChartProducer.Create;
  ChartDiff.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  ChartDiff.OldData.Assign(OldData);
  ChartDiff.Data.Assign(NewData);
  ChartDiff.Options.Legend('position', 'top');
  //ChartDiff.Options.Diff('innerCircle', '{ radiusFactor: 0.3 }');

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
  RegisterClass(TDemo_DiffChart_Column);

end.

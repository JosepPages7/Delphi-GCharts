unit Demo.PieChart.Removing_Slices;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_PieChart_Removing_Slices = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_PieChart_Removing_Slices.GenerateChart;
var
  Chart: IcfsGChartProducer; // Defined as TInterfacedObject No need try..finally
  Slices: TArray<string>;
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_PIE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Pac Man'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Percentage')
  ]);
  Chart.Data.AddRow(['', 75]);
  Chart.Data.AddRow(['', 25]);

  // Options
  Chart.Options.Legend('position', 'none');
  Chart.Options.PieSliceText('none');
  Chart.Options.PieStartAngle(135);

  SetLength(Slices, 2);
  Slices[0] := 'color: ''yellow''';
  Slices[1] := 'color: ''transparent''';
  Chart.Options.Slices(Slices);

  Chart.Options.Tooltip('trigger', 'none');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_PieChart_Removing_Slices);

end.

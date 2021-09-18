unit Demo.PieChart.Rotating;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_PieChart_Rotating = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_PieChart_Rotating.GenerateChart;
var
  // Defined as TInterfacedObject No need try..finally
  Data: IcfsGChartData;
  ChartNoRotation: IcfsGChartProducer;
  Chart100Rotation: IcfsGChartProducer;
begin
  // Data
  Data := TcfsGChartData.Create;
  Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Language'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Speakers (in millions)')
  ]);
  Data.AddRow(['German', 5.85]);
  Data.AddRow(['French', 1.66]);
  Data.AddRow(['Italian', 0.316]);
  Data.AddRow(['Romansh', 0.0791]);


  // Chart No Rotation
  ChartNoRotation := TcfsGChartProducer.Create;
  ChartNoRotation.ClassChartType := TcfsGChartProducer.CLASS_PIE_CHART;
  ChartNoRotation.Data.Assign(Data);
  ChartNoRotation.Options.Title('Swiss Language Use (no rotation)');
  ChartNoRotation.Options.Legend('position', 'none');
  ChartNoRotation.Options.PieSliceText('label');

  // Chart 100 Rotation
  Chart100Rotation := TcfsGChartProducer.Create;
  Chart100Rotation.ClassChartType := TcfsGChartProducer.CLASS_PIE_CHART;
  Chart100Rotation.Data.Assign(Data);
  Chart100Rotation.Options.Title('Swiss Language Use (100 degree rotation)');
  Chart100Rotation.Options.Legend('position', 'none');
  Chart100Rotation.Options.PieStartAngle(100);
  Chart100Rotation.Options.PieSliceText('label');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 100%;">'
    +   '<div id="ChartNoRotation" style="width: 50%"></div>'
    +   '<div id="Chart100Rotation" style="flex-grow: 1;">'
    + '</div></div>'
  );
  GChartsFrame.DocumentGenerate('ChartNoRotation', ChartNoRotation);
  GChartsFrame.DocumentGenerate('Chart100Rotation', Chart100Rotation);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_PieChart_Rotating);

end.

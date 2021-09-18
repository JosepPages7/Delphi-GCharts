unit Demo.Miscellaneous.Crosshairs;

interface

uses
  System.Classes, System.SysUtils, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Miscellaneous_Crosshairs = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

uses
  System.Math;

procedure TDemo_Miscellaneous_Crosshairs.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
  I: Integer;
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_SCATTER_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber)
  ]);

  for I := 0 to 99 do
    Chart.Data.AddRow([Random(99), Random(99)]);

  // Options
  Chart.Options.Legend('position', 'none');
  Chart.Options.Crosshair('trigger', 'both');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
    '<div style="width:100%;font-family: Arial; font-size:14px; text-align: center;"><br><br>Hover over the points below, or select them, to see crosshairs</div>'
    + '<div id="Chart" style="width:100%;height:90%;"></div>'
  );
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Miscellaneous_Crosshairs);

end.

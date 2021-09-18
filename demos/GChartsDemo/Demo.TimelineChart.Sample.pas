unit Demo.TimelineChart.Sample;

interface

uses
  System.Classes, System.SysUtils, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_TimelineChart_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_TimelineChart_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_TIMELINE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'President'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Start'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'End')
  ]);

  Chart.Data.AddRow([ 'Washington', EncodeDate(1789, 4, 30), EncodeDate(1797, 3, 4) ]);
  Chart.Data.AddRow([ 'Adams',      EncodeDate(1797, 3, 4),  EncodeDate(1801, 3, 4) ]);
  Chart.Data.AddRow([ 'Jefferson',  EncodeDate(1801, 3, 4),  EncodeDate(1809, 3, 4) ]);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart" style="width:900px; height:300px; margin:auto;position: absolute;top:0;bottom: 0;left: 0;right: 0;"></div>');
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_TimelineChart_Sample);

end.

unit Demo.TimelineChart.ClassroomSchedules;

interface

uses
  System.Classes, System.SysUtils, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_TimelineChart_ClassroomSchedules = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

uses
  System.DateUtils;

procedure TDemo_TimelineChart_ClassroomSchedules.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_TIMELINE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Room'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Name'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDateTime, 'Start'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDateTime, 'End')
  ]);

  Chart.Data.AddRow([ 'Magnolia Room', 'Beginning JavaScript',       EncodeTime(12,0,0,0),  EncodeTime(13,30,0,0) ]);
  Chart.Data.AddRow([ 'Magnolia Room', 'Intermediate JavaScript',    EncodeTime(14,0,0,0),  EncodeTime(15,30,0,0) ]);
  Chart.Data.AddRow([ 'Magnolia Room', 'Advanced JavaScript',        EncodeTime(16,0,0,0),  EncodeTime(17,30,0,0) ]);
  Chart.Data.AddRow([ 'Willow Room',   'Beginning Google Charts',    EncodeTime(12,30,0,0), EncodeTime(14,0,0,0) ]);
  Chart.Data.AddRow([ 'Willow Room',   'Intermediate Google Charts', EncodeTime(14,30,0,0), EncodeTime(16,0,0,0) ]);
  Chart.Data.AddRow([ 'Willow Room',   'Advanced Google Charts',     EncodeTime(16,30,0,0), EncodeTime(18,0,0,0) ]);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart" style="width:900px; height:300px; margin:auto;position: absolute;top:0;bottom: 0;left: 0;right: 0;"></div>');
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_TimelineChart_ClassroomSchedules);

end.

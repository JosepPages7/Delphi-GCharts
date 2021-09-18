unit Demo.CalendarChart.Sample;

interface

uses
  System.Classes, System.SysUtils, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_CalendarChart_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_CalendarChart_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
  M: Integer;
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_CALENDAR_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Date'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Won/Loss')
  ]);
  for M := 3 to 9 do
  begin
    Chart.Data.AddRow([ EncodeDate(2012, M, 13), 37032 ]);
    Chart.Data.AddRow([ EncodeDate(2012, M, 14), 38024 ]);
    Chart.Data.AddRow([ EncodeDate(2012, M, 15), 38024 ]);
    Chart.Data.AddRow([ EncodeDate(2012, M, 16), 38108 ]);
    Chart.Data.AddRow([ EncodeDate(2012, M, 17), 38229 ]);
    Chart.Data.AddRow([ EncodeDate(2012, M, 18), 38177 ]);

    Chart.Data.AddRow([ EncodeDate(2013, M, 12), 38210 ]);
    Chart.Data.AddRow([ EncodeDate(2013, M, 13), 38029 ]);
    Chart.Data.AddRow([ EncodeDate(2013, M, 19), 38823 ]);
    Chart.Data.AddRow([ EncodeDate(2013, M, 23), 38345 ]);
    Chart.Data.AddRow([ EncodeDate(2013, M, 24), 38436 ]);
    Chart.Data.AddRow([ EncodeDate(2013, M, 30), 38447 ]);
  end;

  // Options
  Chart.Options.Title('Red Sox Attendance');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart" style="width:1000px; height:500px; margin:auto;position: absolute;top:0;bottom: 0;left: 0;right: 0;"></div>');
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_CalendarChart_Sample);

end.

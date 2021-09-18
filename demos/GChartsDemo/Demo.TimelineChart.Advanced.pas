unit Demo.TimelineChart.Advanced;

interface

uses
  System.Classes, System.SysUtils, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_TimelineChart_Advanced = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_TimelineChart_Advanced.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_TIMELINE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Position'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'President'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Start'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'End')
  ]);

  Chart.Data.AddRow([ 'President', 'George Washington', EncodeDate(1789, 4, 30), EncodeDate(1797, 3, 4) ]);
  Chart.Data.AddRow([ 'President', 'John Adams', EncodeDate(1797, 3, 4), EncodeDate(1801, 3, 4) ]);
  Chart.Data.AddRow([ 'President', 'Thomas Jefferson', EncodeDate(1801, 3, 4), EncodeDate(1809, 3, 4) ]);
  Chart.Data.AddRow([ 'Vice President', 'John Adams', EncodeDate(1789, 4, 21), EncodeDate(1797, 3, 4)]);
  Chart.Data.AddRow([ 'Vice President', 'Thomas Jefferson', EncodeDate(1797, 3, 4), EncodeDate(1801, 3, 4)]);
  Chart.Data.AddRow([ 'Vice President', 'Aaron Burr', EncodeDate(1801, 3, 4), EncodeDate(1805, 3, 4)]);
  Chart.Data.AddRow([ 'Vice President', 'George Clinton', EncodeDate(1805, 3, 4), EncodeDate(1812, 4, 20)]);
  Chart.Data.AddRow([ 'Secretary of State', 'John Jay', EncodeDate(1789, 9, 25), EncodeDate(1790, 3, 22)]);
  Chart.Data.AddRow([ 'Secretary of State', 'Thomas Jefferson', EncodeDate(1790, 3, 22), EncodeDate(1793, 12, 31)]);
  Chart.Data.AddRow([ 'Secretary of State', 'Edmund Randolph', EncodeDate(1794, 1, 2), EncodeDate(1795, 8, 20)]);
  Chart.Data.AddRow([ 'Secretary of State', 'Timothy Pickering', EncodeDate(1795, 8, 20), EncodeDate(1800, 5, 12)]);
  Chart.Data.AddRow([ 'Secretary of State', 'Charles Lee', EncodeDate(1800, 5, 13), EncodeDate(1800, 6, 5)]);
  Chart.Data.AddRow([ 'Secretary of State', 'John Marshall', EncodeDate(1800, 6, 13), EncodeDate(1801, 3, 4)]);
  Chart.Data.AddRow([ 'Secretary of State', 'Levi Lincoln', EncodeDate(1801, 3, 5), EncodeDate(1801, 5, 1)]);
  Chart.Data.AddRow([ 'Secretary of State', 'James Madison', EncodeDate(1801, 5, 2), EncodeDate(1809, 3, 3)]);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart" style="width:900px; height:300px; margin:auto;position: absolute;top:0;bottom: 0;left: 0;right: 0;"></div>');
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_TimelineChart_Advanced);

end.

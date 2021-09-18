unit Demo.Miscellaneous.AxisScale;

interface

uses
  System.Classes, System.SysUtils, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Miscellaneous_AxisScale = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

uses
  System.DateUtils;

procedure TDemo_Miscellaneous_AxisScale.GenerateChart;
var
  Chart1, Chart2, Chart3, Chart4: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  //World Population Since 1400 A.D. in Linear Scale
  Chart1 := TcfsGChartProducer.Create;
  Chart1.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  Chart1.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Date'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Population')
  ]);

  Chart1.Data.AddRow([EncodeDate(1400, 1, 1),  374]);
  Chart1.Data.AddRow([EncodeDate(1500, 1, 1),  460]);
  Chart1.Data.AddRow([EncodeDate(1600, 1, 1),  579]);
  Chart1.Data.AddRow([EncodeDate(1700, 1, 1),  679]);
  Chart1.Data.AddRow([EncodeDate(1750, 1, 1),  770]);
  Chart1.Data.AddRow([EncodeDate(1800, 1, 1),  954]);
  Chart1.Data.AddRow([EncodeDate(1850, 1, 1),  1241]);
  Chart1.Data.AddRow([EncodeDate(1900, 1, 1),  1633]);
  Chart1.Data.AddRow([EncodeDate(1910, 1, 1),  1750]);
  Chart1.Data.AddRow([EncodeDate(1920, 1, 1),  1860]);
  Chart1.Data.AddRow([EncodeDate(1930, 1, 1),  2070]);
  Chart1.Data.AddRow([EncodeDate(1940, 1, 1),  2300]);
  Chart1.Data.AddRow([EncodeDate(1950, 1, 1),  2558]);
  Chart1.Data.AddRow([EncodeDate(1951, 1, 1),  2595]);
  Chart1.Data.AddRow([EncodeDate(1952, 1, 1),  2637]);
  Chart1.Data.AddRow([EncodeDate(1953, 1, 1),  2682]);
  Chart1.Data.AddRow([EncodeDate(1954, 1, 1),  2730]);
  Chart1.Data.AddRow([EncodeDate(1955, 1, 1),  2782]);
  Chart1.Data.AddRow([EncodeDate(1956, 1, 1),  2835]);
  Chart1.Data.AddRow([EncodeDate(1957, 1, 1),  2891]);
  Chart1.Data.AddRow([EncodeDate(1958, 1, 1),  2948]);
  Chart1.Data.AddRow([EncodeDate(1959, 1, 1),  3001]);
  Chart1.Data.AddRow([EncodeDate(1960, 1, 1),  3043]);
  Chart1.Data.AddRow([EncodeDate(1961, 1, 1),  3084]);
  Chart1.Data.AddRow([EncodeDate(1962, 1, 1),  3140]);
  Chart1.Data.AddRow([EncodeDate(1963, 1, 1),  3210]);
  Chart1.Data.AddRow([EncodeDate(1964, 1, 1),  3281]);
  Chart1.Data.AddRow([EncodeDate(1965, 1, 1),  3350]);
  Chart1.Data.AddRow([EncodeDate(1966, 1, 1),  3421]);
  Chart1.Data.AddRow([EncodeDate(1967, 1, 1),  3490]);
  Chart1.Data.AddRow([EncodeDate(1968, 1, 1),  3562]);
  Chart1.Data.AddRow([EncodeDate(1969, 1, 1),  3637]);
  Chart1.Data.AddRow([EncodeDate(1970, 1, 1),  3713]);
  Chart1.Data.AddRow([EncodeDate(1971, 1, 1),  3790]);
  Chart1.Data.AddRow([EncodeDate(1972, 1, 1),  3867]);
  Chart1.Data.AddRow([EncodeDate(1973, 1, 1),  3942]);
  Chart1.Data.AddRow([EncodeDate(1974, 1, 1),  4017]);
  Chart1.Data.AddRow([EncodeDate(1975, 1, 1),  4089]);
  Chart1.Data.AddRow([EncodeDate(1976, 1, 1),  4160]);
  Chart1.Data.AddRow([EncodeDate(1977, 1, 1),  4232]);
  Chart1.Data.AddRow([EncodeDate(1978, 1, 1),  4304]);
  Chart1.Data.AddRow([EncodeDate(1979, 1, 1),  4379]);
  Chart1.Data.AddRow([EncodeDate(1980, 1, 1),  4451]);
  Chart1.Data.AddRow([EncodeDate(1981, 1, 1),  4534]);
  Chart1.Data.AddRow([EncodeDate(1982, 1, 1),  4615]);
  Chart1.Data.AddRow([EncodeDate(1983, 1, 1),  4696]);
  Chart1.Data.AddRow([EncodeDate(1984, 1, 1),  4775]);
  Chart1.Data.AddRow([EncodeDate(1985, 1, 1),  4856]);
  Chart1.Data.AddRow([EncodeDate(1986, 1, 1),  4941]);
  Chart1.Data.AddRow([EncodeDate(1987, 1, 1),  5027]);
  Chart1.Data.AddRow([EncodeDate(1988, 1, 1),  5115]);
  Chart1.Data.AddRow([EncodeDate(1989, 1, 1),  5201]);
  Chart1.Data.AddRow([EncodeDate(1990, 1, 1),  5289]);
  Chart1.Data.AddRow([EncodeDate(1991, 1, 1),  5372]);
  Chart1.Data.AddRow([EncodeDate(1992, 1, 1),  5456]);
  Chart1.Data.AddRow([EncodeDate(1993, 1, 1),  5538]);
  Chart1.Data.AddRow([EncodeDate(1994, 1, 1),  5619]);
  Chart1.Data.AddRow([EncodeDate(1995, 1, 1),  5699]);
  Chart1.Data.AddRow([EncodeDate(1996, 1, 1),  5779]);
  Chart1.Data.AddRow([EncodeDate(1997, 1, 1),  5858]);
  Chart1.Data.AddRow([EncodeDate(1998, 1, 1),  5935]);
  Chart1.Data.AddRow([EncodeDate(1999, 1, 1),  6012]);
  Chart1.Data.AddRow([EncodeDate(2000, 1, 1),  6089]);
  Chart1.Data.AddRow([EncodeDate(2001, 1, 1),  6165]);
  Chart1.Data.AddRow([EncodeDate(2002, 1, 1),  6242]);
  Chart1.Data.AddRow([EncodeDate(2003, 1, 1),  6319]);
  Chart1.Data.AddRow([EncodeDate(2004, 1, 1),  6396]);
  Chart1.Data.AddRow([EncodeDate(2005, 1, 1),  6473]);
  Chart1.Data.AddRow([EncodeDate(2006, 1, 1),  6551]);
  Chart1.Data.AddRow([EncodeDate(2007, 1, 1),  6630]);
  Chart1.Data.AddRow([EncodeDate(2008, 1, 1),  6709]);
  Chart1.Data.AddRow([EncodeDate(2009, 1, 1),  6788]);

  Chart1.Options.Title('World Population Since 1400 A.D. in Linear Scale');
  Chart1.Options.Legend('position', 'none');
  Chart1.Options.HAxis('title', 'Date');
  Chart1.Options.VAxis('title', 'Population (millions)');
  Chart1.Options.VAxis('ticks', '[0, 1000, 2000, 4000, 6000]');

  // World Population Since 1400 A.D. in Log Scale
  Chart2 := TcfsGChartProducer.Create;
  Chart2.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;
  Chart2.Data.Assign(Chart1.Data);

  Chart2.Options.Title('World Population Since 1400 A.D. in Log Scale');
  Chart2.Options.Legend('position', 'none');
  Chart2.Options.HAxis('title', 'Date');
  Chart2.Options.VAxis('title', 'Population (millions)');
  Chart2.Options.VAxis('ticks', '[0, 1000, 2000, 4000, 6000]');
  Chart2.Options.VAxis('scaleType', 'log');

  // Fibonacci Numbers in Linear Scale
  Chart3 := TcfsGChartProducer.Create;
  Chart3.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  Chart3.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Index'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Fibonacci Number')
  ]);

  Chart3.Data.AddRow([-16, -987]);
  Chart3.Data.AddRow([-15, 610]);
  Chart3.Data.AddRow([-14, -377]);
  Chart3.Data.AddRow([-13, 233]);
  Chart3.Data.AddRow([-12, -144]);
  Chart3.Data.AddRow([-11, 89]);
  Chart3.Data.AddRow([-10, -55]);
  Chart3.Data.AddRow([-9, 34]);
  Chart3.Data.AddRow([-8, -21]);
  Chart3.Data.AddRow([-7, 13]);
  Chart3.Data.AddRow([-6, -8]);
  Chart3.Data.AddRow([-5, 5]);
  Chart3.Data.AddRow([-4, -3]);
  Chart3.Data.AddRow([-3, 2]);
  Chart3.Data.AddRow([-2, -1]);
  Chart3.Data.AddRow([-1, 1]);
  Chart3.Data.AddRow([0, 0]);
  Chart3.Data.AddRow([1, 1]);
  Chart3.Data.AddRow([2, 1]);
  Chart3.Data.AddRow([3, 2]);
  Chart3.Data.AddRow([4, 3]);
  Chart3.Data.AddRow([5, 5]);
  Chart3.Data.AddRow([6, 8]);
  Chart3.Data.AddRow([7, 13]);
  Chart3.Data.AddRow([8, 21]);
  Chart3.Data.AddRow([9, 34]);
  Chart3.Data.AddRow([10, 55]);
  Chart3.Data.AddRow([11, 89]);
  Chart3.Data.AddRow([12, 144]);
  Chart3.Data.AddRow([13, 233]);
  Chart3.Data.AddRow([14, 377]);
  Chart3.Data.AddRow([15, 610]);
  Chart3.Data.AddRow([16, 987]);

  Chart3.Options.Title('Fibonacci Numbers in Linear Scale');
  Chart3.Options.Legend('position', 'none');
  Chart3.Options.PointSize(5);
  Chart3.Options.HAxis('gridlines', '{count: -1}');
  Chart3.Options.VAxis('ticks', '[-1000, -500, 0, 500, 1000]');

  // Fibonacci Numbers in Mirror Log Scale
  Chart4 := TcfsGChartProducer.Create;
  Chart4.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;
  Chart4.Data.Assign(Chart3.Data);
  Chart4.Options.Title('Fibonacci Numbers in Mirror Log Scale');
  Chart4.Options.Legend('position', 'none');
  Chart4.Options.PointSize(5);
  Chart4.Options.HAxis('gridlines', '{count: -1}');
  Chart4.Options.VAxis('scaleType', 'mirrorLog');
  Chart4.Options.VAxis('ticks', ' [-1000, -250, -50, -10, 0, 10, 50, 250, 1000]');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 50%;">'
    +   '<div id="Chart1" style="width: 50%"></div>'
    +   '<div id="Chart2" style="flex-grow: 1;"></div>'
    + '</div>'
    +  '<div style="display: flex; width: 100%; height: 50%;">'
    +   '<div id="Chart3" style="width: 50%"></div>'
    +   '<div id="Chart4" style="flex-grow: 1;"></div>'
    + '</div>'
  );
  GChartsFrame.DocumentGenerate('Chart1', Chart1);
  GChartsFrame.DocumentGenerate('Chart2', Chart2);
  GChartsFrame.DocumentGenerate('Chart3', Chart3);
  GChartsFrame.DocumentGenerate('Chart4', Chart4);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Miscellaneous_AxisScale);

end.

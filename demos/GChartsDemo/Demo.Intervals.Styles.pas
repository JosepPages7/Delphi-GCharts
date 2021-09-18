unit Demo.Intervals.Styles;

interface

uses
  System.Classes, System.SysUtils, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Intervals_Styles = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_Intervals_Styles.GenerateChart;
var
  //Defined as TInterfacedObject. No need try..finally
  Data: IcfsGChartData;
  Charts: array[1..12] of IcfsGChartProducer;
  I: Integer;
begin
  // Data
  Data := TcfsGChartData.Create;
  Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'x'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'values'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i0'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i1'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i2'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i2'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i2'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i2')
  ]);

  Data.AddRow([1, 100, 90, 110, 85, 96, 104, 120]);
  Data.AddRow([2, 120, 95, 130, 90, 113, 124, 140]);
  Data.AddRow([3, 130, 105, 140, 100, 117, 133, 139]);
  Data.AddRow([4, 90, 85, 95, 85, 88, 92, 95]);
  Data.AddRow([5, 70, 74, 63, 67, 69, 70, 72]);
  Data.AddRow([6, 30, 39, 22, 21, 28, 34, 40]);
  Data.AddRow([7, 80, 77, 83, 70, 77, 85, 90]);
  Data.AddRow([8, 100, 90, 110, 85, 95, 102, 110]);

  for I := Low(Charts) to High(Charts) do
  begin
    Charts[I] := TcfsGChartProducer.Create;

    Charts[I] := TcfsGChartProducer.Create;
    Charts[I].ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;
    Charts[I].Data.Assign(Data);
  end;

  // Chart1 Options
  Charts[1].Options.Title('Line intervals, tailored');
  Charts[1].Options.LineWidth(4);
  Charts[1].Options.CurveType('function');
  Charts[1].Options.Interval('i0', '{ style:''line'', color:''#D3362D'', lineWidth: 0.5 }');
  Charts[1].Options.Interval('i1', '{ style:''line'', color:''#F1CA3A'', lineWidth: 1 }');
  Charts[1].Options.Interval('i2', '{ style:''line'', color:''#5F9654'', lineWidth: 2 }');
  Charts[1].Options.Legend('position', 'none');

  // Chart2 Options
  Charts[2].Options.Title('Bar intervals, default');
  Charts[2].Options.CurveType('function');
  Charts[2].Options.Series(['color: ''#D9544C''']);
  Charts[2].Options.Intervals('style', 'bars');
  Charts[2].Options.Legend('position', 'none');

  // Chart3 Options
  Charts[3].Options.Title('Box intervals, default');
  Charts[3].Options.CurveType('function');
  Charts[3].Options.Series(['color: ''#1A8763''']);
  Charts[3].Options.Intervals('style', 'boxes');
  Charts[3].Options.Legend('position', 'none');

  // Chart4 Options
  Charts[4].Options.Title('Box intervals, thick');
  Charts[4].Options.CurveType('function');
  Charts[4].Options.LineWidth(4);
  Charts[4].Options.Series(['color: ''#1A8763''']);
  Charts[4].Options.Intervals('style', 'boxes');
  Charts[4].Options.Intervals('barWidth', 0.5);
  Charts[4].Options.Intervals('lineWidth', 4);
  Charts[4].Options.Legend('position', 'none');

  // Chart5 Options
  Charts[5].Options.Title('Stick intervals, default');
  Charts[5].Options.CurveType('function');
  Charts[5].Options.Series(['color: ''#E7711B''']);
  Charts[5].Options.Intervals('style', 'sticks');
  Charts[5].Options.Legend('position', 'none');

  // Chart6 Options
  Charts[6].Options.Title('Points intervals, default');
  Charts[6].Options.CurveType('function');
  Charts[6].Options.LineWidth(4);
  Charts[6].Options.Series(['color: ''#D3362D''']);
  Charts[6].Options.Intervals('style', 'points');
  Charts[6].Options.Intervals('pointSize', 2);
  Charts[6].Options.Legend('position', 'none');

  // Chart7 Options
  Charts[7].Options.Title('Area intervals, default');
  Charts[7].Options.CurveType('function');
  Charts[7].Options.Series(['color: ''#F1CA3A''']);
  Charts[7].Options.Intervals('style', 'area');
  Charts[7].Options.Legend('position', 'none');

  // Chart8 Options
  Charts[8].Options.Title('Multi interval styles');
  Charts[8].Options.CurveType('function');
  Charts[8].Options.Intervals('color', 'series-color');
  Charts[8].Options.Interval('i0', '{ color: ''#4374E0'', style:''bars'', barWidth:0, lineWidth:4, pointSize:10, fillOpacity:1 }');
  Charts[8].Options.Interval('i1', '{ color: ''#E49307'', style:''bars'', barWidth:0, lineWidth:4, pointSize:10, fillOpacity:1 }');
  Charts[8].Options.Interval('i2', '{ style:''area'', ''curveType'':''function'', fillOpacity:0.3 }');
  Charts[8].Options.Legend('position', 'none');

  // Chart9 Options
  Charts[9].Options.Title('Sticks, horizontal');
  Charts[9].Options.CurveType('function');
  Charts[9].Options.LineWidth(4);
  Charts[9].Options.Series(['color: ''#E7711B''']);
  Charts[9].Options.Intervals('lineWidth', 4);
  Charts[9].Options.Intervals('barWidth', 0.5);
  Charts[9].Options.Interval('i2', '{ style:''sticks'', color:''grey'', boxWidth: 2.5, lineWidth: 1 }');
  Charts[9].Options.Legend('position', 'none');

  // Chart10 Options
  Charts[10].Options.Title('Background boxes');
  Charts[10].Options.CurveType('function');
  Charts[10].Options.LineWidth(4);
  Charts[10].Options.Series(['color: ''#1A8763''']);
  Charts[10].Options.Intervals('lineWidth', 2);
  Charts[10].Options.Intervals('barWidth', 0.5);
  Charts[10].Options.Interval('i2', '{ style:''boxes'', color:''grey'', boxWidth: 2.5, lineWidth: 0, fillOpacity: 0.2}');
  Charts[10].Options.Legend('position', 'none');

  // Chart11 Options
  Charts[11].Options.Title('Points and whiskers');
  Charts[11].Options.CurveType('function');
  Charts[11].Options.LineWidth(4);
  Charts[11].Options.Series(['color: ''#D3362D''']);
  Charts[11].Options.Intervals('lineWidth', 2);
  Charts[11].Options.Intervals('barWidth', 0.5);
  Charts[11].Options.Interval('i2', '{ style:''points'', color:''grey'', pointSize: 10, lineWidth: 0, fillOpacity: 0.3}');
  Charts[11].Options.Legend('position', 'none');

  // Chart12 Options
  Charts[12].Options.Title('Box Plot');
  Charts[12].Options.HAxis('gridlines', '{color: ''#fff''}');
  Charts[12].Options.LineWidth(0);
  Charts[12].Options.Series(['color: ''#D3362D''']);
  Charts[12].Options.Intervals('barWidth', 1);
  Charts[12].Options.Intervals('boxWidth', 1);
  Charts[12].Options.Intervals('lineWidth', 2);
  Charts[12].Options.Intervals('style', 'boxes');
  Charts[12].Options.Interval('max', '{style: ''bars'', fillOpacity: 1, color: ''#777''}');
  Charts[12].Options.Interval('min', '{style: ''bars'', fillOpacity: 1, color: ''#777''}');
  Charts[12].Options.Legend('position', 'none');

  // Generate
  GChartsFrame.DocumentInit;

  GChartsFrame.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 33%;">'
    +   '<div id="Chart1" style="width: 25%"></div>'
    +   '<div id="Chart2" style="width: 25%"></div>'
    +   '<div id="Chart3" style="width: 25%"></div>'
    +   '<div id="Chart4" style="width: 25%"></div>'
    + '</div>'
    + '<div style="display: flex; width: 100%; height: 33%;">'
    +   '<div id="Chart5" style="width: 25%"></div>'
    +   '<div id="Chart6" style="width: 25%"></div>'
    +   '<div id="Chart7" style="width: 25%"></div>'
    +   '<div id="Chart8" style="width: 25%"></div>'
    + '</div>'
    + '<div style="display: flex; width: 100%; height: 33%;">'
    +   '<div id="Chart9" style="width: 25%"></div>'
    +   '<div id="Chart10" style="width: 25%"></div>'
    +   '<div id="Chart11" style="width: 25%"></div>'
    +   '<div id="Chart12" style="width: 25%"></div>'
    + '</div>'
  );

  for I := Low(Charts) to High(Charts) do
    GChartsFrame.DocumentGenerate('Chart' + I.ToString, Charts[I]);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Intervals_Styles);

end.

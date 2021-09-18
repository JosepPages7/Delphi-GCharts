unit Demo.Overview;

interface

uses
  System.Classes, System.SysUtils, System.Variants, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Overview = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

uses
  System.DateUtils;

function GetAreaChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_AREA_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Year'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Sales'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Expenses')
  ]);
  Result.Data.AddRow(['2013',  1000,      400]);
  Result.Data.AddRow(['2014',  1170,      460]);
  Result.Data.AddRow(['2015',  660,       1120]);
  Result.Data.AddRow(['2016',  1030,      540]);

  // Options
  Result.Options.ChartArea('width', '50%');
end;

function GetBarChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_BAR_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'City'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '2010 Population'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '2000 Population')
  ]);
  Result.Data.AddRow(['New York City, NY', 8175000, 8008000]);
  Result.Data.AddRow(['Los Angeles, CA', 3792000, 3694000]);
  Result.Data.AddRow(['Chicago, IL', 2695000, 2896000]);
  Result.Data.AddRow(['Houston, TX', 2099000, 1953000]);
  Result.Data.AddRow(['Philadelphia, PA', 1526000, 1517000]);

  // Options
  Result.Options.ChartArea('width', '50%');
  Result.Options.hAxis('minValue', 0);
end;

function GetBubbleChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_BUBBLE_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'ID'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'X'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Y'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Temperature')
  ]);
  Result.Data.AddRow(['',   80,  167,      120]);
  Result.Data.AddRow(['',   79,  136,      130]);
  Result.Data.AddRow(['',   78,  184,      50]);
  Result.Data.AddRow(['',   72,  278,      230]);
  Result.Data.AddRow(['',   81,  200,      210]);
  Result.Data.AddRow(['',   72,  170,      100]);
  Result.Data.AddRow(['',   68,  477,      80]);

  // Options
  Result.Options.ColorAxis('colors', TcfsGChartOptions.ArrayOfStringToJS(['yellow', 'red']));
end;

function GetCalendarChart: IcfsGChartProducer;
var
  M: Integer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_CALENDAR_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Date'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Won/Loss')
  ]);
  for M := 3 to 9 do
  begin
    Result.Data.AddRow([ EncodeDate(2021, M, 13), 37032 ]);
    Result.Data.AddRow([ EncodeDate(2021, M, 14), 38024 ]);
    Result.Data.AddRow([ EncodeDate(2021, M, 15), 38024 ]);
    Result.Data.AddRow([ EncodeDate(2021, M, 16), 38108 ]);
    Result.Data.AddRow([ EncodeDate(2021, M, 17), 38229 ]);
    Result.Data.AddRow([ EncodeDate(2021, M, 18), 38177 ]);
  end;

  // Options
  Result.Options.Title('Calendar');
end;

function GetCandlestickChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_CANDLESTICK_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Month'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, ''),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, ''),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, ''),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '')
  ]);

  Result.Data.AddRow(['Mon', 20, 28, 38, 45]);
  Result.Data.AddRow(['Tue', 31, 38, 55, 66]);
  Result.Data.AddRow(['Wed', 50, 55, 77, 80]);
  Result.Data.AddRow(['Thu', 77, 77, 66, 50]);
  Result.Data.AddRow(['Fri', 68, 66, 22, 15]);

  // Options
  Result.Options.Legend('position', 'none');
end;

function GetColumnChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Element'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Density'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_STYLE)
  ]);
  Result.Data.AddRow(['Copper', 8.94, '#b87333']);            // RGB value
  Result.Data.AddRow(['Silver', 10.49, 'silver']);            // English color name
  Result.Data.AddRow(['Gold', 19.30, 'gold']);
  Result.Data.AddRow(['Platinum', 21.45, 'color: #e5e4e2' ]); // CSS-style declaration  Result.Data.AddRow(['New York City, NY', 8175000, 8008000]);

  Result.Options.Legend('position', 'none');
  Result.Options.Bar('groupWidth', '90%');
end;

function GetComboChart: IcfsGChartProducer;
var
  Series: TArray<string>;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_COMBO_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Month'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Bolivia'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Ecuador'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Madagascar'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Papua New Guinea'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Rwanda'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Average')
  ]);

  Result.Data.AddRow(['2004/05',  165,      938,         522,             998,           450,      614.6]);
  Result.Data.AddRow(['2005/06',  135,      1120,        599,             1268,          288,      682]);
  Result.Data.AddRow(['2006/07',  157,      1167,        587,             807,           397,      623]);
  Result.Data.AddRow(['2007/08',  139,      1110,        615,             968,           215,      609.4]);
  Result.Data.AddRow(['2008/09',  136,      691,         629,             1026,          366,      569.6]);

  // Options
  Result.Options.ChartArea('width', '50%');
  Result.Options.SeriesType('bars');

  SetLength(Series, 6);
  Series[5] := 'type: ''line''';
  Result.Options.Series(Series);
end;

function GetGanttChart: IcfsGChartProducer;

  function DaysToMilliseconds(Days: Integer): Integer;
  begin
    Result := Days * 24 * 60 * 60 * 1000;
  end;

begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_GANTT_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Task ID'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Task Name'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Resource'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Start'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'End'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Duration'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Percent Complete'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Dependencies')
  ]);

  Result.Data.AddRow(['Research', 'Find sources', null, EncodeDate(2015, 1, 1), EncodeDate(2015, 1, 5), null,  100, null]);
  Result.Data.AddRow(['Write', 'Write paper', 'write', null, EncodeDate(2015, 1, 9), daysToMilliseconds(3), 25, 'Research,Outline']);
  Result.Data.AddRow(['Cite', 'Create bibliography', 'write', null, EncodeDate(2015, 1, 7), daysToMilliseconds(1), 20, 'Research']);
  Result.Data.AddRow(['Complete', 'Hand in paper', 'complete', null, EncodeDate(2015, 1, 10), daysToMilliseconds(1), 0, 'Cite,Write']);
  Result.Data.AddRow(['Outline', 'Outline paper', 'write', null, EncodeDate(2015, 1, 6), daysToMilliseconds(1), 100, 'Research']);

  // Options
  Result.Options.Gantt('criticalPathEnabled', true);
  Result.Options.Gantt('criticalPathStyle', '{stroke: ''#e64a19'', strokeWidth: 5}');
end;

function GetDiffChart: IcfsGChartProducer;
var
  OldData: IcfsGChartData;
  NewData: IcfsGChartData;
begin
  // Old Data
  OldData := TcfsGChartData.Create;
  OldData.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Major'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Degrees')
  ]);
  OldData.AddRow(['Business', 256070]);
  OldData.AddRow(['Education', 108034]);
  OldData.AddRow(['Social Sciences & History', 127101]);
  OldData.AddRow(['Health', 81863]);
  OldData.AddRow(['Psychology', 74194]);

  // New Data
  NewData := TcfsGChartData.Create;
  NewData.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Major'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Degrees')
  ]);
  NewData.AddRow(['Business', 358293]);
  NewData.AddRow(['Education', 101265]);
  NewData.AddRow(['Social Sciences & History', 172780]);
  NewData.AddRow(['Health', 129634]);
  NewData.AddRow(['Psychology', 97216]);

  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_PIE_CHART;
  Result.OldData.Assign(OldData);
  Result.Data.Assign(NewData);
  Result.Options.PieSliceText('none');
  Result.Options.Diff('innerCircle', '{ borderFactor: 0.08 }');
end;

function GetPieChart3D: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_PIE_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Tasks'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Hours per Day')
  ]);
  Result.Data.AddRow(['Work', 11]);
  Result.Data.AddRow(['Eat', 2]);
  Result.Data.AddRow(['Commute', 2]);
  Result.Data.AddRow(['Watch TV', 2]);
  Result.Data.AddRow(['Sleep', 7]);

  // Options
  Result.Options.Is3D(True);
end;

function GetGeoChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_GEO_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Country'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Latitude')
  ]);

  Result.Data.AddRow(['Algeria', 36]);
  Result.Data.AddRow(['Angola', -8]);
  Result.Data.AddRow(['Benin', 6]);
  Result.Data.AddRow(['Botswana', -24]);
  Result.Data.AddRow(['Burkina Faso', 12]);
  Result.Data.AddRow(['Burundi', -3]);
  Result.Data.AddRow(['Cameroon', 3]);
  Result.Data.AddRow(['Canary Islands', 28]);
  Result.Data.AddRow(['Cape Verde', 15]);
  Result.Data.AddRow(['Central African Republic', 4]);
  Result.Data.AddRow(['Ceuta', 35]);
  Result.Data.AddRow(['Chad', 12]);
  Result.Data.AddRow(['Comoros', -12]);
  Result.Data.AddRow(['Cote d''Ivoire', 6]);
  Result.Data.AddRow(['Democratic Republic of the Congo', -3]);
  Result.Data.AddRow(['Djibouti', 12]);
  Result.Data.AddRow(['Egypt', 26]);
  Result.Data.AddRow(['Equatorial Guinea', 3]);
  Result.Data.AddRow(['Eritrea', 15]);
  Result.Data.AddRow(['Ethiopia', 9]);
  Result.Data.AddRow(['Gabon', 0]);
  Result.Data.AddRow(['Gambia', 13]);
  Result.Data.AddRow(['Ghana', 5]);
  Result.Data.AddRow(['Guinea', 10]);
  Result.Data.AddRow(['Guinea-Bissau', 12]);
  Result.Data.AddRow(['Kenya', -1]);
  Result.Data.AddRow(['Lesotho', -29]);
  Result.Data.AddRow(['Liberia', 6]);
  Result.Data.AddRow(['Libya', 32]);
  Result.Data.AddRow(['Madagascar', null]);
  Result.Data.AddRow(['Madeira', 33]);
  Result.Data.AddRow(['Malawi', -14]);
  Result.Data.AddRow(['Mali', 12]);
  Result.Data.AddRow(['Mauritania', 18]);
  Result.Data.AddRow(['Mauritius', -20]);
  Result.Data.AddRow(['Mayotte', -13]);
  Result.Data.AddRow(['Melilla', 35]);
  Result.Data.AddRow(['Morocco', 32]);
  Result.Data.AddRow(['Mozambique', -25]);
  Result.Data.AddRow(['Namibia', -22]);
  Result.Data.AddRow(['Niger', 14]);
  Result.Data.AddRow(['Nigeria', 8]);
  Result.Data.AddRow(['Republic of the Congo', -1]);
  Result.Data.AddRow(['Réunion', -21]);
  Result.Data.AddRow(['Rwanda', -2]);
  Result.Data.AddRow(['Saint Helena', -16]);
  Result.Data.AddRow(['São Tomé and Principe', 0]);
  Result.Data.AddRow(['Senegal', 15]);
  Result.Data.AddRow(['Seychelles', -5]);
  Result.Data.AddRow(['Sierra Leone', 8]);
  Result.Data.AddRow(['Somalia', 2]);
  Result.Data.AddRow(['Sudan', 15]);
  Result.Data.AddRow(['South Africa', -30]);
  Result.Data.AddRow(['South Sudan', 5]);
  Result.Data.AddRow(['Swaziland', -26]);
  Result.Data.AddRow(['Tanzania', -6]);
  Result.Data.AddRow(['Togo', 6]);
  Result.Data.AddRow(['Tunisia', 34]);
  Result.Data.AddRow(['Uganda', 1]);
  Result.Data.AddRow(['Western Sahara', 25]);
  Result.Data.AddRow(['Zambia', -15]);
  Result.Data.AddRow(['Zimbabwe', -18]);

  // Options
  Result.Options.Region('002'); // Africa
  Result.Options.ColorAxis('colors', '[''#00853f'', ''black'', ''#e31b23'']');
  Result.Options.BackgroundColor('#81d4fa');
  Result.Options.DefaultColor('#f5f5f5');
  Result.Options.DatalessRegionColor('#f8bbd0');
end;

function GetTimelineChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_TIMELINE_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Room'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Name'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDateTime, 'Start'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDateTime, 'End')
  ]);

  Result.Data.AddRow([ 'Magnolia Room', 'Beginning JavaScript',       EncodeTime(12,0,0,0),  EncodeTime(13,30,0,0) ]);
  Result.Data.AddRow([ 'Magnolia Room', 'Intermediate JavaScript',    EncodeTime(14,0,0,0),  EncodeTime(15,30,0,0) ]);
  Result.Data.AddRow([ 'Magnolia Room', 'Advanced JavaScript',        EncodeTime(16,0,0,0),  EncodeTime(17,30,0,0) ]);
  Result.Data.AddRow([ 'Willow Room',   'Beginning Google Charts',    EncodeTime(12,30,0,0), EncodeTime(14,0,0,0) ]);
  Result.Data.AddRow([ 'Willow Room',   'Intermediate Google Charts', EncodeTime(14,30,0,0), EncodeTime(16,0,0,0) ]);
  Result.Data.AddRow([ 'Willow Room',   'Advanced Google Charts',     EncodeTime(16,30,0,0), EncodeTime(18,0,0,0) ]);

  // Options
  Result.Options.Timeline('colorByRowLabel', True);
end;

function GetIntervalsChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'x'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'values'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i0'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i1'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i2'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i2'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i2'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '', TcfsGChartDataCol.ROLE_INTERVAL, 'i2')
  ]);

  Result.Data.AddRow([1, 100, 90, 110, 85, 96, 104, 120]);
  Result.Data.AddRow([2, 120, 95, 130, 90, 113, 124, 140]);
  Result.Data.AddRow([3, 130, 105, 140, 100, 117, 133, 139]);
  Result.Data.AddRow([4, 90, 85, 95, 85, 88, 92, 95]);
  Result.Data.AddRow([5, 70, 74, 63, 67, 69, 70, 72]);
  Result.Data.AddRow([6, 30, 39, 22, 21, 28, 34, 40]);
  Result.Data.AddRow([7, 80, 77, 83, 70, 77, 85, 90]);
  Result.Data.AddRow([8, 100, 90, 110, 85, 95, 102, 110]);

  // Options
  Result.Options.CurveType('function');
  Result.Options.LineWidth(4);
  Result.Options.Intervals('style', 'line');
  Result.Options.Legend('position', 'none');
end;

function GetOrgChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_ORG_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Name'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Manager'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'ToolTip')
  ]);

  Result.Data.AddRow;
  Result.Data.SetValue(0, 'Mike', 'Mike<div style="color:red; font-style:italic">President</div>');
  Result.Data.SetValue(1, '');
  Result.Data.SetValue(2, 'The President');

  Result.Data.AddRow;
  Result.Data.SetValue(0, 'Jim', 'Jim<div style="color:red; font-style:italic">Vice President</div>');
  Result.Data.SetValue(1, 'Mike');
  Result.Data.SetValue(2, 'VP');

  Result.Data.AddRow;
  Result.Data.SetValue(0, 'Alice');
  Result.Data.SetValue(1, 'Mike');
  Result.Data.SetValue(2, '');

  Result.Data.AddRow;
  Result.Data.SetValue(0, 'Bob');
  Result.Data.SetValue(1, 'Jim');
  Result.Data.SetValue(2, 'Bob Sponge');

  Result.Data.AddRow;
  Result.Data.SetValue(0, 'Carol');
  Result.Data.SetValue(1, 'Bob');
  Result.Data.SetValue(2, '');

  Result.Options.AllowHtml(True);
end;

function GetMaterialLineChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_MATERIAL_LINE_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Day'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Guardians of the Galaxy'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'The Avengers'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Transformers: Age of Extinction')
  ]);

  Result.Data.AddRow([1,  37.8, 80.8, 41.8]);
  Result.Data.AddRow([2,  30.9, 69.5, 32.4]);
  Result.Data.AddRow([3,  25.4,   57, 25.7]);
  Result.Data.AddRow([4,  11.7, 18.8, 10.5]);
  Result.Data.AddRow([5,  11.9, 17.6, 10.4]);
  Result.Data.AddRow([6,   8.8, 13.6,  7.7]);
  Result.Data.AddRow([7,   7.6, 12.3,  9.6]);
  Result.Data.AddRow([8,  12.3, 29.2, 10.6]);
  Result.Data.AddRow([9,  16.9, 42.9, 14.8]);
  Result.Data.AddRow([10, 12.8, 30.9, 11.6]);
  Result.Data.AddRow([11,  5.3,  7.9,  4.7]);
  Result.Data.AddRow([12,  6.6,  8.4,  5.2]);
  Result.Data.AddRow([13,  4.8,  6.3,  3.6]);
  Result.Data.AddRow([14,  4.2,  6.2,  3.4]);

  // Options
  //Result.Options.Title('Box Office Earnings in First Two Weeks of Opening');
  //Result.Options.Subtitle('in millions of dollars (USD)');
end;

function GetLineChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'X'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Dogs'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Cats')
  ]);
  Result.Data.AddRow([0, 0, 0]);
  Result.Data.AddRow([1, 10, 5]);
  Result.Data.AddRow([2, 23, 15]);
  Result.Data.AddRow([3, 17, 9]);
  Result.Data.AddRow([4, 18, 10]);
  Result.Data.AddRow([5, 9, 5]);
  Result.Data.AddRow([6, 11, 3]);
  Result.Data.AddRow([7, 27, 19]);
  Result.Data.AddRow([8, 33, 25]);
  Result.Data.AddRow([9, 40, 32]);
  Result.Data.AddRow([10, 32, 24]);
  Result.Data.AddRow([11, 35, 27]);
  Result.Data.AddRow([12, 30, 22]);
  Result.Data.AddRow([13, 40, 32]);
  Result.Data.AddRow([14, 42, 34]);
  Result.Data.AddRow([15, 47, 39]);
  Result.Data.AddRow([16, 44, 36]);
  Result.Data.AddRow([17, 48, 40]);
  Result.Data.AddRow([18, 52, 44]);
  Result.Data.AddRow([19, 54, 46]);
  Result.Data.AddRow([20, 42, 34]);
  Result.Data.AddRow([21, 55, 47]);
  Result.Data.AddRow([22, 56, 48]);
  Result.Data.AddRow([23, 57, 49]);
  Result.Data.AddRow([24, 60, 52]);
  Result.Data.AddRow([25, 50, 42]);
  Result.Data.AddRow([26, 52, 44]);
  Result.Data.AddRow([27, 51, 43]);
  Result.Data.AddRow([28, 49, 41]);
  Result.Data.AddRow([29, 53, 45]);
  Result.Data.AddRow([30, 55, 47]);
  Result.Data.AddRow([31, 60, 52]);
  Result.Data.AddRow([32, 61, 53]);
  Result.Data.AddRow([33, 59, 51]);
  Result.Data.AddRow([34, 62, 54]);
  Result.Data.AddRow([35, 65, 57]);
  Result.Data.AddRow([36, 62, 54]);
  Result.Data.AddRow([37, 58, 50]);
  Result.Data.AddRow([38, 55, 47]);
  Result.Data.AddRow([39, 61, 53]);
  Result.Data.AddRow([40, 64, 56]);
  Result.Data.AddRow([41, 65, 57]);
  Result.Data.AddRow([42, 63, 55]);
  Result.Data.AddRow([43, 66, 58]);
  Result.Data.AddRow([44, 67, 59]);
  Result.Data.AddRow([45, 69, 61]);
  Result.Data.AddRow([46, 69, 61]);
  Result.Data.AddRow([47, 70, 62]);
  Result.Data.AddRow([48, 72, 64]);
  Result.Data.AddRow([49, 68, 60]);
  Result.Data.AddRow([50, 66, 58]);
  Result.Data.AddRow([51, 65, 57]);
  Result.Data.AddRow([52, 67, 59]);
  Result.Data.AddRow([53, 70, 62]);
  Result.Data.AddRow([54, 71, 63]);
  Result.Data.AddRow([55, 72, 64]);
  Result.Data.AddRow([56, 73, 65]);
  Result.Data.AddRow([57, 75, 67]);
  Result.Data.AddRow([58, 70, 62]);
  Result.Data.AddRow([59, 68, 60]);
  Result.Data.AddRow([60, 64, 56]);
  Result.Data.AddRow([61, 60, 52]);
  Result.Data.AddRow([62, 65, 57]);
  Result.Data.AddRow([63, 67, 59]);
  Result.Data.AddRow([64, 68, 60]);
  Result.Data.AddRow([65, 69, 61]);
  Result.Data.AddRow([66, 70, 62]);
  Result.Data.AddRow([67, 72, 64]);
  Result.Data.AddRow([68, 75, 67]);
  Result.Data.AddRow([69, 80, 72]);

  Result.Options.TrendLines(['type: ''exponential'', color: ''#333'', opacity: 1', 'type: ''linear'', color: ''#111'', opacity: .3']);
end;

function GetSankeyDiagram: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_SANKEY_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'From'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'To'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Weight')
  ]);

  Result.Data.AddRow([ 'A', 'X', 5 ]);
  Result.Data.AddRow([ 'A', 'Y', 7 ]);
  Result.Data.AddRow([ 'A', 'Z', 6 ]);
  Result.Data.AddRow([ 'B', 'X', 2 ]);
  Result.Data.AddRow([ 'B', 'Y', 9 ]);
  Result.Data.AddRow([ 'B', 'Z', 4 ]);
end;

function GetChartBarFormat: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_TABLE_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Department'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Revenues')
  ]);

  Result.Data.AddRow;
  Result.Data.SetValue(0, 'Shoes');
  Result.Data.SetValue(1, 10700);

  Result.Data.AddRow;
  Result.Data.SetValue(0, 'Sports');
  Result.Data.SetValue(1, -15400);

  Result.Data.AddRow;
  Result.Data.SetValue(0, 'Toys');
  Result.Data.SetValue(1, 12500);

  Result.Data.AddRow;
  Result.Data.SetValue(0, 'Electronics');
  Result.Data.SetValue(1, -2100);

  Result.Data.AddRow;
  Result.Data.SetValue(0, 'Food');
  Result.Data.SetValue(1, 22600);

  Result.Data.AddRow;
  Result.Data.SetValue(0, 'Art');
  Result.Data.SetValue(1, 1100);

  // Options
  Result.Options.AllowHtml(True);
  //Result.Options.SetAsBoolean('showRowNumber', True);
  //Result.Options.Width(350);

  // Formatter
  Result.ScripCodeBeforeCallDraw :=
      'var formatter = new google.visualization.BarFormat({width: 120});'
    + 'formatter.format(data, 1);'
  ;
end;

function GetWaterfallChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_CANDLESTICK_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Month'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, ''),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, ''),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, ''),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '')
  ]);
  Result.Data.AddRow(['Mon', 28, 28, 38, 38]);
  Result.Data.AddRow(['Tue', 38, 38, 55, 55]);
  Result.Data.AddRow(['Wed', 55, 55, 77, 77]);
  Result.Data.AddRow(['Thu', 77, 77, 66, 66]);
  Result.Data.AddRow(['Fri', 66, 66, 22, 22]);

  // Options
  Result.Options.Legend('position', 'none');
  Result.Options.Bar('groupWidth', '100%');
  Result.Options.Candlestick('fallingColor', '{ strokeWidth: 0, fill: ''#a52714'' }'); // red
  Result.Options.Candlestick('risingColor', '{ strokeWidth: 0, fill: ''#0f9d58'' }');  // green
end;

function GetTreeMapChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_TREE_MAP_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Location'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Parent'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Market trade volume (size)'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Market increase/decrease (color)')
  ]);

  Result.Data.AddRow(['Global',     null,       0,   0]);
  Result.Data.AddRow(['America',   'Global',    0,   0]);
  Result.Data.AddRow(['Europe',    'Global',    0,   0]);
  Result.Data.AddRow(['Asia',      'Global',    0,   0]);
  Result.Data.AddRow(['Australia', 'Global',    0,   0]);
  Result.Data.AddRow(['Africa',    'Global',    0,   0]);
  Result.Data.AddRow(['Brazil',    'America',   11,  10]);
  Result.Data.AddRow(['USA',       'America',   52,  31]);
  Result.Data.AddRow(['Mexico',    'America',   24,  12]);
  Result.Data.AddRow(['Canada',    'America',   16,  -23]);
  Result.Data.AddRow(['France',    'Europe',    42,  -11]);
  Result.Data.AddRow(['Germany',   'Europe',    31,  -2]);
  Result.Data.AddRow(['Sweden',    'Europe',    22,  -13]);
  Result.Data.AddRow(['Italy',     'Europe',    17,  4]);
  Result.Data.AddRow(['UK',        'Europe',    21,  -5]);
  Result.Data.AddRow(['China',     'Asia',      36,  4]);
  Result.Data.AddRow(['Japan',     'Asia',      20,  -12]);
  Result.Data.AddRow(['India',     'Asia',      40,  63]);
  Result.Data.AddRow(['Laos',      'Asia',      4,   34]);
  Result.Data.AddRow(['Mongolia',  'Asia',      1,   -5]);
  Result.Data.AddRow(['Israel',    'Asia',      12,  24]);
  Result.Data.AddRow(['Iran',      'Asia',      18,  13]);
  Result.Data.AddRow(['Pakistan',  'Asia',      11,  -52]);
  Result.Data.AddRow(['Egypt',     'Africa',    21,  0]);
  Result.Data.AddRow(['S. Africa', 'Africa',    30,  43]);
  Result.Data.AddRow(['Sudan',     'Africa',    12,  2]);
  Result.Data.AddRow(['Congo',     'Africa',    10,  12]);
  Result.Data.AddRow(['Zaire',     'Africa',    8,   10]);

  // Options
  Result.Options.SetAsQuotedStr('minColor', '#f00');
  Result.Options.SetAsQuotedStr('midColor', '#ddd');
  Result.Options.SetAsQuotedStr('maxColor', '#0d0');
  Result.Options.SetAsInteger('headerHeight', 15);
  Result.Options.SetAsQuotedStr('fontColor', 'black');
  Result.Options.SetAsBoolean('showScale', True);
  Result.Options.SetAsUnQuotedStr('generateTooltip', 'showFullTooltip');

  Result.ScripCodeAfterCallDraw :=
    'function showFullTooltip(row, size, value) {'
      + 'return ''<div style="background:#fd9; padding:10px; border-style:solid">'
      + '<span style="font-family:Courier"><b>'' + data.getValue(row, 0) +'
      + '''</b>, '' + data.getValue(row, 1) + '', '' + data.getValue(row, 2)'
    + '}'
  ;
end;


function GetMaterialScatterChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_MATERIAL_SCATTER_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, ''),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '')
  ]);

  Result.Data.AddRow([0, 67]);
  Result.Data.AddRow([1, 88]);
  Result.Data.AddRow([2, 77]);
  Result.Data.AddRow([3, 93]);
  Result.Data.AddRow([4, 85]);
  Result.Data.AddRow([5, 91]);
  Result.Data.AddRow([6, 71]);
  Result.Data.AddRow([7, 78]);
  Result.Data.AddRow([8, 93]);
  Result.Data.AddRow([9, 80]);
  Result.Data.AddRow([10, 82]);
  Result.Data.AddRow([0, 75]);
  Result.Data.AddRow([5, 80]);
  Result.Data.AddRow([3, 90]);
  Result.Data.AddRow([1, 72]);
  Result.Data.AddRow([5, 75]);
  Result.Data.AddRow([6, 68]);
  Result.Data.AddRow([7, 98]);
  Result.Data.AddRow([3, 82]);
  Result.Data.AddRow([9, 94]);
  Result.Data.AddRow([2, 79]);
  Result.Data.AddRow([2, 95]);
  Result.Data.AddRow([2, 86]);
  Result.Data.AddRow([3, 67]);
  Result.Data.AddRow([4, 60]);
  Result.Data.AddRow([2, 80]);
  Result.Data.AddRow([6, 92]);
  Result.Data.AddRow([2, 81]);
  Result.Data.AddRow([8, 79]);
  Result.Data.AddRow([9, 83]);
  Result.Data.AddRow([3, 75]);
  Result.Data.AddRow([1, 80]);
  Result.Data.AddRow([3, 71]);
  Result.Data.AddRow([3, 89]);
  Result.Data.AddRow([4, 92]);
  Result.Data.AddRow([5, 85]);
  Result.Data.AddRow([6, 92]);
  Result.Data.AddRow([7, 78]);
  Result.Data.AddRow([6, 95]);
  Result.Data.AddRow([3, 81]);
  Result.Data.AddRow([0, 64]);
  Result.Data.AddRow([4, 85]);
  Result.Data.AddRow([2, 83]);
  Result.Data.AddRow([3, 96]);
  Result.Data.AddRow([4, 77]);
  Result.Data.AddRow([5, 89]);
  Result.Data.AddRow([4, 89]);
  Result.Data.AddRow([7, 84]);
  Result.Data.AddRow([4, 92]);
  Result.Data.AddRow([9, 98]);

  Result.Options.Legend('position', 'none');
end;

function GetWordTreesChart: IcfsGChartProducer;
begin
  Result := TcfsGChartProducer.Create;
  Result.ClassChartType := TcfsGChartProducer.CLASS_WORD_TREE_CHART;

  // Data
  Result.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Phrases')
  ]);

  Result.Data.AddRow(['cats are better than dogs']);
  Result.Data.AddRow(['cats eat kibble']);
  Result.Data.AddRow(['cats are better than hamsters']);
  Result.Data.AddRow(['cats are awesome']);
  Result.Data.AddRow(['cats are people too']);
  Result.Data.AddRow(['cats eat mice']);
  Result.Data.AddRow(['cats meowing']);
  Result.Data.AddRow(['cats in the cradle']);
  Result.Data.AddRow(['cats eat mice']);
  Result.Data.AddRow(['cats in the cradle lyrics']);
  Result.Data.AddRow(['cats eat kibble']);
  Result.Data.AddRow(['cats for adoption']);
  Result.Data.AddRow(['cats are family']);
  Result.Data.AddRow(['cats eat mice']);
  Result.Data.AddRow(['cats are better than kittens']);
  Result.Data.AddRow(['cats are evil']);
  Result.Data.AddRow(['cats are weird']);
  Result.Data.AddRow(['cats eat mice']);

  // Options
  Result.Options.SetAsObject('wordtree', 'format', '''implicit''');
  Result.Options.SetAsObject('wordtree', 'word', '''cats''');
end;

procedure TDemo_Overview.GenerateChart;
begin
  // Generate
  GChartsFrame.DocumentInit;

  GChartsFrame.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 200px;">'
    +   '<div id="ColumnChart" style="width: 33%"></div>'
    +   '<div id="AreaChart" style="width: 33%"></div>'
    +   '<div id="BubbleChart" style="width: 33%"></div>'
    + '</div>'
    +  '<div style="display: flex; width: 100%; height: 200px;">'
    + '   <div id="CalendarChart" style="width:1000px; height:200px; margin:auto"></div>'
    + '</div>'
    +  '<div style="display: flex; width: 100%; height: 200px;">'
    +   '<div id="CandlestickChart" style="width: 33%"></div>'
    +   '<div id="DiffChart" style="width: 33%"></div>'
    +   '<div id="IntervalsChart" style="width: 33%"></div>'
    + '</div>'
    +  '<div style="display: flex; width: 100%; height: 250px;">'
    + '   <div id="GanttChart" style="width:1000px; height:250px; margin:auto"></div>'
    + '</div>'
    +  '<div style="display: flex; width: 100%; height: 200px;">'
    +   '<div id="BarChart" style="width: 33%"></div>'
    +   '<div id="PieChart3D" style="width: 33%"></div>'
    +   '<div id="GeoChart" style="width: 33%"></div>'
    + '</div>'
    +  '<div style="display: flex; width: 100%; height: 200px;">'
    + '   <div id="TimelineChart" style="width:1000px; height:200px; padding-top:20px; margin:auto"></div>'
    + '</div>'
    +  '<div style="display: flex; width: 100%; height: 200px;">'
    +   '<div id="ComboChart" style="width: 33%"></div>'
    +   '<div id="OrgChart" style="width: 33%"></div>'
    +   '<div id="LineChart" style="width: 33%"></div>'
    + '</div>'
    +  '<div style="display: flex; width: 100%; height: 200px;">'
    +   '<div id="SankeyDiagram" style="width: 33%; padding:25px"></div>'
    +   '<div id="ChartBarFormat" style="width: 33%; padding-left:100px; padding-top:20px; margin:auto"></div>'
    +   '<div id="WaterfallChart" style="width: 33%"></div>'
    + '</div>'
    +  '<div style="display: flex; width: 100%; height: 200px;">'
    +   '<div id="MaterialScatterChart" style="width: 33%"></div>'
    +   '<div id="TreeMapChart" style="width: 33%"></div>'
    +   '<div id="WordTreesChart" style="width: 33%"></div>'
    + '</div>'
  );

  GChartsFrame.DocumentGenerate('AreaChart', GetAreaChart);
  GChartsFrame.DocumentGenerate('BarChart', GetBarChart);
  GChartsFrame.DocumentGenerate('BubbleChart', GetBubbleChart);
  GChartsFrame.DocumentGenerate('CalendarChart', GetCalendarChart);
  GChartsFrame.DocumentGenerate('CandlestickChart', GetCandlestickChart);
  GChartsFrame.DocumentGenerate('ColumnChart', GetColumnChart);
  GChartsFrame.DocumentGenerate('ComboChart', GetComboChart);
  GChartsFrame.DocumentGenerate('GanttChart', GetGanttChart);
  GChartsFrame.DocumentGenerate('DiffChart', GetDiffChart);
  GChartsFrame.DocumentGenerate('PieChart3D', GetPieChart3D);
  GChartsFrame.DocumentGenerate('GeoChart', GetGeoChart);
  GChartsFrame.DocumentGenerate('TimelineChart', GetTimelineChart);
  GChartsFrame.DocumentGenerate('IntervalsChart', GetIntervalsChart);
  GChartsFrame.DocumentGenerate('OrgChart', GetOrgChart);
  GChartsFrame.DocumentGenerate('LineChart', GetLineChart);
  GChartsFrame.DocumentGenerate('SankeyDiagram', GetSankeyDiagram);
  GChartsFrame.DocumentGenerate('ChartBarFormat', GetChartBarFormat);
  GChartsFrame.DocumentGenerate('WaterfallChart', GetWaterfallChart);
  GChartsFrame.DocumentGenerate('TreeMapChart', GetTreeMapChart);
  GChartsFrame.DocumentGenerate('MaterialScatterChart', GetMaterialScatterChart);
  GChartsFrame.DocumentGenerate('WordTreesChart', GetWordTreesChart);

  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Overview);

end.

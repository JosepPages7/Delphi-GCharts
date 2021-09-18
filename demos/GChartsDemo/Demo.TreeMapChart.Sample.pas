unit Demo.TreeMapChart.Sample;

interface

uses
  System.Classes, System.Variants, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_TreeMapChart_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_TreeMapChart_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer;  // Defined as TInterfacedObject No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_TREE_MAP_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Location'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Parent'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Market trade volume (size)'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Market increase/decrease (color)')
  ]);

  Chart.Data.AddRow(['Global',     null,       0,   0]);
  Chart.Data.AddRow(['America',   'Global',    0,   0]);
  Chart.Data.AddRow(['Europe',    'Global',    0,   0]);
  Chart.Data.AddRow(['Asia',      'Global',    0,   0]);
  Chart.Data.AddRow(['Australia', 'Global',    0,   0]);
  Chart.Data.AddRow(['Africa',    'Global',    0,   0]);
  Chart.Data.AddRow(['Brazil',    'America',   11,  10]);
  Chart.Data.AddRow(['USA',       'America',   52,  31]);
  Chart.Data.AddRow(['Mexico',    'America',   24,  12]);
  Chart.Data.AddRow(['Canada',    'America',   16,  -23]);
  Chart.Data.AddRow(['France',    'Europe',    42,  -11]);
  Chart.Data.AddRow(['Germany',   'Europe',    31,  -2]);
  Chart.Data.AddRow(['Sweden',    'Europe',    22,  -13]);
  Chart.Data.AddRow(['Italy',     'Europe',    17,  4]);
  Chart.Data.AddRow(['UK',        'Europe',    21,  -5]);
  Chart.Data.AddRow(['China',     'Asia',      36,  4]);
  Chart.Data.AddRow(['Japan',     'Asia',      20,  -12]);
  Chart.Data.AddRow(['India',     'Asia',      40,  63]);
  Chart.Data.AddRow(['Laos',      'Asia',      4,   34]);
  Chart.Data.AddRow(['Mongolia',  'Asia',      1,   -5]);
  Chart.Data.AddRow(['Israel',    'Asia',      12,  24]);
  Chart.Data.AddRow(['Iran',      'Asia',      18,  13]);
  Chart.Data.AddRow(['Pakistan',  'Asia',      11,  -52]);
  Chart.Data.AddRow(['Egypt',     'Africa',    21,  0]);
  Chart.Data.AddRow(['S. Africa', 'Africa',    30,  43]);
  Chart.Data.AddRow(['Sudan',     'Africa',    12,  2]);
  Chart.Data.AddRow(['Congo',     'Africa',    10,  12]);
  Chart.Data.AddRow(['Zaire',     'Africa',    8,   10]);

  // Options
  Chart.Options.Title('Market trade volume (size)');
  Chart.Options.SetAsQuotedStr('minColor', '#f00');
  Chart.Options.SetAsQuotedStr('midColor', '#ddd');
  Chart.Options.SetAsQuotedStr('maxColor', '#0d0');
  Chart.Options.SetAsInteger('headerHeight', 15);
  Chart.Options.SetAsQuotedStr('fontColor', 'black');
  Chart.Options.SetAsBoolean('showScale', True);
  Chart.Options.SetAsUnQuotedStr('generateTooltip', 'showFullTooltip');

  Chart.ScripCodeAfterCallDraw :=
    'function showFullTooltip(row, size, value) {'
      + 'return ''<div style="background:#fd9; padding:10px; border-style:solid">'
      + '<span style="font-family:Courier"><b>'' + data.getValue(row, 0) +'
      + '''</b>, '' + data.getValue(row, 1) + '', '' + data.getValue(row, 2)'
    + '}'
  ;

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
      '<div id="Chart" style="width:600px; height:600px; margin:auto;position: absolute;top:0;bottom: 0;left: 0;right: 0;"></div>'
    + '<div style="width:100%;font-family: Arial; font-size:14px; text-align: center;"><br><br>NOTE: click to drilldown / click button right to rollup</div>'
  );
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_TreeMapChart_Sample);

end.

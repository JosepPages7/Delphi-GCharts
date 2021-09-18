unit Demo.ColumnChart.Customizable;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_ColumnChart_Customizable = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_ColumnChart_Customizable.GenerateChart;
var
  // Defined as TInterfacedObject No need try..finally
  Data: IcfsGChartData;
  ChartColors: IcfsGChartProducer;
  ChartAxisTickColors: IcfsGChartProducer;
begin
  // Data
  Data := TcfsGChartData.Create;
  Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'City'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '2010 Population'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '2000 Population')
  ]);
  Data.AddRow(['New York City, NY', 8175000, 8008000]);
  Data.AddRow(['Los Angeles, CA', 3792000, 3694000]);
  Data.AddRow(['Chicago, IL', 2695000, 2896000]);
  Data.AddRow(['Houston, TX', 2099000, 1953000]);
  Data.AddRow(['Philadelphia, PA', 1526000, 1517000]);

  // ChartColors
  ChartColors := TcfsGChartProducer.Create;
  ChartColors.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  ChartColors.Data.Assign(Data);
  ChartColors.Options.Title('Customizable bar colors');
  ChartColors.Options.ChartArea('width', '50%');
  ChartColors.Options.Colors(['#b0120a', '#ffab91']);
  ChartColors.Options.hAxis('title', 'Total Population');
  ChartColors.Options.hAxis('minValue', 0);
  ChartColors.Options.vAxis('title', 'City');


  // ChartAxisTickColors
  ChartAxisTickColors := TcfsGChartProducer.Create;
  ChartAxisTickColors.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  ChartAxisTickColors.Data.Assign(ChartColors.Data);
  ChartAxisTickColors.Options.Title('Customizable axis and tick labels');
  ChartAxisTickColors.Options.TitleTextStyle(TcfsGChartOptions.TextStyleToJSObject('gray', 12, true, false));
  ChartAxisTickColors.Options.Legend('textStyle', TcfsGChartOptions.TextStyleToJSObject('gray', 12, true, false));
  ChartAxisTickColors.Options.ChartArea('width', '50%');
  ChartAxisTickColors.Options.Colors(['#b0120a', '#ffab91']);
  ChartAxisTickColors.Options.hAxis('title', 'Total Population');
  ChartAxisTickColors.Options.hAxis('textStyle', '{bold: true, fontSize: 10, color: ''silver''}');
  ChartAxisTickColors.Options.hAxis('titleTextStyle', '{bold: true, italic: false, fontSize: 11, color: ''silver''}');
  ChartAxisTickColors.Options.hAxis('minValue', 0);
  ChartAxisTickColors.Options.vAxis('title', 'City');
  ChartAxisTickColors.Options.vAxis('textStyle', '{bold: true, fontSize: 11, color: ''gray''}');
  ChartAxisTickColors.Options.vAxis('titleTextStyle', '{bold: true, italic: false, fontSize: 12, color: ''gray''}');
  ChartAxisTickColors.Options.DataOpacity(0.6);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
        '<div id="ChartColors" style="width: 100%;height: 50%;"></div>'
    +   '<div id="ChartAxisTickColors" style="width: 100%;height: 50%;">'
  );
  GChartsFrame.DocumentGenerate('ChartColors', ChartColors);
  GChartsFrame.DocumentGenerate('ChartAxisTickColors', ChartAxisTickColors);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_ColumnChart_Customizable);

end.

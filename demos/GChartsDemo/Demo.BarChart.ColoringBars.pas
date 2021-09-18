unit Demo.BarChart.ColoringBars;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_BarChart_ColoringBars = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_BarChart_ColoringBars.GenerateChart;
var
  // Defined as TInterfacedObject No need try..finally
  DefaultChart: IcfsGChartProducer;
  ChartColors: IcfsGChartProducer;
begin
  // DefaultChart
  DefaultChart := TcfsGChartProducer.Create;
  DefaultChart.ClassChartType := TcfsGChartProducer.CLASS_BAR_CHART;
  DefaultChart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Element'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Density')
  ]);
  DefaultChart.Data.AddRow(['Copper', 8.94]);
  DefaultChart.Data.AddRow(['Silver', 10.49]);
  DefaultChart.Data.AddRow(['Gold', 19.30]);
  DefaultChart.Data.AddRow(['Platinum', 21.45]);
  DefaultChart.Options.Title('Density of Precious Metals, in g/cm^3');
  DefaultChart.Options.Legend('position', 'none');
  DefaultChart.Options.Bar('groupWidth', '90%');


  // ChartColors
  ChartColors := TcfsGChartProducer.Create;
  ChartColors.ClassChartType := TcfsGChartProducer.CLASS_BAR_CHART;
  ChartColors.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Element'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Density'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_STYLE)
  ]);
  ChartColors.Data.AddRow(['Copper', 8.94, '#b87333']);            // RGB value
  ChartColors.Data.AddRow(['Silver', 10.49, 'silver']);            // English color name
  ChartColors.Data.AddRow(['Gold', 19.30, 'gold']);
  ChartColors.Data.AddRow(['Platinum', 21.45, 'color: #e5e4e2' ]); // CSS-style declaration  ChartColors.Data.AddRow(['New York City, NY', 8175000, 8008000]);
  ChartColors.Options.Title('Density of Precious Metals, in g/cm^3');
  ChartColors.Options.Legend('position', 'none');
  ChartColors.Options.Bar('groupWidth', '90%');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
        '<div id="DefaultChart" style="width: 100%;height: 50%;"></div>'
    +   '<div id="ChartColors" style="width: 100%;height: 50%;">'
  );
  GChartsFrame.DocumentGenerate('DefaultChart', DefaultChart);
  GChartsFrame.DocumentGenerate('ChartColors', ChartColors);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_BarChart_ColoringBars);

end.


unit Demo.Miscellaneous.Animation;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Miscellaneous_Animation = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_Miscellaneous_Animation.GenerateChart;
var
  AreaChart, BarChart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  // AreaChart
  AreaChart := TcfsGChartProducer.Create;
  AreaChart.ClassChartType := TcfsGChartProducer.CLASS_AREA_CHART;

  AreaChart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Year'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Sales'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Expenses')
  ]);
  AreaChart.Data.AddRow(['2013',  1000,      400]);
  AreaChart.Data.AddRow(['2014',  1170,      460]);
  AreaChart.Data.AddRow(['2015',  660,       1120]);
  AreaChart.Data.AddRow(['2016',  1030,      540]);

  AreaChart.Options.Title('Company Performance');
  AreaChart.Options.TitleTextStyle(TcfsGChartOptions.TextStyleToJSObject('gray', 12, true, false));
  AreaChart.Options.Legend('textStyle', TcfsGChartOptions.TextStyleToJSObject('gray', 12, true, false));
  AreaChart.Options.ChartArea('width', '50%');
  AreaChart.Options.Colors(['green', 'red']);
  AreaChart.Options.hAxis('textStyle', '{bold: true, fontSize: 11, color: ''gray''}');
  AreaChart.Options.hAxis('minValue', 0);
  AreaChart.Options.vAxis('textStyle', '{bold: true, fontSize: 10, color: ''silver''}');
  AreaChart.Options.Animation('startup', True);
  AreaChart.Options.Animation('duration', 1000);
  AreaChart.Options.Animation('easing', 'out');

  // BarChart
  BarChart := TcfsGChartProducer.Create;
  BarChart.ClassChartType := TcfsGChartProducer.CLASS_BAR_CHART;

  BarChart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Year'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Sales'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Expenses')
  ]);
  BarChart.Data.AddRow(['2013',  1000,      400]);
  BarChart.Data.AddRow(['2014',  1170,      460]);
  BarChart.Data.AddRow(['2015',  660,       1120]);
  BarChart.Data.AddRow(['2016',  1030,      540]);

  BarChart.Options.Title('Company Performance');
  BarChart.Options.TitleTextStyle(TcfsGChartOptions.TextStyleToJSObject('gray', 12, true, false));
  BarChart.Options.Legend('textStyle', TcfsGChartOptions.TextStyleToJSObject('gray', 12, true, false));
  BarChart.Options.ChartArea('width', '50%');
  BarChart.Options.Colors(['green', 'red']);
  BarChart.Options.hAxis('textStyle', '{bold: true, fontSize: 10, color: ''silver''}');
  BarChart.Options.hAxis('minValue', 0);
  BarChart.Options.vAxis('textStyle', '{bold: true, fontSize: 11, color: ''gray''}');
  BarChart.Options.DataOpacity(0.5);
  BarChart.Options.Animation('startup', True);
  BarChart.Options.Animation('duration', 1000);
  BarChart.Options.Animation('easing', 'in');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
        '<div id="AreaChart" style="width: 100%;height: 50%;"></div>'
    +   '<div id="BarChart" style="width: 100%;height: 50%;"></div>'
  );
  GChartsFrame.DocumentGenerate('AreaChart', AreaChart);
  GChartsFrame.DocumentGenerate('BarChart', BarChart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Miscellaneous_Animation);

end.

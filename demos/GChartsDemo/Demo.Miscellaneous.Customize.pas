unit Demo.Miscellaneous.Customize;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Miscellaneous_Customize = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_Miscellaneous_Customize.GenerateChart;
var
  PieChart, BarChart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  // PieChart
  PieChart := TcfsGChartProducer.Create;
  PieChart.ClassChartType := TcfsGChartProducer.CLASS_PIE_CHART;
  PieChart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Topping'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Slices')
  ]);

  PieChart.Data.AddRow(['Mushrooms', 3]);
  PieChart.Data.AddRow(['Onions', 1]);
  PieChart.Data.AddRow(['Olives', 1]);
  PieChart.Data.AddRow(['Zucchini', 1]);
  PieChart.Data.AddRow(['Pepperoni', 2]);

  PieChart.Options.Title('How Much Pizza I Ate Last Night');
  PieChart.Options.TitleTextStyle(TcfsGChartOptions.TextStyleToJSObject('gray', 12, true, false));
  PieChart.Options.Legend('textStyle', TcfsGChartOptions.TextStyleToJSObject('gray', 12, true, false));
  PieChart.Options.PieSliceTextStyle(TcfsGChartOptions.TextStyleToJSObject('', 12, true, false));
  PieChart.Options.Colors(['#e0440e', '#e6693e', '#ec8f6e', '#f3b49f', '#f6c7b6']);
  PieChart.Options.Is3D(True);

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
  BarChart.Options.hAxis('title', 'milions €');
  BarChart.Options.hAxis('textStyle', '{bold: true, fontSize: 10, color: ''silver''}');
  BarChart.Options.hAxis('titleTextStyle', '{bold: true, italic: false, fontSize: 11, color: ''silver''}');
  BarChart.Options.hAxis('minValue', 0);
  BarChart.Options.vAxis('title', 'Year');
  BarChart.Options.vAxis('textStyle', '{bold: true, fontSize: 11, color: ''gray''}');
  BarChart.Options.vAxis('titleTextStyle', '{bold: true, italic: false, fontSize: 12, color: ''gray''}');
  BarChart.Options.DataOpacity(0.5);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
        '<div id="PieChart" style="width: 100%;height: 50%;"></div>'
    +   '<div id="BarChart" style="width: 100%;height: 50%;"></div>'
  );
  GChartsFrame.DocumentGenerate('PieChart', PieChart);
  GChartsFrame.DocumentGenerate('BarChart', BarChart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Miscellaneous_Customize);

end.

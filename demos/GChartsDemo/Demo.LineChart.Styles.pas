unit Demo.LineChart.Styles;

interface

uses
  System.Classes, System.SysUtils, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_LineChart_Styles = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_LineChart_Styles.GenerateChart;
var
  //Defined as TInterfacedObject. No need try..finally
  Data: IcfsGChartData;
  Chart1: IcfsGChartProducer;
  Chart2: IcfsGChartProducer;
  Chart3: IcfsGChartProducer;
begin
  // Data
  Data := TcfsGChartData.Create;
  Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'X'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Dogs'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Cats')
  ]);
  Data.AddRow([0, 0, 0]);
  Data.AddRow([1, 10, 5]);
  Data.AddRow([2, 23, 15]);
  Data.AddRow([3, 17, 9]);
  Data.AddRow([4, 18, 10]);
  Data.AddRow([5, 9, 5]);
  Data.AddRow([6, 11, 3]);
  Data.AddRow([7, 27, 19]);
  Data.AddRow([8, 33, 25]);
  Data.AddRow([9, 40, 32]);
  Data.AddRow([10, 32, 24]);
  Data.AddRow([11, 35, 27]);
  Data.AddRow([12, 30, 22]);
  Data.AddRow([13, 40, 32]);
  Data.AddRow([14, 42, 34]);
  Data.AddRow([15, 47, 39]);
  Data.AddRow([16, 44, 36]);
  Data.AddRow([17, 48, 40]);
  Data.AddRow([18, 52, 44]);
  Data.AddRow([19, 54, 46]);
  Data.AddRow([20, 42, 34]);
  Data.AddRow([21, 55, 47]);
  Data.AddRow([22, 56, 48]);
  Data.AddRow([23, 57, 49]);
  Data.AddRow([24, 60, 52]);
  Data.AddRow([25, 50, 42]);
  Data.AddRow([26, 52, 44]);
  Data.AddRow([27, 51, 43]);
  Data.AddRow([28, 49, 41]);
  Data.AddRow([29, 53, 45]);
  Data.AddRow([30, 55, 47]);
  Data.AddRow([31, 60, 52]);
  Data.AddRow([32, 61, 53]);
  Data.AddRow([33, 59, 51]);
  Data.AddRow([34, 62, 54]);
  Data.AddRow([35, 65, 57]);
  Data.AddRow([36, 62, 54]);
  Data.AddRow([37, 58, 50]);
  Data.AddRow([38, 55, 47]);
  Data.AddRow([39, 61, 53]);
  Data.AddRow([40, 64, 56]);
  Data.AddRow([41, 65, 57]);
  Data.AddRow([42, 63, 55]);
  Data.AddRow([43, 66, 58]);
  Data.AddRow([44, 67, 59]);
  Data.AddRow([45, 69, 61]);
  Data.AddRow([46, 69, 61]);
  Data.AddRow([47, 70, 62]);
  Data.AddRow([48, 72, 64]);
  Data.AddRow([49, 68, 60]);
  Data.AddRow([50, 66, 58]);
  Data.AddRow([51, 65, 57]);
  Data.AddRow([52, 67, 59]);
  Data.AddRow([53, 70, 62]);
  Data.AddRow([54, 71, 63]);
  Data.AddRow([55, 72, 64]);
  Data.AddRow([56, 73, 65]);
  Data.AddRow([57, 75, 67]);
  Data.AddRow([58, 70, 62]);
  Data.AddRow([59, 68, 60]);
  Data.AddRow([60, 64, 56]);
  Data.AddRow([61, 60, 52]);
  Data.AddRow([62, 65, 57]);
  Data.AddRow([63, 67, 59]);
  Data.AddRow([64, 68, 60]);
  Data.AddRow([65, 69, 61]);
  Data.AddRow([66, 70, 62]);
  Data.AddRow([67, 72, 64]);
  Data.AddRow([68, 75, 67]);
  Data.AddRow([69, 80, 72]);


  // Chart1
  Chart1 := TcfsGChartProducer.Create;
  Chart1.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;
  Chart1.Data.Assign(Data);
  Chart1.Options.Title('Customizable background color');
  Chart1.Options.HAxis('title', 'time');
  Chart1.Options.VAxis('title', 'Popularity');
  Chart1.Options.BackgroundColor('#f1f8e9');

  // Chart2
  Chart2 := TcfsGChartProducer.Create;
  Chart2.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;
  Chart2.Data.Assign(Data);
  Chart2.Options.Title('Customizable axis and tick labels');
  Chart2.Options.HAxis('title', 'time');
  Chart2.Options.HAxis('textStyle', TcfsGChartOptions.TextStyleToJSObject('#01579b', 16, True, False, 'Arial') );
  Chart2.Options.HAxis('titleTextStyle', TcfsGChartOptions.TextStyleToJSObject('#01579b', 20, True, False, 'Arial') );
  Chart2.Options.VAxis('title', 'Popularity');
  Chart2.Options.VAxis('textStyle', TcfsGChartOptions.TextStyleToJSObject('#1a237e', 16, True, False, 'Arial') );
  Chart2.Options.VAxis('titleTextStyle', TcfsGChartOptions.TextStyleToJSObject('#1a237e', 30, True, False, 'Arial') );
  Chart2.Options.Colors(['#a52714', '#097138']);

  // Chart3
  Chart3 := TcfsGChartProducer.Create;
  Chart3.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;
  Chart3.Data.Assign(Data);
  Chart3.Options.Title('Customizable Lines');
  Chart3.Options.HAxis('title', 'time');
  Chart3.Options.VAxis('title', 'Popularity');
  Chart3.Options.Colors(['#a52714', '#097138']);
  Chart3.Options.Series(['lineWidth: 10, lineDashStyle: [5, 1, 5]', 'lineWidth: 5, lineDashStyle: [7, 2, 4, 3]']);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 50%;">'
    +   '<div id="Chart1" style="width: 50%"></div>'
    +   '<div id="Chart2" style="flex-grow: 1;"></div>'
    + '</div>'
    +  '<div style="display: flex; width: 100%; height: 50%;">'
    +   '<div style="width: 25%"></div>'
    +     '<div id="Chart3" style="width: 50%"></div>'
    +   '<div style="width: 25%"></div>'
    + '</div>'
  );

  GChartsFrame.DocumentGenerate('Chart1', Chart1);
  GChartsFrame.DocumentGenerate('Chart2', Chart2);
  GChartsFrame.DocumentGenerate('Chart3', Chart3);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_LineChart_Styles);

end.

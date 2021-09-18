unit Demo.BubbleChart.CustomizingLabels;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_BubbleChart_CustomizingLabels = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_BubbleChart_CustomizingLabels.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_BUBBLE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'ID'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Life Expectancy'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Fertility Rate'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Region'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Population')
  ]);
  Chart.Data.AddRow(['CAN',    80.66,              1.67,      'North America',  33739900]);
  Chart.Data.AddRow(['DEU',    79.84,              1.36,      'Europe',         81902307]);
  Chart.Data.AddRow(['DNK',    78.6,               1.84,      'Europe',         5523095]);
  Chart.Data.AddRow(['EGY',    72.73,              2.78,      'Middle East',    79716203]);
  Chart.Data.AddRow(['GBR',    80.05,              2,         'Europe',         61801570]);
  Chart.Data.AddRow(['IRN',    72.49,              1.7,       'Middle East',    73137148]);
  Chart.Data.AddRow(['IRQ',    68.09,              4.77,      'Middle East',    31090763]);
  Chart.Data.AddRow(['ISR',    81.55,              2.96,      'Middle East',    7485600]);
  Chart.Data.AddRow(['RUS',    68.6,               1.54,      'Europe',         141850000]);
  Chart.Data.AddRow(['USA',    78.09,              2.05,      'North America',  307007000]);

  // Options
  Chart.Options.Title('Fertility rate vs life expectancy in selected countries (2010).' +
          ' X=Life Expectancy, Y=Fertility, Bubble size=Population, Bubble color=Region');
  Chart.Options.HAxis('title', 'Life Expectancy');
  Chart.Options.VAxis('title', 'Fertility Rate');
  Chart.Options.Bubble('textStyle', TcfsGChartOptions.TextStyleToJSObject('white', 12, true, true, 'Times-Roman', 'none'));

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_BubbleChart_CustomizingLabels);

end.

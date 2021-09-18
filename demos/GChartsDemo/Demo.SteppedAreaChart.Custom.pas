unit Demo.SteppedAreaChart.Custom;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_SteppedAreaChart_Custom = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_SteppedAreaChart_Custom.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_STEPPED_AREA_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Year'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Colonial'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Victorian'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Modern'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Contemporary')
  ]);

  Chart.Data.AddRow(['2013', 5.2, 3.6, 2.8, 2]);
  Chart.Data.AddRow(['2014', 5.6, 4.0, 2.8, 3]);
  Chart.Data.AddRow(['2015', 7.2, 2.2, 2.2, 6]);
  Chart.Data.AddRow(['2016', 8.0, 1.7, 0.8, 4]);


  // Options
  Chart.Options.BackgroundColor('#ddd');
  Chart.Options.Legend('position', 'bottom');
  Chart.Options.Colors(['#4374E0', '#53A8FB', '#F1CA3A', '#E49307']);
  Chart.Options.SetAsBoolean('connectSteps', False);
  Chart.Options.IsStacked(True);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_SteppedAreaChart_Custom);

end.

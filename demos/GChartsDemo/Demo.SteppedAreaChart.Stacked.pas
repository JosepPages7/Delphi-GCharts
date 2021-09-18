unit Demo.SteppedAreaChart.Stacked;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_AreaChart_Stacked = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_AreaChart_Stacked.GenerateChart;
var
  // Defined as TInterfacedObject No need try..finally
  Data: IcfsGChartData;
  ChartStacked: IcfsGChartProducer;
  ChartStacked100: IcfsGChartProducer;
begin
  // Data
  Data := TcfsGChartData.Create;
  // Data
  Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Year'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Colonial'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Victorian'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Modern'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Contemporary')
  ]);

  Data.AddRow(['2013', 5.2, 3.6, 2.8, 2]);
  Data.AddRow(['2014', 5.6, 4.0, 2.8, 3]);
  Data.AddRow(['2015', 7.2, 2.2, 2.2, 6]);
  Data.AddRow(['2016', 8.0, 1.7, 0.8, 4]);


  // Chart Stacked
  ChartStacked := TcfsGChartProducer.Create;
  ChartStacked.ClassChartType := TcfsGChartProducer.CLASS_STEPPED_AREA_CHART;
  ChartStacked.Data.Assign(Data);

  ChartStacked.Options.Title('Stacked');
  ChartStacked.Options.IsStacked(True);
  ChartStacked.Options.Legend('position', 'top');
  ChartStacked.Options.Legend('maxLines', 3);
  ChartStacked.Options.VAxis('minValue', 0);

  // ChartStacked 100 %
  ChartStacked100 := TcfsGChartProducer.Create;
  ChartStacked100.ClassChartType := TcfsGChartProducer.CLASS_STEPPED_AREA_CHART;
  ChartStacked100.Data.Assign(Data);

  ChartStacked100.Options.Title('Stacked 100%');
  ChartStacked100.Options.IsStacked('relative');
  ChartStacked100.Options.Legend('position', 'top');
  ChartStacked100.Options.Legend('maxLines', 3);
  ChartStacked100.Options.VAxis('minValue', 0);
  ChartStacked100.Options.VAxis('ticks', '[0, .3, .6, .9, 1]');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 100%;">'
    +   '<div id="ChartStacked" style="width: 50%"></div>'
    +   '<div id="ChartStacked100" style="flex-grow: 1;"></div>'
    + '</div>'
  );
  GChartsFrame.DocumentGenerate('ChartStacked', ChartStacked);
  GChartsFrame.DocumentGenerate('ChartStacked100', ChartStacked100);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_AreaChart_Stacked);

end.

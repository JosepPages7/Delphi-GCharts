unit Demo.AreaChart.Stacking;

interface

uses
  System.Classes, System.Variants, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_AreaChart_Stacking = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_AreaChart_Stacking.GenerateChart;
var
  // Defined as TInterfacedObject No need try..finally
  Data: IcfsGChartData;
  ChartNotStacked: IcfsGChartProducer;
  ChartStacked: IcfsGChartProducer;
  ChartStacked100: IcfsGChartProducer;
begin
  // Data
  Data := TcfsGChartData.Create;
  Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Year'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Cars'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Trucks'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Drones'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Segways')
  ]);
  Data.AddRow(['2013',  870,  460,  10, 120]);
  Data.AddRow(['2014',  460,  720,  20, 60]);
  Data.AddRow(['2015',  930,  540, 140, 30]);
  Data.AddRow(['2016', 1000,  400,  80, Null]);


  // Chart Not Stacked
  ChartNotStacked := TcfsGChartProducer.Create;
  ChartNotStacked.ClassChartType := TcfsGChartProducer.CLASS_AREA_CHART;
  ChartNotStacked.Data.Assign(Data);

  ChartNotStacked.Options.Title('Not Stacked');
  ChartNotStacked.Options.Legend('position', 'top');
  ChartNotStacked.Options.Legend('maxLines', 3);

  // Chart Stacked
  ChartStacked := TcfsGChartProducer.Create;
  ChartStacked.ClassChartType := TcfsGChartProducer.CLASS_AREA_CHART;
  ChartStacked.Data.Assign(Data);

  ChartStacked.Options.Title('Stacked');
  ChartStacked.Options.IsStacked(True);
  ChartStacked.Options.Legend('position', 'top');
  ChartStacked.Options.Legend('maxLines', 3);

  // ChartStacked 100 %
  ChartStacked100 := TcfsGChartProducer.Create;
  ChartStacked100.ClassChartType := TcfsGChartProducer.CLASS_AREA_CHART;
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
      '<div style="display: flex; width: 100%; height: 50%;">'
    +   '<div id="ChartStacked" style="width: 50%"></div>'
    +   '<div id="ChartStacked100" style="flex-grow: 1;"></div>'
    + '</div>'
    +  '<div style="display: flex; width: 100%; height: 50%;">'
    +   '<div style="width: 25%"></div>'
    +     '<div id="ChartNotStacked" style="width: 50%"></div>'
    +   '<div style="width: 25%"></div>'
    + '</div>'
  );
  GChartsFrame.DocumentGenerate('ChartNotStacked', ChartNotStacked);
  GChartsFrame.DocumentGenerate('ChartStacked', ChartStacked);
  GChartsFrame.DocumentGenerate('ChartStacked100', ChartStacked100);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_AreaChart_Stacking);

end.

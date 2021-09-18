unit Demo.ColumnChart.Stacking;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_ColumnChart_Stacking = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_ColumnChart_Stacking.GenerateChart;
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
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Fantasy & Sci Fi'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Romance'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Mystery/Crime'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'General'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Western'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Literature')
  ]);
  Data.AddRow(['2010', 10, 24, 20, 32, 18, 5]);
  Data.AddRow(['2020', 16, 22, 23, 30, 16, 9]);
  Data.AddRow(['2030', 28, 19, 29, 30, 12, 13]);


  // Chart Not Stacked
  ChartNotStacked := TcfsGChartProducer.Create;
  ChartNotStacked.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  ChartNotStacked.Data.Assign(Data);
  ChartNotStacked.Options.Title('Not Stacked');
  ChartNotStacked.Options.Legend('position', 'top');
  ChartNotStacked.Options.Legend('maxLines', 3);

  // Chart Stacked
  ChartStacked := TcfsGChartProducer.Create;
  ChartStacked.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  ChartStacked.Data.Assign(Data);
  ChartStacked.Options.Title('Stacked');
  ChartStacked.Options.IsStacked(True);
  ChartStacked.Options.Legend('position', 'top');
  ChartStacked.Options.Legend('maxLines', 3);
  //ChartStacked.Options.Bar('groupWidth', '75%');

  // ChartStacked 100 %
  ChartStacked100 := TcfsGChartProducer.Create;
  ChartStacked100.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  ChartStacked100.Data.Assign(Data);
  ChartStacked100.Options.Title('Stacked 100%');
  ChartStacked100.Options.IsStacked('percent');
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
  RegisterClass(TDemo_ColumnChart_Stacking);

end.

unit Demo.MaterialScatterChart.DualY;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_MaterialScatterChart_DualY = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_MaterialScatterChart_DualY.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_MATERIAL_SCATTER_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Student ID'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Hours Studied'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Final')
  ]);

  Chart.Data.AddRow([0, 0, 67]);
  Chart.Data.AddRow([1, 1, 88]);
  Chart.Data.AddRow([2, 2, 77]);
  Chart.Data.AddRow([3, 3, 93]);
  Chart.Data.AddRow([4, 4, 85]);
  Chart.Data.AddRow([5, 5, 91]);
  Chart.Data.AddRow([6, 6, 71]);
  Chart.Data.AddRow([7, 7, 78]);
  Chart.Data.AddRow([8, 8, 93]);
  Chart.Data.AddRow([9, 9, 80]);
  Chart.Data.AddRow([10, 10, 82]);
  Chart.Data.AddRow([11, 0, 75]);
  Chart.Data.AddRow([12, 5, 80]);
  Chart.Data.AddRow([13, 3, 90]);
  Chart.Data.AddRow([14, 1, 72]);
  Chart.Data.AddRow([15, 5, 75]);
  Chart.Data.AddRow([16, 6, 68]);
  Chart.Data.AddRow([17, 7, 98]);
  Chart.Data.AddRow([18, 3, 82]);
  Chart.Data.AddRow([19, 9, 94]);
  Chart.Data.AddRow([20, 2, 79]);
  Chart.Data.AddRow([21, 2, 95]);
  Chart.Data.AddRow([22, 2, 86]);
  Chart.Data.AddRow([23, 3, 67]);
  Chart.Data.AddRow([24, 4, 60]);
  Chart.Data.AddRow([25, 2, 80]);
  Chart.Data.AddRow([26, 6, 92]);
  Chart.Data.AddRow([27, 2, 81]);
  Chart.Data.AddRow([28, 8, 79]);
  Chart.Data.AddRow([29, 9, 83]);

  // Options
  Chart.Options.Title('Students'' Final Grades');
  Chart.Options.Subtitle('based on hours studied');
  Chart.Options.Series(['0: {axis: ''hours studied''}', '1: {axis: ''final grade''}']);
  Chart.Options.Axes('y', '{''hours studied'': {label: ''Hours Studied'' }, ''final grade'': {label: ''Final Exam Grade''}}');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
    '<div  style="width:80%; height:10%"></div>' +
    '<div id="Chart" style="width:80%; height:80%;margin: auto"></div>' +
    '<div  style="width:80%; height:10%"></div>'
  );
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_MaterialScatterChart_DualY);

end.

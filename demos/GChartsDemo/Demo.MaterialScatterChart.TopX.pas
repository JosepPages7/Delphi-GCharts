unit Demo.MaterialScatterChart.TopX;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_MaterialScatterChart_TopX = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_MaterialScatterChart_TopX.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_MATERIAL_SCATTER_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Hours Studied'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Final')
  ]);

  Chart.Data.AddRow([0, 67]);
  Chart.Data.AddRow([1, 88]);
  Chart.Data.AddRow([2, 77]);
  Chart.Data.AddRow([3, 93]);
  Chart.Data.AddRow([4, 85]);
  Chart.Data.AddRow([5, 91]);
  Chart.Data.AddRow([6, 71]);
  Chart.Data.AddRow([7, 78]);
  Chart.Data.AddRow([8, 93]);
  Chart.Data.AddRow([9, 80]);
  Chart.Data.AddRow([10, 82]);
  Chart.Data.AddRow([0, 75]);
  Chart.Data.AddRow([5, 80]);
  Chart.Data.AddRow([3, 90]);
  Chart.Data.AddRow([1, 72]);
  Chart.Data.AddRow([5, 75]);
  Chart.Data.AddRow([6, 68]);
  Chart.Data.AddRow([7, 98]);
  Chart.Data.AddRow([3, 82]);
  Chart.Data.AddRow([9, 94]);
  Chart.Data.AddRow([2, 79]);
  Chart.Data.AddRow([2, 95]);
  Chart.Data.AddRow([2, 86]);
  Chart.Data.AddRow([3, 67]);
  Chart.Data.AddRow([4, 60]);
  Chart.Data.AddRow([2, 80]);
  Chart.Data.AddRow([6, 92]);
  Chart.Data.AddRow([2, 81]);
  Chart.Data.AddRow([8, 79]);
  Chart.Data.AddRow([9, 83]);
  Chart.Data.AddRow([3, 75]);
  Chart.Data.AddRow([1, 80]);
  Chart.Data.AddRow([3, 71]);
  Chart.Data.AddRow([3, 89]);
  Chart.Data.AddRow([4, 92]);
  Chart.Data.AddRow([5, 85]);
  Chart.Data.AddRow([6, 92]);
  Chart.Data.AddRow([7, 78]);
  Chart.Data.AddRow([6, 95]);
  Chart.Data.AddRow([3, 81]);
  Chart.Data.AddRow([0, 64]);
  Chart.Data.AddRow([4, 85]);
  Chart.Data.AddRow([2, 83]);
  Chart.Data.AddRow([3, 96]);
  Chart.Data.AddRow([4, 77]);
  Chart.Data.AddRow([5, 89]);
  Chart.Data.AddRow([4, 89]);
  Chart.Data.AddRow([7, 84]);
  Chart.Data.AddRow([4, 92]);
  Chart.Data.AddRow([9, 98]);

  // Options
  Chart.Options.Title('Students'' Final Grades');
  Chart.Options.Subtitle('based on hours studied');
  Chart.Options.HAxis('title', 'Hours Studied');
  Chart.Options.VAxis('title', 'Grade');
  Chart.Options.Axes('x', '{0: {side: ''top''}}');

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
  RegisterClass(TDemo_MaterialScatterChart_TopX);

end.

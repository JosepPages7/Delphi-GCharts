unit Demo.Miscellaneous.CustomizePoints;

interface

uses
  System.Classes, System.Variants, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Miscellaneous_CustomizePoints = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_Miscellaneous_CustomizePoints.GenerateChart;
var
  Chart1, Chart2, Chart3, Chart4: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  // Customizing Points
  Chart1 := TcfsGChartProducer.Create;
  Chart1.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  Chart1.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'X'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '1'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '2'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '3'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '4'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '5'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '6')
  ]);
  Chart1.Data.AddRow([1, 2, null, null, null, null, null]);
  Chart1.Data.AddRow([2, null, 3, null, null, null, null]);
  Chart1.Data.AddRow([3, null, null, 4, null, null, null]);
  Chart1.Data.AddRow([4, null, null, null, 5, null, null]);
  Chart1.Data.AddRow([5, null, null, null, null, 6, null]);
  Chart1.Data.AddRow([6, null, null, null, null, null, 7]);

  Chart1.Options.Title('Customizing Points');
  Chart1.Options.Legend('position', 'none');
  Chart1.Options.PointSize(30);
  Chart1.Options.Series([
    '0: { pointShape: ''circle'' }',
    '1: { pointShape: ''triangle'' }',
    '2: { pointShape: ''square'' }',
    '3: { pointShape: ''diamond'' }',
    '4: { pointShape: ''star'' }',
    '5: { pointShape: ''polygon'' }'
  ]);

  // Customizing Point in one series Chart
  Chart2 := TcfsGChartProducer.Create;
  Chart2.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  Chart2.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'X'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Y')
  ]);
  Chart2.Data.AddRow([1, 3]);
  Chart2.Data.AddRow([2, 2.5]);
  Chart2.Data.AddRow([3, 3]);
  Chart2.Data.AddRow([4, 4]);
  Chart2.Data.AddRow([5, 4]);
  Chart2.Data.AddRow([6, 3]);
  Chart2.Data.AddRow([7, 2.5]);
  Chart2.Data.AddRow([8, 3]);

  Chart2.Options.Title('Customizing Point in one series Chart');
  Chart2.Options.Legend('position', 'none');
  Chart2.Options.HAxis('minValue', 0);
  Chart2.Options.HAxis('maxValue', 9);
  Chart2.Options.CurveType('function');
  Chart2.Options.pointSize(20);

  // Customizing Point Shape in one series Chart
  Chart3 := TcfsGChartProducer.Create;
  Chart3.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  Chart3.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'X'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Y')
  ]);
  Chart3.Data.AddRow([1, 3]);
  Chart3.Data.AddRow([2, 2.5]);
  Chart3.Data.AddRow([3, 3]);
  Chart3.Data.AddRow([4, 4]);
  Chart3.Data.AddRow([5, 4]);
  Chart3.Data.AddRow([6, 3]);
  Chart3.Data.AddRow([7, 2.5]);
  Chart3.Data.AddRow([8, 3]);

  Chart3.Options.Title('Customizing Point Shape in one series Chart');
  Chart3.Options.Legend('position', 'none');
  Chart3.Options.HAxis('minValue', 0);
  Chart3.Options.HAxis('maxValue', 9);
  Chart3.Options.Colors(['#795548']);
  Chart3.Options.pointSize(20);
  Chart3.Options.PointShape('square');

  // Customizing individual points
  Chart4 := TcfsGChartProducer.Create;
  Chart4.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  Chart4.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'X'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Y'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_STYLE)
  ]);
  Chart4.Data.AddRow([1, 3, null]);
  Chart4.Data.AddRow([2, 2.5, null]);
  Chart4.Data.AddRow([3, 3, null]);
  Chart4.Data.AddRow([4, 4, null]);
  Chart4.Data.AddRow([5, 4, null]);
  Chart4.Data.AddRow([6, 3, 'point { size: 18; shape-type: star; fill-color: #a52714; }']);
  Chart4.Data.AddRow([7, 2.5, null]);
  Chart4.Data.AddRow([8, 3, null]);

  Chart4.Options.Title('Customizing individual points');
  Chart4.Options.Legend('position', 'none');
  Chart4.Options.CurveType('function');
  Chart4.Options.PointSize(7);
  Chart4.Options.DataOpacity(0.3);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 50%;">'
    +   '<div id="Chart1" style="width: 50%"></div>'
    +   '<div id="Chart2" style="flex-grow: 1;"></div>'
    + '</div>'
    +  '<div style="display: flex; width: 100%; height: 50%;">'
    +   '<div id="Chart3" style="width: 50%"></div>'
    +   '<div id="Chart4" style="flex-grow: 1;"></div>'
    + '</div>'
  );
  GChartsFrame.DocumentGenerate('Chart1', Chart1);
  GChartsFrame.DocumentGenerate('Chart2', Chart2);
  GChartsFrame.DocumentGenerate('Chart3', Chart3);
  GChartsFrame.DocumentGenerate('Chart4', Chart4);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Miscellaneous_CustomizePoints);

end.

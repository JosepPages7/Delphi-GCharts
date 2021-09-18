unit Demo.Miscellaneous.CustomizeLines;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Miscellaneous_CustomizeLines = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_Miscellaneous_CustomizeLines.GenerateChart;
var
  Data: IcfsGChartData;
  Chart1, Chart2, Chart3, Chart4: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  // Data
  Data := TcfsGChartData.Create;
  Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'X'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '1'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '2'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '3'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '4'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '5'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, '6')
  ]);

  Data.AddRow([1, 2, 3, 4, 5, 6, 7]);
  Data.AddRow([2, 3, 4, 5, 6, 7, 8]);
  Data.AddRow([3, 4, 5, 6, 7, 8, 9]);
  Data.AddRow([4, 5, 6, 7, 8, 9, 10]);
  Data.AddRow([5, 6, 7, 8, 9, 10, 11]);
  Data.AddRow([6, 7, 8, 9, 10, 11, 12]);


  // Changing the Color
  Chart1 := TcfsGChartProducer.Create;
  Chart1.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;
  Chart1.Data.Assign(Data);
  Chart1.Options.Title('Changing the Color');
  Chart1.Options.Legend('position', 'none');
  Chart1.Options.Colors(['#e2431e', '#e7711b', '#f1ca3a', '#6f9654', '#1c91c0', '#43459d']);
  (*Chart1.Options.Series([
    '0: { color: ''#e2431e'' }',
    '1: { color: ''#e7711b'' }',
    '2: { color: ''#f1ca3a'' }',
    '3: { color: ''#6f9654'' }',
    '4: { color: ''#1c91c0'' }',
    '5: { color: ''#43459d'' }'
  ]);*)

  // Changing the Thickness
  Chart2 := TcfsGChartProducer.Create;
  Chart2.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;
  Chart2.Data.Assign(Data);
  Chart2.Options.Title('Changing the Thickness');
  Chart2.Options.Legend('position', 'none');
  Chart2.Options.LineWidth(10);
  Chart2.Options.Colors(['#e2431e', '#d3362d', '#e7711b', '#e49307', '#e49307', '#b9c246']);


  // Changing the Thickness of line width of a series
  Chart3 := TcfsGChartProducer.Create;
  Chart3.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;
  Chart3.Data.Assign(Data);
  Chart3.Options.Title('Changing the Thickness series line ');
  Chart3.Options.Legend('position', 'none');
  Chart3.Options.LineWidth(10);
  Chart3.Options.Series([
    '0: { lineWidth: 1 }',
    '1: { lineWidth: 2 }',
    '2: { lineWidth: 4 }',
    '3: { lineWidth: 8 }',
    '4: { lineWidth: 16 }',
    '5: { lineWidth: 24 }'
  ]);
  Chart3.Options.Colors(['#e2431e', '#d3362d', '#e7711b', '#e49307', '#e49307', '#b9c246']);

  // Dashed Lines
  Chart4 := TcfsGChartProducer.Create;
  Chart4.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;
  Chart4.Data.Assign(Data);
  Chart4.Options.Title('Dashed Lines');
  Chart4.Options.Legend('position', 'none');
  Chart4.Options.LineWidth(4);
  Chart4.Options.Series([
    '0: { lineDashStyle: [1, 1] }',
    '1: { lineDashStyle: [2, 2] }',
    '2: { lineDashStyle: [4, 4] }',
    '3: { lineDashStyle: [5, 1, 3] }',
    '4: { lineDashStyle: [4, 1] }',
    '5: { lineDashStyle: [10, 2] }'
  ]);
  Chart4.Options.Colors(['#e2431e', '#f1ca3a', '#6f9654', '#1c91c0', '#4374e0', '#5c3292']);

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
  RegisterClass(TDemo_Miscellaneous_CustomizeLines);

end.

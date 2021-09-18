unit Demo.ColumnChart.LabelingColumns;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_ColumnChart_LabelingColumns = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_ColumnChart_LabelingColumns.GenerateChart;
var
  Chart1, Chart2: IcfsGChartProducer; // Defined as TInterfacedObject No need try..finally
begin
  // Chart 1
  Chart1 := TcfsGChartProducer.Create;
  Chart1.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  Chart1.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Element'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Density'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_STYLE),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION)
  ]);
  Chart1.Data.AddRow(['Copper', 8.94, '#b87333', 'Cu']);            // RGB value
  Chart1.Data.AddRow(['Silver', 10.49, 'silver', 'Ag']);            // English color name
  Chart1.Data.AddRow(['Gold', 19.30, 'gold', 'Au']);
  Chart1.Data.AddRow(['Platinum', 21.45, 'color: #e5e4e2', 'Pt' ]); // CSS-style declaration
  Chart1.Options.Title('Density of Precious Metals, in g/cm^3');
  Chart1.Options.Legend('position', 'none');
  Chart1.Options.Bar('groupWidth', '95%');

  // Chart 2
  Chart2 := TcfsGChartProducer.Create;
  Chart2.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  Chart2.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Element'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Density'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_STYLE)
  ]);
  Chart2.Data.AddRow(['Copper', 8.94, '#b87333']);            // RGB value
  Chart2.Data.AddRow(['Silver', 10.49, 'silver']);            // English color name
  Chart2.Data.AddRow(['Gold', 19.30, 'gold']);
  Chart2.Data.AddRow(['Platinum', 21.45, 'color: #e5e4e2']); // CSS-style declaration
  Chart2.Options.Title('Density of Precious Metals, in g/cm^3');
  Chart2.Options.Legend('position', 'none');
  Chart2.Options.Bar('groupWidth', '95%');
  Chart2.ScripCodeBeforeCallDraw :=
      'var view = new google.visualization.DataView(data);'
    + 'view.setColumns([0, 1,  { calc: "stringify", sourceColumn: 1, type: "string", role: "annotation" }, 2]);'
  ;

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
        '<div id="Chart1" style="width: 100%;height: 50%;"></div>'
    +   '<div id="Chart2" style="width: 100%;height: 50%;">'
  );
  GChartsFrame.DocumentGenerate('Chart1', Chart1);
  GChartsFrame.DocumentGenerate('Chart2', Chart2);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_ColumnChart_LabelingColumns);

end.

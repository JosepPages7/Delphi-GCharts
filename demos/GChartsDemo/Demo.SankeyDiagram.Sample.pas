unit Demo.SankeyDiagram.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_SankeyDiagram_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_SankeyDiagram_Sample.GenerateChart;
var
  Diagram: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Diagram := TcfsGChartProducer.Create;
  Diagram.ClassChartType := TcfsGChartProducer.CLASS_SANKEY_CHART;

  // Data
  Diagram.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'From'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'To'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Weight')
  ]);

  Diagram.Data.AddRow([ 'A', 'X', 5 ]);
  Diagram.Data.AddRow([ 'A', 'Y', 7 ]);
  Diagram.Data.AddRow([ 'A', 'Z', 6 ]);
  Diagram.Data.AddRow([ 'B', 'X', 2 ]);
  Diagram.Data.AddRow([ 'B', 'Y', 9 ]);
  Diagram.Data.AddRow([ 'B', 'Z', 4 ]);

  // Options

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="sankey_div" style="width:600px; height:300px; margin:auto;position: absolute;top:0;bottom: 0;left: 0;right: 0;"></div>');
  GChartsFrame.DocumentGenerate('sankey_div', Diagram);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_SankeyDiagram_Sample);

end.

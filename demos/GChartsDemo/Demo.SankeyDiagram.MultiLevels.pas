unit Demo.SankeyDiagram.MultiLevels;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_SankeyDiagram_MultiLevels = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_SankeyDiagram_MultiLevels.GenerateChart;
var
  Diagram: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
  Colors: string;
begin
  Diagram := TcfsGChartProducer.Create;
  Diagram.ClassChartType := TcfsGChartProducer.CLASS_SANKEY_CHART;

  // Data
  Diagram.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'From'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'To'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Weight')
  ]);

  Diagram.Data.AddRow([ 'Brazil', 'Portugal', 5 ]);
  Diagram.Data.AddRow([ 'Brazil', 'France', 1 ]);
  Diagram.Data.AddRow([ 'Brazil', 'Spain', 1 ]);
  Diagram.Data.AddRow([ 'Brazil', 'England', 1 ]);
  Diagram.Data.AddRow([ 'Canada', 'Portugal', 1 ]);
  Diagram.Data.AddRow([ 'Canada', 'France', 5 ]);
  Diagram.Data.AddRow([ 'Canada', 'England', 1 ]);
  Diagram.Data.AddRow([ 'Mexico', 'Portugal', 1 ]);
  Diagram.Data.AddRow([ 'Mexico', 'France', 1 ]);
  Diagram.Data.AddRow([ 'Mexico', 'Spain', 5 ]);
  Diagram.Data.AddRow([ 'Mexico', 'England', 1 ]);
  Diagram.Data.AddRow([ 'USA', 'Portugal', 1 ]);
  Diagram.Data.AddRow([ 'USA', 'France', 1 ]);
  Diagram.Data.AddRow([ 'USA', 'Spain', 1 ]);
  Diagram.Data.AddRow([ 'USA', 'England', 5 ]);
  Diagram.Data.AddRow([ 'Portugal', 'Angola', 2 ]);
  Diagram.Data.AddRow([ 'Portugal', 'Senegal', 1 ]);
  Diagram.Data.AddRow([ 'Portugal', 'Morocco', 1 ]);
  Diagram.Data.AddRow([ 'Portugal', 'South Africa', 3 ]);
  Diagram.Data.AddRow([ 'France', 'Angola', 1 ]);
  Diagram.Data.AddRow([ 'France', 'Senegal', 3 ]);
  Diagram.Data.AddRow([ 'France', 'Mali', 3 ]);
  Diagram.Data.AddRow([ 'France', 'Morocco', 3 ]);
  Diagram.Data.AddRow([ 'France', 'South Africa', 1 ]);
  Diagram.Data.AddRow([ 'Spain', 'Senegal', 1 ]);
  Diagram.Data.AddRow([ 'Spain', 'Morocco', 3 ]);
  Diagram.Data.AddRow([ 'Spain', 'South Africa', 1 ]);
  Diagram.Data.AddRow([ 'England', 'Angola', 1 ]);
  Diagram.Data.AddRow([ 'England', 'Senegal', 1 ]);
  Diagram.Data.AddRow([ 'England', 'Morocco', 2 ]);
  Diagram.Data.AddRow([ 'England', 'South Africa', 7 ]);
  Diagram.Data.AddRow([ 'South Africa', 'China', 5 ]);
  Diagram.Data.AddRow([ 'South Africa', 'India', 1 ]);
  Diagram.Data.AddRow([ 'South Africa', 'Japan', 3 ]);
  Diagram.Data.AddRow([ 'Angola', 'China', 5 ]);
  Diagram.Data.AddRow([ 'Angola', 'India', 1 ]);
  Diagram.Data.AddRow([ 'Angola', 'Japan', 3 ]);
  Diagram.Data.AddRow([ 'Senegal', 'China', 5 ]);
  Diagram.Data.AddRow([ 'Senegal', 'India', 1 ]);
  Diagram.Data.AddRow([ 'Senegal', 'Japan', 3 ]);
  Diagram.Data.AddRow([ 'Mali', 'China', 5 ]);
  Diagram.Data.AddRow([ 'Mali', 'India', 1 ]);
  Diagram.Data.AddRow([ 'Mali', 'Japan', 3 ]);
  Diagram.Data.AddRow([ 'Morocco', 'China', 5 ]);
  Diagram.Data.AddRow([ 'Morocco', 'India', 1 ]);
  Diagram.Data.AddRow([ 'Morocco', 'Japan', 3 ]);

  // Options
  Colors := '''#a6cee3'', ''#b2df8a'', ''#fb9a99'', ''#fdbf6f'', ''#cab2d6'', ''#ffff99'', ''#1f78b4'', ''#33a02c''';
  Diagram.Options.SetAsObject('sankey', 'node', '{nodePadding: 80, colors: [' + Colors + ']}, link: { colorMode: ''gradient'', colors: [' + Colors + '] }');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
    '<div  style="width:80%; height:5%"></div>' +
    '<div id="sankey_div" style="width:80%; height:90%;margin: auto"></div>' +
    '<div  style="width:80%; height:5%"></div>'
  );
  GChartsFrame.DocumentGenerate('sankey_div', Diagram);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_SankeyDiagram_MultiLevels);

end.

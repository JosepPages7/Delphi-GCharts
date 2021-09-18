unit Demo.WordTrees.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_WordTrees_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_WordTrees_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer;  // Defined as TInterfacedObject No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_WORD_TREE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Phrases')
  ]);

  Chart.Data.AddRow(['cats are better than dogs']);
  Chart.Data.AddRow(['cats eat kibble']);
  Chart.Data.AddRow(['cats are better than hamsters']);
  Chart.Data.AddRow(['cats are awesome']);
  Chart.Data.AddRow(['cats are people too']);
  Chart.Data.AddRow(['cats eat mice']);
  Chart.Data.AddRow(['cats meowing']);
  Chart.Data.AddRow(['cats in the cradle']);
  Chart.Data.AddRow(['cats eat mice']);
  Chart.Data.AddRow(['cats in the cradle lyrics']);
  Chart.Data.AddRow(['cats eat kibble']);
  Chart.Data.AddRow(['cats for adoption']);
  Chart.Data.AddRow(['cats are family']);
  Chart.Data.AddRow(['cats eat mice']);
  Chart.Data.AddRow(['cats are better than kittens']);
  Chart.Data.AddRow(['cats are evil']);
  Chart.Data.AddRow(['cats are weird']);
  Chart.Data.AddRow(['cats eat mice']);

  // Options
  Chart.Options.SetAsObject('wordtree', 'format', '''implicit''');
  Chart.Options.SetAsObject('wordtree', 'word', '''cats''');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="chart_div" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('chart_div', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_WordTrees_Sample);

end.

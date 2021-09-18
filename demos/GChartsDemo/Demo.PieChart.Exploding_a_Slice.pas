unit Demo.PieChart.Exploding_a_Slice;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_PieChart_Exploding_a_Slice = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_PieChart_Exploding_a_Slice.GenerateChart;
var
  Chart: IcfsGChartProducer; // Defined as TInterfacedObject No need try..finally
  Slices: TArray<string>;
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_PIE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Language'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Speakers (in millions)')
  ]);
  Chart.Data.AddRow(['Assamese', 13]);
  Chart.Data.AddRow(['Bengali', 83]);
  Chart.Data.AddRow(['Bodo', 1.4]);
  Chart.Data.AddRow(['Dogri', 2.3]);
  Chart.Data.AddRow(['Gujarati', 46]);
  Chart.Data.AddRow(['Hindi', 300]);
  Chart.Data.AddRow(['Kannada', 38]);
  Chart.Data.AddRow(['Kashmiri', 5.5]);
  Chart.Data.AddRow(['Konkani', 5]);
  Chart.Data.AddRow(['Maithili', 20]);
  Chart.Data.AddRow(['Malayalam', 33]);
  Chart.Data.AddRow(['Manipuri', 1.5]);
  Chart.Data.AddRow(['Marathi', 72]);
  Chart.Data.AddRow(['Nepali', 2.9]);
  Chart.Data.AddRow(['Oriya', 33]);
  Chart.Data.AddRow(['Punjabi', 29]);
  Chart.Data.AddRow(['Sanskrit', 0.01]);
  Chart.Data.AddRow(['Santhali', 6.5]);
  Chart.Data.AddRow(['Sindhi', 2.5]);
  Chart.Data.AddRow(['Tamil', 61]);
  Chart.Data.AddRow(['Telugu', 74]);
  Chart.Data.AddRow(['Urdu', 52]);

  // Options
  Chart.Options.Title('Indian Language Use');
  Chart.Options.Legend('position', 'none');
  Chart.Options.PieSliceText('label');

  SetLength(Slices, 16);
  Slices[ 4] := 'offset: 0.2';
  Slices[12] := 'offset: 0.3';
  Slices[14] := 'offset: 0.4';
  Slices[15] := 'offset: 0.5';
  Chart.Options.Slices(Slices);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_PieChart_Exploding_a_Slice);

end.

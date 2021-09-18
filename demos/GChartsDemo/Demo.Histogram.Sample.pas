unit Demo.Histogram.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Histogram_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_Histogram_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_HISTOGRAM_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Dinosaur'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Length')
  ]);

  Chart.Data.AddRow(['Acrocanthosaurus (top-spined lizard)', 12.2]);
  Chart.Data.AddRow(['Albertosaurus (Alberta lizard)', 9.1]);
  Chart.Data.AddRow(['Allosaurus (other lizard)', 12.2]);
  Chart.Data.AddRow(['Apatosaurus (deceptive lizard)', 22.9]);
  Chart.Data.AddRow(['Archaeopteryx (ancient wing)', 0.9]);
  Chart.Data.AddRow(['Argentinosaurus (Argentina lizard)', 36.6]);
  Chart.Data.AddRow(['Baryonyx (heavy claws)', 9.1]);
  Chart.Data.AddRow(['Brachiosaurus (arm lizard)', 30.5]);
  Chart.Data.AddRow(['Ceratosaurus (horned lizard)', 6.1]);
  Chart.Data.AddRow(['Coelophysis (hollow form)', 2.7]);
  Chart.Data.AddRow(['Compsognathus (elegant jaw)', 0.9]);
  Chart.Data.AddRow(['Deinonychus (terrible claw)', 2.7]);
  Chart.Data.AddRow(['Diplodocus (double beam)', 27.1]);
  Chart.Data.AddRow(['Dromicelomimus (emu mimic)', 3.4]);
  Chart.Data.AddRow(['Gallimimus (fowl mimic)', 5.5]);
  Chart.Data.AddRow(['Mamenchisaurus (Mamenchi lizard)', 21.0]);
  Chart.Data.AddRow(['Megalosaurus (big lizard)', 7.9]);
  Chart.Data.AddRow(['Microvenator (small hunter)', 1.2]);
  Chart.Data.AddRow(['Ornithomimus (bird mimic)', 4.6]);
  Chart.Data.AddRow(['Oviraptor (egg robber)', 1.5]);
  Chart.Data.AddRow(['Plateosaurus (flat lizard)', 7.9]);
  Chart.Data.AddRow(['Sauronithoides (narrow-clawed lizard)', 2.0]);
  Chart.Data.AddRow(['Seismosaurus (tremor lizard)', 45.7]);
  Chart.Data.AddRow(['Spinosaurus (spiny lizard)', 12.2]);
  Chart.Data.AddRow(['Supersaurus (super lizard)', 30.5]);
  Chart.Data.AddRow(['Tyrannosaurus (tyrant lizard)', 15.2]);
  Chart.Data.AddRow(['Ultrasaurus (ultra lizard)', 30.5]);
  Chart.Data.AddRow(['Velociraptor (swift robber)', 1.8]);

  // Options
  Chart.Options.Title('Lengths of dinosaurs, in meters');
  Chart.Options.Legend('position', 'none');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Histogram_Sample);

end.

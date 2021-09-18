unit Demo.GaugeChart.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts, uniTimer;

type
  TDemo_GaugeChart_Sample = class(TDemoBaseFrame)
  private
    FuniTimer: TUniTimer;
    FMemory: Integer;
    FCPU: Integer;
    FNetwork: Integer;
    procedure OnTimer(Sender: TObject);
  public
    procedure CreateDynamicComponents; override;
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_GaugeChart_Sample.CreateDynamicComponents;
begin
  inherited;

  FuniTimer := TUniTimer.Create(Self);
  FuniTimer.ChainMode := True;
  FuniTimer.OnTimer := OnTimer;
  FuniTimer.Interval := 6000;
end;

procedure TDemo_GaugeChart_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_GAUGE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Label'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Value')
  ]);

  FMemory := 40 + Random(60);
  FCPU :=  40 + Random(60);
  FNetwork :=  60 + Random(20);

  Chart.Data.AddRow(['Memory', FMemory]);
  Chart.Data.AddRow(['CPU', FCPU]);
  Chart.Data.AddRow(['Network', FNetwork]);

  // Options
  Chart.Options.Title('Computational resources');
  Chart.Options.RedFrom(90);
  Chart.Options.RedTo(100);
  Chart.Options.YellowFrom(75);
  Chart.Options.YellowTo(90);
  Chart.Options.MinorTicks(5);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart" style="width:600px; height:200px; margin:auto;position: absolute;top:0;bottom: 0;left: 0;right: 0;"></div>');
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

procedure TDemo_GaugeChart_Sample.OnTimer(Sender: TObject);
begin
  GenerateChart;
end;

initialization
  RegisterClass(TDemo_GaugeChart_Sample);

end.

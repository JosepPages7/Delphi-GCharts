unit Demo.BubbleChart.ColorByNumbers;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_BubbleChart_ColorByNumbers = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_BubbleChart_ColorByNumbers.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_BUBBLE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'ID'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'X'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Y'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Temperature')
  ]);
  Chart.Data.AddRow(['',   80,  167,      120]);
  Chart.Data.AddRow(['',   79,  136,      130]);
  Chart.Data.AddRow(['',   78,  184,      50]);
  Chart.Data.AddRow(['',   72,  278,      230]);
  Chart.Data.AddRow(['',   81,  200,      210]);
  Chart.Data.AddRow(['',   72,  170,      100]);
  Chart.Data.AddRow(['',   68,  477,      80]);

  // Options
  Chart.Options.ColorAxis('colors', TcfsGChartOptions.ArrayOfStringToJS(['yellow', 'red']));

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;


initialization
  RegisterClass(TDemo_BubbleChart_ColorByNumbers);

end.

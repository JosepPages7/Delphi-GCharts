unit Demo.AnnotationChart.Sample;

interface

uses
  System.Classes, System.SysUtils, System.Variants, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_AnnotationChart_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_AnnotationChart_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_ANNOTATION_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Date'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Kepler-22b mission'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Kepler title'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Kepler text'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Gliese 163 mission'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Gliese title'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Gliese text')
  ]);
  Chart.Data.AddRow([EncodeDate(2314, 3, 15), 12400, null, null, 10645, null, null]);
  Chart.Data.AddRow([EncodeDate(2314, 3, 16), 24045, 'Lalibertines', 'First encounter', 12374, null, null]);
  Chart.Data.AddRow([EncodeDate(2314, 3, 17), 35022, 'Lalibertines', 'They are very tall', 15766, 'Gallantors', 'First Encounter']);
  Chart.Data.AddRow([EncodeDate(2314, 3, 18), 12284, 'Lalibertines', 'Attack on our crew!', 34334, 'Gallantors', 'Statement of shared principles']);
  Chart.Data.AddRow([EncodeDate(2314, 3, 19), 8476, 'Lalibertines', 'Heavy casualties', 66467, 'Gallantors', 'Mysteries revealed']);
  Chart.Data.AddRow([EncodeDate(2314, 3, 20), 0, 'Lalibertines', 'All crew lost', 79463, 'Gallantors', 'Omniscience achieved']);

  // Options
  Chart.Options.DisplayAnnotations(True);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
    '<div  style="width:80%; height:10%"></div>' +
    '<div id="Chart1" style="width:80%; height:80%;margin: auto"></div>' +
    '<div  style="width:80%; height:10%"></div>'
  );
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_AnnotationChart_Sample);

end.

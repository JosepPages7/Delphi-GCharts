unit Demo.GeoChart.Marker;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_GeoChart_Marker = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_GeoChart_Marker.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_GEO_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Country'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Popularity'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Area')
  ]);

  Chart.Data.AddRow(['Rome',      2761477,    1285.31]);
  Chart.Data.AddRow(['Milan',     1324110,    181.76]);
  Chart.Data.AddRow(['Naples',    959574,     117.27]);
  Chart.Data.AddRow(['Turin',     907563,     130.17]);
  Chart.Data.AddRow(['Palermo',   655875,     158.9]);
  Chart.Data.AddRow(['Genoa',     607906,     243.60]);
  Chart.Data.AddRow(['Bologna',   380181,     140.7]);
  Chart.Data.AddRow(['Florence',  371282,     102.41]);
  Chart.Data.AddRow(['Fiumicino', 67370,      213.44]);
  Chart.Data.AddRow(['Anzio',     52192,      43.43]);
  Chart.Data.AddRow(['Ciampino',  38262,      11]);

  // Options
  Chart.Options.Region('IT');
  Chart.Options.DisplayMode('markers');
  Chart.Options.ColorAxis('colors', '[''green'', ''blue'']');

  Chart.LibraryMapsApiKey := '?'; // <------------------------------ Your Google MapsApiKey (https://developers.google.com/maps/documentation/javascript/get-api-key)

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
      '<div style="width:100%;font-family: Arial; font-size:14px; text-align: center;"><br>NOTE: Because this Geo Chart requires geocoding, you''ll need a mapsApiKey to see Data. (Look at source code for details)<br></div>'
    + '<div id="Chart1" style="width:100%;height:90%"></div>'
  );
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_GeoChart_Marker);

end.

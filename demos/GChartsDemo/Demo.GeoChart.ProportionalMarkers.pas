unit Demo.GeoChart.ProportionalMarkers;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_GeoChart_ProportionalMarkers = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_GeoChart_ProportionalMarkers.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_GEO_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Country'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Population'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Area Percentage')
  ]);

  Chart.Data.AddRow(['France',  65700000, 50]);
  Chart.Data.AddRow(['Germany', 81890000, 27]);
  Chart.Data.AddRow(['Poland',  38540000, 23]);

  // Options
  Chart.Options.SizeAxis('minValue', 0);
  Chart.Options.SizeAxis('maxValue', 100);
  Chart.Options.Region('155'); // Western Europe
  Chart.Options.DisplayMode('markers');
  Chart.Options.ColorAxis('colors', '[''#e7711c'', ''#4374e0'']');  // orange to blue

  Chart.LibraryMapsApiKey := '?'; // <------------------------------ Your Google MapsApiKey (https://developers.google.com/maps/documentation/javascript/get-api-key)

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
      '<div style="width:100%;font-family: Arial; font-size:14px; text-align: center;"><br>NOTE: Because this Geo Chart requires geocoding, you''ll need a mapsApiKey to see Data. (Look at source code for details)<br></div>'
    + '<div id="Chart" style="width:100%;height:90%"></div>'
  );
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_GeoChart_ProportionalMarkers);

end.

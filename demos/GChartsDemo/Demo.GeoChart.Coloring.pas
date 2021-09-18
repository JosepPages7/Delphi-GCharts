unit Demo.GeoChart.Coloring;

interface

uses
  System.Classes, System.Variants, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_GeoChart_Coloring = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_GeoChart_Coloring.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_GEO_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Country'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Latitude')
  ]);

  Chart.Data.AddRow(['Algeria', 36]);
  Chart.Data.AddRow(['Angola', -8]);
  Chart.Data.AddRow(['Benin', 6]);
  Chart.Data.AddRow(['Botswana', -24]);
  Chart.Data.AddRow(['Burkina Faso', 12]);
  Chart.Data.AddRow(['Burundi', -3]);
  Chart.Data.AddRow(['Cameroon', 3]);
  Chart.Data.AddRow(['Canary Islands', 28]);
  Chart.Data.AddRow(['Cape Verde', 15]);
  Chart.Data.AddRow(['Central African Republic', 4]);
  Chart.Data.AddRow(['Ceuta', 35]);
  Chart.Data.AddRow(['Chad', 12]);
  Chart.Data.AddRow(['Comoros', -12]);
  Chart.Data.AddRow(['Cote d''Ivoire', 6]);
  Chart.Data.AddRow(['Democratic Republic of the Congo', -3]);
  Chart.Data.AddRow(['Djibouti', 12]);
  Chart.Data.AddRow(['Egypt', 26]);
  Chart.Data.AddRow(['Equatorial Guinea', 3]);
  Chart.Data.AddRow(['Eritrea', 15]);
  Chart.Data.AddRow(['Ethiopia', 9]);
  Chart.Data.AddRow(['Gabon', 0]);
  Chart.Data.AddRow(['Gambia', 13]);
  Chart.Data.AddRow(['Ghana', 5]);
  Chart.Data.AddRow(['Guinea', 10]);
  Chart.Data.AddRow(['Guinea-Bissau', 12]);
  Chart.Data.AddRow(['Kenya', -1]);
  Chart.Data.AddRow(['Lesotho', -29]);
  Chart.Data.AddRow(['Liberia', 6]);
  Chart.Data.AddRow(['Libya', 32]);
  Chart.Data.AddRow(['Madagascar', null]);
  Chart.Data.AddRow(['Madeira', 33]);
  Chart.Data.AddRow(['Malawi', -14]);
  Chart.Data.AddRow(['Mali', 12]);
  Chart.Data.AddRow(['Mauritania', 18]);
  Chart.Data.AddRow(['Mauritius', -20]);
  Chart.Data.AddRow(['Mayotte', -13]);
  Chart.Data.AddRow(['Melilla', 35]);
  Chart.Data.AddRow(['Morocco', 32]);
  Chart.Data.AddRow(['Mozambique', -25]);
  Chart.Data.AddRow(['Namibia', -22]);
  Chart.Data.AddRow(['Niger', 14]);
  Chart.Data.AddRow(['Nigeria', 8]);
  Chart.Data.AddRow(['Republic of the Congo', -1]);
  Chart.Data.AddRow(['Réunion', -21]);
  Chart.Data.AddRow(['Rwanda', -2]);
  Chart.Data.AddRow(['Saint Helena', -16]);
  Chart.Data.AddRow(['São Tomé and Principe', 0]);
  Chart.Data.AddRow(['Senegal', 15]);
  Chart.Data.AddRow(['Seychelles', -5]);
  Chart.Data.AddRow(['Sierra Leone', 8]);
  Chart.Data.AddRow(['Somalia', 2]);
  Chart.Data.AddRow(['Sudan', 15]);
  Chart.Data.AddRow(['South Africa', -30]);
  Chart.Data.AddRow(['South Sudan', 5]);
  Chart.Data.AddRow(['Swaziland', -26]);
  Chart.Data.AddRow(['Tanzania', -6]);
  Chart.Data.AddRow(['Togo', 6]);
  Chart.Data.AddRow(['Tunisia', 34]);
  Chart.Data.AddRow(['Uganda', 1]);
  Chart.Data.AddRow(['Western Sahara', 25]);
  Chart.Data.AddRow(['Zambia', -15]);
  Chart.Data.AddRow(['Zimbabwe', -18]);

  // Options
  Chart.Options.Region('002'); // Africa
  Chart.Options.ColorAxis('colors', '[''#00853f'', ''black'', ''#e31b23'']');
  Chart.Options.BackgroundColor('#81d4fa');
  Chart.Options.DefaultColor('#f5f5f5');
  Chart.Options.DatalessRegionColor('#f8bbd0');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_GeoChart_Coloring);

end.

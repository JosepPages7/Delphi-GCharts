unit Demo.Miscellaneous.AxisNumberFormatLang;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Miscellaneous_AxisNumberFormatLang = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

uses
  MainModule;

procedure TDemo_Miscellaneous_AxisNumberFormatLang.GenerateChart;

  procedure SetCommonOptions(Options: TcfsGChartOptions);
  begin
    Options.Legend('position', 'none');
    Options.ChartArea('width', '50%');
    Options.Bar('groupWidth', '95%');
    Options.DataOpacity(0.3);
    Options.VAxis('gridlines', '{ count: 4 }');
    Options.VAxis('textStyle', TcfsGChartOptions.TextStyleToJSObject('#0059b3', 12, True, false));
    Options.HAxis('textStyle', TcfsGChartOptions.TextStyleToJSObject('Silver', 10, false, false));
  end;

var
  Data: IcfsGChartData;
  Chart1, Chart2, Chart3, Chart4, Chart5, Chart6, Chart7, Chart8: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  // Data
  Data := TcfsGChartData.Create;
  Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Country'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'GDP')
  ]);

  Data.AddRow(['US', 16768100]);
  Data.AddRow(['China', 9181204]);
  Data.AddRow(['Japan', 4898532]);
  Data.AddRow(['Germany', 3730261]);
  Data.AddRow(['France', 2678455]);

  // Currency Format
  Chart1 := TcfsGChartProducer.Create;
  Chart1.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  Chart1.Data.Assign(Data);
  SetCommonOptions(Chart1.Options);
  Chart1.Options.Title('Currency Format');
  Chart1.Options.VAxis('format', 'currency');
  Chart1.LibraryLanguage := UniSession.Language;

  // Decimal Format
  Chart2 := TcfsGChartProducer.Create;
  Chart2.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  Chart2.Data.Assign(Data);
  SetCommonOptions(Chart2.Options);
  Chart2.Options.Title('Decimal Format');
  Chart2.Options.VAxis('format', 'decimal');
  Chart2.LibraryLanguage := UniSession.Language;

  // Long Format
  Chart3 := TcfsGChartProducer.Create;
  Chart3.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  Chart3.Data.Assign(Data);
  SetCommonOptions(Chart3.Options);
  Chart3.Options.Title('Long Format');
  Chart3.Options.VAxis('format', 'long');
  Chart3.LibraryLanguage := UniSession.Language;

  // Short Format
  Chart4 := TcfsGChartProducer.Create;
  Chart4.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  Chart4.Data.Assign(Data);
  SetCommonOptions(Chart4.Options);
  Chart4.Options.Title('Short Format');
  Chart4.Options.VAxis('format', 'short');
  Chart4.LibraryLanguage := UniSession.Language;

  // Custom Format
  Chart5 := TcfsGChartProducer.Create;
  Chart5.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  Chart5.Data.Assign(Data);
  SetCommonOptions(Chart5.Options);
  Chart5.Options.Title('Custom Format (€ 0,000.00)');
  Chart5.Options.VAxis('format', '€ 0,000.00');
  Chart5.LibraryLanguage := UniSession.Language;

  // Scientific Format
  Chart6 := TcfsGChartProducer.Create;
  Chart6.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  Chart6.Data.Assign(Data);
  SetCommonOptions(Chart6.Options);
  Chart6.Options.Title('Scientific Format');
  Chart6.Options.VAxis('format', 'scientific');
  Chart6.LibraryLanguage := UniSession.Language;

  // Percent Format
  Chart7 := TcfsGChartProducer.Create;
  Chart7.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  Chart7.Data.Assign(Data);
  SetCommonOptions(Chart7.Options);
  Chart7.Options.Title('Percent Format');
  Chart7.Options.VAxis('format', 'percent');
  Chart7.LibraryLanguage := UniSession.Language;

  // Empty Format
  Chart8 := TcfsGChartProducer.Create;
  Chart8.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  Chart8.Data.Assign(Data);
  SetCommonOptions(Chart8.Options);
  Chart8.Options.Title('Empty Format');
  Chart8.Options.VAxis('format', '');
  Chart8.LibraryLanguage := UniSession.Language;

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 50%;">'
    +   '<div id="Chart1" style="width: 50%"></div>'
    +   '<div id="Chart2" style="width: 50%"></div>'
    +   '<div id="Chart3" style="width: 50%"></div>'
    +   '<div id="Chart4" style="width: 50%"></div>'
    + '</div>'
    + '<div style="display: flex; width: 100%; height: 50%;">'
    +   '<div id="Chart5" style="width: 50%"></div>'
    +   '<div id="Chart6" style="width: 50%"></div>'
    +   '<div id="Chart7" style="width: 50%"></div>'
    +   '<div id="Chart8" style="width: 50%"></div>'
    + '</div>'
  );
  GChartsFrame.DocumentGenerate('Chart1', Chart1);
  GChartsFrame.DocumentGenerate('Chart2', Chart2);
  GChartsFrame.DocumentGenerate('Chart3', Chart3);
  GChartsFrame.DocumentGenerate('Chart4', Chart4);
  GChartsFrame.DocumentGenerate('Chart5', Chart5);
  GChartsFrame.DocumentGenerate('Chart6', Chart5);
  GChartsFrame.DocumentGenerate('Chart6', Chart6);
  GChartsFrame.DocumentGenerate('Chart7', Chart7);
  GChartsFrame.DocumentGenerate('Chart8', Chart8);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Miscellaneous_AxisNumberFormatLang);

end.

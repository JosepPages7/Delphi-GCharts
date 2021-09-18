unit Demo.Miscellaneous.DateTimes;

interface

uses
  System.Classes, System.SysUtils, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Miscellaneous_DateTimes = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

uses
  System.DateUtils;

procedure TDemo_Miscellaneous_DateTimes.GenerateChart;
var
  Chart1, Chart2, Chart3, Chart4: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  //Default Date Format
  Chart1 := TcfsGChartProducer.Create;
  Chart1.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  Chart1.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Time of Day'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Rating')
  ]);

  Chart1.Data.AddRow([EncodeDate(2015, 1, 1), 5]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 2), 7]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 3), 3]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 4), 1]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 5), 3]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 6), 4]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 7), 3]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 8), 4]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 9), 2]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 10), 5]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 11), 8]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 12), 6]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 13), 3]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 14), 3]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 15), 5]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 16), 7]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 17), 6]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 18), 6]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 19), 3]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 20), 1]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 21), 2]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 22), 4]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 23), 6]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 24), 5]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 25), 9]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 26), 4]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 27), 9]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 28), 8]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 29), 6]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 30), 4]);
  Chart1.Data.AddRow([EncodeDate(2015, 1, 31), 6]);
  Chart1.Data.AddRow([EncodeDate(2015, 2, 1), 7]);
  Chart1.Data.AddRow([EncodeDate(2015, 2, 2), 9]);

  Chart1.Options.Title('Default Date Format');
  Chart1.Options.HAxis('gridlines', '{count: 15}');
  Chart1.Options.VAxis('gridlines', '{color: ''none''}');
  Chart1.Options.VAxis('gridlines', 'minValue: 0');

  // Custom Date Format
  Chart2 := TcfsGChartProducer.Create;
  Chart2.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;
  Chart2.Data.Assign(Chart1.Data);

  Chart2.Options.Title('Custom Date Format');
  Chart2.Options.HAxis('gridlines', '{count: 15}');
  Chart2.Options.HAxis('format', 'M/d/yy');
  Chart2.Options.VAxis('gridlines', '{color: ''none''}');
  Chart2.Options.VAxis('gridlines', 'minValue: 0');

  // Change View Window
  Chart3 := TcfsGChartProducer.Create;
  Chart3.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  Chart3.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDateTime, 'Time of Day'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Rating')
  ]);

  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 0, 0, 0, 0), 5]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 0, 30, 0, 0), 5.1]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 1, 0, 0, 0), 6.2]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 2, 0, 0, 0), 7]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 3, 0, 0, 0), 6.4]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 4, 0, 0, 0), 3]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 5, 0, 0, 0), 4]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 6, 0, 0, 0), 4.2]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 7, 0, 0, 0), 1]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 8, 0, 0, 0), 2.7]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 9, 0, 0, 0), 3.9]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 10, 0, 0, 0), 3.8]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 11, 0, 0, 0), 5]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 12, 0, 0, 0), 6.2]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 13, 0, 0, 0), 7.8]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 14, 0, 0, 0), 9.1]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 15, 0, 0, 0), 8]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 16, 0, 0, 0), 6.8]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 17, 0, 0, 0), 7.2]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 18, 0, 0, 0), 4]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 19, 0, 0, 0), 5.9]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 20, 0, 0, 0), 6.3]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 21, 0, 0, 0), 6]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 22, 0, 0, 0), 3]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 1, 23, 0, 0, 0), 2.2]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 2, 0, 0, 0, 0), 2.4]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 2, 1, 0, 0, 0), 3.6]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 2, 2, 0, 0, 0), 4]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 2, 3, 0, 0, 0), 5.5]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 2, 4, 0, 0, 0), 7.1]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 2, 5, 0, 0, 0), 6]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 2, 6, 0, 0, 0), 7.8]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 2, 7, 0, 0, 0), 8.2]);
  Chart3.Data.AddRow([EncodeDateTime(2015, 1, 2, 8, 0, 0, 0), 9]);

  Chart3.Options.Title('Change View Window (From Dec 2014 31 18:00 to Jan 2015 03)');
  Chart3.Options.Legend('position', 'none');
  Chart3.Options.ChartArea('width', '85%');
  Chart3.Options.HAxis('viewWindow', '{min: new Date(2014, 11, 31, 18), max: new Date(2015, 0, 3, 1) }');
  Chart3.Options.HAxis('gridlines', '{count: -1,units: {days: {format: [''MMM dd'']},hours: {format: [''HH:mm'', ''ha'']},}}');
  Chart3.Options.HAxis('minorGridlines', '{units: {hours: {format: [''hh:mm:ss a'', ''ha'']}, minutes: {format: [''HH:mm a Z'', '':mm'']}}}');

  // Customizing individual points
  Chart4 := TcfsGChartProducer.Create;
  Chart4.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;
  Chart4.Data.Assign(Chart3.Data);
  Chart4.Options.Title('Change View Window (From Jan 2015 01 00:00 to Jan 2015 01 03:00)');
  Chart4.Options.Legend('position', 'none');
  Chart4.Options.ChartArea('width', '85%');
  Chart4.Options.HAxis('viewWindow', '{min: new Date(2015, 0, 1), max: new Date(2015, 0, 1, 3) }');
  Chart4.Options.HAxis('gridlines', '{count: -1,units: {days: {format: [''MMM dd'']},hours: {format: [''HH:mm'', ''ha'']},}}');
  Chart4.Options.HAxis('minorGridlines', '{units: {hours: {format: [''hh:mm:ss a'', ''ha'']}, minutes: {format: [''HH:mm a Z'', '':mm'']}}}');


  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 50%;">'
    +   '<div id="Chart1" style="width: 50%"></div>'
    +   '<div id="Chart2" style="flex-grow: 1;"></div>'
    + '</div>'
    +  '<div style="display: flex; width: 100%; height: 50%;">'
    +   '<div id="Chart3" style="width: 50%"></div>'
    +   '<div id="Chart4" style="flex-grow: 1;"></div>'
    + '</div>'
  );
  GChartsFrame.DocumentGenerate('Chart1', Chart1);
  GChartsFrame.DocumentGenerate('Chart2', Chart2);
  GChartsFrame.DocumentGenerate('Chart3', Chart3);
  GChartsFrame.DocumentGenerate('Chart4', Chart4);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Miscellaneous_DateTimes);

end.

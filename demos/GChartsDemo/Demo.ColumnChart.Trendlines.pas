unit Demo.ColumnChart.Trendlines;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_ColumnChart_Trendlines = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

uses
  System.SysUtils, System.DateUtils;

procedure TDemo_ColumnChart_Trendlines.GenerateChart;
var
  Chart: IcfsGChartProducer;   // Defined as TInterfacedObject No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtTimeOfDay, 'Time of Day'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Motivation Level'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Energy Level')
  ]);
  Chart.Data.AddRow;
  Chart.Data.SetValue(0, EncodeTime(8, 0, 0, 0), '8 am');
  Chart.Data.SetValue(1, 1);
  Chart.Data.SetValue(2, 0.25);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, EncodeTime(9, 0, 0, 0), '9 am');
  Chart.Data.SetValue(1, 2);
  Chart.Data.SetValue(2, 0.5);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, EncodeTime(10, 0, 0, 0), '10 am');
  Chart.Data.SetValue(1, 3);
  Chart.Data.SetValue(2, 1);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, EncodeTime(11, 0, 0, 0), '11 am');
  Chart.Data.SetValue(1, 4);
  Chart.Data.SetValue(2, 2.25);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, EncodeTime(12, 0, 0, 0), '12 pm');
  Chart.Data.SetValue(1, 5);
  Chart.Data.SetValue(2, 2.25);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, EncodeTime(13, 0, 0, 0), '1 pm');
  Chart.Data.SetValue(1, 6);
  Chart.Data.SetValue(2, 3);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, EncodeTime(14, 0, 0, 0), '2 pm');
  Chart.Data.SetValue(1, 7);
  Chart.Data.SetValue(2, 4);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, EncodeTime(15, 0, 0, 0), '3 pm');
  Chart.Data.SetValue(1, 8);
  Chart.Data.SetValue(2, 5.25);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, EncodeTime(16, 0, 0, 0), '4 pm');
  Chart.Data.SetValue(1, 9);
  Chart.Data.SetValue(2, 7.5);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, EncodeTime(17, 0, 0, 0), '5 pm');
  Chart.Data.SetValue(1, 10);
  Chart.Data.SetValue(2,  10);

  // Options
  Chart.Options.Title('Motivation and Energy Level Throughout the Day');
  Chart.Options.Colors(['#9575cd', '#33ac71']);
  Chart.Options.hAxis('title', 'Time of Day');
  Chart.Options.hAxis('format', 'h:mm a');
  Chart.Options.hAxis('viewWindow', '{ min: [7, 30, 0],  max: [17, 30, 0]}');
  Chart.Options.vAxis('title', 'Rating (scale of 1-10)');
  Chart.Options.Trendlines([ '0: {type: ''linear'', lineWidth: 5, opacity: .3}', '1: {type: ''exponential'', lineWidth: 10, opacity: .3}']);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_ColumnChart_Trendlines);

end.

unit Demo.TableChart.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_TableChart_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_TableChart_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_TABLE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Name'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Salary'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtBoolean, 'Full Time Employee')
  ]);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, 'Mike');
  Chart.Data.SetValue(1, 10000, '$10,000');
  Chart.Data.SetValue(2, True);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, 'Jim');
  Chart.Data.SetValue(1, 8000, '$8,000');
  Chart.Data.SetValue(2, False);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, 'Alice');
  Chart.Data.SetValue(1, 12500, '$12,500');
  Chart.Data.SetValue(2, True);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, 'Bob');
  Chart.Data.SetValue(1, 7000, '$7,000');
  Chart.Data.SetValue(2, True);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, 'Mary');
  Chart.Data.SetValue(1, 7000, '$7,000');
  Chart.Data.SetValue(2, True);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, 'Joseph');
  Chart.Data.SetValue(1, 5000, '$5,000');
  Chart.Data.SetValue(2, False);

  // Options
  Chart.Options.SetAsBoolean('showRowNumber', True);
  Chart.Options.SetAsInteger('pageSize', 5);
  Chart.Options.Width(500);

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart" style="width:500px; height:300px; margin:auto;position: absolute;top:0;bottom: 0;left: 0;right: 0;"></div>');
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_TableChart_Sample);

end.

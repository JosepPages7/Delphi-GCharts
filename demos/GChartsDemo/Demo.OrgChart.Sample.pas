unit Demo.OrgChart.Sample;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_OrgChart_Sample = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_OrgChart_Sample.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_ORG_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Name'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Manager'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'ToolTip')
  ]);

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, 'Mike', 'Mike<div style="color:red; font-style:italic">President</div>');
  Chart.Data.SetValue(1, '');
  Chart.Data.SetValue(2, 'The President');

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, 'Jim', 'Jim<div style="color:red; font-style:italic">Vice President</div>');
  Chart.Data.SetValue(1, 'Mike');
  Chart.Data.SetValue(2, 'VP');

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, 'Alice');
  Chart.Data.SetValue(1, 'Mike');
  Chart.Data.SetValue(2, '');

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, 'Bob');
  Chart.Data.SetValue(1, 'Jim');
  Chart.Data.SetValue(2, 'Bob Sponge');

  Chart.Data.AddRow;
  Chart.Data.SetValue(0, 'Carol');
  Chart.Data.SetValue(1, 'Bob');
  Chart.Data.SetValue(2, '');

  Chart.Options.AllowHtml(True);
  //Chart.Options.SetAsQuotedStr('size', 'large');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart" style="width:900px; height:500px; margin:auto;position: absolute;top:0;bottom: 0;left: 0;right: 0;"></div>');
  GChartsFrame.DocumentGenerate('Chart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_OrgChart_Sample);

end.

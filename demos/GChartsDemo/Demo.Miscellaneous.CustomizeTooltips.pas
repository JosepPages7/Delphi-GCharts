unit Demo.Miscellaneous.CustomizeTooltips;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Miscellaneous_CustomizeTooltips = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_Miscellaneous_CustomizeTooltips.GenerateChart;
var
  Chart1, Chart2: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  // Customize Tooltips
  Chart1 := TcfsGChartProducer.Create;
  Chart1.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;

  Chart1.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Year'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Sales'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_TOOLTIP)
  ]);
  Chart1.Data.AddRow(['2010', 600,'$600K in our first year!']);
  Chart1.Data.AddRow(['2011', 1500, 'Sunspot activity made this our best year ever!']);
  Chart1.Data.AddRow(['2012', 800, '$800K in 2012.']);
  Chart1.Data.AddRow(['2013', 1000, '$1M in sales last year.']);

  Chart1.Options.Title('hover over columns to see the tooltips');
  Chart1.Options.Legend('position', 'none');
  //Chart1.Options.Tooltip('isHtml', True);

  // Annotating data
  Chart2 := TcfsGChartProducer.Create;
  Chart2.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  Chart2.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Year'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'USA'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_ANOTATION_TEXT),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'China'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'UK')

  ]);

  Chart2.Data.AddRow(['2000',  94, '94',  '', 58, 28]);
  Chart2.Data.AddRow(['2004', 101, '101',  '', 63, 30]);
  Chart2.Data.AddRow(['2008', 110, 'hover over this text', 'An all time high!', 100, 47]);
  Chart2.Data.AddRow(['2012', 104, '104',  '', 88, 65]);

  Chart2.Options.Title('Tooltip in Annotating data');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 100%;">'
    +   '<div id="Chart1" style="width: 50%"></div>'
    +   '<div id="Chart2" style="flex-grow: 1;"></div>'
    + '</div>'
  );
  GChartsFrame.DocumentGenerate('Chart1', Chart1);
  GChartsFrame.DocumentGenerate('Chart2', Chart2);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Miscellaneous_CustomizeTooltips);

end.

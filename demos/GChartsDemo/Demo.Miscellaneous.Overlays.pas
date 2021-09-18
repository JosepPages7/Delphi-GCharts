unit Demo.Miscellaneous.Overlays;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Miscellaneous_Overlays = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

procedure TDemo_Miscellaneous_Overlays.GenerateChart;
var
  Chart: IcfsGChartProducer;  // Defined as TInterfacedObject No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_LINE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Threat'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Attacks')
  ]);

  Chart.Data.AddRow(['Chandrian', 38]);
  Chart.Data.AddRow(['Ghosts', 12]);
  Chart.Data.AddRow(['Ghouls', 6]);
  Chart.Data.AddRow(['UFOs', 44]);
  Chart.Data.AddRow(['Vampires', 28]);
  Chart.Data.AddRow(['Zombies', 88]);

  // Options
  Chart.Options.Title('Overlay Example');
  Chart.Options.Legend('position', 'none');
  Chart.Options.colors(['#760946']);
  Chart.Options.VAxis('gridlines', '{cont: 4}');

  // Generate
  GChartsFrame.DocumentInit;

  GChartsFrame.DocumentSetCSS('<style>.chartWithOverlay {position: relative; width: 700px;}.overlay {width: 200px; height: 200px; position: absolute; top: 60px;   /* chartArea top  */   left: 180px; /* chartArea left */  } </style>');

  GChartsFrame.DocumentSetBody(
     '<div class="chartWithOverlay">'
   + '  <div id="linechart" style="width: 700px; height: 500px;"></div>'
   + '   <div class="overlay">'
   + '    <div style="font-family:''Arial Black''; font-size: 128px;">88</div>'
   + '    <div style="color: #b44; font-family:''Arial Black''; font-size: 32px; letter-spacing: .21em; margin-left:5px;">zombie</div>'
   + '    <div style="color: #444; font-family:''Arial Black''; font-size: 32px; letter-spacing: .15em; margin-left:5px;">attacks</div>'
   + '  </div>'
   + '</div>'
  );
  GChartsFrame.DocumentGenerate('linechart', Chart);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Miscellaneous_Overlays);

end.

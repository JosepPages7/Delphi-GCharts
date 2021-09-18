unit Demo.LineChart.Bitcoin;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_LineChart_Bitcoin = class(TDemoBaseFrame)
  private
  public
    procedure GenerateChart; override;
  end;

implementation

uses
  IdHTTP,
  IdSSLOpenSSL,
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  System.DateUtils;

procedure TDemo_LineChart_Bitcoin.GenerateChart;
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally

  procedure GetBitcoinData;
  var
    I: Integer;
    IdHTTP: TIdHTTP;
    IdSSL: TIdSSLIOHandlerSocketOpenSSL;
    JSonValue: TJSonValue;
    Value: TJSONObject;
    BitcoinValues: TJSONArray;
    DatePrice: TDateTime;
    BitcoinPrice: Extended;
  const
    URL_BITCOIN_MARKET_PRICE = 'https://api.blockchain.info/charts/market-price';
  begin
    IdHTTP := TIdHTTP.Create(nil);
    try
      IdHTTP.HTTPOptions := IdHTTP.HTTPOptions + [hoForceEncodeParams];
      IdHTTP.HandleRedirects := True;

      IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(IdHTTP);
      IdSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
      IdHTTP.IOHandler := IdSSL;
      JsonValue := TJSonObject.ParseJSONValue(IdHTTP.Get(URL_BITCOIN_MARKET_PRICE));
      try
        BitcoinValues := (JsonValue as TJSONObject).Get('values').JsonValue as TJSONArray;
        if Assigned(BitcoinValues) then
        begin
          for I := 0 to BitcoinValues.Count - 1 do
          begin
            Value := BitcoinValues.Items[I] as TJSONObject;
            DatePrice := UnixToDateTime(StrToInt(Value.Get('x').JsonValue.Value));
            BitcoinPrice := StrToFloat(Value.Get('y').JsonValue.Value);
            Chart.Data.AddRow([DatePrice, BitcoinPrice]);
          end;
        end;
      finally
        JsonValue.Free;
      end;
    finally
      IdHTTP.Free;
    end;
  end;

begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_AREA_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Date'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Price')
  ]);
  GetBitcoinData;

  // Options
  Chart.Options.Title('Historial Bitcoin price in US$');
  Chart.Options.Legend('position', 'none');
  Chart.Options.HAxis('title', 'Date');
  Chart.Options.HAxis('format', 'MMM/yy');
  //Chart.Options.HAxis('gridlines', 10);
  Chart.Options.VAxis('title', 'Price');
  Chart.Options.Animation('startup', True);
  Chart.Options.Animation('duration', 1000);
  Chart.Options.Animation('easing', 'out');
  Chart.Options.Crosshair('trigger', 'selection');

  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody('<div id="Chart1" style="width:100%;height:100%;"></div>');
  GChartsFrame.DocumentGenerate('Chart1', Chart);
  GChartsFrame.DocumentPost;
end;


initialization
  RegisterClass(TDemo_LineChart_Bitcoin);

end.

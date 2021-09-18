unit Demo.Miscellaneous.Formatters;

interface

uses
  System.Classes, Demo.BaseFrame, cfs.GCharts;

type
  TDemo_Miscellaneous_Formatters = class(TDemoBaseFrame)
  public
    procedure GenerateChart; override;
  end;

implementation

uses
  System.SysUtils, System.DateUtils;

procedure TDemo_Miscellaneous_Formatters.GenerateChart;

  function GetChartArrowFormat: IcfsGChartProducer;
  begin
    Result := TcfsGChartProducer.Create;
    Result.ClassChartType := TcfsGChartProducer.CLASS_TABLE_CHART;

    // Data
    Result.Data.DefineColumns([
      TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Department'),
      TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Revenues Change')
    ]);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Shoes');
    Result.Data.SetValue(1, 12, '12.0%');

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Sports');
    Result.Data.SetValue(1, -7.3, '-7.3%');

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Toys');
    Result.Data.SetValue(1, 0, '0%');

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Electronics');
    Result.Data.SetValue(1, -2.1, '-2.1%');

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Food');
    Result.Data.SetValue(1, 22, '22.0%');

    // Options
    Result.Options.AllowHtml(True);
    Result.Options.SetAsBoolean('showRowNumber', True);
    Result.Options.Width(350);

    // Formatter
    Result.ScripCodeBeforeCallDraw :=
        'var formatter = new google.visualization.ArrowFormat();'
      + 'formatter.format(data, 1);'
    ;
  end;

  function GetChartBarFormat: IcfsGChartProducer;
  begin
    Result := TcfsGChartProducer.Create;
    Result.ClassChartType := TcfsGChartProducer.CLASS_TABLE_CHART;

    // Data
    Result.Data.DefineColumns([
      TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Department'),
      TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Revenues')
    ]);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Shoes');
    Result.Data.SetValue(1, 10700);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Sports');
    Result.Data.SetValue(1, -15400);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Toys');
    Result.Data.SetValue(1, 12500);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Electronics');
    Result.Data.SetValue(1, -2100);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Food');
    Result.Data.SetValue(1, 22600);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Art');
    Result.Data.SetValue(1, 1100);

    // Options
    Result.Options.AllowHtml(True);
    Result.Options.SetAsBoolean('showRowNumber', True);
    Result.Options.Width(350);

    // Formatter
    Result.ScripCodeBeforeCallDraw :=
        'var formatter = new google.visualization.BarFormat({width: 120});'
      + 'formatter.format(data, 1);'
    ;
  end;

  function GetChartColorFormat: IcfsGChartProducer;
  begin
    Result := TcfsGChartProducer.Create;
    Result.ClassChartType := TcfsGChartProducer.CLASS_TABLE_CHART;

    // Data
    Result.Data.DefineColumns([
      TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Department'),
      TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Revenues')
    ]);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Shoes');
    Result.Data.SetValue(1, 10700);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Sports');
    Result.Data.SetValue(1, -15400);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Toys');
    Result.Data.SetValue(1, 12500);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Electronics');
    Result.Data.SetValue(1, -2100);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Food');
    Result.Data.SetValue(1, 22600);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Art');
    Result.Data.SetValue(1, 1100);

    // Options
    Result.Options.AllowHtml(True);
    Result.Options.SetAsBoolean('showRowNumber', True);
    Result.Options.Width(350);

    // Formatter
    Result.ScripCodeBeforeCallDraw :=
        'var formatter = new google.visualization.ColorFormat({width: 120});'
      + 'formatter.addRange(-20000, 0, ''white'', ''orange'');'
      + 'formatter.addRange(20000, null, ''red'', ''#33ff33''); '
      + 'formatter.format(data, 1);'
    ;
  end;

  function GetChartDateFormat: IcfsGChartProducer;
  begin
    Result := TcfsGChartProducer.Create;
    Result.ClassChartType := TcfsGChartProducer.CLASS_TABLE_CHART;

    // Data
    Result.Data.DefineColumns([
      TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Employee Name'),
      TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Start Date (Long)'),
      TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Start Date (Medium)'),
      TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtDate, 'Start Date (Short)')
    ]);

    Result.Data.AddRow(['Mike', EncodeDateTime(2008, 2, 28, 0, 31, 26, 0),   EncodeDateTime(2008, 2, 28, 0, 31, 26, 0),  EncodeDateTime(2008, 2, 28, 0, 31, 26, 0)]);
    Result.Data.AddRow(['Bob', EncodeDate(2007, 6, 1),  EncodeDate(2007, 6, 1), EncodeDate(2007, 6, 1)]);
    Result.Data.AddRow(['Alice', EncodeDate(2006, 8, 16), EncodeDate(2006, 8, 16), EncodeDate(2006, 8, 16)]);

    // Options
    Result.Options.AllowHtml(True);
    Result.Options.SetAsBoolean('showRowNumber', True);
    Result.Options.Width(550);

    // Formatter
    Result.ScripCodeBeforeCallDraw :=
        'var formatter_long = new google.visualization.DateFormat({formatType: ''long''});'
      + 'var formatter_medium = new google.visualization.DateFormat({formatType: ''medium''});'
      + 'var formatter_short = new google.visualization.DateFormat({formatType: ''short''});'
      + 'formatter_long.format(data, 1);'
      + 'formatter_medium.format(data, 2);'
      + 'formatter_short.format(data, 3);'
    ;
  end;

  function GetChartNumberFormat: IcfsGChartProducer;
  begin
    Result := TcfsGChartProducer.Create;
    Result.ClassChartType := TcfsGChartProducer.CLASS_TABLE_CHART;

    // Data
    Result.Data.DefineColumns([
      TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Department'),
      TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Revenues')
    ]);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Shoes');
    Result.Data.SetValue(1, 10700);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Sports');
    Result.Data.SetValue(1, -15400);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Toys');
    Result.Data.SetValue(1, 12500);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Electronics');
    Result.Data.SetValue(1, -2100);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Food');
    Result.Data.SetValue(1, 22600);

    Result.Data.AddRow;
    Result.Data.SetValue(0, 'Art');
    Result.Data.SetValue(1, 1100);

    // Options
    Result.Options.AllowHtml(True);
    Result.Options.SetAsBoolean('showRowNumber', True);
    Result.Options.Width(550);

    // Formatter
    Result.ScripCodeBeforeCallDraw :=
        'var formatter = new google.visualization.NumberFormat({prefix: ''$'', negativeColor: ''red'', negativeParens: true});'
      + 'formatter.format(data, 1);'
    ;
  end;

 function GetChartPatternFormat: IcfsGChartProducer;
  begin
    Result := TcfsGChartProducer.Create;
    Result.ClassChartType := TcfsGChartProducer.CLASS_TABLE_CHART;


    // Data
    Result.Data.DefineColumns([
      TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Name'),
      TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Email')
    ]);

    Result.Data.AddRow(  ['John Lennon', 'john@beatles.co.uk'] );
    Result.Data.AddRow(  ['Paul McCartney', 'paul@beatles.co.uk'] );
    Result.Data.AddRow(  ['George Harrison', 'george@beatles.co.uk'] );
    Result.Data.AddRow(  ['Ringo Starr', 'ringo@beatles.co.uk'] );

    // Options
    Result.Options.AllowHtml(True);
    Result.Options.SetAsBoolean('showRowNumber', True);
    Result.Options.Width(550);

    // Formatter
    //Result.UseDataView := True; // <---- ATTENTION: In this formatter example we UseDataView to Hide email column after draw!
    Result.ScripCodeBeforeCallDraw :=
        'var formatter = new google.visualization.PatternFormat(''<a href="mailto:{1}">{0}</a>'');'
      + 'formatter.format(data, [0, 1]);'
      + 'var view = new google.visualization.DataView(data);' // <-- Create a Data View
      + 'view.setColumns([0]);'; // Show the first column only (hide email column)
    ;
  end;

begin
  // Generate
  GChartsFrame.DocumentInit;
  GChartsFrame.DocumentSetBody(
       '<div style="display: flex; width: 100%; height: 30%;">'
    +     '<div style="width: 10%; height: 100%;"></div>'
    +     '<div style="width: 40%; height: 100%;">'
    +       '<div style="font-family: Arial; font-size:12px; font-weight:bold"><br>Arrow Format<br><br></div>'
    +       '<div id="ChartArrowFormat"></div>'
    +     '</div>'
    +     '<div style="width: 50%; height: 100%;">'
    +       '<div style="font-family: Arial; font-size:12px; font-weight:bold"><br>Date Format<br><br></div>'
    +       '<div id="ChartDateFormat"></div>'
    +     '</div>'
    +  '</div>'
    + '<div style="display: flex; width: 100%; height: 30%;">'
    +     '<div style="width: 10%; height: 100%;"></div>'
    +     '<div style="width: 40%; height: 100%;">'
    +       '<div style="font-family: Arial; font-size:12px; font-weight:bold"><br>Bar Format<br><br></div>'
    +       '<div id="ChartBarFormat"></div>'
    +     '</div>'
    +     '<div style="width: 50%; height: 100%;">'
    +       '<div style="font-family: Arial; font-size:12px; font-weight:bold"><br>Number Format<br><br></div>'
    +       '<div id="ChartNumberFormat"></div>'
    +     '</div>'
    +  '</div>'
    + '<div style="display: flex; width: 100%; height: 30%;">'
    +     '<div style="width: 10%; height: 100%;"></div>'
    +     '<div style="width: 40%; height: 100%;">'
    +       '<div style="font-family: Arial; font-size:12px; font-weight:bold"><br>Color Format<br><br></div>'
    +       '<div id="ChartColorFormat"></div>'
    +     '</div>'
    +     '<div style="width: 50%; height: 100%;">'
    +       '<div style="font-family: Arial; font-size:12px; font-weight:bold"><br>Pattern Format<br><br></div>'
    +       '<div id="ChartPatternFormat"></div>'
    +     '</div>'
    + '</div>'
    + '<div style="display: flex; width: 100%; height: 10%;">'
    +   '<div style="width:100%;font-family: Arial; font-size:14px; text-align: center;"><br><br>Note: click the column headings to sort</div>'
    + '</div>'
  );

  GChartsFrame.DocumentGenerate('ChartArrowFormat', GetChartArrowFormat);
  GChartsFrame.DocumentGenerate('ChartBarFormat', GetChartBarFormat);
  GChartsFrame.DocumentGenerate('ChartColorFormat', GetChartColorFormat);
  GChartsFrame.DocumentGenerate('ChartDateFormat', GetChartDateFormat);
  GChartsFrame.DocumentGenerate('ChartNumberFormat', GetChartNumberFormat);
  GChartsFrame.DocumentGenerate('ChartPatternFormat', GetChartPatternFormat);
  GChartsFrame.DocumentPost;
end;

initialization
  RegisterClass(TDemo_Miscellaneous_Formatters);

end.


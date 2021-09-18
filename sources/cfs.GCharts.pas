// ***************************************************************************
//
// Delphi Google Charts
//
// Copyright (c) 2021 Josep Pagès
//
// https://github.com/JosepPages7/DelphiGCharts
//
//
// ***************************************************************************
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// *************************************************************************** }

unit cfs.GCharts;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Variants,
  Generics.Collections,
  Data.DB;

type
  TcfsJSCode = string;
  TcfsGChartDataType = (gcdtString, gcdtNumber, gcdtBoolean, gcdtDate, gcdtDateTime, gcdtTimeOfDay);

  TcfsGChartDataCol = record
  private
  public
    const ROLE_ANOTATION = 'annotation';
    const ROLE_ANOTATION_TEXT = 'annotationText';
    const ROLE_CERTAINTY = 'certainty';
    const ROLE_EMPHASIS = 'emphasis';
    const ROLE_INTERVAL = 'interval';
    const ROLE_SCOPE = 'scope';
    const ROLE_STYLE = 'style';
    const ROLE_TOOLTIP = 'tooltip';
    const ROLE_DOMAIN = 'domain';
  public
    Id: string;
    DataType: TcfsGChartDataType;
    DisplayLabel: string;
    Role: string;
    class function Create(const DataType: TcfsGChartDataType; const DisplayLabel: string = ''; const Role: string = ''; const Id: string = ''): TcfsGChartDataCol; static;
  end;

  TcfsGChartData = class;

  IcfsGChartData = interface
    ['{3B9A70D3-08F7-4BEA-8D91-A74EF6436C5B}']
    procedure Clear;
    procedure BeginDefineColumns;
    procedure EndDefineColumns;
    procedure DefineColumns(const Columns: array of TcfsGChartDataCol);
    procedure AssignFromDataSet(SourceDataSet: TDataSet);
    procedure Assign(Source: TcfsGChartData); overload;
    procedure Assign(Source: IcfsGChartData); overload;
    procedure AddColum(Col: TcfsGChartDataCol); overload;
    procedure AddColum(const DataType: TcfsGChartDataType; const DisplayLabel: string = ''; const Role: string = ''; const Id: string = ''); overload;
    procedure AddRow(const Values: TArray<Variant>); overload;
    procedure AddRow; overload;
    procedure SetValue(const ColIndex: Integer; Value: Variant; const FormattedValue: string = ''); overload;
    function GetValue(const RowIndex, ColIndex: Integer): Variant;
    function GetFormatedValue(const RowIndex, ColIndex: Integer): Variant;
    function ToJSDataTable: TcfsJSCode;
    function GetColumns: TList<TcfsGChartDataCol>;

    property Columns: TList<TcfsGChartDataCol> read GetColumns;
  end;

  TcfsGChartDataRow = class
  private
    FValues: TList<Variant>;
    FFormatedValues: TList<Variant>;
  public
    constructor Create;
    destructor Destroy; override;

    property Values: TList<Variant> read FValues;
    property FormatedValues: TList<Variant> read FFormatedValues;
  end;

  TcfsGChartData = class(TInterfacedObject, IcfsGChartData)
  strict private
    FData: TObjectList<TcfsGChartDataRow>;
    FColumns: TList<TcfsGChartDataCol>;
    FDefiningColumns: Boolean;
    function GetColumns: TList<TcfsGChartDataCol>;
    procedure CheckRowIndex(RowIndex: Integer);
    procedure CheckColIndex(ColIndex: Integer);
    procedure CheckDataSetActive;
    procedure CreateInternalData;
    function AddInternalDataRow: TcfsGChartDataRow;
  protected
    const JS_TRUE = 'true';
    const JS_FALSE = 'false';
  private
  protected
    class function VariantIsNull(const Value: Variant): Boolean; static;
    class function BooleanToJS(const Value: Boolean): TcfsJSCode; static;
    class function DateToJS(Value: TDate): TcfsJSCode; static;
    class function DateTimeToJS(Value: TDateTime): TcfsJSCode; static;
    class function NumberToJS(Value: Extended): TcfsJSCode; static;
    class function StringToQuotedJS(const Value: string): TcfsJSCode; static;
    class function StringToUnquotedJS(const Value: string): TcfsJSCode; static;
    class function TimeToJS(Value: TDateTime): TcfsJSCode; static;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure BeginDefineColumns;
    procedure EndDefineColumns;
    procedure DefineColumns(const Columns: array of TcfsGChartDataCol);
    procedure AssignFromDataSet(SourceDataSet: TDataSet);
    procedure Assign(Source: TcfsGChartData); overload;
    procedure Assign(Source: IcfsGChartData); overload;
    procedure AddColum(Col: TcfsGChartDataCol); overload;
    procedure AddColum(const DataType: TcfsGChartDataType; const DisplayLabel: string= ''; const Role: string = ''; const Id: string = ''); overload;
    procedure AddRowValues(const Values: TArray<Variant>); overload;
    procedure AddRow(const Values: TArray<Variant>); overload;
    procedure AddRow; overload;
    procedure SetValue(const ColIndex: Integer; Value: Variant; const FormattedValue: string = '');
    function GetValue(const RowIndex, ColIndex: Integer): Variant;
    function GetFormatedValue(const RowIndex, ColIndex: Integer): Variant;
    function ToJSDataTable: TcfsJSCode;

    property Columns: TList<TcfsGChartDataCol> read GetColumns;
  end;

  TcfsGChartOptions = class
  strict private
    FOptionsList: TStringList;
    function VariantToStr(const OptionName: string; const Value: Variant): string;
    class procedure RemoveLastComma(var Value: string); static;
  public
    constructor Create;
    destructor Destroy; override;
    class function TextStyleToJSObject(const Color: string; const FontSize: Integer; Bold: Boolean; Italic: Boolean; const FontName: string = '';
      const AuraColor: string = ''; const Opacity: Extended = 1): TcfsJSCode; static;
    class function ArrayOfStringToJS(const Values: TArray<TcfsJSCode>): TcfsJSCode; static;
    class function ArrayOfStringToJSArrayOfObjects(const Values: TArray<TcfsJSCode>): TcfsJSCode; static;
    class function ArrayOfStringToJSObjectWithNestedObjects(const Values: TArray<TcfsJSCode>): TcfsJSCode; static;
    function ToJSCode: TcfsJSCode;
    procedure Clear;
    procedure SetAsUnquotedStr(const Name, Value: string);
    procedure SetAsQuotedStr(const Name, Value: string);
    procedure SetAsFloat(const Name: string; Value: Extended);
    procedure SetAsInteger(const Name: string; Value: Integer);
    procedure SetAsBoolean(const Name: string; Value: Boolean);
    procedure SetAsVariant(const Name: string; const Value: Variant);
    procedure SetAsJSCode(const Name: string; JSCode: TcfsJSCode);
    procedure SetAsObject(const ObjectName, OptionName, Value: string);
    procedure SetAsArrayOfStrings(const ObjectName: string; Values: TArray<TcfsJSCode>);
    procedure SetAsArrayOfJSCode(const ObjectName: string; Values: TArray<TcfsJSCode>);
    procedure SetAsArrayOfObjects(const ObjectName: string; Values: TArray<TcfsJSCode>);
    procedure SetAsObjectWithNestedObjects(const ObjectName: string; Values: TArray<TcfsJSCode>);

    procedure AllowHtml(const Value: Boolean);
    procedure Animation(const SubOptionName: string; const Value: Variant);
    procedure Annotations(const SubOptionName: string; const Value: Variant);
    procedure Axes(const SubOptionName: string; const Value: Variant);
    procedure Bar(const SubOptionName: string; const Value: Variant);
    procedure BoxStyle(const SubOptionName: string; const Value: Variant);
    procedure Bubble(const SubOptionName: string; const Value: Variant);
    procedure BackgroundColor(const Value: string); overload;
    procedure BackgroundColor(const SubOptionName: string; const Value: Variant); overload;
    procedure Calendar(const SubOptionName: string; const Value: Variant);
    procedure Candlestick(const SubOptionName: string; const Value: Variant);
    procedure ChartArea(const SubOptionName: string; const Value: Variant);
    procedure ColorAxis(const SubOptionName: string; const Value: Variant);
    procedure Colors(const Values: TArray<string>);
    procedure Crosshair(const SubOptionName: string; const Value: Variant);
    procedure CurveType(const Value: string);
    procedure DefaultColor(const Value: string);
    procedure DatalessRegionColor(const Value: string);
    procedure DataOpacity(const Value: Extended);
    procedure Diff(const SubOptionName: string; const Value: Variant);
    procedure DisplayAnnotations(const Value: Boolean);
    procedure DisplayMode(const Value: string);
    procedure DateFormat(const Value: string);
    procedure EnableInteractivity(const Value: Boolean);
    procedure FontName(const Value: string);
    procedure FontSize(const Value: Word);
    procedure Gantt(const SubOptionName: string; const Value: Variant);
    procedure HAxis(const SubOptionName: string; const Value: Variant);
    procedure Height(const Value: Variant);
    procedure Histogram(const SubOptionName: string; const Value: Variant);
    procedure Interval(const SubOptionName: string; const Value: Variant);
    procedure Intervals(const SubOptionName: string; const Value: Variant);
    procedure InterpolateNulls(Value: Variant);
    procedure Is3D(const Value: Boolean);
    procedure IsStacked(const Value: Boolean); overload;
    procedure IsStacked(const Value: string); overload;
    procedure Legend(const SubOptionName: string; const Value: Variant);
    procedure LineWidth(const Value: Extended);
    procedure NoDataPattern(const SubOptionName: string; const Value: Variant);
    procedure PieHole(const Value: Extended);
    procedure PieSliceText(const Value: string);
    procedure PieSliceTextStyle(const Value: Variant);
    procedure PieStartAngle(const Value: Extended);
    procedure PointShape(const Value: string);
    procedure PointSize(const Value: Integer);
    procedure Region(const Value: string);
    procedure RedFrom(const Value: Integer);
    procedure RedTo(const Value: Integer);
    procedure YellowFrom(const Value: Integer);
    procedure YellowTo(const Value: Integer);
    procedure MinorTicks(const Value: Integer);
    procedure Series(const Values: TArray<TcfsJSCode>);
    procedure SeriesType(const Value: string);
    procedure SizeAxis(const SubOptionName: string; const Value: Variant);
    procedure Slices(const Values: TArray<TcfsJSCode>);
    procedure Subtitle(const Value: string);
    procedure Title(const Value: string);
    procedure TitleTextStyle(const Value: Variant);
    procedure TrendLines(const Values: TArray<TcfsJSCode>);
    procedure Timeline(const SubOptionName: string; const Value: Variant);
    procedure Tooltip(const SubOptionName: string; const Value: Variant);
    procedure VAxes(const Values: TArray<TcfsJSCode>);
    procedure VAxis(const SubOptionName: string; const Value: Variant);
    procedure Width(const Value: Variant);
  end;

  IcfsGChartProducer = interface
    ['{A7141427-7308-458F-A1D0-228CA38E1C5F}']
    function GenerateJSCode(const ChartId: string; AddSelectEvent: Boolean = False; const JSAjaxRequest: string = ''; const JSName: string = ''): TcfsJSCode;
    function GetClassChartType: string;
    function GetData: TcfsGChartData;
    function GetOldData: TcfsGChartData;
    function GetOptions: TcfsGChartOptions;
    function GetLibraryLanguage: string;
    function GetLibraryMapsApiKey: string;
    function GetLibraryPackage: string;
    function GetLibrarySafeLoad: Boolean;
    function GetLibraryVersion: string;
    function GetScripCodeAfterCallDraw: string;
    function GetScripCodeBeforeCallDraw: string;
    procedure SetScripCodeAfterCallDraw(const Value: string);
    procedure SetScripCodeBeforeCallDraw(const Value: string);
    procedure SetLibraryLanguage(const Value: string);
    procedure SetLibraryMapsApiKey(const Value: string);
    procedure SetLibraryPackage(const Value: string);
    procedure SetLibrarySafeLoad(const Value: Boolean);
    procedure SetLibraryVersion(const Value: string);
    procedure SetClassChartType(const Value: string);

    property ClassChartType: string read GetClassChartType write SetClassChartType;
    property Data: TcfsGChartData read GetData;
    property OldData: TcfsGChartData read GetOldData;
    property LibraryVersion: string read GetLibraryVersion write SetLibraryVersion;
    property LibraryPackage: string read GetLibraryPackage write SetLibraryPackage;
    property LibraryLanguage: string read GetLibraryLanguage write SetLibraryLanguage;
    property LibraryMapsApiKey: string read GetLibraryMapsApiKey write SetLibraryMapsApiKey;
    property LibrarySafeLoad: Boolean read GetLibrarySafeLoad write SetLibrarySafeLoad;
    property ScripCodeBeforeCallDraw: string read GetScripCodeBeforeCallDraw write SetScripCodeBeforeCallDraw;
    property ScripCodeAfterCallDraw: string read GetScripCodeAfterCallDraw write SetScripCodeAfterCallDraw;
    property Options: TcfsGChartOptions read GetOptions;
  end;

  TcfsGChartProducer = class(TInterfacedObject, IcfsGChartProducer)
  strict private
    FClassChartType: string;
    FData: TcfsGChartData;
    FOldData: TcfsGChartData;
    FOptions: TcfsGChartOptions;
    FLibraryPackage: string;
    FLibraryLanguage: string;
    FLibraryVersion: string;
    FLibraryMapsApiKey: string;
    FLibrarySafeLoad: Boolean;
    FScripCodeAfterCallDraw: string;
    FScripCodeBeforeCallDraw: string;
    function GetClassChartType: string;
    function GetData: TcfsGChartData;
    function GetOptions: TcfsGChartOptions;
    procedure SetClassChartType(const Value: string);
    function GetOldData: TcfsGChartData;
    function GetLibraryLanguage: string;
    function GetLibraryMapsApiKey: string;
    function GetLibraryPackage: string;
    function GetLibrarySafeLoad: Boolean;
    function GetLibraryVersion: string;
    function GetScripCodeAfterCallDraw: string;
    function GetScripCodeBeforeCallDraw: string;
    procedure SetLibraryLanguage(const Value: string);
    procedure SetLibraryMapsApiKey(const Value: string);
    procedure SetLibraryPackage(const Value: string);
    procedure SetLibrarySafeLoad(const Value: Boolean);
    procedure SetLibraryVersion(const Value: string);
    procedure SetScripCodeAfterCallDraw(const Value: string);
    procedure SetScripCodeBeforeCallDraw(const Value: string);
  protected
  public
    const PREFIX_DRAW_CHART_FUNCTION_NAME = 'draw';

    const LIBRARY_VERSION_CURRENT = 'current';
    const LIBRARY_VERSION_UPCOMING = 'upcoming';

    const CLASS_ANNOTATION_CHART = 'AnnotationChart';
    const CLASS_AREA_CHART = 'AreaChart';
    const CLASS_BAR_CHART = 'BarChart';
    const CLASS_MATERIAL_BAR_CHART = 'Bar';
    const CLASS_COLUMN_CHART = 'ColumnChart';
    const CLASS_MATERIAL_COLUMN_CHART = 'Column';
    const CLASS_CALENDAR_CHART = 'Calendar';
    const CLASS_BUBBLE_CHART = 'BubbleChart';
    const CLASS_CANDLESTICK_CHART = 'CandlestickChart';
    const CLASS_COMBO_CHART = 'ComboChart';
    const CLASS_GANTT_CHART = 'Gantt';
    const CLASS_GAUGE_CHART = 'Gauge';
    const CLASS_GEO_CHART = 'GeoChart';
    const CLASS_HISTOGRAM_CHART = 'Histogram';
    const CLASS_LINE_CHART = 'LineChart';
    const CLASS_MATERIAL_LINE_CHART = 'Line';
    const CLASS_ORG_CHART = 'OrgChart';
    const CLASS_PIE_CHART = 'PieChart';
    const CLASS_SANKEY_CHART = 'Sankey';
    const CLASS_SCATTER_CHART = 'ScatterChart';
    const CLASS_MATERIAL_SCATTER_CHART = 'Scatter';
    const CLASS_STEPPED_AREA_CHART = 'SteppedAreaChart';
    const CLASS_TABLE_CHART = 'Table';
    const CLASS_TIMELINE_CHART = 'Timeline';
    const CLASS_TREE_MAP_CHART = 'TreeMap';
    const CLASS_WORD_TREE_CHART = 'WordTree';

    const PACKAGE_ANNOTATION_CHART = 'annotationchart';
    const PACKAGE_CORE_CHART = 'corechart';
    const PACKAGE_MATERIAL_BAR ='bar';
    const PACKAGE_CALENDAR = 'calendar';
    const PACKAGE_GANTT = 'gantt';
    const PACKAGE_GAUGE = 'gauge';
    const PACKAGE_GEO_CHART = 'geochart';
    const PACKAGE_SANKEY = 'sankey';
    const PACKAGE_MATERIAL_LINE = 'line';
    const PACKAGE_ORG_CHART = 'orgchart';
    const PACKAGE_MATERIAL_SCATTER = 'scatter';
    const PACKAGE_TABLE = 'table';
    const PACKAGE_TIMELINE = 'timeline';
    const PACKAGE_TREE_MAP = 'treemap';
    const PACKAGE_WORD_TREE = 'wordtree';
  public
    constructor Create;
    destructor Destroy; override;
    function GenerateJSCode(const ChartId: string; AddSelectEvent: Boolean = False; const JSAjaxRequest: string = ''; const JSName: string = ''): TcfsJSCode;
    property ClassChartType: string read GetClassChartType write SetClassChartType;
    property Data: TcfsGChartData read GetData;
    property OldData: TcfsGChartData read GetOldData;
    property LibraryVersion: string read GetLibraryVersion write SetLibraryVersion;
    property LibraryPackage: string read GetLibraryPackage write SetLibraryPackage;
    property LibraryLanguage: string read GetLibraryLanguage write SetLibraryLanguage;
    property LibrarySafeLoad: Boolean read GetLibrarySafeLoad write SetLibrarySafeLoad;
    property LibraryMapsApiKey: string read GetLibraryMapsApiKey write SetLibraryMapsApiKey;
    property Options: TcfsGChartOptions read GetOptions;
    property ScripCodeBeforeCallDraw: string read GetScripCodeBeforeCallDraw write SetScripCodeBeforeCallDraw;
    property ScripCodeAfterCallDraw: string read GetScripCodeAfterCallDraw write SetScripCodeAfterCallDraw;
  end;

implementation

uses
  System.DateUtils;

type
  TGChartPackageAndType = record
    ClassChartType: string;
    Package: string;
    MaterialDesign: Boolean;
  end;

const
  GChartPackagesAndTypes : array[0..25] of TGChartPackageAndType =
  (
    (ClassChartType: TcfsGChartProducer.CLASS_AREA_CHART;             Package: TcfsGChartProducer.PACKAGE_CORE_CHART;        MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_BAR_CHART;              Package: TcfsGChartProducer.PACKAGE_CORE_CHART;        MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_COLUMN_CHART;           Package: TcfsGChartProducer.PACKAGE_CORE_CHART;        MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_LINE_CHART;             Package: TcfsGChartProducer.PACKAGE_CORE_CHART;        MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_PIE_CHART;              Package: TcfsGChartProducer.PACKAGE_CORE_CHART;        MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_SCATTER_CHART;          Package: TcfsGChartProducer.PACKAGE_CORE_CHART;        MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_MATERIAL_BAR_CHART;     Package: TcfsGChartProducer.PACKAGE_MATERIAL_BAR;      MaterialDesign: True),
    (ClassChartType: TcfsGChartProducer.CLASS_MATERIAL_COLUMN_CHART;  Package: TcfsGChartProducer.PACKAGE_MATERIAL_BAR;      MaterialDesign: True),
    (ClassChartType: TcfsGChartProducer.CLASS_MATERIAL_SCATTER_CHART; Package: TcfsGChartProducer.PACKAGE_MATERIAL_SCATTER;  MaterialDesign: True),
    (ClassChartType: TcfsGChartProducer.CLASS_MATERIAL_LINE_CHART;    Package: TcfsGChartProducer.PACKAGE_MATERIAL_LINE;     MaterialDesign: True),
    (ClassChartType: TcfsGChartProducer.CLASS_BUBBLE_CHART;           Package: TcfsGChartProducer.PACKAGE_CORE_CHART;        MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_CANDLESTICK_CHART;      Package: TcfsGChartProducer.PACKAGE_CORE_CHART;        MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_COMBO_CHART;            Package: TcfsGChartProducer.PACKAGE_CORE_CHART;        MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_HISTOGRAM_CHART;        Package: TcfsGChartProducer.PACKAGE_CORE_CHART;        MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_STEPPED_AREA_CHART;     Package: TcfsGChartProducer.PACKAGE_CORE_CHART;        MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_ANNOTATION_CHART;       Package: TcfsGChartProducer.PACKAGE_ANNOTATION_CHART;  MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_CALENDAR_CHART;         Package: TcfsGChartProducer.PACKAGE_CALENDAR;          MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_GANTT_CHART;            Package: TcfsGChartProducer.PACKAGE_GANTT;             MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_GAUGE_CHART;            Package: TcfsGChartProducer.PACKAGE_GAUGE;             MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_GEO_CHART;              Package: TcfsGChartProducer.PACKAGE_GEO_CHART;         MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_ORG_CHART;              Package: TcfsGChartProducer.PACKAGE_ORG_CHART;         MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_TABLE_CHART;            Package: TcfsGChartProducer.PACKAGE_TABLE;             MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_TIMELINE_CHART;         Package: TcfsGChartProducer.PACKAGE_TIMELINE;          MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_TREE_MAP_CHART;         Package: TcfsGChartProducer.PACKAGE_TREE_MAP;          MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_SANKEY_CHART;           Package: TcfsGChartProducer.PACKAGE_SANKEY;            MaterialDesign: False),
    (ClassChartType: TcfsGChartProducer.CLASS_WORD_TREE_CHART;        Package: TcfsGChartProducer.PACKAGE_WORD_TREE;         MaterialDesign: False)
  ) ;

{ TcfsGChartDataCol }

class function TcfsGChartDataCol.Create(const DataType: TcfsGChartDataType; const DisplayLabel: string = ''; const Role: string = ''; const Id: string = ''): TcfsGChartDataCol;
begin
  Result.Id := Id.Trim;
  Result.DataType := DataType;
  Result.DisplayLabel := DisplayLabel;
  Result.Role := Role.Trim;
end;

{ TcfsGChartDataRow }

constructor TcfsGChartDataRow.Create;
begin
  FValues := TList<Variant>.Create;
  FFormatedValues := TList<Variant>.Create;
end;

destructor TcfsGChartDataRow.Destroy;
begin
  FValues.Free;
  FFormatedValues.Free;

  inherited;
end;

{ TcfsGChartData }

constructor TcfsGChartData.Create;
begin
  FColumns := TList<TcfsGChartDataCol>.Create;

  FData := TObjectList<TcfsGChartDataRow>.Create;
end;

destructor TcfsGChartData.Destroy;
begin
  FColumns.Free;
  FData.Free;

  inherited;
end;

procedure TcfsGChartData.Clear;
begin
  FColumns.Clear;
  FData.Clear;
end;

procedure TcfsGChartData.BeginDefineColumns;
begin
  Clear;
  FDefiningColumns := True;
end;

procedure TcfsGChartData.EndDefineColumns;
begin
  FDefiningColumns := False;
  CreateInternalData;
end;

class function TcfsGChartData.BooleanToJS(const Value: Boolean): TcfsJSCode;
begin
  if Value then
    Result := JS_TRUE
  else
    Result := JS_FALSE;
end;

class function TcfsGChartData.NumberToJS(Value: Extended): string;

  function FormatSettingsJSNumeric: TFormatSettings;
  begin
    Result.ThousandSeparator := ',';
    Result.DecimalSeparator := '.';
    Result.NegCurrFormat := 0;
  end;

begin
  Result := Format('%g', [Value], FormatSettingsJSNumeric);
end;

procedure TcfsGChartData.DefineColumns(const Columns: array of TcfsGChartDataCol);
var
  Col: TcfsGChartDataCol;
begin
  Clear;
  for Col in Columns do
    FColumns.Add(Col);
  EndDefineColumns;
end;

procedure TcfsGChartData.AddColum(Col: TcfsGChartDataCol);
begin
  if not FDefiningColumns then
    raise Exception.Create(ClassName + ': Not in DefiningColumns State');

  FColumns.Add(Col);
end;

procedure TcfsGChartData.AddColum(const DataType: TcfsGChartDataType; const DisplayLabel: string = ''; const Role: string = ''; const Id: string = '');
var
  Col: TcfsGChartDataCol;
begin
  Col.Id := Id.Trim;
  Col.DataType := DataType;
  Col.DisplayLabel := DisplayLabel;
  Col.Role := Role.Trim;
  AddColum(Col);
end;

function TcfsGChartData.GetColumns: TList<TcfsGChartDataCol>;
begin
  Result := FColumns;
end;

function TcfsGChartData.GetFormatedValue(const RowIndex, ColIndex: Integer): Variant;
begin
  CheckRowIndex(RowIndex);
  CheckColIndex(ColIndex);
  Result := FData[RowIndex].FValues[ColIndex];
end;

function TcfsGChartData.GetValue(const RowIndex, ColIndex: Integer): Variant;
begin
  CheckRowIndex(RowIndex);
  CheckColIndex(ColIndex);
  Result := FData[RowIndex].FFormatedValues[ColIndex];
end;

class function TcfsGChartData.DateToJS(Value: TDate): string;
var
  yy, mm, dd: Word;
begin
  // JavaScript Date object (zero-based month)

  DecodeDate(Value, yy, mm, dd);
  Result := Format('new Date(%d,%d,%d)', [yy, mm-1, dd]);
end;

class function TcfsGChartData.DateTimeToJS(Value: TDateTime): string;
var
  yy, mm, dd, hh, nn, ss, ms: Word;
begin
  // JavaScript DateTime object (zero-based month)

  if TimeOf(Value) = 0 then  // no Time
    Result := DateToJS(Value)
  else if DateOf(Value) = 0 then  // no Date
  begin
    DecodeDateTime(Value, yy, mm, dd, hh, nn, ss, ms);
    Result := Format('new Date(0,0,0,%d,%d,%d)', [hh, nn, ss]);
  end
  else
  begin
    DecodeDateTime(Value, yy, mm, dd, hh, nn, ss, ms);
    Result := Format('new Date(%d,%d,%d,%d,%d,%d)', [yy, mm-1, dd, hh, nn, ss]);
  end;
end;

class function TcfsGChartData.TimeToJS(Value: TDateTime): string;
var
  hh, nn, ss, ms: Word;
begin
  DecodeTime(Value,hh, nn, ss, ms);
  Result := Format('[%d,%d,%d,%d]', [hh, nn, ss, ms]);
end;


class function TcfsGChartData.VariantIsNull(const Value: Variant): Boolean;
begin
  Result := VarIsClear(Value) or VarIsNull(Value) or (VarCompareValue(Value, Unassigned) = vrEqual);
end;

function TcfsGChartData.ToJSDataTable: TcfsJSCode;

  function GetDataType(DataType: TcfsGChartDataType): string;
  begin
    case DataType of
      gcdtNumber: Result := 'number';
      gcdtBoolean: Result := 'boolean';
      gcdtDate: Result := 'date';
      gcdtDateTime: Result := 'datetime';
      gcdtTimeOfDay: Result := 'timeofday';
    else
      Result := 'string';
    end;
  end;

  function VariantToStr(DataType: TcfsGChartDataType; const Value: Variant): TcfsJSCode;
  begin
    Result := '';
    if VariantIsNull(Value) then
      Exit;

    case DataType of
      gcdtString:     Result := StringToQuotedJS(Value);
      gcdtNumber:     Result := NumberToJS(Value);
      gcdtBoolean:    Result := BooleanToJS(Value);
      gcdtDate:       Result := DateTimeToJS(Value);
      gcdtDateTime:   Result := DateTimeToJS(Value);
      gcdtTimeOfDay:  Result := TimeToJS(Value);
    end;
  end;

var
  I: Integer;
  DataTable: TStringBuilder;
  Row: TcfsGChartDataRow;
  Col: TcfsGChartDataCol;
begin
  CheckDataSetActive;

  DataTable := TStringBuilder.Create;
  try
    // Titles Row
    DataTable.Append('[');
    for I := 0 to FColumns.Count -1  do
    begin
      if I > 0 then
        DataTable.Append(',');

      Col := FColumns[I];
      if Col.DisplayLabel.Trim.IsEmpty and Col.Id.IsEmpty and Col.Role.IsEmpty  then
        DataTable.Append(Format('{type: %s}', [QuotedStr(GetDataType(Col.DataType))]))
      else if Col.Role.IsEmpty and Col.Id.IsEmpty then
        DataTable.Append(Format('{label: %s, type: %s}', [TcfsGChartData.StringToQuotedJS(Col.DisplayLabel), QuotedStr(GetDataType(Col.DataType)) ]))
      else
        DataTable.Append(Format('{label: %s, id: %s, type: %s, role: %s}', [TcfsGChartData.StringToQuotedJS(Col.DisplayLabel), TcfsGChartData.StringToQuotedJS(Col.Id), QuotedStr(GetDataType(Col.DataType)),
          QuotedStr(Col.Role) ]));
    end;
    DataTable.Append(']');

    // Data Rows
    for Row in FData do
    begin
      DataTable.Append(',[');

      for I := 0 to FColumns.Count -1  do
      begin
        if I > 0 then
          DataTable.Append(',');

        Col := FColumns[I];
        if VariantIsNull(Row.FValues[I]) then
          DataTable.Append('null')
        else
        begin
          if not VariantIsNull(Row.FormatedValues[I]) and (Row.FormatedValues[I] <> '') then
            DataTable.Append(Format('{v: %s, f: %s}', [VariantToStr(Col.DataType, Row.FValues[I]), TcfsGChartData.StringToQuotedJS(Row.FormatedValues[I]) ]))
          else
            DataTable.Append(VariantToStr(Col.DataType, Row.FValues[I]))
        end;
      end;
      DataTable.Append(']');
    end;
    Result := DataTable.ToString;
  finally
    DataTable.Free;
  end;
end;

procedure TcfsGChartData.AssignFromDataSet(SourceDataSet: TDataSet);

 function GetDataType(Field: TField): TcfsGChartDataType;
  begin
    if Field is TNumericField then
      Result := TcfsGChartDataType.gcdtNumber
    else if ( (Field is TDateField) ) then
      Result := TcfsGChartDataType.gcdtDate
    else if ( (Field is TDateTimeField) or (Field is TSQLTimeStampField) ) then
      Result := TcfsGChartDataType.gcdtDateTime
    else if (Field is TBooleanField) then
      Result := TcfsGChartDataType.gcdtBoolean
    else if (Field is TTimeField) then
      Result := TcfsGChartDataType.gcdtTimeOfDay
    else
      Result := TcfsGChartDataType.gcdtString;
  end;

var
  I: Integer;
  F: TField;
  Col: TcfsGChartDataCol;
begin
  if not Assigned(SourceDataSet) then
    raise Exception.Create(ClassName + ': SourceDataSet is nil');

  if not SourceDataSet.Active then
    raise Exception.Create(ClassName + ': SourceDataSet is not Active');

  Clear;

  // Create Columns
  for F in SourceDataSet.Fields do
  begin
    Col := TcfsGChartDataCol.Create(GetDataType(F), F.DisplayLabel);
    FColumns.Add(Col);
  end;

  CreateInternalData;

  // Copy Data
  SourceDataSet.DisableControls;
  try
    SourceDataSet.First;
    while not SourceDataSet.eof do
    begin
      AddInternalDataRow;
      for I := 0 to SourceDataSet.FieldCount - 1 do
        SetValue(I, SourceDataSet.Fields[I].Value, SourceDataSet.Fields[I].DisplayText);
      SourceDataSet.Next;
    end;
  finally
    SourceDataSet.EnableControls;
  end;
end;

procedure TcfsGChartData.CreateInternalData;
begin
  FData.Clear;
end;

procedure TcfsGChartData.AddRow(const Values: TArray<Variant>);
begin
  AddRowValues(Values);
end;

procedure TcfsGChartData.AddRow;
begin
  CheckDataSetActive;
  AddRowValues([]);
end;

function TcfsGChartData.AddInternalDataRow: TcfsGChartDataRow;
var
  I: Integer;
begin
  CheckDataSetActive;
  Result := TcfsGChartDataRow.Create;
  FData.Add(Result);
  for I := 0 to FColumns.Count -1 do
  begin
    Result.FValues.Add(Null);
    Result.FormatedValues.Add(Null);
  end;
end;

procedure TcfsGChartData.AddRowValues(const Values: TArray<Variant>);
var
  R: TcfsGChartDataRow;
  V: Variant;
  ColIndex: Integer;
begin
  R := AddInternalDataRow;
  ColIndex := 0;
  for V in Values do
  begin
    CheckColIndex(ColIndex);
    R.FValues[ColIndex] := V;
    Inc(ColIndex);
  end;
end;

procedure TcfsGChartData.Assign(Source: IcfsGChartData);
begin
  Assign(Source as TcfsGChartData);
end;

procedure TcfsGChartData.Assign(Source: TcfsGChartData);
var
  I: Integer;
  Sour: TcfsGChartDataCol;
  Dest: TcfsGChartDataCol;
  DestRow: TcfsGChartDataRow;
  SourRow: TcfsGChartDataRow;
begin
  if (Source = nil) or (Source = Self) then
    raise Exception.Create(ClassName + ': Assign Error');

  Clear;
  BeginDefineColumns;
  for Sour in Source.Columns do
  begin
    Dest := TcfsGChartDataCol.Create(Sour.DataType, Sour.DisplayLabel, Sour.Role, Sour.Id);
    AddColum(Dest);
  end;
  EndDefineColumns;

  // Copy Source Data
  for SourRow in Source.FData do
  begin
    DestRow := AddInternalDataRow;
    for I := 0 to Source.Columns.Count - 1 do
    begin
      DestRow.Values[I] := SourRow.Values[I];
      if not VariantIsNull(SourRow.FormatedValues[I]) then
        DestRow.FormatedValues[I] := SourRow.FormatedValues[I];
    end;
  end;
end;

procedure TcfsGChartData.CheckColIndex(ColIndex: Integer);
begin
  if (ColIndex < 0) or (ColIndex > FColumns.Count -1) then
    raise Exception.Create(ClassName + ': ColIndex out range');
end;

procedure TcfsGChartData.CheckDataSetActive;
begin
  if FDefiningColumns then
    raise Exception.Create(ClassName + ': DefiningColumns State is Active. Please call "EndDefineColumns" procedure to Add Data');

  if FColumns.Count = 0 then
    raise Exception.Create(ClassName + ': Has not Columns');
end;

procedure TcfsGChartData.CheckRowIndex(RowIndex: Integer);
begin
  if (RowIndex < 0) or (RowIndex > FData.Count - 1) then
    raise Exception.Create(ClassName + ': RowIndex out range');
end;

procedure TcfsGChartData.SetValue(const ColIndex: Integer; Value: Variant; const FormattedValue: string = '');
var
  R: TcfsGChartDataRow;
begin
  CheckColIndex(ColIndex);
  CheckDataSetActive;

  if FData.Count = 0 then
    raise Exception.Create(ClassName + ': Has not Active Row');
  R := FData[FData.Count - 1];

  R.FValues[ColIndex] := Value;
  if not FormattedValue.IsEmpty then
    R.FFormatedValues[ColIndex] := FormattedValue;
end;

class function TcfsGChartData.StringToQuotedJS(const Value: string): TcfsJSCode;
const
  SINGLE_QUOTE = '''';
begin
  Result := SINGLE_QUOTE + StringReplace(Value, SINGLE_QUOTE, '\' + SINGLE_QUOTE, [rfReplaceAll]) + SINGLE_QUOTE;
end;

class function TcfsGChartData.StringToUnquotedJS(const Value: string): TcfsJSCode;
begin
  Result := TcfsGChartData.StringToUnquotedJS(Value);
end;

{ TcfsGChartOptions }

constructor TcfsGChartOptions.Create;
begin
  FOptionsList := TStringList.Create;
  FOptionsList.Duplicates := TDuplicates.dupError;
  FOptionsList.CaseSensitive := False;
  FOptionsList.Sorted := False;
end;


destructor TcfsGChartOptions.Destroy;
begin
  FOptionsList.Free;

  inherited;
end;

procedure TcfsGChartOptions.Clear;
begin
  FOptionsList.Clear;
end;

function TcfsGChartOptions.ToJSCode: TcfsJSCode;
var
  I, Count: Integer;
  N, V: string;
  SB: TStringBuilder;
  IsObject: Boolean;
begin
  Result := '';
  if FOptionsList.Count = 0 then
    Exit;

  SB := TStringBuilder.Create;
  try
    Count := 0;
    for I := 0 to FOptionsList.Count - 1 do
    begin
      V := FOptionsList.ValueFromIndex[I];
      if not V.IsEmpty then
      begin
        if Count > 0 then
          SB.Append(',');

        IsObject := False;
        N := FOptionsList.Names[I];
        if N.StartsWith('{') then
          IsObject := True;
          if IsObject then
          SB.Append(Copy(N, 2) + ':{' + V + '}')
        else
          SB.Append(N + ':' + V);
        Inc(Count);
      end;
    end;

    Result := SB.ToString;
  finally
    SB.Free;
  end;
end;

procedure TcfsGChartOptions.CurveType(const Value: string);
begin
  SetAsQuotedStr('curveType', Value);
end;

procedure TcfsGChartOptions.DefaultColor(const Value: string);
begin
  SetAsQuotedStr('defaultColor', Value);
end;

procedure TcfsGChartOptions.DatalessRegionColor(const Value: string);
begin
  SetAsQuotedStr('datalessRegionColor', Value);
end;

procedure TcfsGChartOptions.DataOpacity(const Value: Extended);
begin
  SetAsFloat('dataOpacity', Value);
end;

procedure TcfsGChartOptions.SetAsUnquotedStr(const Name, Value: string);
begin
  SetAsJSCode(Name, Value);
end;

procedure TcfsGChartOptions.SetAsQuotedStr(const Name, Value: string);
begin
  SetAsJSCode(Name, TcfsGChartData.StringToQuotedJS(Value));
end;

procedure TcfsGChartOptions.SizeAxis(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('sizeAxis', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.SetAsFloat(const Name: string; Value: Extended);
begin
  SetAsJSCode(Name, TcfsGChartData.NumberToJS(Value));
end;

procedure TcfsGChartOptions.SetAsInteger(const Name: string; Value: Integer);
begin
  SetAsJSCode(Name, Value.ToString);
end;

procedure TcfsGChartOptions.Series(const Values: TArray<TcfsJSCode>);
begin
  SetAsArrayOfJSCode('series', Values);
end;

procedure TcfsGChartOptions.SeriesType(const Value: string);
begin
  SetAsQuotedStr('seriesType', Value);
end;

procedure TcfsGChartOptions.DateFormat(const Value: string);
begin
  SetAsQuotedStr('dateFormat', Value);
end;

procedure TcfsGChartOptions.SetAsArrayOfStrings(const ObjectName: string; Values: TArray<TcfsJSCode>);
begin
  SetAsJSCode(ObjectName, ArrayOfStringToJS(Values));
end;

procedure TcfsGChartOptions.SetAsArrayOfJSCode(const ObjectName: string; Values: TArray<TcfsJSCode>);
begin
  if High(Values) < 0 then
    Exit;

  if (Values[0].Trim <> '') and CharInSet(Values[0].TrimLeft[1], ['0'..'9']) then // Check if first chart is númeric so I interpret that is and object with nested objects
    SetAsObjectWithNestedObjects(ObjectName, Values)
  else // is an array of objects
    SetAsArrayOfObjects(ObjectName, Values);
end;

procedure TcfsGChartOptions.SetAsArrayOfObjects(const ObjectName: string; Values: TArray<TcfsJSCode>);
begin
  SetAsJSCode(ObjectName, ArrayOfStringToJSArrayOfObjects(Values));
end;

procedure TcfsGChartOptions.SetAsObjectWithNestedObjects(const ObjectName: string; Values: TArray<TcfsJSCode>);
begin
  SetAsJSCode(ObjectName, ArrayOfStringToJSObjectWithNestedObjects(Values));
end;

procedure TcfsGChartOptions.SetAsBoolean(const Name: string; Value: Boolean);
begin
  SetAsJSCode(Name, TcfsGChartData.BooleanToJS(Value));
end;

procedure TcfsGChartOptions.SetAsVariant(const Name: string; const Value: Variant);
begin
  SetAsJSCode(Name, VariantToStr(Name, Value));
end;

procedure TcfsGChartOptions.SetAsJSCode(const Name: string; JSCode: TcfsJSCode);
begin
  if JSCode.Trim.IsEmpty then
    Exit
  else
    FOptionsList.Values[Name] := JSCode;
end;

procedure TcfsGChartOptions.SetAsObject(const ObjectName, OptionName, Value: string);
var
  ObjectNameEx: string;
  V: string;
  OV: string;
begin
  //if Value.Trim.IsEmpty then
    //Exit;

  if ObjectName.Trim.IsEmpty then
    raise Exception.Create(ClassName + ': ObjectName is empty');

  ObjectNameEx := '{' + ObjectName;

  OV :=  OptionName + ':' + Value;

  V := FOptionsList.Values[ObjectNameEx];
  if V.IsEmpty then
  begin
    FOptionsList.Values[ObjectNameEx] := OV;
  end
  else
  begin
    FOptionsList.Values[ObjectNameEx] := V + ',' + OV;
  end;
end;

function TcfsGChartOptions.VariantToStr(const OptionName: string; const Value: Variant): string;

  function VariantIsNull(const Value: Variant): Boolean;
  begin
    Result := VarIsClear(Value) or VarIsNull(Value) or (VarCompareValue(Value, Unassigned) = vrEqual);
  end;

var
  basicType: Integer;
  s: string;
begin
  Result := '';
  if VariantIsNull(Value) then
    Exit;

  basicType := VarType(Value) and VarTypeMask;

  case basicType of
    varEmpty     : Exit;
    varNull      : Exit;
    varShortInt  : Result := Value;
    varSmallInt  : Result := Value;
    varInteger   : Result := Value;
    varSingle    : Result := TcfsGChartData.NumberToJS(Value);
    varDouble    : Result := TcfsGChartData.NumberToJS(Value);
    varCurrency  : Result := TcfsGChartData.NumberToJS(Value);
    varDate      : Result := TcfsGChartData.DateTimeToJS(Value);
    varBoolean   : Result := TcfsGChartData.BooleanToJS(Value);
    varByte      : Result := Value;
    varWord      : Result := Value;
    varUInt32    : Result := Value;
    varInt64     : Result := Value;
    varString, varUString    :
      begin
        s := Value;
        if s.TrimLeft.StartsWith('{') then
          Result := Value
        else if s.TrimLeft.StartsWith('[') then
          Result := Value
        else
          Result := TcfsGChartData.StringToQuotedJS(Value);
      end
  else
    raise Exception.Create(ClassName + '.' + OptionName + ': Value Incorrect');
  end;
end;

procedure TcfsGChartOptions.Timeline(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('timeline', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.Tooltip(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('tooltip', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.TrendLines(const Values: TArray<TcfsJSCode>);
begin
  SetAsArrayOfJSCode('trendlines', Values);
end;

procedure TcfsGChartOptions.Diff(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('diff', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.DisplayAnnotations(const Value: Boolean);
begin
  SetAsBoolean('displayAnnotations', Value);
end;

procedure TcfsGChartOptions.DisplayMode(const Value: string);
begin
  SetAsQuotedStr('displayMode', Value);
end;

procedure TcfsGChartOptions.EnableInteractivity(const Value: Boolean);
begin
  SetAsBoolean('enableInteractivity', Value)
end;

procedure TcfsGChartOptions.VAxes(const Values: TArray<TcfsJSCode>);
begin
  SetAsArrayOfJSCode('vAxes', Values);
end;

procedure TcfsGChartOptions.VAxis(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('vAxis', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.Width(const Value: Variant);
begin
  SetAsVariant('width', Value);
end;

procedure TcfsGChartOptions.HAxis(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('hAxis', SubOptionName, VariantToStr(SubOptionName, Value));
end;

class function TcfsGChartOptions.TextStyleToJSObject(const Color: string; const FontSize: Integer; Bold: Boolean; Italic: Boolean; const FontName: string = '';
  const AuraColor: string = ''; const Opacity: Extended = 1): TcfsJSCode;
var
  s: string;
begin
  Result := '';
  s := '';
  if not Color.Trim.IsEmpty then
    s := s + 'color:' + Color.QuotedString + ',';
  if not FontName.Trim.IsEmpty then
    s := s + 'fontName:' + FontName.QuotedString + ',';
  if FontSize <> 0 then
    s := s + 'fontSize:' + FontSize.ToString + ',';
  s := s + 'bold:' + TcfsGChartData.BooleanToJS(Bold) + ',';
  s := s + 'italic:' + TcfsGChartData.BooleanToJS(Italic) + ',';
  if not AuraColor.Trim.IsEmpty then
    s := s + 'auraColor:' + AuraColor.QuotedString + ',';
  if Opacity <> 1 then
    s := s + 'opacity:' + TcfsGChartData.NumberToJS(Opacity);

  if s <> '' then
  begin
    RemoveLastComma(s);
    Result := '{' + s + '}';
  end;
end;

procedure TcfsGChartOptions.Title(const Value: string);
begin
  SetAsQuotedStr('title', Value);
end;

procedure TcfsGChartOptions.TitleTextStyle(const Value: Variant);
begin
  SetAsVariant('titleTextStyle', Value);
end;

procedure TcfsGChartOptions.Subtitle(const Value: string);
begin
  SetAsQuotedStr('subtitle', Value);
end;

procedure TcfsGChartOptions.AllowHtml(const Value: Boolean);
begin
  SetAsBoolean('allowHtml', Value);
end;

procedure TcfsGChartOptions.Animation(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('animation', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.Annotations(const SubOptionName: string;  const Value: Variant);
begin
  SetAsObject('annotations', SubOptionName, VariantToStr(SubOptionName, Value));
end;

class function TcfsGChartOptions.ArrayOfStringToJS(const Values: TArray<TcfsJSCode>): string;
var
  s: string;
  v: string;
begin
  s := '[';
  for v in Values do
    s := s + TcfsGChartData.StringToQuotedJS(v) + ',';
  RemoveLastComma(s);
  s := s + ']';
  Result := s;
end;

class function TcfsGChartOptions.ArrayOfStringToJSArrayOfObjects(const Values: TArray<TcfsJSCode>): TcfsJSCode;
var
  s: string;
  v: string;
begin
  s := '[';
  for v in Values do
    s := s + '{' + v + '},';
  RemoveLastComma(s);
  s := s + ']';
  Result := s;
end;

class function TcfsGChartOptions.ArrayOfStringToJSObjectWithNestedObjects(const Values: TArray<TcfsJSCode>): TcfsJSCode;
var
  s: string;
  v: string;
begin
  s := '{';
  for v in Values do
    s := s + v + ',';
  RemoveLastComma(s);
  s := s + '}';
  Result := s;
end;

procedure TcfsGChartOptions.Axes(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('axes', SubOptionName, Value);
end;

procedure TcfsGChartOptions.BackgroundColor(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('backgroundColor', SubOptionName, Value);
end;

procedure TcfsGChartOptions.BackgroundColor(const Value: string);
begin
  SetAsQuotedStr('backgroundColor', Value);
end;

procedure TcfsGChartOptions.Bar(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('bar', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.BoxStyle(const SubOptionName: string;  const Value: Variant);
begin
  SetAsObject('boxStyle', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.Bubble(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('bubble', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.Calendar(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('calendar', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.Candlestick(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('candlestick', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.ChartArea(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('chartArea', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.ColorAxis(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('colorAxis', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.Colors(const Values: TArray<string>);
begin
  SetAsArrayOfStrings('colors', Values);
end;

procedure TcfsGChartOptions.Crosshair(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('crosshair', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.FontName(const Value: string);
begin
  SetAsQuotedStr('fontName', Value);
end;

procedure TcfsGChartOptions.FontSize(const Value: Word);
begin
  SetAsInteger('fontSize', Value);
end;

procedure TcfsGChartOptions.RedFrom(const Value: Integer);
begin
  SetAsInteger('redFrom', Value);
end;

procedure TcfsGChartOptions.RedTo(const Value: Integer);
begin
  SetAsInteger('redTo', Value);
end;

procedure TcfsGChartOptions.Region(const Value: string);
begin
  SetAsQuotedStr('region', Value);
end;

procedure TcfsGChartOptions.YellowFrom(const Value: Integer);
begin
  SetAsInteger('yellowFrom', Value);
end;

procedure TcfsGChartOptions.YellowTo(const Value: Integer);
begin
  SetAsInteger('yellowTo', Value);
end;

procedure TcfsGChartOptions.MinorTicks(const Value: Integer);
begin
  SetAsInteger('minorTicks', Value);
end;

procedure TcfsGChartOptions.Gantt(const SubOptionName: string;  const Value: Variant);
begin
  SetAsObject('gantt', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.Height(const Value: Variant);
begin
  SetAsVariant('height', Value);
end;

procedure TcfsGChartOptions.Histogram(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('histogram', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.Interval(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('interval', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.Intervals(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('intervals', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.InterpolateNulls(Value: Variant);
begin
  SetAsJSCode('interpolateNulls', VariantToStr('interpolateNulls', Value));
end;

procedure TcfsGChartOptions.Is3D(const Value: Boolean);
begin
  SetAsBoolean('is3D', Value);
end;

procedure TcfsGChartOptions.IsStacked(const Value: Boolean);
begin
  SetAsBoolean('isStacked', Value);
end;

procedure TcfsGChartOptions.IsStacked(const Value: string);
begin
  SetAsQuotedStr('isStacked', Value);
end;

procedure TcfsGChartOptions.Legend(const SubOptionName: string; const Value: Variant);
begin
  SetAsObject('legend', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.LineWidth(const Value: Extended);
begin
  SetAsFloat('lineWidth', Value);
end;

procedure TcfsGChartOptions.NoDataPattern(const SubOptionName: string;  const Value: Variant);
begin
  SetAsObject('noDataPattern', SubOptionName, VariantToStr(SubOptionName, Value));
end;

procedure TcfsGChartOptions.PieHole(const Value: Extended);
begin
  SetAsFloat('pieHole', Value);
end;

procedure TcfsGChartOptions.PieSliceText(const Value: string);
begin
  SetAsQuotedStr('pieSliceText', Value);
end;

procedure TcfsGChartOptions.PieSliceTextStyle(const Value: Variant);
begin
  SetAsVariant('pieSliceTextStyle', Value);
end;

procedure TcfsGChartOptions.PieStartAngle(const Value: Extended);
begin
  SetAsFloat('pieStartAngle', Value);
end;

procedure TcfsGChartOptions.PointShape(const Value: string);
begin
  SetAsQuotedStr('pointShape', Value);
end;

procedure TcfsGChartOptions.PointSize(const Value: Integer);
begin
  SetAsInteger('pointSize', Value);
end;

class procedure TcfsGChartOptions.RemoveLastComma(var Value: string);
begin
  Delete(Value, Length(Value), 1);
end;

procedure TcfsGChartOptions.Slices(const Values: TArray<TcfsJSCode>);
begin
  SetAsArrayOfJSCode('slices', Values);
end;

{ TcfsGChartProducer }

constructor TcfsGChartProducer.Create;
begin
  FData := TcfsGChartData.Create;
  FOptions := TcfsGChartOptions.Create;

  LibrarySafeLoad := True;
end;

destructor TcfsGChartProducer.Destroy;
begin
  FOptions.Free;
  FData.Free;
  if Assigned(FOldData) then
    FOldData.Free;

  inherited;
end;

function TcfsGChartProducer.GenerateJSCode(const ChartId: string; AddSelectEvent: Boolean = False; const JSAjaxRequest: string = ''; const JSName: string = ''): string;
var
  Id, T: string;
  SB: TStringBuilder;
  MaterialDesign: Boolean;

  procedure AddLibray;
  var
    I: Integer;
    Package: string;
    Language: string;
    MapsApiKey: string;
    LoadMode: string;
    LibVers: string;
  begin
    LibVers := FLibraryVersion.Trim;
    if LibVers.IsEmpty then
      LibVers := TcfsGChartProducer.LIBRARY_VERSION_CURRENT;

    MaterialDesign := False;
    Package := FLibraryPackage.Trim;
    if Package.IsEmpty then
    begin
      // Find Chart Library and if it uses Material Design
      for I := Low(GChartPackagesAndTypes) to High(GChartPackagesAndTypes) do
      begin
        if SameText(GChartPackagesAndTypes[I].ClassChartType, ClassChartType) then
        begin
          Package := GChartPackagesAndTypes[I].Package;
          MaterialDesign := GChartPackagesAndTypes[I].MaterialDesign;
          Break;
        end;
      end;
    end;

    if Package.IsEmpty then
      raise Exception.Create(ClassName + ': LibraryPackage can''t be empty');

    Language := '';
    if FLibraryLanguage <> '' then
      Language := ', ' + QuotedStr('language') + ':' + FLibraryLanguage.QuotedString;

    MapsApiKey := '';
    if not FLibraryMapsApiKey.IsEmpty then
    begin
      if SameText(Package, PACKAGE_GEO_CHART) then
        MapsApiKey := ', ' + QuotedStr('mapsApiKey') + ':' + FLibraryMapsApiKey.QuotedString;
    end;

    if LibrarySafeLoad and SameText(LibVers, TcfsGChartProducer.LIBRARY_VERSION_CURRENT) then
    begin
      LibVers := '';
      LoadMode := 'google.charts.safeLoad';
    end
    else
    begin
      LibVers := FLibraryVersion.QuotedString('"') + ',';
      LoadMode := 'google.charts.load';
    end;

    SB.Append(LoadMode + '(' + LibVers + '{packages:[' + Package.QuotedString + ']' + Language + MapsApiKey+ '}).then(' + PREFIX_DRAW_CHART_FUNCTION_NAME + Id + ');');
  end;

  procedure AppendSelectEvent;
  begin
    SB.Append('google.visualization.events.addListener(chart, ''select'', selectHandler);');
    SB.Append('function selectHandler() {');
    SB.Append('var selectedItem = chart.getSelection()[0];');
    SB.Append('var itemRow="";');
    SB.Append('var itemColumn="";');
    SB.Append('var itemValue="";');
    SB.Append('var itemCategory="";');
    SB.Append('if (selectedItem) {');
    SB.Append('itemRow = selectedItem.row;');
    SB.Append('itemColumn = selectedItem.column;');
    SB.Append('if (selectedItem.row != null && selectedItem.column != null) {');
    SB.Append('itemValue = data.getValue(selectedItem.row, selectedItem.column);');
    SB.Append('itemCategory = data.getValue(selectedItem.row, 0);');
    SB.Append('} else if (selectedItem.row != null) {');
    SB.Append('itemValue = data.getValue(selectedItem.row, 0);');
    SB.Append('} else if (selectedItem.column != null) {');
    SB.Append('itemValue = data.getValue(0, selectedItem.column);');
    SB.Append('}');
    SB.Append('if (itemValue instanceof Date){itemValue=itemValue.toISOString()};');
    SB.Append('if (itemCategory instanceof Date){itemCategory=itemCategory.toISOString()};');
    SB.Append('if (itemColumn == null){itemColumn=""};');
    SB.Append('if (itemRow == null){itemRow=""};');
    SB.Append('}');
    //SB.Append('      alert("itemRow=" + itemRow + ";itemColumn=" + itemColumn + ";itemValue=" + itemValue + ";itemCategory=" + itemCategory);');
    SB.Append(JSAjaxRequest + Format('(%s, "chartSelect", ["chartId="+' + '"' + Id + '"' + ', "itemRow="+itemRow, "itemColumn="+itemColumn, "itemValue="+itemValue, "itemCategory="+itemCategory]);', [JSName]));
    SB.Append('}');
  end;

var
  DrawDataVarName: string;
begin
  Id := ChartId.Trim;
  if not IsValidIdent(Id) then
    raise Exception.Create(ClassName + ': Invalid CanvasChart Name');

  T := FClassChartType.Trim;
  if T.IsEmpty then
    raise Exception.Create(ClassName + ': ClassChartType can''t be empty');

  SB := TStringBuilder.Create;
  try
    AddLibray;

    SB.Append('function ' + PREFIX_DRAW_CHART_FUNCTION_NAME + Id + '(){');

    SB.Append('if (document.getElementById("' + Id + '") === null)  {alert("chart div not found: ' + Id + '");};');

    if MaterialDesign then
      SB.Append('var chart = new google.charts.' + T + '(document.getElementById("' + Id + '"));')
    else
      SB.Append('var chart = new google.visualization.' + T + '(document.getElementById("' + Id + '"));');

    if Assigned(FOldData) then
    begin
      SB.Append('var oldData = google.visualization.arrayToDataTable([' + FOldData.ToJSDataTable + ']);');
      SB.Append('var newData = google.visualization.arrayToDataTable([' + FData.ToJSDataTable + ']);');
      SB.Append('var data = chart.computeDiff(oldData, newData);');
    end
    else
    begin
      SB.Append('var data = google.visualization.arrayToDataTable([' + FData.ToJSDataTable + ']);');
    end;

     SB.Append('var options = {' + Options.ToJSCode + '};');

//    SB.Append('google.visualization.events.addListener(chart, ''error'', function (err) {');
//    SB.Append('alert(err.message);');
//    SB.Append('console.log(err.id, err.message);');
//    SB.Append('google.visualization.errors.removeError(err.id);');
//    SB.Append('google.visualization.errors.removeAll(container);');
//    SB.Append('});');

    DrawDataVarName := 'data';
    if not FScripCodeBeforeCallDraw.IsEmpty then
    begin
      SB.Append(FScripCodeBeforeCallDraw);
      // Look for use of DataView object in ScripCodeBeforeCallDraw
      if Pos('DATAVIEW', FScripCodeBeforeCallDraw.ToUpper) > 0 then
        DrawDataVarName := 'view';
    end;

    if MaterialDesign then
      SB.Append('chart.draw(' + DrawDataVarName + ', google.charts.' + T + '.convertOptions(options));')
    else
      SB.Append('chart.draw(' + DrawDataVarName + ', options);');

    SB.Append(FScripCodeAfterCallDraw);

    if AddSelectEvent then
      AppendSelectEvent;
    SB.Append('}');

    Result := SB.ToString;
  finally
    SB.Free;
  end;
end;

function TcfsGChartProducer.GetClassChartType: string;
begin
  Result := FClassChartType;
end;

function TcfsGChartProducer.GetOldData: TcfsGChartData;
begin
  if not Assigned(FOldData) then
    FOldData := TcfsGChartData.Create;

  Result := FOldData;
end;

function TcfsGChartProducer.GetData: TcfsGChartData;
begin
  Result := FData;
end;

function TcfsGChartProducer.GetLibraryLanguage: string;
begin
  Result := FLibraryLanguage;
end;

function TcfsGChartProducer.GetLibraryMapsApiKey: string;
begin
  Result := FLibraryMapsApiKey;
end;

function TcfsGChartProducer.GetLibraryPackage: string;
begin
  Result := FLibraryPackage;
end;

function TcfsGChartProducer.GetLibrarySafeLoad: Boolean;
begin
  Result := FLibrarySafeLoad;
end;

function TcfsGChartProducer.GetLibraryVersion: string;
begin
  Result := FLibraryVersion;
end;

function TcfsGChartProducer.GetOptions: TcfsGChartOptions;
begin
  Result := FOptions;
end;

function TcfsGChartProducer.GetScripCodeAfterCallDraw: string;
begin
  Result := FScripCodeAfterCallDraw;
end;

function TcfsGChartProducer.GetScripCodeBeforeCallDraw: string;
begin
  Result := FScripCodeBeforeCallDraw;
end;

procedure TcfsGChartProducer.SetClassChartType(const Value: string);
begin
  FClassChartType := Value;
end;

procedure TcfsGChartProducer.SetLibraryLanguage(const Value: string);
begin
  FLibraryLanguage := Value;
end;

procedure TcfsGChartProducer.SetLibraryMapsApiKey(const Value: string);
begin
  FLibraryMapsApiKey := Value;
end;

procedure TcfsGChartProducer.SetLibraryPackage(const Value: string);
begin
  FLibraryPackage := Value;
end;

procedure TcfsGChartProducer.SetLibrarySafeLoad(const Value: Boolean);
begin
  FLibrarySafeLoad := Value;
end;

procedure TcfsGChartProducer.SetLibraryVersion(const Value: string);
begin
  FLibraryVersion := Value;
end;

procedure TcfsGChartProducer.SetScripCodeAfterCallDraw(const Value: string);
begin
  FScripCodeAfterCallDraw := Value;
end;

procedure TcfsGChartProducer.SetScripCodeBeforeCallDraw(const Value: string);
begin
  FScripCodeBeforeCallDraw := Value;
end;

end.

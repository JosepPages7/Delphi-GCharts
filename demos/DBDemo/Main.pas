unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniPanel,
  cfs.GCharts.uniGUI, Data.DB, Datasnap.DBClient, uniBasicGrid, uniDBGrid,
  uniMemo, uniDBNavigator, uniToolBar, uniButton;

type
  TMainForm = class(TUniForm)
    UniPanel1: TUniPanel;
    UniPanel2: TUniPanel;
    uniGChartsFrame1: TuniGChartsFrame;
    DataSource1: TDataSource;
    UniDBGrid1: TUniDBGrid;
    UniButton1: TUniButton;
    procedure UniFormCreate(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure uniGChartsFrame1Select(Sender: TuniGChartsFrame;
      const ChartId, Row, Column, Value, Category: string);
  private
    FClientDataSet: TClientDataSet;
    procedure CreateClientDataSet;
    procedure GenerateChart;
  public
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, cfs.GCharts;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
begin
  CreateClientDataSet;
  GenerateChart;
end;


procedure TMainForm.CreateClientDataSet;
begin
  FClientDataSet := TClientDataSet.Create(Self);
  FClientDataSet.FieldDefs.Add('Year', ftString, 4, False);
  FClientDataSet.FieldDefs.Add('Sales', ftCurrency, 0, False);
  FClientDataSet.FieldDefs.Add('Expenses', ftCurrency, 0, False);
  FClientDataSet.CreateDataSet;

  FClientDataSet.Open;
  FClientDataSet.AppendRecord(['2016',  1000,      400]);
  FClientDataSet.AppendRecord(['2017',  1170,      460]);
  FClientDataSet.AppendRecord(['2018',  660,       1120]);
  FClientDataSet.AppendRecord(['2019',  1030,      540]);
  FClientDataSet.AppendRecord(['2020',  880,      600]);
  FClientDataSet.AppendRecord(['2021',  1202,      789]);
  FClientDataSet.AppendRecord(['2022',  1400,      1100]);
  FClientDataSet.AppendRecord(['2023',  null,      null]);

  DataSource1.DataSet := FClientDataSet;
end;

procedure TMainForm.GenerateChart;
var
  //Defined as TInterfacedObject. No need try..finally
  AreaChart: IcfsGChartProducer;
  ColumnChart: IcfsGChartProducer;
  Profit: Currency;
begin
  AreaChart := TcfsGChartProducer.Create;
  AreaChart.ClassChartType := TcfsGChartProducer.CLASS_AREA_CHART;
  AreaChart.Data.AssignFromDataSet(FClientDataSet);
  AreaChart.Options.Title('Company Performance');
  AreaChart.Options.Legend('position', 'bottom');
  AreaChart.LibraryLanguage := UniSession.Language;


  ColumnChart := TcfsGChartProducer.Create;
  ColumnChart.ClassChartType := TcfsGChartProducer.CLASS_COLUMN_CHART;
  ColumnChart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Year'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Profit'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, '', TcfsGChartDataCol.ROLE_STYLE)
  ]);

  FClientDataSet.First;
  while not FClientDataSet.eof do
  begin
    Profit := FClientDataSet.FieldByName('Sales').AsCurrency - FClientDataSet.FieldByName('Expenses').AsCurrency;

    ColumnChart.Data.AddRow;
    ColumnChart.Data.SetValue(0, FClientDataSet.FieldByName('Year').Value);
    ColumnChart.Data.SetValue(1, Profit);
    if Profit < 0 then
      ColumnChart.Data.SetValue(2, 'red');

    FClientDataSet.Next;
  end;
  ColumnChart.Options.Title('Company Profit');
  ColumnChart.Options.Legend('position', 'none');
  ColumnChart.LibraryLanguage := UniSession.Language;

  // Generate
  uniGChartsFrame1.DocumentInit;
  uniGChartsFrame1.DocumentSetBody(
      '<div style="display: flex; width: 100%; height: 100%;">'
    +   '<div id="AreaChart" style="width: 50%"></div>'
    +   '<div id="ColumnChart" style="width: 50%"></div>'
    +   '</div>'
    + '</div>'
  );
  uniGChartsFrame1.DocumentGenerate('AreaChart', AreaChart);
  uniGChartsFrame1.DocumentGenerate('ColumnChart', ColumnChart);
  uniGChartsFrame1.DocumentPost;
end;

procedure TMainForm.UniButton1Click(Sender: TObject);
begin
  GenerateChart;
end;

procedure TMainForm.uniGChartsFrame1Select(Sender: TuniGChartsFrame; const ChartId, Row, Column, Value, Category: string);
begin
  ShowMessageN(Format('ChartId=%s, Row=%s, Column=%s, Value=%s, Category=%s', [ChartId, Row, Column, Value, Category]));
end;


initialization
  RegisterAppFormClass(TMainForm);

end.

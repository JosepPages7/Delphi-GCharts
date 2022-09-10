unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniGUIJSInterface,
  cfs.GCharts.uniGUI, uniPanel, Vcl.Menus, uniMainMenu, uniToolBar;

type
  TMainForm = class(TUniForm)
    uniGChartsFrame1: TuniGChartsFrame;
    UniToolBar1: TUniToolBar;
    btnPrintChart: TUniToolButton;
    procedure UniFormCreate(Sender: TObject);
    procedure uniGChartsFrame1Select(Sender: TuniGChartsFrame;
      const ChartId, Row, Column, Value, Category: string);
    procedure btnPrintChartClick(Sender: TObject);
  private
  public
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, uniGUIApplication, MainModule, cfs.GCharts;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.btnPrintChartClick(Sender: TObject);
begin
  uniGChartsFrame1.DocumentPrint;
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
var
  Chart: IcfsGChartProducer; //Defined as TInterfacedObject. No need try..finally
begin
  Chart := TcfsGChartProducer.Create;
  Chart.ClassChartType := TcfsGChartProducer.CLASS_PIE_CHART;

  // Data
  Chart.Data.DefineColumns([
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtString, 'Topping'),
    TcfsGChartDataCol.Create(TcfsGChartDataType.gcdtNumber, 'Slices')
  ]);
  Chart.Data.AddRow(['Mushrooms', 3]);
  Chart.Data.AddRow(['Onions', 1]);
  Chart.Data.AddRow(['Olives', 1]);
  Chart.Data.AddRow(['Zucchini', 1]);
  Chart.Data.AddRow(['Pepperoni', 2]);

  // Options
  Chart.Options.Title('How Much Pizza I Ate Last Night');

  // Generate
  uniGChartsFrame1.DocumentInit;
  uniGChartsFrame1.DocumentSetBody('<div id="Chart" style="width:100%;height:100%;"></div>');
  uniGChartsFrame1.DocumentGenerate('Chart', Chart);
  uniGChartsFrame1.DocumentPost;
end;

procedure TMainForm.uniGChartsFrame1Select(Sender: TuniGChartsFrame; const ChartId, Row, Column, Value, Category: string);
begin
  ShowMessageN(Format('ChartId=%s, Row=%s, Column=%s, Value=%s, Category=%s', [ChartId, Row, Column, Value, Category]));
end;

initialization
  RegisterAppFormClass(TMainForm);

end.

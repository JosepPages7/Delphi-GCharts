// ***************************************************************************
//
// cfs.GCharts.uniGUI: uniGUI Google Charts Frame
// cfsCharts is a Delphi library of components to generate Charts in uniGUI Framework using the Google Charts API
//
// Copyright (c) 2021 Josep Pagès
//
// https://github.com/JosepPages7/Delphi-GCharts
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

unit cfs.GCharts.uniGUI;

interface

uses
  System.Classes,
  System.SysUtils,
  Generics.Collections,
  Data.DB,
  uniGUITypes,
  uniGUIClasses,
  uniGUIInterfaces,
  cfs.GCharts;

type
  TuniGChartsFrame = class;
  TuniGChartsSelectEvent = procedure(Sender: TuniGChartsFrame; const ChartId, Row, Column, Value, Category: string) of object;
  TuniGChartsBeforeDocumentPost = procedure(Sender: TComponent; var HTMLDocument: string) of object;

  TcfsCustomURLFrame = class(TUniCustomContainerPanel)
  strict private
    FLoaded: Boolean;
    FHTMLDocument: string;
    FOnLoaded : TNotifyEvent;
    FBeforeDocumentPost: TuniGChartsBeforeDocumentPost;
    procedure H_OnLoaded(This: TJSObject; EventName: string; Params: TUniStrings);
    procedure SetHTMLDocument(const Value: string);
    procedure PostHTMLDocument;
  protected
    procedure CreateFrame; virtual;
    procedure SetOnLoaded(Value: TNotifyEvent);
    procedure LoadCompleted; override;
    function VCLControlClassName: string; override;
    procedure ConfigJSClasses(ALoading: Boolean); override;
    procedure WebCreate; override;

    property OnFrameLoaded: TNotifyEvent read FOnLoaded write SetOnLoaded;
    property BeforeDocumentPost: TuniGChartsBeforeDocumentPost read FBeforeDocumentPost write FBeforeDocumentPost;
    property HTMLDocument: string write SetHTMLDocument;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TuniGChartsFrame = class(TcfsCustomURLFrame)
  private
    FScriptCode: TStringBuilder;
    FListIdCharts: TList<string>;
    FCSSCode: string;
    FHTMLCode: string;
    FOnSelect: TuniGChartsSelectEvent;
    FAutoResize: Boolean;
    procedure CheckDocumentInit;
    function GetHTMLDocument: string;
  protected
    procedure DOHandleEvent(EventName: string; Params: TUniStrings); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetHTMLDocument(const Text: string);
    procedure DocumentInit;
    procedure DocumentSetCSS(const CSSText: string);
    procedure DocumentSetBody(const HTMLText: string);
    procedure DocumentAddScript(const Text: string);
    procedure DocumentGenerate(const ChartId: string; ChartProducer: TcfsGChartProducer); overload;
    procedure DocumentGenerate(const ChartId: string; ChartProducer: IcfsGChartProducer); overload;
    procedure DocumentPost;
  published
    property AlignmentControl;
    property ParentAlignmentControl;
    property Align;
    property Anchors;
    property LayoutConfig;
    property ScreenMask;
    property OnAjaxEvent;
    property TabOrder;
    property TabStop;

    property OnFrameLoaded;
    property BeforeDocumentPost;

    property AutoResize: Boolean read FAutoResize write FAutoResize default False;
    property OnSelect: TuniGChartsSelectEvent read FOnSelect write FOnSelect;
  end;

const
  JS_RESOURCE_GCHARTS_LOADER : string = '<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>';
  JS_RESOURCE_JQUERY: string = '<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js" integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>';

procedure register;

implementation

uses
  UniGUIJSUtils;

procedure register;
begin
  RegisterComponents('uniGUI CFS', [TuniGChartsFrame]);
end;

{ TcfsCustomURLFrame }

function TcfsCustomURLFrame.VCLControlClassName: string;
begin
  Result:='TVCLURLFrame';  // to be defined
end;

procedure TcfsCustomURLFrame.ConfigJSClasses(ALoading: Boolean);
begin
  JSObjects.DefaultJSClassName:='Ext.panel.iframe';
end;

constructor TcfsCustomURLFrame.Create(AOwner: TComponent);
begin
  inherited;

  Width := 320;
  Height := 240;
end;

procedure TcfsCustomURLFrame.CreateFrame;
var
  FName : string;
begin
  FName := Name+'_'+JSName;
  JSConfig('ifName', ['name_'+FName]);
  JSConfig('items',
            [JSArray('{xtype:"component",'+
                      'width:"100%",'+
                      'height:"100%",'+
                      'autoEl: {tag:"iframe",'+
                      'onload:"iframe_load('''+JSId+''')",'+
                      'name:"name_'+FName+'",'+
                      'title:"title_'+FName+'",'+
                      'src:"about:blank",frameborder:"0"}}')
            ]
          );

  JSCall('initIFrame');
end;

procedure TcfsCustomURLFrame.PostHTMLDocument;
begin
  if Assigned(FBeforeDocumentPost) then
    FBeforeDocumentPost(Self, FHTMLDocument);

  if FHTMLDocument <>'' then
    JSCall('setValue', [FHTMLDocument]);

  FHTMLDocument := ''; // Free Memory;
end;

procedure TcfsCustomURLFrame.LoadCompleted;
begin
  inherited;
  CreateFrame;

  FLoaded := True;
  if FHTMLDocument <> '' then
    PostHTMLDocument;
end;

procedure TcfsCustomURLFrame.WebCreate;
begin
  inherited;
  BorderStyle := ubsNone;
end;

procedure TcfsCustomURLFrame.H_OnLoaded(This: TJSObject; EventName: string; Params: TUniStrings);
begin
  if Assigned(FOnLoaded) then
    FOnLoaded(Self);
end;

procedure TcfsCustomURLFrame.SetHTMLDocument(const Value: string);
begin
  FHTMLDocument := Value;
  if FLoaded then
    PostHTMLDocument;
end;

procedure TcfsCustomURLFrame.SetOnLoaded(Value: TNotifyEvent);
begin
  FOnLoaded:=Value;
  if WebMode then
  begin
    if Assigned(FOnLoaded) then
      JSAddEvent('frameload', ['This', '%0.nm', 'Frame', '%1.nm'], H_OnLoaded)
    else
      JSRemoveEvent('frameload', H_OnLoaded);
  end;
end;

{ TuniHTMLFrameGCharts }

constructor TuniGChartsFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  if Name = '' then
    Name := 'cfsChart' + Self.JSName; // Important assign a default name!

  FAutoResize := False;
end;

destructor TuniGChartsFrame.Destroy;
begin
  if Assigned(FScriptCode) then
    FreeAndNil(FScriptCode);
  FreeAndNil(FListIdCharts);

  inherited;
end;

procedure TuniGChartsFrame.DOHandleEvent(EventName: string; Params: TUniStrings);
begin
  inherited;

  if Assigned(FOnSelect) then
  begin
    if EventName = 'chartSelect' then
      FOnSelect(Self, Params.Values['chartId'], Params.Values['itemRow'], Params.Values['itemColumn'], Params.Values['itemValue'], Params.Values['itemCategory']);
  end;
end;

procedure TuniGChartsFrame.CheckDocumentInit;
begin
  if not Assigned(FScriptCode)  then
    raise Exception.Create(ClassName + ': Please call DocumentInit before to start');
end;

procedure TuniGChartsFrame.DocumentInit;
begin
  if Assigned(FScriptCode) then
    FreeAndNil(FScriptCode);
  FScriptCode := TStringBuilder.Create;
  FHTMLCode := '';
  FCSSCode := '';
  FListIdCharts := TList<string>.Create;
end;

procedure TuniGChartsFrame.DocumentPost;
var
  N: string;
begin
  CheckDocumentInit;

  if FAutoResize and (FListIdCharts.Count > 0) then
  begin
    FScriptCode.Append('$(window).resize(function(){');
    FScriptCode.Append('if(this.resizeTO) clearTimeout(this.resizeTO);');
    FScriptCode.Append('this.resizeTO=setTimeout(function(){');
    FScriptCode.Append('$(this).trigger(''resizeEnd'');');
    FScriptCode.Append('},500);');
    FScriptCode.Append('});');

    FScriptCode.Append('$(window).on(''resizeEnd'',function() {');
    for N in FListIdCharts do
      FScriptCode.Append('if (typeof ' + TcfsGChartProducer.PREFIX_DRAW_CHART_FUNCTION_NAME + N + ' === "function") {' + TcfsGChartProducer.PREFIX_DRAW_CHART_FUNCTION_NAME + N + '();}');
    FScriptCode.Append('});');
  end;

  if Assigned(FScriptCode) or (FHTMLCode <> '') then
    HTMLDocument := GetHTMLDocument;
end;

function TuniGChartsFrame.GetHTMLDocument: string;

  function GetCSSCode: string;
  begin
    Result := FCSSCode;
    //if Result = '' then
      //Result := '<style type="text/css">body{margin: 0;padding: 0}</style>'; // remove Margins
  end;

var
  H: string;

const
  DESACTIVATE_RIGHT_BUTTON = 'document.addEventListener("contextmenu", event => event.preventDefault());';
begin
  if Assigned(FScriptCode) then
  begin
    if FScriptCode.Length <> 0 then
    begin
      H := JS_RESOURCE_GCHARTS_LOADER;
      if AutoResize then
        H := H + JS_RESOURCE_JQUERY;

      Result := H +  '<script type="text/javascript">' + DESACTIVATE_RIGHT_BUTTON + FScriptCode.ToString + '</script>' + GetCSSCode + FHTMLCode;
    end
    else
      Result := GetCSSCode + FHTMLCode;

    FreeAndNil(FScriptCode);
    FreeAndNil(FListIdCharts);
  end
  else
  begin
     Result := GetCSSCode + FHTMLCode;
  end;

  FHTMLCode := '';
  FCSSCode := '';
end;

procedure TuniGChartsFrame.SetHTMLDocument(const Text: string);
begin
  HTMLDocument := Text;
  FreeAndNil(FScriptCode);
  FreeAndNil(FListIdCharts);
end;

procedure TuniGChartsFrame.DocumentSetBody(const HTMLText: string);
begin
  CheckDocumentInit;

  if Copy(FHTMLCode.TrimLeft, 1, 6).ToUpper <> '<BODY>' then
    FHTMLCode := '<body>' + HTMLText + '</body>'
  else
    FHTMLCode := HTMLText;
end;

procedure TuniGChartsFrame.DocumentSetCSS(const CSSText: string);
begin
  CheckDocumentInit;

  if Copy(FHTMLCode.TrimLeft, 1, 7).ToUpper <> '<STYLE>' then
    FCSSCode := '<style type="text/css">' + CSSText + '</style>'
  else
    FCSSCode := CSSText;
end;

procedure TuniGChartsFrame.DocumentAddScript(const Text: string);
begin
  CheckDocumentInit;
  FScriptCode.Append(Text);
end;

procedure TuniGChartsFrame.DocumentGenerate(const ChartId: string; ChartProducer: IcfsGChartProducer);
begin
  DocumentGenerate(ChartId, ChartProducer as TcfsGChartProducer);
end;

procedure TuniGChartsFrame.DocumentGenerate(const ChartId: string; ChartProducer: TcfsGChartProducer);
var
  Id: string;
begin
  CheckDocumentInit;

  Id := ChartId.Trim;
  if not IsValidIdent(Id) then
    raise Exception.Create(ClassName + ': Invalid Chart Id');

  if ChartProducer = nil then
    raise Exception.Create(ClassName + ': ChartProducer is nil');

  FListIdCharts.Add(Id);

  if Assigned(FOnSelect) then
    FScriptCode.Append(ChartProducer.GenerateJSCode(Id, True, 'parent.ajaxRequest', 'parent.' + Self.JSName))
  else
    FScriptCode.Append(ChartProducer.GenerateJSCode(Id));
end;

end.

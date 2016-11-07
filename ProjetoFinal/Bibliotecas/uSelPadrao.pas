unit uSelPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  Data.FMTBcd, Datasnap.Provider, Data.SqlExpr, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Datasnap.DBClient, Vcl.StdCtrls, Vcl.ExtCtrls, uDmPrinc;

type
  TFSelPadrao = class(TForm)
    cdsSel: TClientDataSet;
    dsSel: TDataSource;
    qrySel: TSQLQuery;
    dspSel: TDataSetProvider;
    Panel1: TPanel;
    btSelReg: TButton;
    btCancelar: TButton;
    qrySelID: TIntegerField;
    qrySelDESCRICAO: TStringField;
    cxGrid: TcxGrid;
    cxGridTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    procedure btSelRegClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    lCancelou : Boolean;
  protected


  end;

var
  FSelPadrao: TFSelPadrao;

implementation

{$R *.dfm}

procedure TFSelPadrao.btCancelarClick(Sender: TObject);
begin
  lCancelou:=True;
  Self.Close;
end;

procedure TFSelPadrao.btSelRegClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFSelPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFSelPadrao.FormCreate(Sender: TObject);
begin
  lCancelou := False;
end;

end.

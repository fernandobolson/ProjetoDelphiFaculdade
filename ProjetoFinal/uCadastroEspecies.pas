unit uCadastroEspecies;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormPadrao, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  dxBarBuiltInMenu, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, Data.DB, cxDBData, Data.FMTBcd, Data.SqlExpr,
  cxClasses, Datasnap.Provider, Datasnap.DBClient, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxPC, Vcl.StdCtrls, cxButtons, cxGroupBox,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls, cxTextEdit, cxDBEdit,
  Vcl.DBCtrls;

type
  TFCadEspecie = class(TFPadraoManut)
    cxGridTableViewID: TcxGridDBColumn;
    cxGridTableViewDESCRICAO: TcxGridDBColumn;
    cdsPadraoID: TIntegerField;
    cdsPadraoDESCRICAO: TStringField;
    Label4: TLabel;
    EB_ID: TcxDBTextEdit;
    Label3: TLabel;
    EB_DESCRICAO: TcxDBTextEdit;
    procedure Ac_IncluirExecute(Sender: TObject);
  private
    { Private declarations }
    procedure CriaObjetoCrud; override;
    function CheckDadosFinal: Boolean; override;
    function CheckDadosExclusao: Boolean; override;
  public
    { Public declarations }
  end;

var
  FCadEspecie: TFCadEspecie;

implementation

{$R *.dfm}

uses
  uDmPrinc,
  BibGeral;



function TFCadEspecie.CheckDadosExclusao: Boolean;

var
  qry :TSQLQuery;
begin
  try
    Result := True;
    if (CdsPadrao.RecordCount <= 0) then
      begin
      Result := False;
      raise Exception.Create('N�o existe nenhum registro para ser Excluido.');
    end;

    qry := TSQLQuery.Create(Self);
    qry.SQLConnection := DmPrinc.sqlCon;

    qry.SQL.Clear;

    //Verifica Dependencias de Ra�as
    qry.SQL.Add('SELECT COUNT(*) FROM RACA WHERE CD_ESPECIE =' + QuotedStr(cdsPadrao.FieldByName('ID').AsString));
    qry.Open;
    if qry.RecordCount > 0 then
      begin
      Result := False;
      raise Exception.Create('N�o � poss�vel realizar a exclus�o! '+sLineBreak +
                             'Existem Ra�as cadastradas com essa Esp�cie!');
    end;

  finally
    FreeAndNil(qry);
  end;

end;


procedure TFCadEspecie.Ac_IncluirExecute(Sender: TObject);
begin
  inherited;
  cdsPadrao.Edit;
  cdsPadrao.FieldByName(ObjCrud.CampoChave).AsInteger := -1; //Sera incrementado a partir de uma trigger no BD
end;

function TFCadEspecie.CheckDadosFinal: Boolean;
begin
  Result := True;
  if Trim(EB_DESCRICAO.Text) = EmptyStr then
    begin
    raise Exception.Create('Informe uma Descri��o V�lida');
    Result := False;
  end;
end;

procedure TFCadEspecie.CriaObjetoCrud;
begin
  inherited;
  ObjCrud := TObjCrud.Create;
  With ObjCrud do
  begin
    Nome := 'Cadastro de Esp�cies';
    TabelaBanco := 'ESPECIES';
    CampoChave := 'ID';
  end;
end;

end.

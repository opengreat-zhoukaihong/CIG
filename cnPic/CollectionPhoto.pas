unit CollectionPhoto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, Db, DBTables,
  Wwquery, wwdblook;

type
  TfmCollectionPhoto = class(TForm)
    Panel3: TPanel;
    Label3: TLabel;
    DBText1: TDBText;
    DBNavigator1: TDBNavigator;
    wwDBGrid2: TwwDBGrid;
    quSelPhoto: TwwQuery;
    quSelPhotoPHOTOID: TBCDField;
    quSelPhotoNAME: TStringField;
    quSelPhotoAUTHORID: TBCDField;
    quSelPhotoDESCRIPTION: TStringField;
    quSelPhotoTIME: TDateTimeField;
    quSelPhotoLOCATION: TStringField;
    quSelPhotoPLACE: TStringField;
    quSelPhotoCONTENT: TStringField;
    dlcPhoto: TwwDBLookupCombo;
    quSelPhotoSTORAGEID: TStringField;
    quSelPhotoMANUSCRIPT: TStringField;
    quSelPhotoMANUSCRIPTID: TBCDField;
    quSelPhotoFILE_SIZE: TBCDField;
    quSelPhotoFILE_FORMAT: TStringField;
    quSelPhotoFILMTYPE: TStringField;
    quSelPhotoDIRID: TBCDField;
    quSelPhotoTHUMBFILE: TStringField;
    quSelPhotoSMALLFILE: TStringField;
    quSelPhotoMIDDLEFILE: TStringField;
    quSelPhotoIMAGEFILE: TStringField;
    quSelPhotoFULLPRICE1: TBCDField;
    quSelPhotoCOMMERCIALPRICE1: TBCDField;
    quSelPhotoNOCOMPRICE1: TBCDField;
    quSelPhotoMAGAZINEPRICE1: TBCDField;
    quSelPhotoCURRENCY1: TStringField;
    quSelPhotoREMARK: TStringField;
    quSelPhotoSTATUS: TStringField;
    quSelPhotoVERIFY_FLAG1: TStringField;
    quSelPhotoVERIFY_FLAG2: TStringField;
    quSelPhotoRECORDSTATUS: TStringField;
    quSelPhotoCREATEDATE: TDateTimeField;
    quSelPhotoLASTMODIFYDATE: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCollectionPhoto: TfmCollectionPhoto;

implementation

{$R *.DFM}
uses pic;
procedure TfmCollectionPhoto.FormCreate(Sender: TObject);
begin
  with dmPic.quCollectionPhoto do
    if not Active then
      Open;
  if gIsAdmin then
    dmPic.quCollectionPhotoVERIFY_FLAG.Visible := True
  else
    dmPic.quCollectionPhotoVERIFY_FLAG.Visible := False;
end;

procedure TfmCollectionPhoto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with dmPic.quCollectionPhoto do
    if Active then
      Close;
end;

end.

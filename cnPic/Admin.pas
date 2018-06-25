unit Admin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, Buttons, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, StdCtrls, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb;

type
  TfmAdmin = class(TForm)
    wwDBGrid1: TwwDBGrid;
    dcbPasswd: TwwDBComboBox;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAdmin: TfmAdmin;

implementation

{$R *.DFM}
uses Pic;
procedure TfmAdmin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with dmPic.quOperator do
    if Active then
      Close;
  Action := caFree;

end;

procedure TfmAdmin.FormCreate(Sender: TObject);
begin
  with dmPic.quOperator do
    if not Active then
      Open;
end;

end.

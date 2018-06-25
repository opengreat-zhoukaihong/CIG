unit ManuScript;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, Buttons, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid;

type
  TfmManuScript = class(TForm)
    wwDBGrid1: TwwDBGrid;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmManuScript: TfmManuScript;

implementation
uses pic;
{$R *.DFM}

procedure TfmManuScript.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with dmPic.quManuScriptSize do
    if Active then
      Close;
  Action := caFree;
end;

procedure TfmManuScript.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfmManuScript.FormCreate(Sender: TObject);
begin
  with dmPic.quManuScriptSize do
    if Not Active then
      Open;
end;

end.

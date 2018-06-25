unit DirSetting;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Wwdbigrd, Wwdbgrid, Buttons, ExtCtrls, DBCtrls, wwSpeedButton,
  wwDBNavigator, DBGrids, StdCtrls, wwdblook, Mask, wwdbedit, Wwdotdot;

type
  TfmDirSetting = class(TForm)
    wwDBGrid1: TwwDBGrid;
    Label3: TLabel;
    dlcName: TwwDBLookupCombo;
    dcdDirSetting: TwwDBComboDlg;
    odDirSetting: TOpenDialog;
    DBNavigator1: TDBNavigator;
    ff: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dcdDirSettingCustomDlg(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDirSetting: TfmDirSetting;

implementation
uses pic;
{$R *.DFM}

procedure TfmDirSetting.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with dmPic do
  begin
    with quSelAuthor do
      if Active then
        Close;
 //   dlcName.Text := quSelAuthor.FieldByName('FirstName').AsString;
    with quDirSetting do
      if Active then
        Close;
  end;
  Action := caFree;

end;
procedure TfmDirSetting.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfmDirSetting.FormCreate(Sender: TObject);
begin
  with dmPic do
  begin
    with quSelAuthor do
      if not Active then
        Open;
    dlcName.Text := quSelAuthor.FieldByName('FirstName').AsString;
    with quDirSetting do
      if not Active then
        Open;
  end;
end;

procedure TfmDirSetting.dcdDirSettingCustomDlg(Sender: TObject);
var
  wPath : String;
begin
  if odDirSetting.Execute then
  begin
    //StringReplace(const S, OldPattern, NewPattern: string; Flags: TReplaceFlags): string;
    wPath := ExtractFilePath(odDirSetting.FileName);
    Delete(wPath, 1, 2);
    wPath := StringReplace(wPath,'\','/',[rfReplaceAll, rfIgnoreCase]);
    dmPic.quDirSetting.FieldByName('Dir').AsString := wPath;
  end;
end;

end.

unit Photo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  wwdblook, StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, Grids, Wwdbigrd,
  Wwdbgrid, ExtCtrls, Menus, DBCtrls, Buttons;

type
  TfmPhoto = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    wwDBGrid1: TwwDBGrid;
    dlcName: TwwDBLookupCombo;
    PopupMenu1: TPopupMenu;
    dlcManuScriptSize: TwwDBLookupCombo;
    dcbManuscript: TwwDBComboBox;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    dcdDir: TwwDBComboDlg;
    Label3: TLabel;
    Label1: TLabel;
    odDirSetting: TOpenDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure dcdDirCustomDlg(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPhoto: TfmPhoto;
  wPhotoPath: String;

implementation

{$R *.DFM}
uses pic, EditPhoto;
procedure TfmPhoto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with dmPic do
  begin
     with quDirSetting do
      if Active then
        Close;
    with quPhotoCategory do
      if Active then
        Close;
    with quSelAuthor do
      if Active then
        Close;
    with quPhoto do
      if Active then
        Close;
    with quManuScriptSize do
      if Active then
        Close;
    with quCategory1 do
      if Active then
        Close;
    with quCategory2 do
      if Active then
        Close;
    with quCategory3 do
      if Active then
        Close;
    with quCategory4 do
      if Active then
        Close;
    with quCategory5 do
      if Active then
        Close;
    with quCategory6 do
      if Active then
        Close;
    with quCategory7 do
      if Active then
        Close;
    with quCategory8 do
      if Active then
        Close;
    with quAwardWork do
      if Active then
        Close;
    with quCollectionPhotoP do
      if Active then
        Close;
  end;
  Action := caFree;
end;

procedure TfmPhoto.FormCreate(Sender: TObject);
begin
  with dmPic do
  begin
    with quSelAuthor do
      if not Active then
        Open;
    dlcName.Text := quSelAuthor.FieldByName('FirstName').AsString;
    with quPhoto do
      if not Active then
        Open;
    with quManuScriptSize do
      if not Active then
        Open;
    with quCategory1 do
      if not Active then
        Open;
    with quCategory2 do
      if not Active then
        Open;
    with quCategory3 do
      if not Active then
        Open;
    with quCategory4 do
      if not Active then
        Open;
    with quCategory5 do
      if not Active then
        Open;
    with quCategory6 do
      if not Active then
        Open;
    with quCategory7 do
      if not Active then
        Open;
    with quCategory8 do
      if not Active then
        Open;
    with quAwardWork do
      if not Active then
        Open;
    with quCollectionPhotoP do
      if not Active then
        Open;
    with quPhotoCategory do
      if not Active then
        Open;
    with quDirSetting do
      if not Active then
        Open;

  end;
end;

procedure TfmPhoto.wwDBGrid1DblClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfmEditPhoto, fmEditPhoto);
    fmEditPhoto.lbDir.Caption := dcdDir.Text;
    fmEditPhoto.ShowModal;
  finally
    fmEditPhoto.Free;
  end;
end;


procedure TfmPhoto.SpeedButton3Click(Sender: TObject);
begin
  try
    Application.CreateForm(TfmEditPhoto, fmEditPhoto);
    if not dmPic.quPhoto.Active then
      dmPic.quPhoto.Open;
    dmPic.quPhoto.Insert;
    fmEditPhoto.lbDir.Caption := dcdDir.Text;
    fmEditPhoto.ShowModal;
  finally
    fmEditPhoto.Free;
  end;
end;

procedure TfmPhoto.SpeedButton4Click(Sender: TObject);
begin
  Close;
end;

procedure TfmPhoto.dcdDirCustomDlg(Sender: TObject);
begin
  if odDirSetting.Execute then
  begin
    //StringReplace(const S, OldPattern, NewPattern: string; Flags: TReplaceFlags): string;

    wPhotoPath := ExtractFilePath(odDirSetting.FileName);
    dcdDir.Text := wPhotoPath;
    dcdDir.SetFocus;
    //Delete(wPath, 1, 2);
    //wPath := StringReplace(wPath,'\','/',[rfReplaceAll, rfIgnoreCase]);
    //dmPic.quDirSetting.FieldByName('Dir').AsString := wPath;
  end;
end;

procedure TfmPhoto.FormShow(Sender: TObject);
begin
  dcdDir.Text := 'W:\Photo\';
  wPhotoPath := 'W:\Photo\';
end;

end.

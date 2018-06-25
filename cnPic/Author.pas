unit Author;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, Buttons, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid,
  wwdbdatetimepicker, StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb;

type
  TfmAuthor = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    wwDBGrid1: TwwDBGrid;
    edAuthorID: TEdit;
    edName: TEdit;
    edCompany: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    dtpCreateDate: TwwDBDateTimePicker;
    wwDBComboBox1: TwwDBComboBox;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAuthor: TfmAuthor;

implementation
uses pic, EditAuthor;
{$R *.DFM}

procedure TfmAuthor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with dmPic do
  begin
    with quCollection do
      if Active then
        Close;
    with quPublishWC do
      if Active then
        Close;
  end;
  Action := caFree;
end;

procedure TfmAuthor.wwDBGrid1DblClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfmEditAuthor, fmEditAuthor);
    fmEditAuthor.ShowModal;
  finally
    fmEditAuthor.Free;
  end;
end;

procedure TfmAuthor.SpeedButton1Click(Sender: TObject);
begin
  if (Trim(edAuthorID.Text) = '') and (Trim(dtpCreateDate.Text) = '')
     and (Trim(edName.Text) = '') and (Trim(edCompany.Text) = '') then
  begin
    with dmPic.quAuthor do
    begin
      if Active then
        Close;
      with Sql do
      begin
        Clear;
        Add('Select * from Local_Author order by AuthorID');
      end;
      Open;
    end;
  end
  else if Trim(edAuthorID.Text) <> '' then
  begin
    with dmPic.quAuthor do
    begin
      if Active then
        Close;
     // RequestLive := False;
      with Sql do
      begin
        Clear;
        Add('Select * from Local_Author where AuthorID = ' + Trim(edAuthorID.Text));
      end;
      Open;
      //RequestLive := True;
    end;
  end
  else if (Trim(edName.Text) <> '') then
  begin
    with dmPic.quAuthor do
    begin
      if Active then
        Close;
      with Sql do
      begin
        Clear;
        Add('Select * from Local_Author where FirstName like ''%' + Trim(edName.Text) + '%''');
      end;
      Open;
    end;
  end
  else if (Trim(edCompany.Text) <> '') then
  begin
    with dmPic.quAuthor do
    begin
      if Active then
        Close;
      with Sql do
      begin
        Clear;
        Add('Select * from local_Author where Company like "%' + Trim(edCompany.Text) + '%"');
      end;
      Open;
    end;
  end
  else if (Trim(dtpCreateDate.Text)<> '') then
  begin
    with dmPic.quAuthor do
    begin
      if Active then
        Close;
      with Sql do
      begin
        Clear;
        Add('Select * from local_Author where CreateDate  >= :CreateDate');
      end;
      ParamByName('CreateDate').AsDate := dtpCreateDate.Date;
      Open;
    end;
  end;
end;

procedure TfmAuthor.SpeedButton2Click(Sender: TObject);
begin
  edAuthorID.Text := '';
  edName.Text := '';
  edCompany.Text := '';
end;

procedure TfmAuthor.FormCreate(Sender: TObject);
begin
  with dmPic do
  begin
    with quCollection do
      if not Active then
        Open;
    with quPublishWC do
      if not Active then
        Open;
  end;
end;

procedure TfmAuthor.SpeedButton3Click(Sender: TObject);
begin
  try
    Application.CreateForm(TfmEditAuthor, fmEditAuthor);
    if not dmPic.quAuthor.Active then
      dmPic.quAuthor.Open;
    dmPic.quAuthor.Insert;
    fmEditAuthor.ShowModal;
  finally
    fmEditAuthor.Free;
  end;
end;

procedure TfmAuthor.SpeedButton4Click(Sender: TObject);
begin
  Close;
end;

end.

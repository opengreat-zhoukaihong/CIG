unit Login;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons;

type
  TfmLogin = class(TForm)
    Label17: TLabel;
    Label21: TLabel;
    mePassword: TMaskEdit;
    edUser: TEdit;
    btOk: TButton;
    btCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bbOkClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure edUserExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLogin: TfmLogin;

implementation
{$R *.DFM}

procedure TfmLogin.FormCreate(Sender: TObject);
begin
  edUser.Text := '';
  mePassword.Text := '';
end;

procedure TfmLogin.FormShow(Sender: TObject);
begin
  edUser.SetFocus;
end;

procedure TfmLogin.bbOkClick(Sender: TObject);
begin
  if edUser.Text = '' then
  begin
    ShowMessage('请输入用户!');
    edUser.SetFocus;
  end;
  if mePassword.Text = '' then
  begin
    ShowMessage('请输入口令!');
    mePassword.SetFocus;
  end;
end;

procedure TfmLogin.btOkClick(Sender: TObject);
begin
  if (edUser.Text = '') and  (mePassword.Text = '') then
  begin
    ShowMessage('请输入用户与口令!');
    edUser.SetFocus;
    Exit;
  end
  else
  begin
    if (edUser.Text = '') then
    begin
      ShowMessage('请输入用户!');
      edUser.SetFocus;
      Exit;
    end
    else
      if mePassword.Text = '' then
      begin
        ShowMessage('请输入口令!');
        mePassword.SetFocus;
        Exit;
      end;
  end;
  Close;
end;

procedure TfmLogin.btCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmLogin.edUserExit(Sender: TObject);
begin
  edUser.Text := (edUser.Text);
end;

end.

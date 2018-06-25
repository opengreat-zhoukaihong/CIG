program PicBst;

uses
  SysUtils,
  Windows,
  Messages,
  Dialogs,
  Forms,
  PicMain in 'PicMain.PAS' {fmPicMain},
  About in 'about.pas' {AboutBox},
  pic in 'pic.pas' {dmPic: TDataModule},
  DirSetting in 'DirSetting.pas' {fmDirSetting},
  ManuScript in 'ManuScript.pas' {fmManuScript},
  Author in 'Author.pas' {fmAuthor},
  EditAuthor in 'EditAuthor.pas' {fmEditAuthor},
  Photo in 'Photo.pas' {fmPhoto},
  EditPhoto in 'EditPhoto.pas' {fmEditPhoto},
  cat in 'cat.pas' {fmCat},
  DisplayPhoto in 'DisplayPhoto.pas' {fmDisplayPhoto},
  Admin in 'Admin.pas' {fmAdmin},
  CollectionPhoto in 'CollectionPhoto.pas' {fmCollectionPhoto},
  Login in 'Login.pas' {fmLogin},
  CollectionPub in 'CollectionPub.pas' {fmCollectionPub};

{$R *.RES}
var
  wUserID, wPassword : String;
  wIsLogin : Boolean;
begin
  Application.Initialize;
  Application.Title := 'CHINAPIC.COM数据输入系统';
  Application.CreateForm(TdmPic, dmPic);
  while true do
  begin
    fmLogin := TfmLogin.Create(Application);
    with fmLogin do
    begin
      try
        ShowModal;
      finally
        wUserID := fmLogin.edUser.Text;
        wPassword := fmLogin.mePassword.Text;
        if trim(wUserID) = '' then
        begin
          Free;
          Application.Terminate;
        end;
        with dmPic.dbPic do
        begin
          if not Connected then
          try
            Connected := True;
          except
            ShowMessage('未能连接CNPIC数据库！');
          end;
          if not Connected then
            Application.Terminate
        end;

        with dmPic.quGetUser do
        begin
          if Active then
            Close;
          Sql.Clear;
          Sql.Add('select * from Local_operator where login='''
                    + wUserID + ''' and  passwd = ''' + wPassword + '''');
          Open;
          if not IsEmpty then
          begin
            if dmPic.quGetUserPRIVILEDGE.AsString = 'A' then
                gIsAdmin := True
            else
                gIsAdmin := False;
            wIsLogin := True;
          end
          else
            wIsLogin := False;
            //dbPic.Params.Values['USER NAME'] := wUserID;
            //dbPic.Params.Values['PASSWORD'] := wPassword;
        end;
        Release;
      end;
      if wIsLogin then
          Break
      else
        ShowMessage('用户口令不对，请再输入!');
    end;
  end;
  if wIsLogin then
  begin
    Application.CreateForm(TfmPicMain, fmPicMain);
    gPhotoPath := 'P:';
    Application.CreateForm(TAboutBox, AboutBox);
    Application.Run;
  end;
end.

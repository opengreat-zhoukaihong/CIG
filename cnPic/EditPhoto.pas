unit EditPhoto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, wwdbdatetimepicker, StdCtrls, ComCtrls, wwriched, ExtCtrls, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, Db, DBTables, Grids, Wwdbigrd, Wwdbgrid,
  wwdblook, jpeg, Menus, Wwquery, Wwdatsrc;

type
  TfmEditPhoto = class(TForm)
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    Label3: TLabel;
    DBText1: TDBText;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    paPhoto: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label16: TLabel;
    Label15: TLabel;
    dedName: TDBEdit;
    dedPlace: TDBEdit;
    dedStorageID: TDBEdit;
    dcbManuScript: TwwDBComboBox;
    dedLocation: TDBEdit;
    dtpTime: TwwDBDateTimePicker;
    gbImage: TGroupBox;
    gbPrice: TGroupBox;
    Label22: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    dedFullPrice: TDBEdit;
    dedCom: TDBEdit;
    dedNoCom: TDBEdit;
    dedMagaz: TDBEdit;
    Label26: TLabel;
    Label27: TLabel;
    gbAward: TGroupBox;
    wwDBGrid1: TwwDBGrid;
    gbCollection: TGroupBox;
    wwDBGrid2: TwwDBGrid;
    Label8: TLabel;
    dedFileSize: TDBEdit;
    Label7: TLabel;
    Label4: TLabel;
    dlcFileExt: TwwDBComboBox;
    dlcDirSetting: TwwDBLookupCombo;
    Label23: TLabel;
    dedImageName: TDBEdit;
    GroupBox1: TGroupBox;
    dreContent: TwwDBRichEdit;
    gbVerify: TGroupBox;
    dckVerify2: TDBCheckBox;
    dckVerify1: TDBCheckBox;
    dcbFilmType: TwwDBComboBox;
    dlcManuscript: TwwDBLookupCombo;
    Panel2: TPanel;
    imPhoto: TImage;
    gbRemark: TGroupBox;
    wwDBRichEdit2: TwwDBRichEdit;
    gbCat: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    dlcCat1: TwwDBLookupCombo;
    dlcCat3: TwwDBLookupCombo;
    dlcCat4: TwwDBLookupCombo;
    dlcCat5: TwwDBLookupCombo;
    dlcCat2: TwwDBLookupCombo;
    odImage: TOpenDialog;
    pmDisplay: TPopupMenu;
    N1: TMenuItem;
    pmAward: TPopupMenu;
    quSelCollection: TwwQuery;
    quSelCollectionCOLLECTIONID: TBCDField;
    quSelCollectionNAME: TStringField;
    quSelCollectionDESCRIPTION: TStringField;
    quSelCollectionPUBLISH_COMPANY: TStringField;
    quSelCollectionAUTHORID: TBCDField;
    quSelCollectionSTATUS: TStringField;
    quSelCollectionCREATEDATE: TDateTimeField;
    quSelCollectionPHOTOID: TBCDField;
    quSelCollectionVERIFY_FLAG: TStringField;
    dlcCollectionName: TwwDBLookupCombo;
    dedPhotoID: TDBEdit;
    ckThumbFile: TCheckBox;
    ckSmallFile: TCheckBox;
    ckMiddleFile: TCheckBox;
    dsSelCollection: TwwDataSource;
    usSelCollection: TUpdateSQL;
    Label18: TLabel;
    dlcCat6: TwwDBLookupCombo;
    dlcCat7: TwwDBLookupCombo;
    Label28: TLabel;
    Label29: TLabel;
    dlcCat8: TwwDBLookupCombo;
    dcbCurr: TwwDBComboBox;
    Label30: TLabel;
    lbDir: TLabel;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    pmPub: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    dcbColorType: TDBCheckBox;
    dcbDisplayType: TwwDBComboBox;
    Label31: TLabel;
    odDirSetting: TOpenDialog;
    procedure N1Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label23Click(Sender: TObject);
    procedure dlcCat1Change(Sender: TObject);
    procedure dlcCat2Change(Sender: TObject);
    procedure dlcCat3Change(Sender: TObject);
    procedure dlcCat4Change(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure imPhotoDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dedPhotoIDChange(Sender: TObject);
    procedure dlcCat5Change(Sender: TObject);
    procedure wwDBGrid1Enter(Sender: TObject);
    procedure gbCatDblClick(Sender: TObject);
    procedure gbCollectionDblClick(Sender: TObject);
    procedure quSelCollectionAfterPost(DataSet: TDataSet);
    procedure dlcCat6Change(Sender: TObject);
    procedure dlcCat7Change(Sender: TObject);
    procedure dlcCat8Change(Sender: TObject);
    procedure dedStorageIDExit(Sender: TObject);
    procedure quSelCollectionBeforeDelete(DataSet: TDataSet);
    procedure N4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure paPhotoDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dtpTimeEnter(Sender: TObject);
    procedure Label30DblClick(Sender: TObject);
    procedure wwDBGrid1Exit(Sender: TObject);
    procedure wwDBGrid2Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEditPhoto: TfmEditPhoto;
  gSeq, gImageFile, gDir, gFileHead : String;

implementation

{$R *.DFM}
uses Pic, DisplayPhoto, ManuScript, DirSetting, cat, CollectionPub, Photo;

procedure TfmEditPhoto.N1Click(Sender: TObject);
begin
  try
    Application.CreateForm(TfmDisplayPhoto, fmDisplayPhoto);
    fmDisplayPhoto.imPhoto.Picture.Graphic := imPhoto.Picture.Graphic;
    fmDisplayPhoto.ShowModal;

  finally
    fmDisplayPhoto.Free;
  end;
end;

procedure TfmEditPhoto.Label6Click(Sender: TObject);

begin
  try
    Application.CreateForm(TfmManuScript, fmManuScript);
    fmManuScript.FormStyle := fsNormal;
    fmManuScript.Visible := False;
    fmManuScript.ShowModal;
  finally
    fmManuScript.Free;
    dmPic.quManuScriptSize.Open;
  end;
end;


procedure TfmEditPhoto.Label23Click(Sender: TObject);
begin
  try
    Application.CreateForm(TfmDirSetting, fmDirSetting);
    fmDirSetting.FormStyle := fsNormal;
    fmDirSetting.Visible := False;
    fmDirSetting.dlcName.Text :=
      dmPic.quSelAuthor.FieldByName('FirstName').AsString;
    fmDirSetting.dlcName.Enabled := False;
    fmDirSetting.ShowModal;
  finally
    fmDirSetting.Free;
    dmPic.quSelAuthor.Open;
    dmPic.quDirSetting.Open;
  end;
end;

procedure TfmEditPhoto.dlcCat1Change(Sender: TObject);
begin
  if  (dmPic.quPhoto.State <> dsInsert) and
       (dmPic.quPhoto.State <> dsEdit) then
    dmPic.quPhoto.Edit;
  dlcCat2.Text := '';
  dlcCat3.Text := '';
  dlcCat4.Text := '';
  dlcCat5.Text := '';
  dlcCat6.Text := '';
  dlcCat7.Text := '';
  dlcCat8.Text := '';

end;

procedure TfmEditPhoto.dlcCat2Change(Sender: TObject);
begin
  if  (dmPic.quPhoto.State <> dsInsert) and
       (dmPic.quPhoto.State <> dsEdit) then
    dmPic.quPhoto.Edit;
  dlcCat3.Text := '';
  dlcCat4.Text := '';
  dlcCat5.Text := '';
  dlcCat6.Text := '';
  dlcCat7.Text := '';
  dlcCat8.Text := '';
end;

procedure TfmEditPhoto.dlcCat3Change(Sender: TObject);
begin
  if  (dmPic.quPhoto.State <> dsInsert) and
       (dmPic.quPhoto.State <> dsEdit) then
    dmPic.quPhoto.Edit;
  dlcCat4.Text := '';
  dlcCat5.Text := '';
  dlcCat6.Text := '';
  dlcCat7.Text := '';
  dlcCat8.Text := '';
end;

procedure TfmEditPhoto.dlcCat4Change(Sender: TObject);
begin
  if  (dmPic.quPhoto.State <> dsInsert) and
       (dmPic.quPhoto.State <> dsEdit) then
    dmPic.quPhoto.Edit;
  dlcCat5.Text := '';
  dlcCat6.Text := '';
  dlcCat7.Text := '';
  dlcCat8.Text := '';
end;

procedure TfmEditPhoto.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
  //CopyFile(
end;

procedure TfmEditPhoto.imPhotoDblClick(Sender: TObject);
var
  wImageFile : file of byte;
 
begin
  try
    Application.CreateForm(TfmDisplayPhoto, fmDisplayPhoto);
    fmDisplayPhoto.imPhoto.Picture.Graphic := imPhoto.Picture.Graphic;
    fmDisplayPhoto.ShowModal;

  finally
    fmDisplayPhoto.Free;
  end;
{  if (dmPic.quPhoto.State <> dsInsert) and (dmPic.quPhoto.State <> dsEdit) then
    dmPic.quPhoto.Edit;
  if odImage.Execute then
  begin
    imPhoto.Picture.LoadFromFile(odImage.FileName);
    AssignFile(wImageFile, odImage.FileName);
    Reset(wImageFile);
    dmPic.quPhoto.FieldByName('File_format').AsString  :=
      UpperCase(Copy(ExtractFileExt(odImage.FileName),2,3));
    dmPic.quPhoto.FieldByName('ImageFile').AsString :=
      ExtractFileName(odImage.FileName);
    dmPic.quPhoto.FieldByName('File_Size').AsInteger :=
       FileSize(wImageFile);
    //some_proc(PChar(odImage.FileName)) ;
    //PChar(odImage.FileName);

    CloseFile(wImageFile);
    
  end;  }
end;


procedure TfmEditPhoto.FormCreate(Sender: TObject);
begin
  with quSelCollection do
    if not Active then
      Open;
  if gIsAdmin then
  begin
    dckVerify2.Enabled := True;
    dckVerify1.Enabled := True;
    dmPic.quAwardWorkVERIFY_FLAG.Visible := True ;
    dmPic.quCollectionPhotoPVERIFY_FLAG.Visible := True;
  end
  else
  begin
    dckVerify2.Enabled := False;
    dckVerify1.Enabled := False;
    dmPic.quAwardWorkVERIFY_FLAG.Visible := False;
    dmPic.quCollectionPhotoPVERIFY_FLAG.Visible := False;
  end;
end;

procedure TfmEditPhoto.dedPhotoIDChange(Sender: TObject);
var
  wImageFile, wCat1, wCat2, wCat3, wCat4, wCat5, wCat6, wCat7, wCat8 : String;
  wCat1ID, wCat2ID, wCat3ID, wCat4ID, wCat5ID, wCat6ID, wCat7ID, wCat8ID  : Integer;
begin
  if not fmEditPhoto.Showing then
    Exit;
  with dmPic do
  begin
    if  (quPhoto.State <> dsInsert) then
    begin
      if (quPhotoVERIFY_FLAG1.AsString = 'Y') and (not gIsAdmin) then
        paPhoto.Enabled := False
      else
        paPhoto.Enabled := True;
      wImageFile := gPhotoPath + quPhotoDir.AsString + quPhotoIMAGEFILE.AsString;
    //  ShowMessage(quPhotoDir.AsString);
    //  ShowMessage(quPhotoIMAGEFILE.AsString);
      wImageFile := StringReplace(wImageFile,'/','\',[rfReplaceAll, rfIgnoreCase]);
      if FileExists(wImageFile) then
        imPhoto.Picture.LoadFromFile(wImageFile)
      else
      begin
        imPhoto.Picture := nil;
        ShowMessage(wImageFile + '图片文件不存在!');
      end;
      if quPhotoTHUMBFILE.AsString <> '' then
        ckThumbFile.Checked := True
      else
        ckThumbFile.Checked := False;
      if quPhotoSMALLFILE.AsString <> '' then
        ckSmallFile.Checked := True
      else
        ckSmallFile.Checked := False;
      if quPhotoMIDDLEFILE.AsString <> '' then
        ckMiddleFile.Checked := True
      else
        ckMiddleFile.Checked := False;
    end
    else
      paPhoto.Enabled := True;
    dlcCat1.Text := '';
    case quPhotoCategoryGrade.AsInteger of
    0:begin
        dlcCat1.Text := quPhotoCategoryCat.AsString;
      end;
    1:begin
        wCat2 := quPhotoCategoryCat.AsString;
        with quGetCat do
        begin
          if Active then
            Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              quPhotoCategoryCATEGORYID.AsString );
          Open;
          wCat1 := quGetCatParentCat.AsString;
          wCat1ID := quGetCatPARENTCATEID.AsInteger;
          Close;
        end;
        dlcCat1.Text := wCat1;
        dlcCat2.Text := wCat2;

      end;
    2:begin
        wCat3 := quPhotoCategoryCat.AsString;
        with quGetCat do
        begin
          if Active then
            Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              quPhotoCategoryCATEGORYID.AsString );
          Open;
          wCat2 := quGetCatParentCat.AsString;
          wCat2ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat2ID));
          Open;
          wCat1 := quGetCatParentCat.AsString;
          wCat1ID := quGetCatPARENTCATEID.AsInteger;
          Close;
        end;
        dlcCat1.Text := wCat1;
        dlcCat2.Text := wCat2;
        dlcCat3.Text := wCat3;

      end;
    3:begin
        wCat4 := quPhotoCategoryCat.AsString;
        with quGetCat do
        begin
          if Active then
            Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              quPhotoCategoryCATEGORYID.AsString );
          Open;
          wCat3 := quGetCatParentCat.AsString;
          wCat3ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat3ID));
          Open;
          wCat2 := quGetCatParentCat.AsString;
          wCat2ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat2ID));
          Open;
          wCat1 := quGetCatParentCat.AsString;
          wCat1ID := quGetCatPARENTCATEID.AsInteger;
          Close;
        end;
        dlcCat1.Text := wCat1;
        dlcCat2.Text := wCat2;
        dlcCat3.Text := wCat3;
        dlcCat4.Text := wCat4;
      end;
    4:begin
        wCat5 := quPhotoCategoryCat.AsString;
        with quGetCat do
        begin
          if Active then
            Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              quPhotoCategoryCATEGORYID.AsString );
          Open;
          wCat4 := quGetCatParentCat.AsString;
          wCat4ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat4ID));
          Open;
          wCat3 := quGetCatParentCat.AsString;
          wCat3ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat3ID));
          Open;
          wCat2 := quGetCatParentCat.AsString;
          wCat2ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat2ID));
          Open;
          wCat1 := quGetCatParentCat.AsString;
          wCat1ID := quGetCatPARENTCATEID.AsInteger;
          Close;
        end;
        dlcCat1.Text := wCat1;
        dlcCat2.Text := wCat2;
        dlcCat3.Text := wCat3;
        dlcCat4.Text := wCat4;
        dlcCat5.Text := wCat5;
      end;
    5:begin
        wCat6 := quPhotoCategoryCat.AsString;
        with quGetCat do
        begin
          if Active then
            Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              quPhotoCategoryCATEGORYID.AsString );
          Open;
          wCat5 := quGetCatParentCat.AsString;
          wCat5ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat5ID));
          Open;
          wCat4 := quGetCatParentCat.AsString;
          wCat4ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat4ID));
          Open;
          wCat3 := quGetCatParentCat.AsString;
          wCat3ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat3ID));
          Open;
          wCat2 := quGetCatParentCat.AsString;
          wCat2ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat2ID));
          Open;
          wCat1 := quGetCatParentCat.AsString;
          wCat1ID := quGetCatPARENTCATEID.AsInteger;
          Close;
        end;
        dlcCat1.Text := wCat1;
        dlcCat2.Text := wCat2;
        dlcCat3.Text := wCat3;
        dlcCat4.Text := wCat4;
        dlcCat5.Text := wCat5;
        dlcCat6.Text := wCat6;
      end;
    6:begin
        wCat7 := quPhotoCategoryCat.AsString;
        with quGetCat do
        begin
          if Active then
            Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              quPhotoCategoryCATEGORYID.AsString );
          Open;
          wCat6 := quGetCatParentCat.AsString;
          wCat6ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat6ID));
          Open;
          wCat5 := quGetCatParentCat.AsString;
          wCat5ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat5ID));
          Open;
          wCat4 := quGetCatParentCat.AsString;
          wCat4ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat4ID));
          Open;
          wCat3 := quGetCatParentCat.AsString;
          wCat3ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat3ID));
          Open;
          wCat2 := quGetCatParentCat.AsString;
          wCat2ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat2ID));
          Open;
          wCat1 := quGetCatParentCat.AsString;
          wCat1ID := quGetCatPARENTCATEID.AsInteger;
          Close;
        end;
        dlcCat1.Text := wCat1;
        dlcCat2.Text := wCat2;
        dlcCat3.Text := wCat3;
        dlcCat4.Text := wCat4;
        dlcCat5.Text := wCat5;
        dlcCat6.Text := wCat6;
        dlcCat7.Text := wCat7;
      end;
    7:begin
        wCat8 := quPhotoCategoryCat.AsString;
        with quGetCat do
        begin
          if Active then
            Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              quPhotoCategoryCATEGORYID.AsString );
          Open;
          wCat7 := quGetCatParentCat.AsString;
          wCat7ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat7ID));
          Open;
          wCat6 := quGetCatParentCat.AsString;
          wCat6ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat6ID));
          Open;
          wCat5 := quGetCatParentCat.AsString;
          wCat5ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat5ID));
          Open;
          wCat4 := quGetCatParentCat.AsString;
          wCat4ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat4ID));
          Open;
          wCat3 := quGetCatParentCat.AsString;
          wCat3ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat3ID));
          Open;
          wCat2 := quGetCatParentCat.AsString;
          wCat2ID := quGetCatPARENTCATEID.AsInteger;
          Close;
          SQL.Clear;
          Sql.Add('Select * from local_category_category where categoryID = ' +
              IntToStr(wCat2ID));
          Open;
          wCat1 := quGetCatParentCat.AsString;
          wCat1ID := quGetCatPARENTCATEID.AsInteger;
          Close;
        end;
        dlcCat1.Text := wCat1;
        dlcCat2.Text := wCat2;
        dlcCat3.Text := wCat3;
        dlcCat4.Text := wCat4;
        dlcCat5.Text := wCat5;
        dlcCat6.Text := wCat6;
        dlcCat7.Text := wCat7;
        dlcCat8.Text := wCat8;
      end;
    end;
    //ShowMessage(quPhotoCategoryCat.AsString);
  end;
end;

procedure TfmEditPhoto.dlcCat5Change(Sender: TObject);
begin
  if  (dmPic.quPhoto.State <> dsInsert) and
       (dmPic.quPhoto.State <> dsEdit) then
    dmPic.quPhoto.Edit;
  dlcCat6.Text := '';
  dlcCat7.Text := '';
  dlcCat8.Text := '';

end;

procedure TfmEditPhoto.wwDBGrid1Enter(Sender: TObject);
begin
  if  (dmPic.quPhoto.State = dsInsert) then
    dmPic.quPhoto.Post;
end;

procedure TfmEditPhoto.gbCatDblClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfmCat, fmCat);
    fmCat.FormStyle := fsNormal;
    fmCat.Visible := False;
    fmCat.ShowModal;
  finally
    fmCat.Free;
    dmPic.quCategory1.Open;
    dmPic.quCategory2.Open;
    dmPic.quCategory3.Open;
    dmPic.quCategory4.Open;
    dmPic.quCategory5.Open;
  end;
end;

procedure TfmEditPhoto.gbCollectionDblClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfmCollectionPub, fmCollectionPub);
    fmCollectionPub.ShowModal;
  finally
    fmCollectionPub.Free;
  end;
end;

procedure TfmEditPhoto.quSelCollectionAfterPost(DataSet: TDataSet);
begin
  try
    quSelCollection.ApplyUpdates;
    quSelCollection.CommitUpdates;
  except
    quSelCollection.CancelUpdates;
    ShowMessage('更新错误!');
  end;
end;

procedure TfmEditPhoto.dlcCat6Change(Sender: TObject);
begin
  if  (dmPic.quPhoto.State <> dsInsert) and
       (dmPic.quPhoto.State <> dsEdit) then
    dmPic.quPhoto.Edit;
  dlcCat7.Text := '';
  dlcCat8.Text := '';
end;

procedure TfmEditPhoto.dlcCat7Change(Sender: TObject);
begin
  if  (dmPic.quPhoto.State <> dsInsert) and
       (dmPic.quPhoto.State <> dsEdit) then
    dmPic.quPhoto.Edit;
  dlcCat8.Text := '';
end;

procedure TfmEditPhoto.dlcCat8Change(Sender: TObject);
begin
  if  (dmPic.quPhoto.State <> dsInsert) and
       (dmPic.quPhoto.State <> dsEdit) then
    dmPic.quPhoto.Edit;
end;

procedure TfmEditPhoto.dedStorageIDExit(Sender: TObject);
var
  wImageFile : file of byte;
  wThumbFile, wSmallFile, wMiddleFile : String;
begin
  if Trim(dedStorageID.Text) = '' then
  begin
    if Trim(dedName.Text) = '' then
    begin
      //ShowMessage('请输入图片名!');
      dedName.SetFocus;
      Exit;
    end;
    ShowMessage('请输入存储编号!');
    dedStorageID.SetFocus;
    Exit;
  end;
  if dmPic.quPhoto.state <> dsInsert then
    if dmPic.quPhotoSTORAGEID.OldValue = dmPic.quPhotoSTORAGEID.NewValue then
      Exit;
  gSeq := Trim(dedStorageID.Text);
  Delete(gSeq, 1, Pos('0',gSeq) - 1);
  try
    StrToInt(gSeq);
  except
    ShowMessage('存储编号错误!');
    dedStorageID.Text := '';
    dedStorageID.SetFocus;
    Exit;
  end;
  with dmPic.quDirSetting do
  begin
    if not Active then
      Open;
    if IsEmpty then
    begin
      ShowMessage('没有设置图片路径!');
      dedStorageID.Text := '';
      dedStorageID.SetFocus;
      Exit;
    end;
    if RecordCount = 1 then
    begin
      gDir := FieldByName('Dir').AsString;
      gFileHead := FieldByName('File_Head').AsString;
    end
    else
    begin
      First;
      while (not eof) do
      begin
        if (StrToInt(gSeq) >= FieldByName('Start_Seq').AsInteger) and
           (StrToInt(gSeq) <= FieldByName('End_Seq').AsInteger) then
        begin
          gDir := FieldByName('Dir').AsString;
          gFileHead := FieldByName('File_Head').AsString;
          Break;
        end;
        Next;
      end;
      if gDir = '' then
      begin
        ShowMessage('没有设置图片路径的起止序号!');
        dedStorageID.Text := '';
        dedStorageID.SetFocus;
        Exit;
      end;
    end;
  end;
 // fmPhoto.dcdDir.Text +
  gImageFile :=  lbDir.Caption + gFileHead + '.5' + gSeq + '.jpg';
  if FileExists(gImageFile) then
  begin
    imPhoto.Picture.LoadFromFile(gImageFile);
   // AssignFile(wImageFile, gImageFile);
   // Reset(wImageFile);
    dmPic.quPhoto.FieldByName('File_format').AsString  := 'tif';
    //  (Copy(ExtractFileExt(gImageFile),2,3));
    dmPic.quPhoto.FieldByName('ImageFile').AsString :=
      ExtractFileName(gImageFile);
    //dmPic.quPhoto.FieldByName('File_Size').AsInteger :=
       //FileSize(wImageFile);
    //some_proc(PChar(odImage.FileName)) ;
    //PChar(odImage.FileName);

    //CloseFile(wImageFile);
    wThumbFile := StringReplace(gImageFile,'.5','.1',[rfReplaceAll, rfIgnoreCase]);
    wSmallFile := StringReplace(gImageFile,'.5','.2',[rfReplaceAll, rfIgnoreCase]);
    wMiddleFile := StringReplace(gImageFile,'.5','.4',[rfReplaceAll, rfIgnoreCase]);
    if FileExists(wThumbFile) then
      ckThumbFile.Checked := True
    else
      ckThumbFile.Checked := False;
    if FileExists(wSmallFile) then
      ckSmallFile.Checked := True
    else
    begin
      ShowMessage('小型图片不存在!');
      dedStorageID.Text := '';
      dedStorageID.SetFocus;
      Exit;
      //ckSmallFile.Checked := False;

    end;
    if FileExists(wMiddleFile) then
      ckMiddleFile.Checked := True
    else
      ckMiddleFile.Checked := False;
  end
  else
  begin
    ShowMessage(gImageFile + '图片文件不存在!');
    dedStorageID.Text := '';
    dedStorageID.SetFocus;
  end;
end;

procedure TfmEditPhoto.quSelCollectionBeforeDelete(DataSet: TDataSet);
begin
  with quSelCollection do
  begin
    if (Trim(FieldByName('Verify_flag').AsString) = 'Y') then
    begin
      if not gIsAdmin  then
      begin
        ShowMessage('你没有删除记录权利!');
        Abort;
      end;
    end;
  end;
  if MessageDlg('确认删除记录?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then
      abort;
end;

procedure TfmEditPhoto.N4Click(Sender: TObject);
begin
  if dmPic.quAwardWork.State in [dsInsert, dsEdit] then
    dmPic.quAwardWork.Post;
end;

procedure TfmEditPhoto.N2Click(Sender: TObject);
begin
  if dmPic.quAwardWork.State in [dsInsert, dsEdit] then
    dmPic.quAwardWork.Cancel;
end;

procedure TfmEditPhoto.N3Click(Sender: TObject);
begin
  if not dmPic.quAwardWork.IsEmpty then
    dmPic.quAwardWork.Delete;
end;

procedure TfmEditPhoto.MenuItem1Click(Sender: TObject);
begin
  if dmPic.quCollectionPhotoP.State in [dsInsert, dsEdit] then
    dmPic.quCollectionPhotoP.Cancel;
end;

procedure TfmEditPhoto.MenuItem2Click(Sender: TObject);
begin
  if not dmPic.quCollectionPhotoP.IsEmpty then
    dmPic.quCollectionPhotoP.Delete;
end;

procedure TfmEditPhoto.MenuItem3Click(Sender: TObject);
begin
  if dmPic.quCollectionPhotoP.State in [dsInsert, dsEdit] then
    dmPic.quCollectionPhotoP.Post;
end;

procedure TfmEditPhoto.paPhotoDblClick(Sender: TObject);
begin
  ShowMessage('testing:' + dmPic.quPhotoPHOTOID.AsString); 
end;

procedure TfmEditPhoto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with dmPic do
  begin
    with quAwardWork do
    begin
      if State = dsInsert  then
        if MessageDlg('获奖记录没有保存，是否取消?',
           mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          Cancel;
        end
        else
          Abort;
    end;
    with quCollectionPhotoP do
    begin
      if State = dsInsert  then
        if MessageDlg('出版情况记录没有保存，是否取消?',
           mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          Cancel;
        end
        else
          Abort;
    end;
    with quPhoto do
    begin
      if State = dsInsert  then
        if MessageDlg('记录没有保存，是否关闭?',
           mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          Cancel;
        end
        else
          Abort;
    end;
  end;
end;

procedure TfmEditPhoto.dtpTimeEnter(Sender: TObject);
var
  wYear,
  wMonth,
  wDay : word;
begin
  DecodeDate(now, wYear, wMonth, wDay);
  dtpTime.CalendarAttributes.PopupYearOptions.StartYear :=
    wYear - 100;
  dtpTime.CalendarAttributes.PopupYearOptions.NumberColumns := 10;
end;

procedure TfmEditPhoto.Label30DblClick(Sender: TObject);
begin
  if odDirSetting.Execute then
  begin
    //StringReplace(const S, OldPattern, NewPattern: string; Flags: TReplaceFlags): string;
    lbDir.Caption := ExtractFilePath(odDirSetting.FileName);

  end;
end;

procedure TfmEditPhoto.wwDBGrid1Exit(Sender: TObject);
begin
  if dmPic.quAwardWork.state in [dsInsert,dsEdit] then
    dmPic.quAwardWork.Post;
end;

procedure TfmEditPhoto.wwDBGrid2Exit(Sender: TObject);
begin
  if dmPic.quCollectionPhotoP.state in [dsInsert,dsEdit] then
    dmPic.quCollectionPhotoP.Post;
end;

end.

unit EditAuthor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, Mask, ComCtrls, wwriched, Grids, Wwdbigrd,
  Wwdbgrid, wwdbdatetimepicker, Buttons, Menus, db, wwdbedit, Wwdotdot,
  DBTables, Wwdatsrc, Wwquery, wwdblook;

type
  TfmEditAuthor = class(TForm)
    paAuthor: TPanel;
    Label1: TLabel;
    dedAuthorID: TDBEdit;
    Label2: TLabel;
    dedName: TDBEdit;
    Label4: TLabel;
    dedTitle: TDBEdit;
    Label5: TLabel;
    dedDuty: TDBEdit;
    Label6: TLabel;
    Label8: TLabel;
    dedCompany: TDBEdit;
    Label9: TLabel;
    dedTel: TDBEdit;
    Label10: TLabel;
    dedMobile: TDBEdit;
    Label11: TLabel;
    dedFax: TDBEdit;
    Label12: TLabel;
    dedEmail: TDBEdit;
    Label13: TLabel;
    Label14: TLabel;
    dedPost: TDBEdit;
    Label16: TLabel;
    dedPY: TDBEdit;
    drgSex: TDBRadioGroup;
    drgStatus: TDBRadioGroup;
    gbBio: TGroupBox;
    dtpBirth: TwwDBDateTimePicker;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    GroupBox3: TGroupBox;
    wwDBGrid1: TwwDBGrid;
    GroupBox2: TGroupBox;
    wwDBGrid2: TwwDBGrid;
    dreAdd: TwwDBRichEdit;
    pmPublish: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    pmCollection: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    dckVerify: TDBCheckBox;
    wwDBRichEdit2: TwwDBRichEdit;
    GroupBox1: TGroupBox;
    wwDBGrid3: TwwDBGrid;
    dcdDirSetting: TwwDBComboDlg;
    quDirSetting: TwwQuery;
    quDirSettingDIR: TStringField;
    quDirSettingDESCRIPTION: TStringField;
    quDirSettingRECORDSTATUS: TStringField;
    quDirSettingAUTHORID: TBCDField;
    quDirSettingDIRID: TBCDField;
    dsDirSetting: TwwDataSource;
    usDirSetting: TUpdateSQL;
    odDirSetting: TOpenDialog;
    dlcPhoto: TwwDBLookupCombo;
    quSelPhoto: TwwQuery;
    quSelPhotoPHOTOID: TBCDField;
    quSelPhotoNAME: TStringField;
    quSelPhotoPLACE: TStringField;
    quSelPhotoTIME: TDateTimeField;
    quSelPhotoIMAGEFILE: TStringField;
    quSelPhotoAUTHORID: TBCDField;
    quSelPhotoDESCRIPTION: TStringField;
    quSelPhotoLOCATION: TStringField;
    quSelPhotoCONTENT: TStringField;
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
    quDirSettingFILE_HEAD: TStringField;
    quDirSettingSTART_SEQ: TBCDField;
    quDirSettingEND_SEQ: TBCDField;
    N3: TMenuItem;
    N4: TMenuItem;
    pmDir: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    procedure SpeedButton1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quDirSettingAfterPost(DataSet: TDataSet);
    procedure quDirSettingBeforeDelete(DataSet: TDataSet);
    procedure quDirSettingNewRecord(DataSet: TDataSet);
    procedure dcdDirSettingCustomDlg(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dedAuthorIDChange(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure dtpBirthEnter(Sender: TObject);
    procedure wwDBGrid3Enter(Sender: TObject);
    procedure quDirSettingBeforePost(DataSet: TDataSet);
    procedure wwDBGrid3Exit(Sender: TObject);
    procedure wwDBGrid1Exit(Sender: TObject);
    procedure wwDBGrid2Exit(Sender: TObject);
    procedure quDirSettingPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure quDirSettingUpdateError(DataSet: TDataSet; E: EDatabaseError;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEditAuthor: TfmEditAuthor;

implementation
uses pic, CollectionPhoto;
{$R *.DFM}

procedure TfmEditAuthor.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfmEditAuthor.N2Click(Sender: TObject);
begin
  if dmPic.quPublishWC.State in [dsInsert, dsEdit] then
    dmPic.quPublishWC.Cancel;
end;

procedure TfmEditAuthor.N1Click(Sender: TObject);
begin
  if not dmPic.quPublishWC.IsEmpty then
    dmPic.quPublishWC.Delete;
end;

procedure TfmEditAuthor.MenuItem1Click(Sender: TObject);
begin
  if dmPic.quCollection.State in [dsInsert, dsEdit] then
    dmPic.quCollection.Cancel;
end;

procedure TfmEditAuthor.MenuItem2Click(Sender: TObject);
begin
  if not dmPic.quCollection.IsEmpty then
    dmPic.quCollection.Delete;
end;

procedure TfmEditAuthor.wwDBGrid1DblClick(Sender: TObject);
begin
  Application.CreateForm(TfmCollectionPhoto, fmCollectionPhoto);
  try
    fmCollectionPhoto.ShowModal;
  finally
    fmCollectionPhoto.Free;
  end;
end;

procedure TfmEditAuthor.FormCreate(Sender: TObject);
begin
  if gIsAdmin then
  begin
    dckVerify.Visible := True;
    dmPic.quCollectionVERIFY_FLAG.Visible := True;
    dmPic.quPublishWCVERIFY_FLAG.Visible := True;
  end
  else
  begin
    dckVerify.Visible := False;
    dmPic.quCollectionVERIFY_FLAG.Visible := False;
    dmPic.quPublishWCVERIFY_FLAG.Visible := False;
  end;
  with quSelPhoto do
    if not Active then
      Open;
  with quDirSetting do
    if not Active then
      Open;
end;

procedure TfmEditAuthor.quDirSettingAfterPost(DataSet: TDataSet);
begin
  try
    quDirSetting.ApplyUpdates;
    quDirSetting.CommitUpdates;
  except
    quDirSetting.CancelUpdates;
    ShowMessage('更新错误!');
  end;
end;

procedure TfmEditAuthor.quDirSettingBeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('确认删除记录?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then
      abort;
end;

procedure TfmEditAuthor.quDirSettingNewRecord(DataSet: TDataSet);
begin
  quDirSetting.FieldByName('DirID').AsInteger := 0;
  quDirSetting.FieldByName('AuthorID').AsInteger :=
    dmPic.quAuthor.FieldByName('AuthorID').AsInteger;
  quDirSetting.FieldByName('Start_Seq').AsInteger := 1;
  quDirSetting.FieldByName('End_Seq').AsInteger := 1000;
end;

procedure TfmEditAuthor.dcdDirSettingCustomDlg(Sender: TObject);
var
  wPath : String;
begin
  if odDirSetting.Execute then
  begin
    //StringReplace(const S, OldPattern, NewPattern: string; Flags: TReplaceFlags): string;
    wPath := ExtractFilePath(odDirSetting.FileName);
    Delete(wPath, 1, 2);
    wPath := StringReplace(wPath,'\','/',[rfReplaceAll, rfIgnoreCase]);
    quDirSetting.FieldByName('Dir').AsString := wPath;
  end;
end;

procedure TfmEditAuthor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with dmPic do
  begin
    with quAuthor do
    begin
      if State = dsInsert then
      begin
        if MessageDlg('记录没有保存，是否关闭?',
           mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          Cancel;
        end
        else
          Abort;
      end
      else
      begin
        with quDirSetting do
        begin
          if State in [dsInsert, dsEdit] then
            Post;
          {if IsEmpty then
          begin
            ShowMessage('输入图片路径!');
            Abort;
          end; }
        end;
      end;
    end;
  end;
  with quSelPhoto do
    if Active then
      Close;
  with quDirSetting do
    if Active then
      Close;
end;

procedure TfmEditAuthor.dedAuthorIDChange(Sender: TObject);
begin
  with dmPic do
  begin
    if (quAuthor.State <> dsInsert) and (quAuthorFIRSTNAME.AsString <> '') then
    begin
      if (quAuthorVERIFY_FLAG.AsString = 'Y') and (not gIsAdmin) then
        paAuthor.Enabled := False
      else
        paAuthor.Enabled := True;
    end
    else
      paAuthor.Enabled := True;
  end;
end;

procedure TfmEditAuthor.N3Click(Sender: TObject);
begin
  if dmPic.quCollection.State in [dsInsert, dsEdit] then
    dmPic.quCollection.Post;
end;

procedure TfmEditAuthor.N4Click(Sender: TObject);
begin
  if dmPic.quPublishWC.State in [dsInsert, dsEdit] then
    dmPic.quPublishWC.Post;
end;

procedure TfmEditAuthor.MenuItem3Click(Sender: TObject);
begin
  if quDirSetting.State in [dsInsert, dsEdit] then
    quDirSetting.Cancel;
end;

procedure TfmEditAuthor.MenuItem4Click(Sender: TObject);
begin
  if not quDirSetting.IsEmpty then
    quDirSetting.Delete;
end;

procedure TfmEditAuthor.MenuItem5Click(Sender: TObject);
begin
  if quDirSetting.State in [dsInsert, dsEdit] then
    quDirSetting.Post;
end;

procedure TfmEditAuthor.dtpBirthEnter(Sender: TObject);
var
  wYear,
  wMonth,
  wDay : word;
begin
  DecodeDate(now, wYear, wMonth, wDay);
  dtpBirth.CalendarAttributes.PopupYearOptions.StartYear :=
    wYear - 100;
  dtpBirth.CalendarAttributes.PopupYearOptions.NumberColumns := 10;
end;

procedure TfmEditAuthor.wwDBGrid3Enter(Sender: TObject);
begin
  if (dmPic.quAuthor.State in [dsInsert,dsEdit]) and
     (dmPic.quAuthor.FieldByName('AuthorID').AsInteger > 0) then
    dmPic.quAuthor.Post;
end;

procedure TfmEditAuthor.quDirSettingBeforePost(DataSet: TDataSet);
begin
  if quDirSettingDIR.AsString = '' then
  begin
    ShowMessage('请输入图片路径!');
    Abort;
  end;
  if quDirSettingFILE_HEAD.AsString = '' then
  begin
    ShowMessage('请输入文件前缀!');
    Abort;
  end;
end;

procedure TfmEditAuthor.wwDBGrid3Exit(Sender: TObject);
begin
  if quDirSetting.state in [dsInsert,dsEdit] then
    quDirSetting.Post;
end;

procedure TfmEditAuthor.wwDBGrid1Exit(Sender: TObject);
begin
  if dmPic.quCollection.state in [dsInsert,dsEdit] then
    dmPic.quCollection.Post;
end;

procedure TfmEditAuthor.wwDBGrid2Exit(Sender: TObject);
begin
  if dmPic.quPublishWC.state in [dsInsert,dsEdit] then
    dmPic.quPublishWC.Post;
end;

procedure TfmEditAuthor.quDirSettingPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  if (pos('changed the record', E.Message) <> 0) then
  begin
    ShowMessage('更改记录错误!');
    Action := daAbort;
    DataSet.Close;
    DataSet.Open;
  end
  else
  begin
    if (pos('UNIQUE KEY', e.Message) <> 0) then
    begin
      ShowMessage('输入记录已经存在!');
      Action := daAbort;
      DataSet.Close;
      DataSet.Open;
    end
    else
    if Length(e.Message) > 0 then
    begin
      ShowMessage(e.Message);
      Action := daAbort;
    end;
  end; 
end;

procedure TfmEditAuthor.quDirSettingUpdateError(DataSet: TDataSet;
  E: EDatabaseError; UpdateKind: TUpdateKind;
  var UpdateAction: TUpdateAction);
begin
  if (pos('changed the record', E.Message) <> 0) then
  begin
    ShowMessage('更改记录错误！');
    UpdateAction := uaAbort;
    DataSet.Close;
    DataSet.Open;
  end
  else
  begin
    if (pos('unique', e.Message) <> 0) then
    begin
      ShowMessage('输入记录已经存在！');
      UpdateAction := uaAbort;
      //DataSet.Close;
      //DataSet.Open;
    end
    else
    if Length(e.Message) > 0 then
    begin
      ShowMessage(e.Message);
      UpdateAction := uaAbort;
    end;
  end;
end;

end.

unit pic;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, DBTables, DB, Wwdatsrc, Wwquery, Wwtable;

type
  TdmPic = class(TDataModule)
    dbPic: TDatabase;
    quDirSetting: TwwQuery;
    dsDirSetting: TwwDataSource;
    usDirSetting: TUpdateSQL;
    quDirSettingDIRID: TBCDField;
    quDirSettingDIR: TStringField;
    quDirSettingDESCRIPTION: TStringField;
    quManuScriptSize: TwwQuery;
    dsManuScriptSize: TwwDataSource;
    usManuScriptSize: TUpdateSQL;
    quManuScriptSizeMANUSCRIPTID: TBCDField;
    quManuScriptSizeMANUSCRIPTSIZE: TStringField;
    quAuthor: TwwQuery;
    dsAuthor: TwwDataSource;
    usAuthor: TUpdateSQL;
    quAuthorAUTHORID: TBCDField;
    quAuthorFIRSTNAME: TStringField;
    quAuthorSEX: TStringField;
    quAuthorTITLE: TStringField;
    quAuthorDUTY: TStringField;
    quAuthorBIRTH: TDateTimeField;
    quAuthorBIO: TStringField;
    quAuthorCOMPANY: TStringField;
    quAuthorPHONE: TStringField;
    quAuthorMOBILE: TStringField;
    quAuthorFAX: TStringField;
    quAuthorEMAIL: TStringField;
    quAuthorADDRESS: TMemoField;
    quAuthorPOSTCODE: TStringField;
    quAuthorSTATUS: TStringField;
    quAuthorSURORDER: TStringField;
    quAuthorVERIFY_FLAG: TStringField;
    quAuthorCREATEDATE: TDateTimeField;
    quAuthorLASTMODIFYDATE: TDateTimeField;
    quEditAuthor: TwwQuery;
    BCDField1: TBCDField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    DateTimeField1: TDateTimeField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    MemoField1: TMemoField;
    StringField13: TStringField;
    DateTimeField2: TDateTimeField;
    DateTimeField3: TDateTimeField;
    StringField14: TStringField;
    dsEditAuthor: TwwDataSource;
    usEditAuthor: TUpdateSQL;
    quCollection: TwwQuery;
    dsCollection: TwwDataSource;
    usCollection: TUpdateSQL;
    quCollectionCOLLECTIONID: TBCDField;
    quCollectionNAME: TStringField;
    quCollectionDESCRIPTION: TStringField;
    quCollectionPUBLISH_COMPANY: TStringField;
    quCollectionAUTHORID: TBCDField;
    quCollectionSTATUS: TStringField;
    quCollectionCREATEDATE: TDateTimeField;
    quCollectionPHOTOID: TBCDField;
    quCollectionVERIFY_FLAG: TStringField;
    quPublishWC: TwwQuery;
    dsPublishWC: TwwDataSource;
    usPublishWC: TUpdateSQL;
    quPublishWCAUTHORID: TBCDField;
    quPublishWCWORKS_TITLE: TStringField;
    quPublishWCPUBLISHING_COMPANY: TStringField;
    quPublishWCPUBLISHING_DATE: TDateTimeField;
    quPublishWCVERIFY_FLAG: TStringField;
    quPhoto: TwwQuery;
    dsPhoto: TwwDataSource;
    usPhoto: TUpdateSQL;
    quPhotoPHOTOID: TBCDField;
    quPhotoNAME: TStringField;
    quPhotoAUTHORID: TBCDField;
    quPhotoDESCRIPTION: TStringField;
    quPhotoTIME: TDateTimeField;
    quPhotoLOCATION: TStringField;
    quPhotoPLACE: TStringField;
    quPhotoCONTENT: TStringField;
    quPhotoSTORAGEID: TStringField;
    quPhotoMANUSCRIPT: TStringField;
    quPhotoMANUSCRIPTID: TBCDField;
    quPhotoFILMTYPE: TStringField;
    quPhotoDIRID: TBCDField;
    quPhotoTHUMBFILE: TStringField;
    quPhotoSMALLFILE: TStringField;
    quPhotoMIDDLEFILE: TStringField;
    quPhotoIMAGEFILE: TStringField;
    quPhotoFULLPRICE1: TBCDField;
    quPhotoCOMMERCIALPRICE1: TBCDField;
    quPhotoNOCOMPRICE1: TBCDField;
    quPhotoMAGAZINEPRICE1: TBCDField;
    quPhotoCURRENCY1: TStringField;
    quPhotoREMARK: TStringField;
    quPhotoSTATUS: TStringField;
    quPhotoCREATEDATE: TDateTimeField;
    quPhotoLASTMODIFYDATE: TDateTimeField;
    quSelAuthor: TwwQuery;
    dsSelAuthor: TwwDataSource;
    usSelAuthor: TUpdateSQL;
    quCategory: TwwQuery;
    dsCategory: TwwDataSource;
    usCategory: TUpdateSQL;
    quCategoryCATEGORYID: TBCDField;
    quCategoryNAME: TStringField;
    quCategoryDESCRIPTION: TStringField;
    quCategorySTATUS: TStringField;
    quCategoryGRADE: TStringField;
    quCategoryCHILDSTATUS: TStringField;
    quCategoryANCESTRY: TStringField;
    quCategorySTAGE: TStringField;
    quCategory2: TwwQuery;
    dsCategory2: TwwDataSource;
    usCategory2: TUpdateSQL;
    quCategory3: TwwQuery;
    dsCategory3: TwwDataSource;
    usCategory3: TUpdateSQL;
    quCategory2CATEGORYID: TBCDField;
    quCategory2DESCRIPTION: TStringField;
    quCategory2NAME: TStringField;
    quCategory2STATUS: TStringField;
    quCategory3CATEGORYID: TBCDField;
    quCategory3DESCRIPTION: TStringField;
    quCategory3NAME: TStringField;
    quCategory3STATUS: TStringField;
    quCategory4: TwwQuery;
    BCDField3: TBCDField;
    StringField29: TStringField;
    StringField30: TStringField;
    StringField31: TStringField;
    dsCategory4: TwwDataSource;
    usCategory4: TUpdateSQL;
    quCategory5: TwwQuery;
    BCDField4: TBCDField;
    StringField32: TStringField;
    StringField33: TStringField;
    StringField34: TStringField;
    dsCategory5: TwwDataSource;
    usCategory5: TUpdateSQL;
    quCategory1: TwwQuery;
    StringField35: TStringField;
    BCDField5: TBCDField;
    StringField36: TStringField;
    StringField37: TStringField;
    StringField38: TStringField;
    StringField39: TStringField;
    StringField40: TStringField;
    StringField41: TStringField;
    dsCategory1: TwwDataSource;
    usCategory1: TUpdateSQL;
    quDelCategoryCat: TwwQuery;
    quDelCategory: TwwQuery;
    quCategoryCat: TwwQuery;
    dsCategoryCat: TwwDataSource;
    usCategoryCat: TUpdateSQL;
    quCategoryCatCATEGORYID: TBCDField;
    quCategoryCatPARENTCATEID: TBCDField;
    quCategoryCatRECORDSTATUS: TStringField;
    quCatID: TQuery;
    quCatIDCATEGORYID: TBCDField;
    quPhotoFILE_SIZE: TBCDField;
    quPhotoFILE_FORMAT: TStringField;
    quPhotoVERIFY_FLAG1: TStringField;
    quPhotoVERIFY_FLAG2: TStringField;
    quPhotoRECORDSTATUS: TStringField;
    quAwardWork: TwwQuery;
    dsAwardWork: TwwDataSource;
    usAwardWork: TUpdateSQL;
    quAwardWorkAUTHORID: TBCDField;
    quAwardWorkPHOTOID: TBCDField;
    quAwardWorkCONTEST: TStringField;
    quAwardWorkAWARD_GRADE: TStringField;
    quAwardWorkAWARD_TIME: TDateTimeField;
    quAwardWorkVERIFY_FLAG: TStringField;
    quCollectionPhoto: TwwQuery;
    dsCollectionPhoto: TwwDataSource;
    usCollectionPhoto: TUpdateSQL;
    quCollectionPhotoCOLLECTIONID: TBCDField;
    quCollectionPhotoPHOTOID: TBCDField;
    quCollectionPhotoSTATUS: TStringField;
    quCollectionPhotoVERIFY_FLAG: TStringField;
    quCollectionPhotoP: TwwQuery;
    BCDField7: TBCDField;
    dsCollectionPhotoP: TwwDataSource;
    usCollectionPhotoP: TUpdateSQL;
    quCollectionPhotoPNAME: TStringField;
    quCollectionPhotoPPUBLISH_COMPANY: TStringField;
    quCollectionPhotoPCREATEDATE: TDateTimeField;
    quDirSettingRECORDSTATUS: TStringField;
    quDirSettingAUTHORID: TBCDField;
    quCollectionPhotoPVERIFY_FLAG: TStringField;
    quCollectionPhotoPSTATUS: TStringField;
    quPhotoCategory: TwwQuery;
    dsPhotoCategory: TwwDataSource;
    usPhotoCategory: TUpdateSQL;
    quPhotoCategoryPHOTOID: TBCDField;
    quPhotoCategoryCATEGORYID: TBCDField;
    quPhotoCategoryRECORDSTATUS: TStringField;
    quPhotoID: TQuery;
    quPhotoIDPHOTOID: TBCDField;
    quPhotoDir: TStringField;
    quOperator: TwwQuery;
    dsOperator: TwwDataSource;
    usOperator: TUpdateSQL;
    quOperatorOPID: TStringField;
    quOperatorLOGIN: TStringField;
    quOperatorPASSWD: TStringField;
    quOperatorNAME: TStringField;
    quOperatorTELEPHONE: TStringField;
    quOperatorFAX: TStringField;
    quOperatorEMAIL: TStringField;
    quOperatorDESCRIPTION: TStringField;
    quOperatorSTATUS: TStringField;
    quOperatorLASTMODIFYDATE: TDateTimeField;
    quOperatorPRIVILEDGE: TStringField;
    quGetCat: TwwQuery;
    quGetCatCATEGORYID: TBCDField;
    quGetCatPARENTCATEID: TBCDField;
    quGetCatRECORDSTATUS: TStringField;
    quGetCatParentCat: TStringField;
    quPhotoCategoryGrade: TIntegerField;
    quPhotoCategoryCat: TStringField;
    quPhotoManuScritpName: TStringField;
    quGetUser: TQuery;
    quGetUserOPID: TStringField;
    quGetUserLOGIN: TStringField;
    quGetUserPASSWD: TStringField;
    quGetUserNAME: TStringField;
    quGetUserTELEPHONE: TStringField;
    quGetUserFAX: TStringField;
    quGetUserEMAIL: TStringField;
    quGetUserDESCRIPTION: TStringField;
    quGetUserSTATUS: TStringField;
    quGetUserLASTMODIFYDATE: TDateTimeField;
    quGetUserPRIVILEDGE: TStringField;
    quCollectionPhotoPhotoName: TStringField;
    quGetAuthorID: TQuery;
    quGetAuthorIDAUTHORID: TBCDField;
    quCollectionPhotoName: TStringField;
    quCategoryRECORDSTATUS: TStringField;
    quCategory6: TwwQuery;
    StringField42: TStringField;
    BCDField8: TBCDField;
    StringField43: TStringField;
    StringField44: TStringField;
    dsCategory6: TwwDataSource;
    usCategory6: TUpdateSQL;
    quCategory7: TwwQuery;
    StringField45: TStringField;
    BCDField9: TBCDField;
    StringField46: TStringField;
    StringField47: TStringField;
    dsCategory7: TwwDataSource;
    usCategory7: TUpdateSQL;
    quCategory8: TwwQuery;
    StringField48: TStringField;
    BCDField10: TBCDField;
    StringField49: TStringField;
    StringField50: TStringField;
    dsCategory8: TwwDataSource;
    usCategory8: TUpdateSQL;
    quDirSettingFILE_HEAD: TStringField;
    quDirSettingSTART_SEQ: TBCDField;
    quDirSettingEND_SEQ: TBCDField;
    quCollectionRECORDSTATUS: TStringField;
    quPhotoCOLOR_TYPE: TStringField;
    quPhotoDISPLAY_TYPE: TStringField;
    quCollectionPhotoPRECORDSTATUS: TStringField;
    quCollectionPhotoPCOLLECTIONID: TBCDField;
    quSelAuthorAUTHORID: TBCDField;
    quSelAuthorFIRSTNAME: TStringField;
    quSelAuthorSEX: TStringField;
    quSelAuthorCOMPANY: TStringField;
    quSelAuthorDUTY: TStringField;
    quSelAuthorTITLE: TStringField;
    procedure quDirSettingAfterPost(DataSet: TDataSet);
    procedure quDirSettingNewRecord(DataSet: TDataSet);
    procedure quDirSettingBeforeDelete(DataSet: TDataSet);
    procedure quDirSettingPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure quDirSettingUpdateError(DataSet: TDataSet; E: EDatabaseError;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure quDirSettingAfterDelete(DataSet: TDataSet);
    procedure quManuScriptSizeAfterDelete(DataSet: TDataSet);
    procedure quManuScriptSizeAfterPost(DataSet: TDataSet);
    procedure quManuScriptSizeBeforeDelete(DataSet: TDataSet);
    procedure quManuScriptSizeNewRecord(DataSet: TDataSet);
    procedure quAuthorAfterPost(DataSet: TDataSet);
    procedure quAuthorBeforeDelete(DataSet: TDataSet);
    procedure quAuthorNewRecord(DataSet: TDataSet);
    procedure quCollectionAfterPost(DataSet: TDataSet);
    procedure quCollectionNewRecord(DataSet: TDataSet);
    procedure quPublishWCNewRecord(DataSet: TDataSet);
    procedure quPublishWCAfterPost(DataSet: TDataSet);
    procedure quCategoryAfterPost(DataSet: TDataSet);
    procedure quCategoryCatAfterPost(DataSet: TDataSet);
    procedure quPhotoAfterPost(DataSet: TDataSet);
    procedure quPhotoNewRecord(DataSet: TDataSet);
    procedure quAwardWorkAfterPost(DataSet: TDataSet);
    procedure quCollectionPhotoAfterPost(DataSet: TDataSet);
    procedure quAwardWorkNewRecord(DataSet: TDataSet);
    procedure quCollectionPhotoPNewRecord(DataSet: TDataSet);
    procedure quCollectionPhotoPAfterPost(DataSet: TDataSet);
    procedure quPhotoBeforePost(DataSet: TDataSet);
    procedure quOperatorAfterPost(DataSet: TDataSet);
    procedure quOperatorNewRecord(DataSet: TDataSet);
    procedure quCollectionPhotoNewRecord(DataSet: TDataSet);
    procedure quPhotoBeforeDelete(DataSet: TDataSet);
    procedure quCategoryBeforeDelete(DataSet: TDataSet);
    procedure quCategoryCatBeforeDelete(DataSet: TDataSet);
    procedure quCollectionPhotoPBeforeDelete(DataSet: TDataSet);
    procedure quOperatorBeforeDelete(DataSet: TDataSet);
    procedure quCollectionPhotoBeforeDelete(DataSet: TDataSet);
    procedure quAwardWorkBeforeDelete(DataSet: TDataSet);
    procedure quCollectionBeforeEdit(DataSet: TDataSet);
    procedure quAuthorBeforeEdit(DataSet: TDataSet);
    procedure quPublishWCBeforeEdit(DataSet: TDataSet);
    procedure quAwardWorkBeforeEdit(DataSet: TDataSet);
    procedure quCollectionPhotoBeforeEdit(DataSet: TDataSet);
    procedure quCollectionBeforeDelete(DataSet: TDataSet);
    procedure quPublishWCBeforeDelete(DataSet: TDataSet);
    procedure quPhotoBeforeInsert(DataSet: TDataSet);
    procedure quPhotoAfterDelete(DataSet: TDataSet);
    procedure quAuthorBeforePost(DataSet: TDataSet);
    procedure quAwardWorkBeforePost(DataSet: TDataSet);
    procedure quCollectionPhotoPBeforePost(DataSet: TDataSet);
    procedure quCollectionBeforePost(DataSet: TDataSet);
    procedure quPublishWCBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPic: TdmPic;
  gCat1,gCat2,gCat3,gCat4,gCat5,gCat6,gCat7,gCat8 : boolean;
  gPhotoPath : String;
  gIsAdmin : Boolean;
implementation

uses EditPhoto, EditAuthor;

{$R *.DFM}

procedure TdmPic.quDirSettingAfterPost(DataSet: TDataSet);
begin
  try
    quDirSetting.ApplyUpdates;
    quDirSetting.CommitUpdates;
  except
    quDirSetting.CancelUpdates;
    ShowMessage('更新错误!');
  end;
  //quDirSetting.Refresh;
end;

procedure TdmPic.quDirSettingNewRecord(DataSet: TDataSet);
begin
  quDirSetting.FieldByName('DirID').AsInteger := 0;
  quDirSetting.FieldByName('AuthorID').AsInteger :=
    quSelAuthor.FieldByName('AuthorID').AsInteger;
end;

procedure TdmPic.quDirSettingBeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('确认删除图片路径:' + quDirSetting.FieldByName('Dir').AsString + '?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then
      abort;   

end;

procedure TdmPic.quDirSettingPostError(DataSet: TDataSet;
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
    if (pos('unique', e.Message) <> 0) then
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

procedure TdmPic.quDirSettingUpdateError(DataSet: TDataSet;
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

procedure TdmPic.quDirSettingAfterDelete(DataSet: TDataSet);
begin
  quDirSetting.ApplyUpdates;
  quDirSetting.CommitUpdates;
end;

procedure TdmPic.quManuScriptSizeAfterDelete(DataSet: TDataSet);
begin
  quDirSetting.ApplyUpdates;
  quDirSetting.CommitUpdates;
end;

procedure TdmPic.quManuScriptSizeAfterPost(DataSet: TDataSet);
begin
  try
    quManuScriptSize.ApplyUpdates;
    quManuScriptSize.CommitUpdates;
  except
    quManuScriptSize.CancelUpdates;
    ShowMessage('更新错误!');
  end;
end;

procedure TdmPic.quManuScriptSizeBeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('确认删除记录:' + quManuScriptSize.FieldByName('ManuScriptSize').AsString + '?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then
      abort;
end;

procedure TdmPic.quManuScriptSizeNewRecord(DataSet: TDataSet);
begin
  quManuScriptSize.FieldByName('ManuScriptID').AsInteger := 0;
end;

procedure TdmPic.quAuthorAfterPost(DataSet: TDataSet);
begin
  try
    quAuthor.ApplyUpdates;
    quAuthor.CommitUpdates;
  except
    quAuthor.CancelUpdates;
    ShowMessage('更新错误!');
  end;
end;

procedure TdmPic.quAuthorBeforeDelete(DataSet: TDataSet);
begin
  if (not quCollection.IsEmpty) or (not quPublishWC.IsEmpty) then
   begin
     ShowMessage('个人作品或出版著作有数据！');
     Abort;
   end;
  with quAuthor do
  begin
    if (Trim(FieldByName('Verify_flag').AsString) = 'Y') then
    begin
      if not gIsAdmin  then
      begin
        ShowMessage('你没有删除记录权利！');
        Abort;
      end;
    end;
  end;
  if MessageDlg('确认删除记录?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then
      abort;
end;

procedure TdmPic.quAuthorNewRecord(DataSet: TDataSet);
begin
  with quGetAuthorID do
  begin
    if Active then
      Close;
    Open;
    quAuthor.FieldByName('AuthorId').AsInteger :=
      quGetAuthorID.FieldByName('AuthorId').AsInteger;
    quAuthor.FieldByName('Sex').AsString := 'M';
    quAuthor.FieldByName('Verify_flag').AsString := 'N';
    quAuthor.FieldByName('Status').AsString := 'Y';
    Close;
  end;
  if fmEditAuthor.Showing then
    fmEditAuthor.dedName.SetFocus;

end;

procedure TdmPic.quCollectionAfterPost(DataSet: TDataSet);
begin
  try
    quCollection.ApplyUpdates;
    quCollection.CommitUpdates;
  except
    quCollection.CancelUpdates;
    ShowMessage('更新错误!');
  end;
end;

procedure TdmPic.quCollectionNewRecord(DataSet: TDataSet);
begin
  quCollection.FieldByName('authorID').AsString :=
    quAuthor.FieldByName('authorID').AsString;
  quCollection.FieldByName('CollectionID').AsInteger := 0;
  quCollection.FieldByName('PhotoID').AsInteger := 0;
  quCollection.FieldByName('Status').AsString := 'Y';
end;

procedure TdmPic.quPublishWCNewRecord(DataSet: TDataSet);
begin
  quPublishWC.FieldByName('authorID').AsString :=
    quAuthor.FieldByName('authorID').AsString;
  //quPublishWC.FieldByName('CollectionID').AsInteger := 0;
end;

procedure TdmPic.quPublishWCAfterPost(DataSet: TDataSet);
begin
  try
    quPublishWC.ApplyUpdates;
    quPublishWC.CommitUpdates;
  except
    quPublishWC.CancelUpdates;
    ShowMessage('更新错误!');
  end;
end;

procedure TdmPic.quCategoryAfterPost(DataSet: TDataSet);
begin

  try
    Case  quCategory.FieldByName('Grade').AsInteger of
    0: begin
         gCat1 := True;
       end;
    1: begin
         gCat2 := True;
       end;
    2: begin
         gCat3 := True;
       end;
    3: begin
         gCat4 := True;
       end;
    4: begin
         gCat5 := True;
       end;
    5: begin
         gCat6 := True;
       end;
    6: begin
         gCat7 := True;
       end;
    7: begin
         gCat8 := True;
       end;
    end;
  except

  end;
end;

procedure TdmPic.quCategoryCatAfterPost(DataSet: TDataSet);
begin
  try
    quCategoryCat.ApplyUpdates;
    quCategoryCat.CommitUpdates;
  except
    quCategoryCat.CancelUpdates;
    ShowMessage('更新错误!');
  end;
end;

procedure TdmPic.quPhotoAfterPost(DataSet: TDataSet);

begin
  //if quPhotoCategory.State in [dsInsert, dsEdit] then
  
  try
    quPhoto.ApplyUpdates;
    quPhoto.CommitUpdates;
  except
    quPhoto.CancelUpdates;
    ShowMessage('更新错误!');
    Abort;
  end;

end;

procedure TdmPic.quPhotoNewRecord(DataSet: TDataSet);
var
  wPhotoID : Integer;
begin
  with quPhotoID do
  begin
    if Active then
      Close;
    Open;
   wPhotoID := quPhotoID.FieldByName('PhotoID').AsInteger;
   Close;
  end;
  fmEditPhoto.imPhoto.Picture := nil;
  quPhoto.FieldByName('PhotoID').AsInteger := wPhotoID;
  quPhoto.FieldByName('Display_type').AsString := 'H';
  quPhoto.FieldByName('Verify_flag1').AsString := 'N';
  quPhoto.FieldByName('Verify_flag2').AsString := 'N';
  quPhoto.FieldByName('Currency1').AsString := '￥';
  quPhoto.FieldByName('Color_type').AsString := 'Y';
  quPhoto.FieldByName('AuthorID').AsInteger :=
    quSelAuthor.FieldByName('AuthorID').AsInteger;
  //quPhotoTHUMBFILE.AsString := 'test';
  //quPhotoSMALLFILE.AsString := 'test';
  //quPhotoMIDDLEFILE.AsString := 'test';
  quPhoto.FieldByName('DirID').AsInteger :=
    quDirSetting.FieldByName('DirID').AsInteger;
  quPhoto.FieldByName('ManuScriptID').AsInteger :=
    quManuScriptSize.FieldByName('ManuScriptID').AsInteger;
  quPhoto.FieldByName('ManuScript').AsString := 'P';
  //quPhotoSMALLFILE.AsString := 'test';



end;

procedure TdmPic.quAwardWorkAfterPost(DataSet: TDataSet);
begin
  try
    quAwardWork.ApplyUpdates;
    quAwardWork.CommitUpdates;
  except
    quAwardWork.CancelUpdates;
    ShowMessage('更新错误!');
  end;
end;

procedure TdmPic.quCollectionPhotoAfterPost(DataSet: TDataSet);
begin
  try
    quCollectionPhoto.ApplyUpdates;
    quCollectionPhoto.CommitUpdates;
  except
    quCollectionPhoto.CancelUpdates;
    ShowMessage('更新错误!');
  end;
end;

procedure TdmPic.quAwardWorkNewRecord(DataSet: TDataSet);
begin
  quAwardWork.FieldByName('PhotoID').AsInteger :=
    quPhoto.FieldByName('PhotoID').AsInteger;
  quAwardWork.FieldByName('AuthorID').AsInteger :=
    quPhoto.FieldByName('AuthorID').AsInteger;

end;

procedure TdmPic.quCollectionPhotoPNewRecord(DataSet: TDataSet);
begin
  quCollectionPhotoP.FieldByName('PhotoID').AsInteger :=
    quPhoto.FieldByName('PhotoID').AsInteger ;
  quCollectionPhotoP.FieldByName('Status').AsString := 'Y';
end;

procedure TdmPic.quCollectionPhotoPAfterPost(DataSet: TDataSet);
begin
  try
    quCollectionPhotoP.ApplyUpdates;
    quCollectionPhotoP.CommitUpdates;
  except
    quCollectionPhotoP.CancelUpdates;
    ShowMessage('更新错误!');
  end;
end;

procedure TdmPic.quPhotoBeforePost(DataSet: TDataSet);
var
  wOldFile, wNewFile : array [0..100] of char;
  wPath, wThumbFile, wSmallFile, wMiddleFile : String;
begin
  if (fmEditPhoto.dedName.Text = '') and fmEditPhoto.Showing then
  begin
    ShowMessage('请输入图片名称!');
    fmEditPhoto.dedName.SetFocus;
    Abort;
  end;
  if (fmEditPhoto.dedStorageID.Text = '') and fmEditPhoto.Showing then
  begin
    ShowMessage('请输入存储编号!');
    fmEditPhoto.dedStorageID.SetFocus;
    Abort;
  end;
  if (fmEditPhoto.dlcCat1.Text = '') and fmEditPhoto.Showing then
  begin
    ShowMessage('请选择图片类别!');
    fmEditPhoto.dlcCat1.SetFocus;
    Abort;
  end;

  if (quPhoto.State = dsEdit) then
  begin
    with quPhotoCategory do
      begin
        if IsEmpty then
        begin
          Insert;
          FieldByName('PhotoID').AsInteger :=
            quPhoto.FieldByName('PhotoID').AsInteger;
        end
        else
          Edit;
        if (not quCategory8.IsEmpty) and (fmEditPhoto.dlcCat8.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory8.FieldByName('CategoryID').AsInteger
        else if (not quCategory7.IsEmpty) and (fmEditPhoto.dlcCat7.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory7.FieldByName('CategoryID').AsInteger
        else if (not quCategory6.IsEmpty) and (fmEditPhoto.dlcCat6.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory6.FieldByName('CategoryID').AsInteger
        else if (not quCategory5.IsEmpty) and (fmEditPhoto.dlcCat5.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory5.FieldByName('CategoryID').AsInteger
        else if (not quCategory4.IsEmpty) and (fmEditPhoto.dlcCat4.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory4.FieldByName('CategoryID').AsInteger
        else if (not quCategory3.IsEmpty) and (fmEditPhoto.dlcCat3.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory3.FieldByName('CategoryID').AsInteger
        else if (not quCategory2.IsEmpty) and (fmEditPhoto.dlcCat2.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory2.FieldByName('CategoryID').AsInteger
        else if (not quCategory1.IsEmpty) and (fmEditPhoto.dlcCat1.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory1.FieldByName('CategoryID').AsInteger;
        //Showmessage(FieldByName('CategoryID').AsString + ' ' + FieldByName('PhotoID').AsString );
        quPhotoCategory.Post;
        quPhotoCategory.ApplyUpdates;
        quPhotoCategory.CommitUpdates;
      end;
  end
  else
  begin
    if (quPhoto.State = dsInsert) then
    begin
      with quPhotoCategory do
      begin
        Insert;
        FieldByName('PhotoID').AsInteger :=
          quPhoto.FieldByName('PhotoID').AsInteger;
        if (not quCategory8.IsEmpty) and (fmEditPhoto.dlcCat8.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory8.FieldByName('CategoryID').AsInteger
        else if (not quCategory7.IsEmpty) and (fmEditPhoto.dlcCat7.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory7.FieldByName('CategoryID').AsInteger
        else if (not quCategory6.IsEmpty) and (fmEditPhoto.dlcCat6.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory6.FieldByName('CategoryID').AsInteger
        else if (not quCategory5.IsEmpty) and (fmEditPhoto.dlcCat5.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory5.FieldByName('CategoryID').AsInteger
        else if (not quCategory4.IsEmpty) and (fmEditPhoto.dlcCat4.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory4.FieldByName('CategoryID').AsInteger
        else if (not quCategory3.IsEmpty) and (fmEditPhoto.dlcCat3.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory3.FieldByName('CategoryID').AsInteger
        else if (not quCategory2.IsEmpty) and (fmEditPhoto.dlcCat2.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory2.FieldByName('CategoryID').AsInteger
        else if (not quCategory1.IsEmpty) and (fmEditPhoto.dlcCat1.Text <> '') then
          FieldByName('CategoryID').AsInteger :=
            quCategory1.FieldByName('CategoryID').AsInteger;
        //Showmessage(FieldByName('CategoryID').AsString + ' ' + FieldByName('PhotoID').AsString );
        quPhotoCategory.Post;
        quPhotoCategory.ApplyUpdates;
        quPhotoCategory.CommitUpdates;
      end;
    end;
  end;

  if  quPhoto.State in [dsEdit, dsInsert] then
  begin
    if quPhoto.State = dsEdit then
      if quPhotoIMAGEFILE.OldValue <> quPhotoIMAGEFILE.NewValue then
        Exit;
    wPath := gImageFile;
    //wPath := fmEditPhoto.odImage.FileName;
    wThumbFile := StringReplace(wPath,'.5','.1',[rfReplaceAll, rfIgnoreCase]);
    wSmallFile := StringReplace(wPath,'.5','.2',[rfReplaceAll, rfIgnoreCase]);
    wMiddleFile := StringReplace(wPath,'.5','.4',[rfReplaceAll, rfIgnoreCase]);
    StrPCopy(wOldFile, wPath);
    wPath := gPhotoPath + quPhotoDIR.AsString + quPhotoIMAGEFILE.AsString;
    wPath := StringReplace(wPath,'/','\',[rfReplaceAll, rfIgnoreCase]);
    //wPath := '\\CNHOTEL\httpd\html\PhotoTest\001.jpg';
    StrPCopy(wNewFile, wPath);
    CopyFile(wOldFile,wNewFile,false);
    if fmEditPhoto.ckThumbFile.Checked then
    begin
      if FileExists(wThumbFile) then
      begin
        StrPCopy(wOldFile, wThumbFile);
        wThumbFile := gPhotoPath + quPhotoDIR.AsString + quPhotoIMAGEFILE.AsString;
        wThumbFile := StringReplace(wThumbFile,'.5','.1',[rfReplaceAll, rfIgnoreCase]);
        wThumbFile := StringReplace(wThumbFile,'/','\',[rfReplaceAll, rfIgnoreCase]);
        StrPCopy(wNewFile, wThumbFile);
        CopyFile(wOldFile,wNewFile,false);
        quPhotoTHUMBFILE.AsString := ExtractFileName(wThumbFile);
      end
      else
      begin
        ShowMessage(wThumbFile + '微型图片文件不存在!');
        fmEditPhoto.ckThumbFile.Checked := False;
      end;
    end;
    if fmEditPhoto.ckSmallFile.Checked then
    begin
      if FileExists(wSmallFile) then
      begin
        StrPCopy(wOldFile, wSmallFile);
        wSmallFile := gPhotoPath + quPhotoDIR.AsString + quPhotoIMAGEFILE.AsString;
        wSmallFile := StringReplace(wSmallFile,'.5','.2',[rfReplaceAll, rfIgnoreCase]);
        wSmallFile := StringReplace(wSmallFile,'/','\',[rfReplaceAll, rfIgnoreCase]);
        StrPCopy(wNewFile, wSmallFile);
        CopyFile(wOldFile,wNewFile,false);
        quPhotoSMALLFILE.AsString := ExtractFileName(wSmallFile);
      end
      else
      begin
        ShowMessage(wSmallFile + '小型图片文件不存在!');
        Abort;
        fmEditPhoto.ckSmallFile.Checked := False;
      end;
    end;
    if fmEditPhoto.ckMiddleFile.Checked then
    begin
      if FileExists(wMiddleFile) then
      begin
        StrPCopy(wOldFile, wMiddleFile);
        wMiddleFile := gPhotoPath + quPhotoDIR.AsString + quPhotoIMAGEFILE.AsString;
        wMiddleFile := StringReplace(wMiddleFile,'.5','.4',[rfReplaceAll, rfIgnoreCase]);
        wMiddleFile := StringReplace(wMiddleFile,'/','\',[rfReplaceAll, rfIgnoreCase]);
        StrPCopy(wNewFile, wMiddleFile);
        CopyFile(wOldFile,wNewFile,false);
        quPhotoMIDDLEFILE.AsString := ExtractFileName(wMiddleFile);
      end
      else
      begin
        ShowMessage(wMiddleFile + '小型图片文件不存在!');
        fmEditPhoto.ckMiddleFile.Checked := False;
      end;
    end;
  end;



end;

procedure TdmPic.quOperatorAfterPost(DataSet: TDataSet);
begin
  try
    quOperator.ApplyUpdates;
    quOperator.CommitUpdates;
  except
    quOperator.CancelUpdates;
    ShowMessage('更新错误!');
  end;
end;

procedure TdmPic.quOperatorNewRecord(DataSet: TDataSet);
begin
  quOperator.FieldByName('OpID').AsInteger := 0;
end;

procedure TdmPic.quCollectionPhotoNewRecord(DataSet: TDataSet);
begin
   quCollectionPhoto.FieldByName('CollectionID').AsInteger :=
     quCollection.FieldByName('CollectionID').AsInteger;
   quCollectionPhoto.FieldByName('Status').AsString :=  'Y';
end;

procedure TdmPic.quPhotoBeforeDelete(DataSet: TDataSet);
begin
   if (not quCollectionPhotoP.IsEmpty) or (not quAwardWork.IsEmpty) then
   begin
     ShowMessage('获奖情况或出版情况有数据！');
     Abort;
   end;
   with quPhoto do
   begin
     if (Trim(FieldByName('Verify_flag1').AsString) = 'Y') or
        (Trim(FieldByName('Verify_flag2').AsString) = 'Y') then
     begin
       if not gIsAdmin  then
       begin
         ShowMessage('你没有删除记录权利！');
         Abort;
       end;
     end;
   end;
   if MessageDlg('确认删除记录?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then
      abort
   else
     if not quPhotoCategory.IsEmpty then
     begin
       quPhotoCategory.Delete;
       quPhotoCategory.ApplyUpdates;
       quPhotoCategory.CommitUpdates;
     end;
end;

procedure TdmPic.quCategoryBeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('确认删除记录?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then
      abort;
end;

procedure TdmPic.quCategoryCatBeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('确认删除记录?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then
      abort;
end;

procedure TdmPic.quCollectionPhotoPBeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('确认删除记录?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then
      abort;
end;

procedure TdmPic.quOperatorBeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('确认删除记录?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then
      abort;
end;

procedure TdmPic.quCollectionPhotoBeforeDelete(DataSet: TDataSet);
begin
  with quCollectionPhoto do
  begin
    if (Trim(FieldByName('Verify_flag').AsString) = 'Y') then
    begin
      if not gIsAdmin  then
      begin
        ShowMessage('你没有删除记录权利！');
        Abort;
      end;
    end;
  end;
  if MessageDlg('确认删除记录?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then
      abort;
end;

procedure TdmPic.quAwardWorkBeforeDelete(DataSet: TDataSet);
begin
  with quAwardWork do
  begin
    if (Trim(FieldByName('Verify_flag').AsString) = 'Y') then
    begin
      if not gIsAdmin  then
      begin
        ShowMessage('你没有删除记录权利！');
        Abort;
      end;
    end;
  end;
  if MessageDlg('确认删除记录?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then
      abort;
end;

procedure TdmPic.quCollectionBeforeEdit(DataSet: TDataSet);
begin
  with quCollection do
  begin
    if (Trim(FieldByName('Verify_flag').AsString) = 'Y') then
    begin
      if not gIsAdmin  then
      begin
        ShowMessage('你没有编辑记录的权利！');
        Abort;
      end;
    end;
  end;
end;

procedure TdmPic.quAuthorBeforeEdit(DataSet: TDataSet);
begin
  with quAuthor do
  begin
    if (Trim(FieldByName('Verify_flag').AsString) = 'Y') then
    begin
      if not gIsAdmin  then
      begin
        ShowMessage('你没有编辑记录的权利！');
        Abort;
      end;
    end;
  end;
end;

procedure TdmPic.quPublishWCBeforeEdit(DataSet: TDataSet);
begin
  with quPublishWC do
  begin
    if (Trim(FieldByName('Verify_flag').AsString) = 'Y') then
    begin
      if not gIsAdmin  then
      begin
        ShowMessage('你没有编辑记录的权利！');
        Abort;
      end;
    end;
  end;
end;

procedure TdmPic.quAwardWorkBeforeEdit(DataSet: TDataSet);
begin
  with quAwardWork do
  begin
    if (Trim(FieldByName('Verify_flag').AsString) = 'Y') then
    begin
      if not gIsAdmin  then
      begin
        ShowMessage('你没有编辑记录的权利！');
        Abort;
      end;
    end;
  end;
end;

procedure TdmPic.quCollectionPhotoBeforeEdit(DataSet: TDataSet);
begin
  with quCollectionPhoto do
  begin
    if (Trim(FieldByName('Verify_flag').AsString) = 'Y') then
    begin
      if not gIsAdmin  then
      begin
        ShowMessage('你没有编辑记录的权利！');
        Abort;
      end;
    end;
  end;
end;

procedure TdmPic.quCollectionBeforeDelete(DataSet: TDataSet);
begin
  with quCollection do
  begin
    if (Trim(FieldByName('Verify_flag').AsString) = 'Y') then
    begin
      if not gIsAdmin  then
      begin
        ShowMessage('你没有删除记录权利！');
        Abort;
      end;
    end;
  end;
  if MessageDlg('确认删除记录?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then
      abort;
end;

procedure TdmPic.quPublishWCBeforeDelete(DataSet: TDataSet);
begin
  with quPublishWC do
  begin
    if (Trim(FieldByName('Verify_flag').AsString) = 'Y') then
    begin
      if not gIsAdmin  then
      begin
        ShowMessage('你没有删除记录权利！');
        Abort;
      end;
    end;
  end;
  if MessageDlg('确认删除记录?',
     mtWarning, [mbYes, mbNo], 0) = mrNo then
      abort;
end;

procedure TdmPic.quPhotoBeforeInsert(DataSet: TDataSet);
begin
  if fmEditPhoto.Showing then
    fmEditPhoto.dedName.SetFocus;
end;

procedure TdmPic.quPhotoAfterDelete(DataSet: TDataSet);
begin
  try
    quPhoto.ApplyUpdates;
    quPhoto.CommitUpdates;
  except
    quPhoto.CancelUpdates;
    ShowMessage('更新错误!');
    Abort;
  end;
end;

procedure TdmPic.quAuthorBeforePost(DataSet: TDataSet);
begin
  with quAuthor do
  begin
    if Trim(quAuthorFIRSTNAME.AsString) = '' then
    begin
      ShowMessage('请输入姓名!');
      fmEditAuthor.dedName.SetFocus;
      Abort;
    end;
    if quAuthorSURORDER.AsString = '' then
    begin
      ShowMessage('请输入姓(拼音)!');
      fmEditAuthor.dedPY.SetFocus;
      Abort;
    end;

  end;
end;

procedure TdmPic.quAwardWorkBeforePost(DataSet: TDataSet);
begin
  if (quAwardWorkCONTEST.AsString = '') and fmEditPhoto.Showing then
  begin
    ShowMessage('请输入比赛名称！');
    //fmEditPhoto.dedName.SetFocus;
    Abort;
  end;
  if (quAwardWorkAWARD_GRADE.AsString = '') and fmEditPhoto.Showing then
  begin
    ShowMessage('请输入获奖级别！');
    //fmEditPhoto.dedName.SetFocus;
    Abort;
  end;
  if (quAwardWorkAWARD_TIME.AsString = '') and fmEditPhoto.Showing then
  begin
    ShowMessage('请输入获奖时间！');
    //fmEditPhoto.dedName.SetFocus;
    Abort;
  end;
end;

procedure TdmPic.quCollectionPhotoPBeforePost(DataSet: TDataSet);
begin
  if (quCollectionPhotoPCOLLECTIONID.AsString = '') and fmEditPhoto.Showing then
  begin
    ShowMessage('请输入作品集名称！');
    //fmEditPhoto.dedName.SetFocus;
    Abort;
  end;
end;

procedure TdmPic.quCollectionBeforePost(DataSet: TDataSet);
begin
  if (quCollectionNAME.AsString = '') and fmEditAuthor.Showing then
  begin
    ShowMessage('请输入出版作品名称！');
    //fmEditPhoto.dedName.SetFocus;
    Abort;
  end;
  if (quCollectionPUBLISH_COMPANY.AsString = '') and fmEditAuthor.Showing then
  begin
    ShowMessage('请输入出版社！');
    //fmEditPhoto.dedName.SetFocus;
    Abort;
  end;
  if (quCollectionCREATEDATE.AsString = '') and fmEditAuthor.Showing then
  begin
    ShowMessage('请输入出版日期！');
    //fmEditPhoto.dedName.SetFocus;
    Abort;
  end;
end;

procedure TdmPic.quPublishWCBeforePost(DataSet: TDataSet);
begin
  if (quPublishWCWORKS_TITLE.AsString = '') and fmEditAuthor.Showing then
  begin
    ShowMessage('请著作名称！');
    //fmEditPhoto.dedName.SetFocus;
    Abort;
  end;
  if (quPublishWCPUBLISHING_COMPANY.AsString = '') and fmEditAuthor.Showing then
  begin
    ShowMessage('请输入出版社！');
    //fmEditPhoto.dedName.SetFocus;
    Abort;
  end;
  if (quPublishWCPUBLISHING_DATE.AsString = '') and fmEditAuthor.Showing then
  begin
    ShowMessage('请输入出版日期！');
    //fmEditPhoto.dedName.SetFocus;
    Abort;
  end;
end;

end.

unit cat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, ComCtrls, wwriched, Buttons,
  wwdblook;

type
  TfmCat = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    gbCat: TGroupBox;
    dedName: TwwDBEdit;
    dreDesc: TwwDBRichEdit;
    Label6: TLabel;
    Label7: TLabel;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    dlcCat1: TwwDBLookupCombo;
    dlcCat3: TwwDBLookupCombo;
    dlcCat4: TwwDBLookupCombo;
    dlcCat5: TwwDBLookupCombo;
    dlcCat2: TwwDBLookupCombo;
    Label8: TLabel;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    dlcCat6: TwwDBLookupCombo;
    Label9: TLabel;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    dlcCat7: TwwDBLookupCombo;
    Label10: TLabel;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton26: TSpeedButton;
    dlcCat8: TwwDBLookupCombo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure dlcCat1Enter(Sender: TObject);
    procedure dlcCat2Enter(Sender: TObject);
    procedure dlcCat3Enter(Sender: TObject);
    procedure dlcCat4Enter(Sender: TObject);
    procedure dlcCat5Enter(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure dlcCat1Change(Sender: TObject);
    procedure dlcCat2Change(Sender: TObject);
    procedure dlcCat3Change(Sender: TObject);
    procedure dlcCat4Change(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure dlcCat5Change(Sender: TObject);
    procedure dlcCat6Change(Sender: TObject);
    procedure dlcCat7Change(Sender: TObject);
    procedure dlcCat6Enter(Sender: TObject);
    procedure dlcCat7Enter(Sender: TObject);
    procedure dlcCat8Enter(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure SpeedButton21Click(Sender: TObject);
    procedure SpeedButton24Click(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
    procedure SpeedButton22Click(Sender: TObject);
    procedure SpeedButton25Click(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure SpeedButton23Click(Sender: TObject);
    procedure SpeedButton26Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCat: TfmCat;

implementation

{$R *.DFM}
uses Pic;
var
  wAddFalg,wCatID :  Integer;
  
procedure TfmCat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with dmPic do
  begin
    with quCategory1 do
      if  Active then
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

  end;
  Action := caFree;
end;

procedure TfmCat.FormCreate(Sender: TObject);
begin
  with dmPic do
  begin
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

  end;
end;

procedure TfmCat.SpeedButton1Click(Sender: TObject);

begin
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    ParamByName('CategoryID').AsInteger := 0;
    Open;
    Insert;
    with dmPic.quCatID do
    begin
      if Active then
        Close;
      Open;
      wCatID := FieldByName('CategoryID').AsInteger;
      Close;
    end;
    FieldByName('CategoryID').AsInteger := wCatID;
    FieldByName('Status').AsString := 'Y';
    FieldByName('Grade').AsInteger := 0;
    FieldByName('ChildStatus').AsString := 'N';
  end;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.SpeedButton16Click(Sender: TObject);
begin
  with dmPic.quCategory do
  begin
    Post;
    try
      ApplyUpdates;
      CommitUpdates;
    except
      CancelUpdates;
      ShowMessage('更新错误!');
      Abort;
    end;
  end;

  with dmPic do
  begin
    with quCategoryCat do
    begin
      if Active then
        Close;
      ParamByName('CateGoryID').AsInteger := 0;
      Open;
      case wAddFalg of
      2 : begin
            Insert;
            FieldByName('CategoryID').AsInteger :=
              quCategory.FieldByName('CategoryID').AsInteger;
            FieldByName('ParentCateID').AsInteger :=
              quCategory1.FieldByName('CategoryID').AsInteger;
            Post;
          end;
      3 : begin
            Insert;
            FieldByName('CategoryID').AsInteger :=
              quCategory.FieldByName('CategoryID').AsInteger;
            FieldByName('ParentCateID').AsInteger :=
              quCategory2.FieldByName('CategoryID').AsInteger;
            Post;
          end;
      4 : begin
            Insert;
            FieldByName('CategoryID').AsInteger :=
              quCategory.FieldByName('CategoryID').AsInteger;
            FieldByName('ParentCateID').AsInteger :=
              quCategory3.FieldByName('CategoryID').AsInteger;
            Post;
          end;
      5 : begin
            Insert;
            FieldByName('CategoryID').AsInteger :=
              quCategory.FieldByName('CategoryID').AsInteger;
            FieldByName('ParentCateID').AsInteger :=
              quCategory4.FieldByName('CategoryID').AsInteger;
            Post;
          end;
      6 : begin
            Insert;
            FieldByName('CategoryID').AsInteger :=
              quCategory.FieldByName('CategoryID').AsInteger;
            FieldByName('ParentCateID').AsInteger :=
              quCategory5.FieldByName('CategoryID').AsInteger;
            Post;
          end;
      7 : begin
            Insert;
            FieldByName('CategoryID').AsInteger :=
              quCategory.FieldByName('CategoryID').AsInteger;
            FieldByName('ParentCateID').AsInteger :=
              quCategory6.FieldByName('CategoryID').AsInteger;
            Post;
          end;
      8 : begin
            Insert;
            FieldByName('CategoryID').AsInteger :=
              quCategory.FieldByName('CategoryID').AsInteger;
            FieldByName('ParentCateID').AsInteger :=
              quCategory7.FieldByName('CategoryID').AsInteger;
            Post;
          end;
      end;
    end;
  end;
  gbCat.Enabled := False;
end;

procedure TfmCat.SpeedButton6Click(Sender: TObject);
begin
  if (Trim(dlcCat1.Text) = '') then
  begin
    ShowMessage('请选取删除类别！');
    Abort;
  end;
  if not dmPic.quCategory2.IsEmpty then
  begin
    ShowMessage('还存在子类!,不能删除！');
    Abort;
  end;
  with dmPic.quDelCategoryCat do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category_category where categoryID =' +
      dmPic.quCategory1.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
    end;
  end;
  with dmPic.quDelCategory do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category where categoryID =' +
      dmPic.quCategory1.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
    end;
  end;

  dmPic.quCategory1.Close;
  dmPic.quCategory1.Open;
  //gbCat.Enabled := True;
  //gbCat.Enabled := True;
end;

procedure TfmCat.SpeedButton11Click(Sender: TObject);
begin
  wAddFalg := 0;
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    DataSource := dmPic.dsCategory1;
    //ParamByName('CategoryID').AsInteger :=
    //  dmPic.quCategory1.FieldByName('CategoryID').AsInteger;
    Open;
    Edit;
  end;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.SpeedButton17Click(Sender: TObject);
begin
  with dmPic.quCategory do
  begin
    Cancel;
    Close;
    Open;
  end;
  gbCat.Enabled := False;
end;

procedure TfmCat.dlcCat1Enter(Sender: TObject);
begin
  if gCat1 then
  begin
    dmPic.quCategory1.Close;
    dmPic.quCategory1.Open;
    gCat1 := False;
  end;
  if dlcCat1.Text <> '' then
  begin
    with dmPic do
    begin
      quCategory.Close;
      quCategory.DataSource := dsCategory1;
      quCategory.Open;
    end;
  end;
end;

procedure TfmCat.dlcCat2Enter(Sender: TObject);
begin
  if gCat2 then
  begin
    dmPic.quCategory2.Close;
    dmPic.quCategory2.Open;
    gCat2 := False;
  end;
  if dlcCat2.Text <> '' then
  begin
    with dmPic do
    begin
      quCategory.Close;
      quCategory.DataSource := dsCategory2;
      quCategory.Open;
    end;
  end;
end;

procedure TfmCat.dlcCat3Enter(Sender: TObject);
begin
  if gCat3 then
  begin
    dmPic.quCategory3.Close;
    dmPic.quCategory3.Open;
    gCat3 := False;
  end;
  if dlcCat3.Text <> '' then
  begin
    with dmPic do
    begin
      quCategory.Close;
      quCategory.DataSource := dsCategory3;
      quCategory.Open;
    end;
  end;
end;

procedure TfmCat.dlcCat4Enter(Sender: TObject);
begin
  if gCat4 then
  begin
    dmPic.quCategory4.Close;
    dmPic.quCategory4.Open;
    gCat4 := False;
  end;
  if dlcCat4.Text <> '' then
  begin
    with dmPic do
    begin
      quCategory.Close;
      quCategory.DataSource := dsCategory4;
      quCategory.Open;
    end;
  end;
end;

procedure TfmCat.dlcCat5Enter(Sender: TObject);
begin
  if gCat5 then
  begin
    dmPic.quCategory5.Close;
    dmPic.quCategory5.Open;
    gCat5 := False;
  end;
  if dlcCat5.Text <> '' then
  begin
    with dmPic do
    begin
      quCategory.Close;
      quCategory.DataSource := dsCategory5;
      quCategory.Open;
    end;
  end;
end;

procedure TfmCat.SpeedButton2Click(Sender: TObject);
begin
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    ParamByName('CategoryID').AsInteger := 0;
    Open;
    Insert;
    with dmPic.quCatID do
    begin
      if Active then
        Close;
      Open;
      wCatID := FieldByName('CategoryID').AsInteger;
      Close;
    end;
    FieldByName('CategoryID').AsInteger := wCatID;
    FieldByName('Status').AsString := 'Y';
    FieldByName('Grade').AsInteger := 1;
    FieldByName('ChildStatus').AsString := 'N';
  end;
  wAddFalg := 2;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.SpeedButton3Click(Sender: TObject);
begin
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    ParamByName('CategoryID').AsInteger := 0;
    Open;
    Insert;
    with dmPic.quCatID do
    begin
      if Active then
        Close;
      Open;
      wCatID := FieldByName('CategoryID').AsInteger;
      Close;
    end;
    FieldByName('CategoryID').AsInteger := wCatID;
    FieldByName('Status').AsString := 'Y';
    FieldByName('Grade').AsInteger := 2;
    FieldByName('ChildStatus').AsString := 'N';
  end;
  wAddFalg := 3;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.SpeedButton4Click(Sender: TObject);
begin
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    ParamByName('CategoryID').AsInteger := 0;
    Open;
    Insert;
    with dmPic.quCatID do
    begin
      if Active then
        Close;
      Open;
      wCatID := FieldByName('CategoryID').AsInteger;
      Close;
    end;
    FieldByName('CategoryID').AsInteger := wCatID;
    FieldByName('Status').AsString := 'Y';
    FieldByName('Grade').AsInteger := 3;
    FieldByName('ChildStatus').AsString := 'N';
  end;
  wAddFalg := 4;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.SpeedButton5Click(Sender: TObject);
begin
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    ParamByName('CategoryID').AsInteger := 0;
    Open;
    Insert;
    with dmPic.quCatID do
    begin
      if Active then
        Close;
      Open;
      wCatID := FieldByName('CategoryID').AsInteger;
      Close;
    end;
    FieldByName('CategoryID').AsInteger := wCatID;
    FieldByName('Status').AsString := 'Y';
    FieldByName('Grade').AsInteger := 4;
    FieldByName('ChildStatus').AsString := 'N';
  end;
  wAddFalg := 5;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.SpeedButton7Click(Sender: TObject);
begin
  if (Trim(dlcCat2.Text) = '') then
  begin
    ShowMessage('请选取删除类别！');
    Abort;
  end;
  if not dmPic.quCategory3.IsEmpty then
  begin
    ShowMessage('还存在子类!,不能删除！');
    Abort;
  end;
  with dmPic.quDelCategoryCat do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category_category where categoryID =' +
      dmPic.quCategory2.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
    end;
  end;
  with dmPic.quDelCategory do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category where categoryID =' +
      dmPic.quCategory2.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
      Abort;
    end;
  end;
  dmPic.quCategory2.Close;
  dmPic.quCategory2.Open;
end;

procedure TfmCat.SpeedButton8Click(Sender: TObject);
begin
  if (Trim(dlcCat3.Text) = '') then
  begin
    ShowMessage('请选取删除类别！');
    Abort;
  end;
  if not dmPic.quCategory4.IsEmpty then
  begin
    ShowMessage('还存在子类!,不能删除！');
    Abort;
  end;
  with dmPic.quDelCategoryCat do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category_category where categoryID =' +
      dmPic.quCategory3.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
    end;
  end;
  with dmPic.quDelCategory do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category where categoryID =' +
      dmPic.quCategory3.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
      Abort;
    end;
  end;

  dmPic.quCategory3.Close;
  dmPic.quCategory3.Open;
end;

procedure TfmCat.SpeedButton9Click(Sender: TObject);
begin
  if (Trim(dlcCat4.Text) = '') then
  begin
    ShowMessage('请选取删除类别！');
    Abort;
  end;
  if not dmPic.quCategory5.IsEmpty then
  begin
    ShowMessage('还存在子类!,不能删除！');
    Abort;
  end;
  with dmPic.quDelCategoryCat do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category_category where categoryID =' +
      dmPic.quCategory4.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
    end;
  end;
  with dmPic.quDelCategory do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category where categoryID =' +
      dmPic.quCategory4.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
      Abort;
    end;
  end;

  dmPic.quCategory4.Close;
  dmPic.quCategory4.Open;
end;

procedure TfmCat.SpeedButton10Click(Sender: TObject);
begin
  if (Trim(dlcCat5.Text) = '') then
  begin
    ShowMessage('请选取删除类别！');
    Abort;
  end;
  if not dmPic.quCategory6.IsEmpty then
  begin
    ShowMessage('还存在子类!,不能删除！');
    Abort;
  end;
  with dmPic.quDelCategoryCat do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category_category where categoryID =' +
      dmPic.quCategory5.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
    end;
  end;
  with dmPic.quDelCategory do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category where categoryID =' +
      dmPic.quCategory5.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
      Abort;
    end;
  end;
  dmPic.quCategory5.Close;
  dmPic.quCategory5.Open;
end;

procedure TfmCat.dlcCat1Change(Sender: TObject);
begin
  dlcCat2.Text := '';
  dlcCat3.Text := '';
  dlcCat4.Text := '';
  dlcCat5.Text := '';
  dlcCat6.Text := '';
  dlcCat7.Text := '';
  dlcCat8.Text := '';

end;

procedure TfmCat.dlcCat2Change(Sender: TObject);
begin
  dlcCat3.Text := '';
  dlcCat4.Text := '';
  dlcCat5.Text := '';
  dlcCat6.Text := '';
  dlcCat7.Text := '';
  dlcCat8.Text := '';
end;

procedure TfmCat.dlcCat3Change(Sender: TObject);
begin
  
  dlcCat4.Text := '';
  dlcCat5.Text := '';
  dlcCat6.Text := '';
  dlcCat7.Text := '';
  dlcCat8.Text := '';
end;

procedure TfmCat.dlcCat4Change(Sender: TObject);
begin

  dlcCat5.Text := '';
  dlcCat6.Text := '';
  dlcCat7.Text := '';
  dlcCat8.Text := '';
end;

procedure TfmCat.SpeedButton12Click(Sender: TObject);
begin
  wAddFalg := 0;
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    DataSource := dmPic.dsCategory2;
    //ParamByName('CategoryID').AsInteger :=
    //  dmPic.quCategory1.FieldByName('CategoryID').AsInteger;
    Open;
    Edit;
  end;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.SpeedButton13Click(Sender: TObject);
begin
  wAddFalg := 0;
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    DataSource := dmPic.dsCategory3;
    //ParamByName('CategoryID').AsInteger :=
    //  dmPic.quCategory1.FieldByName('CategoryID').AsInteger;
    Open;
    Edit;
  end;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.SpeedButton14Click(Sender: TObject);
begin
  wAddFalg := 0;
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    DataSource := dmPic.dsCategory4;
    //ParamByName('CategoryID').AsInteger :=
    //  dmPic.quCategory1.FieldByName('CategoryID').AsInteger;
    Open;
    Edit;
  end;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.SpeedButton15Click(Sender: TObject);
begin
  wAddFalg := 0;
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    DataSource := dmPic.dsCategory5;
    //ParamByName('CategoryID').AsInteger :=
    //  dmPic.quCategory1.FieldByName('CategoryID').AsInteger;
    Open;
    Edit;
  end;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.dlcCat5Change(Sender: TObject);
begin
  dlcCat6.Text := '';
  dlcCat7.Text := '';
  dlcCat8.Text := '';
end;

procedure TfmCat.dlcCat6Change(Sender: TObject);
begin
  dlcCat7.Text := '';
  dlcCat8.Text := '';
end;



procedure TfmCat.dlcCat7Change(Sender: TObject);
begin
  dlcCat8.Text := '';
end;

procedure TfmCat.dlcCat6Enter(Sender: TObject);
begin
  if gCat6 then
  begin
    dmPic.quCategory6.Close;
    dmPic.quCategory6.Open;
    gCat6 := False;
  end;
  if dlcCat6.Text <> '' then
  begin
    with dmPic do
    begin
      quCategory.Close;
      quCategory.DataSource := dsCategory6;
      quCategory.Open;
    end;
  end;
end;

procedure TfmCat.dlcCat7Enter(Sender: TObject);
begin
  if gCat7 then
  begin
    dmPic.quCategory7.Close;
    dmPic.quCategory7.Open;
    gCat7 := False;
  end;
  if dlcCat7.Text <> '' then
  begin
    with dmPic do
    begin
      quCategory.Close;
      quCategory.DataSource := dsCategory7;
      quCategory.Open;
    end;
  end;
end;

procedure TfmCat.dlcCat8Enter(Sender: TObject);
begin
  if gCat8 then
  begin
    dmPic.quCategory8.Close;
    dmPic.quCategory8.Open;
    gCat8 := False;
  end;
  if dlcCat8.Text <> '' then
  begin
    with dmPic do
    begin
      quCategory.Close;
      quCategory.DataSource := dsCategory8;
      quCategory.Open;
    end;
  end;
end;

procedure TfmCat.SpeedButton18Click(Sender: TObject);
begin
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    ParamByName('CategoryID').AsInteger := 0;
    Open;
    Insert;
    with dmPic.quCatID do
    begin
      if Active then
        Close;
      Open;
      wCatID := FieldByName('CategoryID').AsInteger;
      Close;
    end;
    FieldByName('CategoryID').AsInteger := wCatID;
    FieldByName('Status').AsString := 'Y';
    FieldByName('Grade').AsInteger := 5;
    FieldByName('ChildStatus').AsString := 'N';
  end;
  wAddFalg := 6;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.SpeedButton21Click(Sender: TObject);
begin
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    ParamByName('CategoryID').AsInteger := 0;
    Open;
    Insert;
    with dmPic.quCatID do
    begin
      if Active then
        Close;
      Open;
      wCatID := FieldByName('CategoryID').AsInteger;
      Close;
    end;
    FieldByName('CategoryID').AsInteger := wCatID;
    FieldByName('Status').AsString := 'Y';
    FieldByName('Grade').AsInteger := 6;
    FieldByName('ChildStatus').AsString := 'N';
  end;
  wAddFalg := 7;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.SpeedButton24Click(Sender: TObject);
begin
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    ParamByName('CategoryID').AsInteger := 0;
    Open;
    Insert;
    with dmPic.quCatID do
    begin
      if Active then
        Close;
      Open;
      wCatID := FieldByName('CategoryID').AsInteger;
      Close;
    end;
    FieldByName('CategoryID').AsInteger := wCatID;
    FieldByName('Status').AsString := 'Y';
    FieldByName('Grade').AsInteger := 7;
    FieldByName('ChildStatus').AsString := 'N';
  end;
  wAddFalg := 8;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.SpeedButton19Click(Sender: TObject);
begin
  if (Trim(dlcCat6.Text) = '') then
  begin
    ShowMessage('请选取删除类别！');
    Abort;
  end;
  if not dmPic.quCategory7.IsEmpty then
  begin
    ShowMessage('还存在子类!,不能删除！');
    Abort;
  end;
  with dmPic.quDelCategoryCat do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category_category where categoryID =' +
      dmPic.quCategory6.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
    end;
  end;
  with dmPic.quDelCategory do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category where categoryID =' +
      dmPic.quCategory6.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
      Abort;
    end;
  end;
  {with dmPic.quDelCategory do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category_category where categoryID =' +
      dmPic.quCategory5.FieldByName('CategoryID').AsString);
    ExecSQL;
  end;}
  dmPic.quCategory6.Close;
  dmPic.quCategory6.Open;
end;

procedure TfmCat.SpeedButton22Click(Sender: TObject);
begin
  if (Trim(dlcCat7.Text) = '') then
  begin
    ShowMessage('请选取删除类别！');
    Abort;
  end;
  if not dmPic.quCategory8.IsEmpty then
  begin
    ShowMessage('还存在子类!,不能删除！');
    Abort;
  end;
  with dmPic.quDelCategoryCat do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category_category where categoryID =' +
      dmPic.quCategory7.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
    end;
  end;
  with dmPic.quDelCategory do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category where categoryID =' +
      dmPic.quCategory7.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
      Abort;
    end;
  end;
  dmPic.quCategory7.Close;
  dmPic.quCategory7.Open;
end;

procedure TfmCat.SpeedButton25Click(Sender: TObject);
begin
  if (Trim(dlcCat8.Text) = '') then
  begin
    ShowMessage('请选取删除类别！');
    Abort;
  end;
  with dmPic.quDelCategoryCat do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category_category where categoryID =' +
      dmPic.quCategory8.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
    end;
  end;
  with dmPic.quDelCategory do
  begin
    sql.Clear;
    sql.Add('Delete from Local_category where categoryID =' +
      dmPic.quCategory8.FieldByName('CategoryID').AsString);
    try
      ExecSQL;
    except
      ShowMessage('不能删除！');
      Abort;
    end;
  end;
  
  dmPic.quCategory8.Close;
  dmPic.quCategory8.Open;
end;

procedure TfmCat.SpeedButton20Click(Sender: TObject);
begin
  wAddFalg := 0;
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    DataSource := dmPic.dsCategory6;
    //ParamByName('CategoryID').AsInteger :=
    //  dmPic.quCategory1.FieldByName('CategoryID').AsInteger;
    Open;
    Edit;
  end;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.SpeedButton23Click(Sender: TObject);
begin
  wAddFalg := 0;
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    DataSource := dmPic.dsCategory7;
    //ParamByName('CategoryID').AsInteger :=
    //  dmPic.quCategory1.FieldByName('CategoryID').AsInteger;
    Open;
    Edit;
  end;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

procedure TfmCat.SpeedButton26Click(Sender: TObject);
begin
  wAddFalg := 0;
  with dmPic.quCategory do
  begin
    if Active then
      Close;
    DataSource := dmPic.dsCategory8;
    //ParamByName('CategoryID').AsInteger :=
    //  dmPic.quCategory1.FieldByName('CategoryID').AsInteger;
    Open;
    Edit;
  end;
  gbCat.Enabled := True;
  dedName.SetFocus;
end;

end.

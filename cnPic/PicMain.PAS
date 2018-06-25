unit PicMain;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList, wwSpeedButton, wwDBNavigator, DBCtrls;

type
  TfmPicMain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    mmAuthor: TMenuItem;
    mmCategory: TMenuItem;
    mmDirSetting: TMenuItem;
    Window1: TMenuItem;
    Help1: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    OpenDialog: TOpenDialog;
    mmManuscript: TMenuItem;
    mmPhoto: TMenuItem;
    Edit1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    WindowMinimizeItem: TMenuItem;
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    FileNew1: TAction;
    FileSave1: TAction;
    FileExit1: TAction;
    FileOpen1: TAction;
    FileSaveAs1: TAction;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowArrangeAll1: TWindowArrange;
    WindowMinimizeAll1: TWindowMinimizeAll;
    HelpAbout1: TAction;
    FileClose1: TWindowClose;
    WindowTileVertical1: TWindowTileVertical;
    WindowTileItem2: TMenuItem;
    ImageList1: TImageList;
    ToolBar2: TToolBar;
    ToolButton9: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    mmOperator: TMenuItem;
    SpeedButton4: TSpeedButton;
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure mmDirSettingClick(Sender: TObject);
    procedure mmManuscriptClick(Sender: TObject);
    procedure mmPhotoClick(Sender: TObject);
    procedure mmOperatorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
    procedure CreateMDIChild(const Name: string);
  public
    { Public declarations }
  end;

var
  fmPicMain: TfmPicMain;

implementation

{$R *.DFM}

uses ChildWin, Cat, About, DirSetting, Manuscript, Admin, Photo, Author, pic;

procedure TfmPicMain.CreateMDIChild(const Name: string);
var
  Child: TMDIChild;
begin
  { create a new MDI child window }
  Child := TMDIChild.Create(Application);
 // Child.Caption := Name;
  //if FileExists(Name) then Child.Memo1.Lines.LoadFromFile(Name);
end;

procedure TfmPicMain.FileNew1Execute(Sender: TObject);
var
  Child: TfmAuthor;
begin
  Child := TfmAuthor.Create(Application);
end;


procedure TfmPicMain.FileOpen1Execute(Sender: TObject);
var
  Child: TfmCat;
begin
  Child := TfmCat.Create(Application);
end;


procedure TfmPicMain.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TfmPicMain.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TfmPicMain.mmDirSettingClick(Sender: TObject);
var
  Child: TfmDirSetting;
begin

  Child := TfmDirSetting.Create(Application);

end;

procedure TfmPicMain.mmManuscriptClick(Sender: TObject);
var
  Child: TfmManuScript;
begin
  Child := TfmManuScript.Create(Application);
end;

procedure TfmPicMain.mmPhotoClick(Sender: TObject);
var
  Child: TfmPhoto;
begin
  Child := TfmPhoto.Create(Application);
end;

procedure TfmPicMain.mmOperatorClick(Sender: TObject);
var
  Child: TfmAdmin;
begin
  Child := TfmAdmin.Create(Application);
end;
procedure TfmPicMain.FormCreate(Sender: TObject);
begin
  if gIsAdmin then
  begin
    mmOperator.Enabled := True;
    mmDirSetting.Enabled := True;
    mmCategory.Enabled := True;
    mmManuscript.Enabled := True;
  end
  else
  begin
    mmOperator.Enabled := False;
    mmCategory.Enabled := False;
    mmDirSetting.Enabled := False;
    mmManuscript.Enabled := False;
  end;
end;

procedure TfmPicMain.SpeedButton4Click(Sender: TObject);
begin
  Close;
end;

end.

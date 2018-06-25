unit CollectionPub;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Wwdbigrd, Wwdbgrid, DBCtrls, StdCtrls, ExtCtrls;

type
  TfmCollectionPub = class(TForm)
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    wwDBGrid1: TwwDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCollectionPub: TfmCollectionPub;

implementation

{$R *.DFM}
uses EditPhoto;
end.

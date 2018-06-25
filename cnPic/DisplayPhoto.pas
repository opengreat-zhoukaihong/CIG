unit DisplayPhoto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  jpeg, ExtCtrls;

type
  TfmDisplayPhoto = class(TForm)
    imPhoto: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDisplayPhoto: TfmDisplayPhoto;

implementation

{$R *.DFM}

end.

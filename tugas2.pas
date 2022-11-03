unit tugas2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ExtDlgs;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnLoad: TButton;
    imgSrc: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

end.


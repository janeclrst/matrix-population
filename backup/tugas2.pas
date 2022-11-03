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
    procedure btnLoadClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

var
  bitmapR, bitmapG, bitmapB, BitmapGray, BitmapBiner : array[0..1000, 0..1000] of integer;
  histo : array[0..255] of integer;

procedure TForm1.btnLoadClick(Sender: TObject);
var
  i, j, R, G, B, gray : integer;
begin
  if (OpenPictureDialog1.Execute) then
  begin
    imgSrc.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
  for j:=0 to imgSrc.Height-1 do
  begin
    for i:=0 to imgSrc.Width-1 do
    begin
      //mengambil nilai RGB
      R := GetRValue(imgSrc.Canvas.Pixels[i,j]);
      G := GetGValue(imgSrc.Canvas.Pixels[i,j]);
      B := GetBValue(imgSrc.Canvas.Pixels[i,j]);
      gray := (R + G + B) div 3;
      bitmapR[i,j] := R;
      bitmapG[i,j] := G;
      bitmapB[i,j] := B;
      bitmapGray[i,j] := gray;
      if gray>127 then
        BitmapBiner[i,j] := 1
      else
        BitmapBiner[i,j] := 0;
    end;
  end;

  for j:= 0  to imgSrc.Height-1 do
  begin
    for i := 0 to imgSrc.Width-1 do
    begin
      inc(histo[bitmapGray[i,j]]);
    end;
  end;
end;

end.


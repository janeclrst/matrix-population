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
    btnPopulation: TButton;
    imgSrc: TImage;
    ListBox: TListBox;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure btnLoadClick(Sender: TObject);
    procedure btnPopulationClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  windows, math;

{ TForm1 }

var
  bitmapR, bitmapG, bitmapB, BitmapGray, BitmapBiner : array[0..1000, 0..1000] of integer;
  histo : array[0..255] of integer;
  pop : array[0..100, 0..100] of integer;
  max1, min1, max2, min2, row, col : integer;

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

procedure TForm1.btnPopulationClick(Sender: TObject);
var
  x, y : integer;
  i, j : integer;
  fitur : integer;

begin
   row := round(Width / 5);
   col := round(Height / 5);
   for y := 0 to col-1 do
   begin
		for x := 0 to row-1 do
                begin
			for j := min1 to imgSrc.Height - 1 do
                        begin
				for i := min2 to imgSrc.Width - 1 do
                                begin
					if BitmapBiner[i,j] = 0 then
                                        begin
						pop[x,y] += 1;
                                        end;
                                        if i = max2 then
                                        begin
						break;
                                        end;
                                end;
                                if (i = max2) AND (j = max1) then
                                begin
						max2 += 5;
						max1 += 5;
						min1 += 5;
						min2 += 5;
						break;
                                end;
                        end;
                end;
   end;

   fitur := 1;
   for y := 0 to imgSrc.Height-1 do
   begin
     for x := 0 to imgSrc.Width-1 do
     begin
        ListBox.Items.Add('Fitur ' + IntToStr(fitur) + ' : ' + IntToStr(pop[x,y]));
        fitur += 1;
     end;
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

end.


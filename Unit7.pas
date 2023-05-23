unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, Grids, StdCtrls,
  Buttons;

type
  TFrevisi = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Edt1: TEdit;
    Cbb1: TComboBox;
    Cbb2: TComboBox;
    StringGrid1: TStringGrid;
    Cht1: TChart;
    Series1: TPieSeries;
    Button3: TButton;
    Btn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure charadd;
    procedure Btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frevisi: TFrevisi;

implementation

{$R *.dfm}

procedure TFrevisi.FormCreate(Sender: TObject);
begin
StringGrid1.RowCount:=1;
StringGrid1.ColCount:=4;
StringGrid1.Cells[0,0]:='NO';
StringGrid1.Cells[1,0]:='JUMLAH TERDAFTAR';
StringGrid1.Cells[2,0]:='FAKULTAS';
StringGrid1.Cells[3,0]:='TAHUN ANGKATAN';
StringGrid1.ColWidths[0]:=20;
StringGrid1.ColWidths[1]:=70;
StringGrid1.ColWidths[2]:=170;
StringGrid1.ColWidths[3]:=100;
end;

procedure TFrevisi.Button1Click(Sender: TObject);
begin
StringGrid1.RowCount := StringGrid1.RowCount+1;
StringGrid1.Cells[0,StringGrid1.RowCount -1] := IntToStr(StringGrid1.RowCount -
1);
StringGrid1.Cells[1,StringGrid1.RowCount -1] := Edt1.Text;
StringGrid1.Cells[2,StringGrid1.RowCount -1] := Cbb2.Text;
StringGrid1.Cells[3,StringGrid1.RowCount -1] := Cbb1.Text;
charadd;//procedure
end;
procedure TFrevisi.Btn1Click(Sender: TObject);
var a,b:Integer;
begin
a:=StringGrid1.Selection.Bottom - StringGrid1.Selection.Top+1;
for b:=StringGrid1.Selection.Bottom +1 to StringGrid1.rowcount-1 do
StringGrid1.Rows[b-a]:=StringGrid1.Rows[b];

StringGrid1.RowCount:=StringGrid1.RowCount-1;
charadd; //procedure
end;

procedure TFrevisi.charadd;
var i:Integer;
begin
cht1.Series[0].Clear; //membersihkan tampilan char
for i:=1 to StringGrid1.rowcount-1 do
begin
cht1.Series[0].Add(StrToFloat(StringGrid1.Cells[1,i]),StringGrid1.Cells[2,i]);
end;
end;


procedure TFrevisi.Button3Click(Sender: TObject);
begin
StringGrid1.RowCount:= StringGrid1.RowCount-
MAX_PATH; //hapus isi data stringgrid all

charadd; //procedure
end;

end.

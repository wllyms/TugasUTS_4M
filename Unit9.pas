unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DB, ADODB, ExtCtrls, ComCtrls;

type
  TFjadwal = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    kelas: TEdit;
    matkul: TEdit;
    mulai: TEdit;
    akhir: TEdit;
    hari: TComboBox;
    ruangan: TEdit;
    hadir: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    dtp1: TDateTimePicker;
    DBGrid1: TDBGrid;
    procedure Button2Click(Sender: TObject);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fjadwal: TFjadwal;
  a: String;

implementation

uses Unit8;

{$R *.dfm}

procedure TFjadwal.Button2Click(Sender: TObject);
var
  a: Integer;
begin
   if (mulai.Text='') or (mulai.Text='00:00') or (akhir.Text='') or (akhir.Text='00:00') or (kelas.Text='') or (matkul.Text='') or (ruangan.Text='') or (hadir.Text='')then
   begin
     ShowMessage('DATA BELUM DIISI DENGAN BENAR');
   end else

   if (hari.Text='') or (hari.Text='-- PILIH HARI --') then
   begin
     ShowMessage('HARI BELUM DI ISI DENGAN BENAR');
   end else
   begin
        a:= Flat.qry1.RecordCount+1;
    with Flat.qry1 do
    begin
      SQL.Clear;
      SQL.Add('insert into jadwal_tb values("'+inttostr(a)+'", "'+mulai.Text+'", "'+akhir.Text+'", "'+hari.Text+'", "'+formatdatetime('yyyy-mm-dd',dtp1.Date)+'", "'+ruangan.Text+'", "'+matkul.Text+'", "'+kelas.Text+'", "'+hadir.Text+'")');
      ExecSQL;

      SQL.Clear;
      SQL.Add('select * from jadwal_tb');
      Open;
      ShowMessage('DATA BERHASIL DISIMPAN');
    end;
   end;

end;


procedure TFjadwal.DBGrid2CellClick(Column: TColumn);
var a:String;

begin
try
a:=Flat.qry1.Fields[0].AsString;
mulai.Text:= Flat.qry1.Fields[1].AsString;
akhir.Text:= Flat.qry1.Fields[2].AsString;
hari.Text:= Flat.qry1.Fields[3].AsString;
dtp1.Date:= Flat.qry1.Fields[4].AsDateTime;
ruangan.Text:= Flat.qry1.Fields[5].AsString;
matkul.Text:= Flat.qry1.Fields[6].AsString;
kelas.Text:= Flat.qry1.Fields[7].AsString;
hadir.Text:= Flat.qry1.Fields[8].AsString;

except
//Kosong
end;
end;

procedure TFjadwal.FormShow(Sender: TObject);

begin
Flat.qry1.SQL.Clear;
Flat.qry1.SQL.Add('select * from jadwal_tb');
Flat.qry1.Open();
end;

procedure TFjadwal.Button3Click(Sender: TObject);
begin
if (mulai.Text='') or (mulai.Text='00:00') or (akhir.Text='') or (akhir.Text='00:00') or (kelas.Text='') or (matkul.Text='') or (ruangan.Text='') or (hadir.Text='')then
   begin
     ShowMessage('DATA BELUM DIISI DENGAN BENAR');
   end else

   if (hari.Text='') or (hari.Text='-- PILIH HARI --') then
   begin
     ShowMessage('HARI BELUM DI ISI DENGAN BENAR');
   end else

   if (mulai.Text = Flat.qry1.Fields[1].AsString) and (akhir.Text = Flat.qry1.Fields[2].AsString) and (hari.Text = Flat.qry1.Fields[3].AsString) then
   begin
     ShowMessage('Data Tidak Ada Perubahan');
   end else

   begin
     //KodeUpdate
     with Flat.qry1 do
     begin
       SQL.Clear;
       SQL.Add('update jadwal_tb set jam_mulai="'+mulai.Text+'", jam_akhir="'+akhir.Text+'", hari="'+hari.Text+'", ruang="'+ruangan.Text+'", matkul="'+matkul.Text+'", kelas="'+kelas.Text+'", kehadiran_total="'+hadir.Text+'" where no="'+a+'"');
       ExecSQL;

       SQL.Clear;
       SQL.Add('select * from jadwal_tb');
       Open;
       ShowMessage('Data Berhasil Di Update');
     end;
   end;
end;

procedure TFjadwal.Button4Click(Sender: TObject);
begin
 if (mulai.Text='') or (mulai.Text='00:00') or (akhir.Text='') or (akhir.Text='00:00') or (kelas.Text='') or (matkul.Text='') or (ruangan.Text='') or (hadir.Text='')then
   begin
     ShowMessage('DATA BELUM DIISI DENGAN BENAR');
   end else

   if (hari.Text='') or (hari.Text='-- PILIH HARI --') then
   begin
     ShowMessage('HARI BELUM DI ISI DENGAN BENAR');
   end else
   begin

     if MessageDlg('Apakah Anda Yaking Ingin Menghapus  Data Ini ??', mtWarning, [mbYes,mbNo],0)=mryes then
     begin
      with Flat.qry1 do
      begin
        SQL.Clear;
        SQL.Add('delete from jadwal_tb where id="'+a+'"');
        ExecSQL;
      end;
      ShowMessage('Data Berhasil Dihapus');
     end else
     begin
       Flat.qry1.SQL.Clear;
       Flat.qry1.SQL.Add('select * from jadwal_tb');
       Flat.qry1.Open;
       ShowMessage('Data Batal Dihapus');
     end;
   end;
end;

end.

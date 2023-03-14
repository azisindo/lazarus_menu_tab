unit uTabForms;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Menus,uForms1,uForms2;

type
  TMyFormClass=Class of TForm;
  TMyTabSheet= Class(TTabSheet)
    Private
      TabForm:TForm;
      fFormClass:TMyFormClass;

    Protected
       Constructor Create(Aowner:TComponent); Reintroduce;
    Public
       Constructor New(Aowner:TComponent; YourFormClass:TMyFormClass);
       Property FormClass:TMyFormClass Read fFormClass;


  end;


type

  { Tfrm_main }

  Tfrm_main = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    ImageList1: TImageList;
    MenuItem2: TMenuItem;
    Panel1: TPanel;
    PGC1: TPageControl;
    PnlMenu: TPanel;
    PopupMenu1: TPopupMenu;
    spl: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure PopupMenu1Close(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
  private
         //membuat tab baru pada page control
    function BuatTab(FormClass:TMyFormClass): TMyTabSheet;

    //menampilkan form yang page page control
     procedure TampilForm(NewFormClass: TMyFormClass; ImgIndex: Integer);

     //cek apakah form sudah ditampilkan pada page control
     function CekFormSudahAda(FormClass:TMyFormClass): TMyTabSheet;
  public

  end;




var
  frm_main: Tfrm_main;

implementation

{$R *.lfm}

{ Tfrm_main }

Constructor TMyTabSheet.Create(Aowner: TComponent);
begin
  Inherited Create(Aowner);
end;

Constructor TMyTabSheet.New(Aowner: TComponent; YourFormClass: TMyFormClass);
begin
  Inherited Create(Aowner);
  fFormClass:=YourFormClass;
end;

procedure Tfrm_main.Button1Click(Sender: TObject);
begin
 TampilForm(TForm2,0);
end;

procedure Tfrm_main.Button2Click(Sender: TObject);
begin
  TampilForm(TForm3,0);
end;

procedure Tfrm_main.Button3Click(Sender: TObject);
begin
  TMyTabSheet(PGC1.ActivePage).TabForm.Free;
  PGC1.ActivePage.Free;
end;

procedure Tfrm_main.Button4Click(Sender: TObject);
begin
  TMyTabSheet(PGC1.ActivePage).TabForm.Free;
  PGC1.ActivePage.Free;
end;

procedure Tfrm_main.Button5Click(Sender: TObject);
begin
//  spl.Left:=0;
PnlMenu.Width:=0;
{
procedure TForm1.Button1Click(Sender :TObject);
begin
  if (Panel1.Height <> 1) then begin
    FExpandHeight:= Panel1.Height;
    Panel1.Height := 1;
  end;
end;

procedure TForm1.Button2Click(Sender :TObject);
begin
  if Panel1.Height = 1 then begin
    Panel1.Height := FExpandHeight;
    Panel1.Top    := 10;
    Splitter1.Top := Panel1.Top - Splitter1.Height-1;
  end;
end;      }
end;

procedure Tfrm_main.Button6Click(Sender: TObject);
begin
 // spl.Left:=0;
  PnlMenu.Width:=168;
end;

procedure Tfrm_main.MenuItem1Click(Sender: TObject);
begin
  TMyTabSheet(PGC1.ActivePage).TabForm.Free;
  PGC1.ActivePage.Free;
end;

procedure Tfrm_main.PopupMenu1Close(Sender: TObject);
begin
  TMyTabSheet(PGC1.ActivePage).TabForm.Free;
  PGC1.ActivePage.Free;
end;

procedure Tfrm_main.PopupMenu1Popup(Sender: TObject);
begin

end;

function Tfrm_main.BuatTab(FormClass:TMyFormClass): TMyTabSheet;
Var H:TMyTabSheet;
begin
  {fungsi digunakan untuk membuat tabsheet baru, kemudian tab tersebut 'ditancapkan'
   pada page control yang diinginkan, dan otomatis menjadikannya sebagai tab yang aktif
   saat itu}
  Result:=Nil;
  if Assigned(CekFormSudahAda(FormClass)) then Exit;
  H:=TMyTabSheet.New(Self,FormClass);
  H.PageControl:=PGC1;
  H.TabForm:=H.FormClass.Create(Application);
  H.TabForm.BorderStyle:=bsNone;
  H.Caption:=H.TabForm.Caption;
  H.TabForm.Parent:=H;
  H.TabForm.Align:=AlClient;
  PGC1.ActivePageIndex:=PGC1.PageCount - 1;
  H.TabForm.Show;
  Result:=H;
end;

 function Tfrm_main.CekFormSudahAda(FormClass: TMyFormClass): TMyTabSheet;
var i: Integer;
    H:TMyTabSheet;
begin
  {nilai awal result adalah nil. Jika tab yang mengandung form
   ditemukan, maka fungsi ini akan mengembalikan referensi dari
   tab tersebut. jika tidak ada maka fungsi mengembalikan nilai
   nil. Penting untuk memberikan nilai awal nil, karena jika
   tidak, fungsi Assigned(CekFormSudahAda) akan selalu
   mengembalikan nilai True, baik form tersebut sudah ada
   atau tidak.}
  Result:= nil;
  if PGC1.PageCount<1 then Exit;


  {cek berdasar caption tab}
  H:=Nil;
  for i := 0 to pgc1.PageCount-1 do
    if TMyTabSheet(PGC1.Pages[i]).FormClass=FormClass then begin
       H:=TMyTabSheet(PGC1.Pages[i]);
       Break;
    end;
  Result:=H;
end;

 procedure Tfrm_main.TampilForm(NewFormClass: TMyFormClass; ImgIndex: Integer);
var tab: TTabSheet;
begin
  {jika form sudah ada / ditampilkan dalam tab, maka tab tersebut diaktifkan
  (dijadikan tab aktif. Jika Form belum ada, maka tab baru dibuat, dan form yang
  dimaksudkan diletakkan di tab tersebut}
  if Assigned(CekFormSudahAda(NewFormClass)) then
    pgc1.ActivePageIndex:=CekFormSudahAda(NewFormClass).TabIndex
  else begin
    Tab:=BuatTab(NewFormClass);
    if Assigned(Tab) then
       Tab.ImageIndex:=ImgIndex;
  end;
end;

end.


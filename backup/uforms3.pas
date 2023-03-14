unit uForms3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs;

type
  TForm4 = class(TForm)
  private

  public

  end;
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
var
  Form4: TForm4;

implementation

{$R *.lfm}

end.


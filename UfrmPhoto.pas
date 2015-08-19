unit UfrmPhoto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ExtDlgs, DB, ADODB,Jpeg;

type
  TfrmPhoto = class(TForm)
    ScrollBox1: TScrollBox;
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
  private
    { Private declarations }
    procedure ShowPicture;
  public
    { Public declarations }
  end;

//var
function  frmPhoto(Const Valu_Unid:integer): TfrmPhoto;

implementation

uses UDM;
var
  ffrmPhoto: TfrmPhoto;
  pValu_Unid:integer;

{$R *.dfm}
function  frmPhoto(Const Valu_Unid:integer): TfrmPhoto;
begin
  if ffrmPhoto=nil then ffrmPhoto:=TfrmPhoto.Create(application.mainform);
  pValu_Unid:=Valu_Unid;
  result:=ffrmPhoto;
end;

procedure TfrmPhoto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmPhoto=self then ffrmPhoto:=nil;
end;

procedure TfrmPhoto.FormShow(Sender: TObject);
begin
  ShowPicture;
end;

procedure TfrmPhoto.ShowPicture;
var
  MS:tmemorystream;
  adotemp11:tadoquery;
begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=dm.ADOConnection1;
  adotemp11.Close;
  adotemp11.sql.clear;
  adotemp11.sql.Add('select photo from chk_valu where valueid=:valueid');
  adotemp11.Parameters.ParamByName('valueid').Value:=pValu_Unid;
  adotemp11.Open;

  if tblobfield(adotemp11.FieldByName('photo')).BlobSize <=0 then begin adotemp11.Free;exit;end;

  MS:=TMemoryStream.Create;
  TBlobField(adotemp11.fieldbyname('photo')).SaveToStream(MS);
  MS.Position:=0;
  Image1.Picture.Graphic:=nil;
  Image1.Picture.Graphic:=TJpegImage.Create;
  Image1.Picture.Graphic.LoadFromStream(MS);
  MS.Free;
  adotemp11.Free;
end;

procedure TfrmPhoto.Image1DblClick(Sender: TObject);
begin
  close;
end;

initialization
  ffrmPhoto:=nil;

end.

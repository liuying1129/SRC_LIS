unit UfrmCollectSignature;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, Buttons, DB, ADODB, ExtCtrls;

type
  TfrmCollectSignature = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    PaintBox1: TPaintBox;//390*130(3:1).显示、打印时按此比例才不会变形
    Image1: TImage;//390*130(3:1)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    FIsDrawing: Boolean; // 标记是否正在绘制
    FLastPoint: TPoint;  // 记录上一个点的位置
    FOperatorID: String; //登录帐号
  public
    { Public declarations }
  end;

//var
function  frmCollectSignature(const AOperatorID: String): TfrmCollectSignature;

implementation

uses UDM, ToastUnit;

var
  ffrmCollectSignature: TfrmCollectSignature;

{$R *.dfm}

function  frmCollectSignature(const AOperatorID: String): TfrmCollectSignature;
begin
  if ffrmCollectSignature=nil then ffrmCollectSignature:=TfrmCollectSignature.Create(application.mainform);
  ffrmCollectSignature.FOperatorID:=AOperatorID;
  result:=ffrmCollectSignature;
end;

procedure TfrmCollectSignature.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmCollectSignature=self then ffrmCollectSignature:=nil;
end;

procedure TfrmCollectSignature.FormCreate(Sender: TObject);
begin
  FIsDrawing := False;// 初始化绘制状态
end;

procedure TfrmCollectSignature.PaintBox1Paint(Sender: TObject);
begin
  // 设置绘制区域的背景色为白色
  PaintBox1.Canvas.Brush.Color := clWhite;
  PaintBox1.Canvas.FillRect(PaintBox1.ClientRect);
end;

procedure TfrmCollectSignature.PaintBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbLeft then exit;// 按下鼠标左键开始绘制

  FIsDrawing := True;
  FLastPoint := Point(X, Y); // 记录起始点
end;

procedure TfrmCollectSignature.PaintBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if not FIsDrawing then exit;

  // 在画布上画线
  PaintBox1.Canvas.Pen.Color := clBlack; // 设置画笔颜色为黑色
  PaintBox1.Canvas.Pen.Width := 4;       // 设置画笔粗细
  PaintBox1.Canvas.MoveTo(FLastPoint.X, FLastPoint.Y);
  PaintBox1.Canvas.LineTo(X, Y);
  // 更新上一个点的位置
  FLastPoint := Point(X, Y);
end;

procedure TfrmCollectSignature.PaintBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then FIsDrawing := False;// 释放鼠标左键结束绘制
end;

procedure TfrmCollectSignature.SpeedButton1Click(Sender: TObject);
begin
  // 清除签名：用白色填充整个绘制区域
  PaintBox1.Canvas.Brush.Color := clWhite;
  PaintBox1.Canvas.FillRect(PaintBox1.ClientRect);
end;

procedure TfrmCollectSignature.SpeedButton2Click(Sender: TObject);
var
  Bitmap: TBitmap;
  MemoryStream: TMemoryStream;
  Query1: TADOQuery;
begin
  Bitmap := TBitmap.Create;// 创建一个位图对象
  // 设置位图尺寸与PaintBox一致
  Bitmap.Width := PaintBox1.Width;
  Bitmap.Height := PaintBox1.Height;
  Bitmap.Canvas.CopyRect(Bitmap.Canvas.ClipRect, PaintBox1.Canvas, PaintBox1.ClientRect);// 将PaintBox的内容绘制到位图上

  MemoryStream := TMemoryStream.Create;// 创建内存流
  Bitmap.SaveToStream(MemoryStream);// 将位图保存到流中
  MemoryStream.Position := 0; // 重置流位置

  Query1 := TADOQuery.Create(nil);
  Query1.Connection := DM.ADOConnection1;
  Query1.Close;
  Query1.SQL.Clear;
  Query1.SQL.Text := 'UPDATE worker SET SignPic = :SignPic WHERE id='''+FOperatorID+'''';
  Query1.Parameters.ParamByName('SignPic').LoadFromStream(MemoryStream, ftBlob);//ftGraphic
  Query1.ExecSQL;
  Query1.Free;
  MemoryStream.Free;
  Bitmap.Free;

  LoadSignatureToImage(Image1,FOperatorID);//更新展示区
  ShowToast(Self.Handle,'提交成功');
end;

procedure TfrmCollectSignature.FormShow(Sender: TObject);
begin
  LoadSignatureToImage(Image1,FOperatorID);
end;

initialization
  ffrmCollectSignature:=nil;

end.

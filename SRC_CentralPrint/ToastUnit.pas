unit ToastUnit;

//============================================================================//
//2025-08-14
//该单元实现信息提示方法ShowToast
//实现类似于Android的Toast功能
//该信息提示实现一定时间(参数控制)的弹窗提示,且为非模态
//============================================================================//
interface

uses
  Windows, Messages, Graphics, Forms, Controls;

procedure ShowToast(ParentHandle: HWND; const AMessage: string; ADuration: Integer=2000);
  
implementation

const
  ToastWindowClass = 'ToastWindow';//自定义Toast窗口类

var
  ToastWnd: HWND = 0;
  ToastTimerID: WPARAM = 0;
  CurrentMessage: String; //用于保存要显示的消息,传递给ToastWndProc方法
  ToastFont: HFONT = 0;

function ToastWndProc(Wnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  PS: TPaintStruct;
  DC: HDC;
  Rect: TRect;
  OldFont: HFONT;
  Rgn: HRGN;
begin
  case Msg of
    WM_CREATE://创建圆角区域
      begin
        GetClientRect(Wnd, Rect);
        Rgn := CreateRoundRectRgn(0, 0, Rect.Right, Rect.Bottom, 10, 10);//最后2个参数是圆角半径
        SetWindowRgn(Wnd, Rgn, True); //True表示立即重绘
        Result := 0;
      end;  
    WM_TIMER:
      begin
        if UINT(wParam) = UINT(ToastTimerID) then
        begin
          KillTimer(Wnd, UINT(ToastTimerID));
          DestroyWindow(Wnd);
          ToastWnd := 0;
          if ToastFont <> 0 then
          begin
            DeleteObject(ToastFont);
            ToastFont := 0;
          end;
        end;
        Result := 0;
      end;
    WM_PAINT:
      begin
        DC := BeginPaint(Wnd, PS);
        try
          if ToastFont <> 0 then// 设置字体（只在第一次创建）
          begin
            OldFont := SelectObject(DC, ToastFont);
            try
              GetClientRect(Wnd, Rect);
              
              // 创建圆角矩形路径
              BeginPath(DC);
              RoundRect(DC, Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, 20, 20);
              EndPath(DC);
              FillPath(DC);// 填充路径

              SetBkColor(DC, $00808080);//设置背景颜色
              ExtTextOut(DC, 0, 0, ETO_OPAQUE, @Rect, nil, 0, nil);
              SetTextColor(DC, clWhite);//设置文字颜色
              //DT_SINGLELINE:不支持换行
              //DT_WORDBREAK:支持换行
              DrawText(DC, PChar(CurrentMessage), -1, Rect, DT_CENTER or DT_VCENTER or DT_SINGLELINE or DT_NOCLIP);//绘制文字（居中） 
            finally
              SelectObject(DC, OldFont);
            end;
          end;
        finally
          EndPaint(Wnd, PS);
        end;
        Result := 0;
      end;
    WM_ERASEBKGND:
      begin
        Result := 1;// 阻止默认背景擦除
      end;
  else
    Result := DefWindowProc(Wnd, Msg, wParam, lParam);
  end;
end;

procedure RegisterToastWindowClass;
// 注册窗口类（仅在首次调用时执行）
var
  WC: TWndClass;
begin
  if not GetClassInfo(HInstance, ToastWindowClass, WC) then
  begin
    FillChar(WC, SizeOf(WC), 0);// 初始化结构体
    WC.style := CS_HREDRAW or CS_VREDRAW;
    WC.lpfnWndProc := @ToastWndProc;
    WC.hInstance := HInstance;
    WC.hCursor := LoadCursor(0, IDC_ARROW);
    WC.lpszClassName := ToastWindowClass;
    Windows.RegisterClass(WC);
  end;
end;

procedure ShowToast(ParentHandle: HWND; const AMessage: string; ADuration: Integer=2000);
//显示 Toast
//ParentHandle:调用窗体句柄
//AMessage:需要显示的消息
//ADuration:显示持续时间.默认持续2秒
var
  ParentRect, ToastRect: TRect;
  ParentWidth, ParentHeight: Integer;
  X, Y: Integer;
  ParentFont: HFONT;
  LogFont: TLogFont;
begin
  CurrentMessage := AMessage;// 保存消息到全局变量
  RegisterToastWindowClass;// 注册窗口类（仅在首次调用时执行）

  // 如果已有 Toast 窗口，先关闭旧的
  if ToastWnd <> 0 then
  begin
    KillTimer(ToastWnd, ToastTimerID);
    DestroyWindow(ToastWnd);
    if ToastFont <> 0 then
    begin
      DeleteObject(ToastFont);
      ToastFont := 0;
    end;
  end;

  ParentFont := TForm(FindControl(ParentHandle)).Font.Handle;// 获取父窗口字体
  if ParentFont <> 0 then
  begin
    // 获取字体信息
    GetObject(ParentFont, SizeOf(TLogFont), @LogFont);
    // 创建新字体（基于父窗口字体但可以调整大小）
    //LogFont.lfHeight := -16;//设置字体高度为16像素.注释该行,则继承父窗口的字体大小
    LogFont.lfWeight := FW_BOLD; // 设置为加粗
    ToastFont := CreateFontIndirect(LogFont);
  end else
  begin
    //未获取到父窗口字体时,使用默认字体
    //FW_BOLD:加粗 FW_NORMAL:普通
    ToastFont := CreateFont(16, 0, 0, 0, FW_BOLD, 0, 0, 0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,DEFAULT_PITCH or FF_DONTCARE,'宋体');
  end;

  // 获取父窗口位置
  GetWindowRect(ParentHandle, ParentRect);
  ParentWidth := ParentRect.Right - ParentRect.Left;
  ParentHeight := ParentRect.Bottom - ParentRect.Top;

  // Toast窗口尺寸
  ToastRect.Left := 0;
  ToastRect.Top := 0;
  ToastRect.Right := 400;//窗口宽度
  ToastRect.Bottom := 40;//窗口高度

  // 计算Toast窗口位置（相对于父窗口）
  X := ParentRect.Left + (ParentWidth - (ToastRect.Right - ToastRect.Left)) div 2;//水平居中
  Y := ParentRect.Top + (ParentHeight - (ToastRect.Bottom - ToastRect.Top)) div 2;//垂直居中
  //Y := ParentRect.Bottom - (ToastRect.Bottom - ToastRect.Top) - 10;  // 底部留10像素边距
  
  // 创建窗口
  //WS_EX_TOPMOST:窗口显示在最上层
  //WS_EX_LAYERED:扩展窗口样式
  ToastWnd := CreateWindowEx(
    WS_EX_TOPMOST or WS_EX_LAYERED or WS_EX_TOOLWINDOW,
    ToastWindowClass,
    'Toast',
    WS_POPUP or WS_VISIBLE,
    X, Y,
    ToastRect.Right - ToastRect.Left,
    ToastRect.Bottom - ToastRect.Top,
    ParentHandle, 0, HInstance, nil);

  SetLayeredWindowAttributes(ToastWnd, 0, 220, LWA_ALPHA);//设置半透明效果（Alpha 混合）.220=透明度（0-255）
  ToastTimerID := SetTimer(ToastWnd, 1, ADuration, nil);// 设置定时器自动关闭
  UpdateWindow(ToastWnd);
  RedrawWindow(ToastWnd, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
end;

initialization
  ToastFont := 0;

finalization
  if ToastFont <> 0 then DeleteObject(ToastFont);

end.

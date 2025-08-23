unit ToastUnit;

//============================================================================//
//2025-08-14
//�õ�Ԫʵ����Ϣ��ʾ����ShowToast
//ʵ��������Android��Toast����
//����Ϣ��ʾʵ��һ��ʱ��(��������)�ĵ�����ʾ,��Ϊ��ģ̬
//============================================================================//
interface

uses
  Windows, Messages, Graphics, Forms, Controls;

procedure ShowToast(ParentHandle: HWND; const AMessage: string; ADuration: Integer=2000);
  
implementation

const
  ToastWindowClass = 'ToastWindow';//�Զ���Toast������

var
  ToastWnd: HWND = 0;
  ToastTimerID: WPARAM = 0;
  CurrentMessage: String; //���ڱ���Ҫ��ʾ����Ϣ,���ݸ�ToastWndProc����
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
    WM_CREATE://����Բ������
      begin
        GetClientRect(Wnd, Rect);
        Rgn := CreateRoundRectRgn(0, 0, Rect.Right, Rect.Bottom, 10, 10);//���2��������Բ�ǰ뾶
        SetWindowRgn(Wnd, Rgn, True); //True��ʾ�����ػ�
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
          if ToastFont <> 0 then// �������壨ֻ�ڵ�һ�δ�����
          begin
            OldFont := SelectObject(DC, ToastFont);
            try
              GetClientRect(Wnd, Rect);
              
              // ����Բ�Ǿ���·��
              BeginPath(DC);
              RoundRect(DC, Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, 20, 20);
              EndPath(DC);
              FillPath(DC);// ���·��

              SetBkColor(DC, $00808080);//���ñ�����ɫ
              ExtTextOut(DC, 0, 0, ETO_OPAQUE, @Rect, nil, 0, nil);
              SetTextColor(DC, clWhite);//����������ɫ
              //DT_SINGLELINE:��֧�ֻ���
              //DT_WORDBREAK:֧�ֻ���
              DrawText(DC, PChar(CurrentMessage), -1, Rect, DT_CENTER or DT_VCENTER or DT_SINGLELINE or DT_NOCLIP);//�������֣����У� 
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
        Result := 1;// ��ֹĬ�ϱ�������
      end;
  else
    Result := DefWindowProc(Wnd, Msg, wParam, lParam);
  end;
end;

procedure RegisterToastWindowClass;
// ע�ᴰ���ࣨ�����״ε���ʱִ�У�
var
  WC: TWndClass;
begin
  if not GetClassInfo(HInstance, ToastWindowClass, WC) then
  begin
    FillChar(WC, SizeOf(WC), 0);// ��ʼ���ṹ��
    WC.style := CS_HREDRAW or CS_VREDRAW;
    WC.lpfnWndProc := @ToastWndProc;
    WC.hInstance := HInstance;
    WC.hCursor := LoadCursor(0, IDC_ARROW);
    WC.lpszClassName := ToastWindowClass;
    Windows.RegisterClass(WC);
  end;
end;

procedure ShowToast(ParentHandle: HWND; const AMessage: string; ADuration: Integer=2000);
//��ʾ Toast
//ParentHandle:���ô�����
//AMessage:��Ҫ��ʾ����Ϣ
//ADuration:��ʾ����ʱ��.Ĭ�ϳ���2��
var
  ParentRect, ToastRect: TRect;
  ParentWidth, ParentHeight: Integer;
  X, Y: Integer;
  ParentFont: HFONT;
  LogFont: TLogFont;
begin
  CurrentMessage := AMessage;// ������Ϣ��ȫ�ֱ���
  RegisterToastWindowClass;// ע�ᴰ���ࣨ�����״ε���ʱִ�У�

  // ������� Toast ���ڣ��ȹرվɵ�
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

  ParentFont := TForm(FindControl(ParentHandle)).Font.Handle;// ��ȡ����������
  if ParentFont <> 0 then
  begin
    // ��ȡ������Ϣ
    GetObject(ParentFont, SizeOf(TLogFont), @LogFont);
    // ���������壨���ڸ��������嵫���Ե�����С��
    //LogFont.lfHeight := -16;//��������߶�Ϊ16����.ע�͸���,��̳и����ڵ������С
    LogFont.lfWeight := FW_BOLD; // ����Ϊ�Ӵ�
    ToastFont := CreateFontIndirect(LogFont);
  end else
  begin
    //δ��ȡ������������ʱ,ʹ��Ĭ������
    //FW_BOLD:�Ӵ� FW_NORMAL:��ͨ
    ToastFont := CreateFont(16, 0, 0, 0, FW_BOLD, 0, 0, 0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY,DEFAULT_PITCH or FF_DONTCARE,'����');
  end;

  // ��ȡ������λ��
  GetWindowRect(ParentHandle, ParentRect);
  ParentWidth := ParentRect.Right - ParentRect.Left;
  ParentHeight := ParentRect.Bottom - ParentRect.Top;

  // Toast���ڳߴ�
  ToastRect.Left := 0;
  ToastRect.Top := 0;
  ToastRect.Right := 400;//���ڿ��
  ToastRect.Bottom := 40;//���ڸ߶�

  // ����Toast����λ�ã�����ڸ����ڣ�
  X := ParentRect.Left + (ParentWidth - (ToastRect.Right - ToastRect.Left)) div 2;//ˮƽ����
  Y := ParentRect.Top + (ParentHeight - (ToastRect.Bottom - ToastRect.Top)) div 2;//��ֱ����
  //Y := ParentRect.Bottom - (ToastRect.Bottom - ToastRect.Top) - 10;  // �ײ���10���ر߾�
  
  // ��������
  //WS_EX_TOPMOST:������ʾ�����ϲ�
  //WS_EX_LAYERED:��չ������ʽ
  ToastWnd := CreateWindowEx(
    WS_EX_TOPMOST or WS_EX_LAYERED or WS_EX_TOOLWINDOW,
    ToastWindowClass,
    'Toast',
    WS_POPUP or WS_VISIBLE,
    X, Y,
    ToastRect.Right - ToastRect.Left,
    ToastRect.Bottom - ToastRect.Top,
    ParentHandle, 0, HInstance, nil);

  SetLayeredWindowAttributes(ToastWnd, 0, 220, LWA_ALPHA);//���ð�͸��Ч����Alpha ��ϣ�.220=͸���ȣ�0-255��
  ToastTimerID := SetTimer(ToastWnd, 1, ADuration, nil);// ���ö�ʱ���Զ��ر�
  UpdateWindow(ToastWnd);
  RedrawWindow(ToastWnd, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
end;

initialization
  ToastFont := 0;

finalization
  if ToastFont <> 0 then DeleteObject(ToastFont);

end.

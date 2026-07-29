unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Generics.Collections,
  Vcl.StdCtrls, Vcl.ComCtrls, System.Types, Vcl.Buttons, Vcl.Menus, Vcl.ExtDlgs, System.Generics.Collections,
  Winapi.GDIPOBJ, Winapi.GDIPAPI, Winapi.GDIPUTIL, Vcl.Imaging.pngimage, System.IOUtils, Vcl.Themes, System.UITypes; // ИСПРАВЛЕНО: Добавлен Winapi.GDIPUTIL

const
  crPipette = 5;

type
TLayer = class
    Bitmap: TBitmap;    // Холст слоя
    Visible: Boolean;   // Видим ли слой
    Opacity: Byte;      // Прозрачность (0-255)
    Name: string;       // Имя слоя (для интерфейса)
    constructor Create(Width, Height: Integer);
    destructor Destroy; override;
    end;
    TBrushType = (btPencil, btPen, btEraser, btBucket);
    TFormToCanvas = class(TForm)
    CanvasPanel: TPanel;
    Image1: TImage;
    ColorDialog1: TColorDialog;
    PanelSetting: TPanel;
    ColorSettingsPanel: TPanel;
    shCurrentColor: TShape;
    BrushSettingPanel: TPanel;
    PenWidth: TTrackBar;
    LabelMin: TLabel;
    LabelMax: TLabel;
    PenWidthEdit: TEdit;
    ButtonPencil: TSpeedButton;
    ButtonPen: TSpeedButton;
    ButtonEraser: TSpeedButton;
    shWidthPreview: TShape;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape7: TShape;
    Shape6: TShape;
    Shape5: TShape;
    Shape8: TShape;
    Shape15: TShape;
    Shape14: TShape;
    Shape11: TShape;
    Shape10: TShape;
    Shape9: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    BitBtn1: TBitBtn;
    MainMenu1: TMainMenu;
    FileSetting: TMenuItem;
    CreateFile: TMenuItem;
    OpenFile: TMenuItem;
    SaveFile: TMenuItem;
    SaveAsFile: TMenuItem;
    nnn: TMenuItem;
    OpenDialog: TOpenPictureDialog;
    SaveDialog: TSavePictureDialog;
    ExitFile: TMenuItem;
    PanelForInD: TPanel;
    LayersListBox: TListBox;
    PanelLayersSetting: TPanel;
    AddLayer: TSpeedButton;
    ButtonBucket: TSpeedButton;
    DeleteLayer: TSpeedButton;
    Help: TMenuItem;
    ResetCanvas: TMenuItem;
    BtnClearLayer: TSpeedButton;
    TrackBarOpacity: TTrackBar;
    PerformRedoButton: TSpeedButton;
    PerformUndoButton: TSpeedButton;
    IntrumentIND: TLabel;
    lblWidthDisplay: TLabel;
    BtnToggleBackground: TSpeedButton;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure SetZoom(NewScale: Double);
    procedure btnZoomOutClick(Sender: TObject);
    procedure btnZoomInClick(Sender: TObject);
    procedure btnResetZoomClick(Sender: TObject);
    procedure FitToScreen;
    procedure SelectColor;
    procedure shCurrentColorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PenWidthChange(Sender: TObject);
    procedure PenWidthEditChange(Sender: TObject);
    procedure BrushButtonClick(Sender: TObject);
    procedure AddColorToHistory(NewColor: TColor);
    procedure HistoryColorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CreateFileClick(Sender: TObject);
    procedure OpenFileClick(Sender: TObject);
    procedure SaveAsFileClick(Sender: TObject);
    procedure SaveFileClick(Sender: TObject);
    procedure ExitFileClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CreateNewLayer(const ALayerName: string);
    procedure AddLayerClick(Sender: TObject);
    procedure DeleteLayerClick(Sender: TObject);
    procedure ButtonBucketClick(Sender: TObject);
    procedure ResetCanvasClick(Sender: TObject);
    procedure LayersListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure LayersListBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TrackBarOpacityChange(Sender: TObject);
    procedure LayersListBoxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LayersListBoxDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LayersListBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BtnClearLayerClick(Sender: TObject);
    procedure BtnToggleBackgroundClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure PerformUndoButtonClick(Sender: TObject);
    procedure PerformRedoButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PenWidthEditKeyPress(Sender: TObject; var Key: Char);
    procedure PenWidthEditExit(Sender: TObject);

    private
    { Private declarations }
    HelpFrame: TFrame;
    FPipetteImg: TPngImage; // Держим картинку пипетки всегда под рукой в памяти
    FCacheBitmap: TBitmap; // Буфер для кэширования нижних слоев
    ColorHistory: array[1..18] of TColor;
    FIsDrawing: Boolean;
    FFrameCounter: Integer; // Счетчик кадров для оптимизации рендера
    FShowWhiteBackground: Boolean; // True - белый фон, False - клеточки
    FInterfaceColor: TColor; // Сюда мы запишем реальный цвет панели
    procedure UpdateHistoryUI; // Процедура для обновления цвета в фигурах

  protected
    { Добавьте эту секцию кода }
    procedure CreateParams(var Params: TCreateParams); override;

  public
    { Public declarations }
    Scale: Double; // Теперь переменная стала публичным полем класса формы
    CurrentFilePath: string; // Будет хранить полный путь к открытому/сохраненному файлу
    CurrentBrush: TBrushType;
    SelectedColor: TColor;
    FLastX, FLastY: Integer;


    // Переменные и списки слоев (теперь открыты для другой формы)
    UndoList: TObjectList<TBitmap>;
    RedoList: TObjectList<TBitmap>;
    Layers: TObjectList<TLayer>;
    ActiveLayerIndex: Integer;

    // Методы управления слоями и историей (теперь доступны снаружи)
    procedure RenderLayers;      // Сборка всех слоев в один вывод
    procedure UpdateLayersUI;    // Обновление списка слоев на экране
    procedure PerformUndo;       // Метод для отмены последнего действия
    procedure PerformRedo;       // Метод для повтора отмененного действия
    procedure FixLayerAlpha(ABitmap: TBitmap; CX, CY, BrushWidth: Integer);
    procedure LayerFloodFill(ABitmap: TBitmap; X, Y: Integer; FillColor: TColor);
    procedure CreateNewCanvas(W, H: Integer);
    procedure CenterCanvas; // Добавьте сюда

  end;

var
  FormToCanvas: TFormToCanvas;
  IsDragging: Boolean;
  StartX, StartY: Integer;
  OldMousePos: TPoint;

implementation

uses Unit2, Unit1, UnitCanvasHelp;

{$R *.dfm}

procedure TFormToCanvas.LayerFloodFill(ABitmap: TBitmap; X, Y: Integer; FillColor: TColor);
type
  TRGBQuadArray = array[0..32767] of RGBQuad;
  PRGBQuadArray = ^TRGBQuadArray;
var
  TargetQuad, FillQuad: RGBQuad;
  // Сверхбыстрая очередь на фиксированном массиве (размер равен числу пикселей холста)
  QueueX, QueueY: array of Integer;
  Head, Tail: Integer;
  MaxPixels: Integer;

  function MatchColor(P: PRGBQuad): Boolean;
  begin
    Result := (P^.rgbRed = TargetQuad.rgbRed) and
              (P^.rgbGreen = TargetQuad.rgbGreen) and
              (P^.rgbBlue = TargetQuad.rgbBlue) and
              (P^.rgbReserved = TargetQuad.rgbReserved);
  end;

var
  CurX, CurY: Integer;
  L, R, i: Integer;
  Row, RowUp, RowDown: PRGBQuadArray;
  SpanUp, SpanDown: Boolean;
begin
  if (X < 0) or (X >= ABitmap.Width) or (Y < 0) or (Y >= ABitmap.Height) then Exit;

  // 1. Формируем цвет заливки
  FillQuad.rgbRed := GetRValue(FillColor);
  FillQuad.rgbGreen := GetGValue(FillColor);
  FillQuad.rgbBlue := GetBValue(FillColor);
  FillQuad.rgbReserved := 255;

  // 2. Считываем исходный цвет пикселя в точке клика
  Row := PRGBQuadArray(ABitmap.ScanLine[Y]);
  TargetQuad := Row[X];

  // Защита: если цвет клика уже равен цвету заливки — мгновенно выходим
  if (TargetQuad.rgbRed = FillQuad.rgbRed) and
     (TargetQuad.rgbGreen = FillQuad.rgbGreen) and
     (TargetQuad.rgbBlue = FillQuad.rgbBlue) and
     (TargetQuad.rgbReserved = FillQuad.rgbReserved) then Exit;

  // 3. Выделяем память под очередь один раз (без постоянных SetLength)
  MaxPixels := ABitmap.Width * ABitmap.Height;
  SetLength(QueueX, MaxPixels);
  SetLength(QueueY, MaxPixels);

  Head := 0;
  Tail := 0;

  // Кладем первую точку в очередь
  QueueX[Tail] := X;
  QueueY[Tail] := Y;
  Inc(Tail);

  // Основной цикл заливки
  while Head < Tail do
  begin
    CurX := QueueX[Head];
    CurY := QueueY[Head];
    Inc(Head);

    Row := PRGBQuadArray(ABitmap.ScanLine[CurY]);

    // Если текущий пиксель уже перекрашен другим потоком очереди, пропускаем его
    if not MatchColor(@Row[CurX]) then Continue;

    // Сдвигаемся максимально влево по строке
    L := CurX;
    while (L >= 0) and MatchColor(@Row[L]) do
    begin
      Row[L] := FillQuad;
      Dec(L);
    end;
    Inc(L);

    // Сдвигаемся максимально вправо по строке
    R := CurX + 1;
    while (R < ABitmap.Width) and MatchColor(@Row[R]) do
    begin
      Row[R] := FillQuad;
      Inc(R);
    end;
    Dec(R);

    // Подготавливаем указатели строк выше и ниже (если они существуют)
    RowUp := nil;
    RowDown := nil;
    if CurY > 0 then RowUp := PRGBQuadArray(ABitmap.ScanLine[CurY - 1]);
    if CurY < ABitmap.Height - 1 then RowDown := PRGBQuadArray(ABitmap.ScanLine[CurY + 1]);

    SpanUp := False;
    SpanDown := False;

    // Сканируем сегмент слева направо и добавляем новые "семена" в очередь
    for i := L to R do
    begin
      if (RowUp <> nil) then
      begin
        if (not SpanUp) and MatchColor(@RowUp[i]) then
        begin
          QueueX[Tail] := i;
          QueueY[Tail] := CurY - 1;
          Inc(Tail);
          SpanUp := True;
        end
        else if SpanUp and (not MatchColor(@RowUp[i])) then
          SpanUp := False;
      end;

      if (RowDown <> nil) then
      begin
        if (not SpanDown) and MatchColor(@RowDown[i]) then
        begin
          QueueX[Tail] := i;
          QueueY[Tail] := CurY + 1;
          Inc(Tail);
          SpanDown := True;
        end
        else if SpanDown and (not MatchColor(@RowDown[i])) then
          SpanDown := False;
      end;
    end;
  end;

  // Освобождаем массивы очереди из памяти
  QueueX := nil;
  QueueY := nil;
end;

procedure TFormToCanvas.RenderLayers;
var
  i: Integer;
  BlendFunc: TBlendFunction;
  DestCanvas: TCanvas;
  ImageWidth, ImageHeight: Integer;
  StartFrom: Integer;
  X, Y: Integer;
  P: PRGBQuad;
begin
  if (Layers = nil) or (Layers.Count = 0) then Exit;
  if (Image1.Picture.Bitmap = nil) then Exit;

  ImageWidth := Image1.Picture.Bitmap.Width;
  ImageHeight := Image1.Picture.Bitmap.Height;
  DestCanvas := Image1.Picture.Bitmap.Canvas;

  BlendFunc.BlendOp := AC_SRC_OVER;
  BlendFunc.BlendFlags := 0;
  BlendFunc.AlphaFormat := AC_SRC_ALPHA;

  // 1. ОТРИСОВКА БАЗОВОЙ ПОДЛОЖКИ ХОЛСТА
  if FIsDrawing and (FCacheBitmap <> nil) and (not FCacheBitmap.Empty) then
  begin
    BitBlt(DestCanvas.Handle, 0, 0, ImageWidth, ImageHeight, FCacheBitmap.Canvas.Handle, 0, 0, SRCCOPY);

    if (ActiveLayerIndex >= 0) and (ActiveLayerIndex < Layers.Count) then
      StartFrom := ActiveLayerIndex
    else
      StartFrom := 0;
  end
  else
  begin
    StartFrom := 0;

    if FShowWhiteBackground then
    begin
      // Если белый лист включен — заливаем подложку холста Image1 белым
      DestCanvas.Brush.Color := clWhite;
      DestCanvas.Brush.Style := bsSolid;
      DestCanvas.FillRect(Rect(0, 0, ImageWidth, ImageHeight));
    end
    else
    begin
      // Если белый лист скрыт — делаем холст Image1 кристально прозрачным,
      // чтобы сквозь него была видна сетка формы, открывшаяся под CanvasPanel!
      Image1.Picture.Bitmap.Canvas.Lock;
      try
        for Y := 0 to ImageHeight - 1 do
        begin
          P := Image1.Picture.Bitmap.ScanLine[Y];
          for X := 0 to ImageWidth - 1 do
          begin
            P^.rgbReserved := 0; // Alpha = 0 (Прозрачно)
            P^.rgbBlue     := 0;
            P^.rgbGreen    := 0;
            P^.rgbRed      := 0;
            Inc(P);
          end;
        end;
      finally
        Image1.Picture.Bitmap.Canvas.Unlock;
      end;
    end;
  end;

  // 2. СБОРКА СЦЕНЫ: Накладываем все слои рисунка (сердце) поверх
  for i := StartFrom to Layers.Count - 1 do
  begin
    if (i >= 0) and (i < Layers.Count) then
    begin
      if (Layers[i] <> nil) and (Layers[i].Visible) and (Layers[i].Bitmap <> nil) then
      begin
        BlendFunc.SourceConstantAlpha := Layers[i].Opacity;
        Winapi.Windows.AlphaBlend(
          DestCanvas.Handle, 0, 0, ImageWidth, ImageHeight,
          Layers[i].Bitmap.Canvas.Handle, 0, 0, Layers[i].Bitmap.Width, Layers[i].Bitmap.Height,
          BlendFunc
        );
      end;
    end;
  end;

  Image1.Invalidate;
end;

procedure TFormToCanvas.ResetCanvasClick(Sender: TObject);
var
  CleanLayer: TLayer;
  Backup: TBitmap;
  W, H: Integer;
begin
  // 1. Проверяем, есть ли вообще открытый холст (проверка по слоям)
  if (Layers = nil) or (Layers.Count = 0) then
  begin
    ShowMessage('Нет активного изображения для сброса!');
    Exit;
  end;

  // Запрашиваем подтверждение у пользователя, чтобы он не сбросил работу случайно
  if MessageDlg('Вы уверены, что хотите сбросить текущее изображение до чистого листа? Все несохраненные слои будут удалены.',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  // 2. Запоминаем текущие размеры холста из главного Image1
  W := Image1.Picture.Bitmap.Width;
  H := Image1.Picture.Bitmap.Height;

  // 3. Полностью очищаем старую систему слоев
  Layers.Clear;

  // 4. Создаем ОДИН новый чистый фоновый слой в тех же размерах
  CleanLayer := TLayer.Create(W, H);
  CleanLayer.Name := 'Фон';
  CleanLayer.Bitmap.PixelFormat := pf32bit;
  CleanLayer.Bitmap.AlphaFormat := afDefined;

  // Заливаем фоновый слой чистым белым цветом
  CleanLayer.Bitmap.Canvas.Brush.Color := clWhite;
  CleanLayer.Bitmap.Canvas.Brush.Style := bsSolid;
  CleanLayer.Bitmap.Canvas.FillRect(Rect(0, 0, W, H));
  CleanLayer.Bitmap.Canvas.MoveTo(0, 0); // Обновляем дескриптор холста

  // Добавляем созданный чистый слой и делаем его активным
  Layers.Add(CleanLayer);
  ActiveLayerIndex := 0;

  // 5. Пересоздаем историю Undo/Redo, чтобы записать туда чистый лист
  // Это позволит пользователю нажать "Отмена" (Ctrl+Z) и вернуть рисунок, если он передумал!
  if UndoList <> nil then UndoList.Free;
  UndoList := TObjectList<TBitmap>.Create(True);

  if RedoList <> nil then RedoList.Free;
  RedoList := TObjectList<TBitmap>.Create(True);

  // Добавляем чистый белый битмап как начальную точку истории отмен
  Backup := TBitmap.Create;
  Backup.Assign(CleanLayer.Bitmap);
  UndoList.Add(Backup);

   // 6. Обновляем визуальный интерфейс (список слоев и сам холст)
  UpdateLayersUI;

  // ПРИНУДИТЕЛЬНОЕ МГНОВЕННОЕ ОБНОВЛЕНИЕ ЭКРАНА:
  // 1. Сбрасываем старый дескриптор битмапа в Image1, чтобы Delphi забыл старую картинку
  Image1.Picture.Bitmap.Handle := 0;
  // 2. Задаем правильный размер для результирующего холста
  Image1.Picture.Bitmap.SetSize(W, H);
  Image1.Picture.Bitmap.PixelFormat := pf32bit;
  Image1.Picture.Bitmap.AlphaFormat := afDefined;

  // 3. Вызываем рендер слоев (он запишет белый цвет чистого слоя в Image1)
  RenderLayers;

  // 4. Жестко приказываем Windows немедленно перерисовать компонент на экране
  Image1.Invalidate;
  Image1.Update;

  ShowMessage('Холст успешно сброшен до чистого листа!');

end;

constructor TLayer.Create(Width, Height: Integer);
var
  P: PRGBQuad;
  X, Y: Integer;
begin
  inherited Create;
  Bitmap := TBitmap.Create;
  Bitmap.PixelFormat := pf32bit;   // 32-битный формат (RGB + Alpha)
  Bitmap.AlphaFormat := afDefined; // Альфа-канал учитывается при отрисовке Windows
  Bitmap.SetSize(Width, Height);

  // Чистая и быстрая физическая очистка памяти: Alpha = 0 (абсолютная прозрачность)
  for Y := 0 to Bitmap.Height - 1 do
  begin
    P := Bitmap.ScanLine[Y];
    for X := 0 to Bitmap.Width - 1 do
    begin
      P^.rgbReserved := 0; // Alpha канал занулен (кристально прозрачно)
      P^.rgbBlue := 0;
      P^.rgbGreen := 0;
      P^.rgbRed := 0;
      Inc(P);
    end;
  end;

  Visible := True;
  Opacity := 255; // Общая непрозрачность слоя по умолчанию максимальна
end;

destructor TLayer.Destroy;
begin
  Bitmap.Free;
  inherited;
end;

procedure TFormToCanvas.AddColorToHistory(NewColor: TColor);
var
  i, FoundIndex: Integer;
begin
  // 1. Ищем, есть ли уже этот цвет где-то в истории
  FoundIndex := 0;
  for i := 1 to 18 do
  begin
    if ColorHistory[i] = NewColor then
    begin
      FoundIndex := i;
      Break;
    end;
  end;

  // 2. Если цвет найден, сдвигаем элементы только до него (вытаскиваем его вперед)
  if FoundIndex > 0 then
  begin
    for i := FoundIndex downto 2 do
    begin
      ColorHistory[i] := ColorHistory[i - 1];
    end;
  end
  else
  begin
    // 3. Если цвет абсолютно новый, сдвигаем всю историю, как у вас и было
    for i := 18 downto 2 do
    begin
      ColorHistory[i] := ColorHistory[i - 1];
    end;
  end;

  // Помещаем цвет на первое место
  ColorHistory[1] := NewColor;

  // Обновляем квадратики палитры на экране
  UpdateHistoryUI;
end;


procedure TFormToCanvas.UpdateHistoryUI;
var
  i: Integer;
  SH: TShape;
begin
  for i := 1 to 18 do
  begin
    // Ищем компонент по имени Shape1, Shape2 и т.д.
    SH := TShape(FindComponent('Shape' + IntToStr(i)));
    if Assigned(SH) then
    begin
      SH.Brush.Color := ColorHistory[i];
      // Принудительно заставляем Windows мгновенно перерисовать квадратик
      SH.Refresh;
    end;
  end;
end;

procedure TFormToCanvas.UpdateLayersUI;
var
  i: Integer;
begin
  LayersListBox.Items.BeginUpdate;
  try
    LayersListBox.Items.Clear;
    // Заполняем список сверху вниз (от верхних слоев к нижним)
    for i := Layers.Count - 1 downto 0 do
    begin
      // ИСПРАВЛЕНО: передаем и имя, и сам объект слоя для связи с OnDrawItem
      LayersListBox.Items.AddObject(Layers[i].Name, Layers[i]);
    end;

    // Подсвечиваем активный слой в списке
    // Индексы инвертированы, так как в ListBox верхний слой идет первым
    if (ActiveLayerIndex >= 0) and (ActiveLayerIndex < Layers.Count) then
      LayersListBox.ItemIndex := (Layers.Count - 1) - ActiveLayerIndex;
  finally
    LayersListBox.Items.EndUpdate;
  end;
end;

procedure TFormToCanvas.FitToScreen;
var
  RatioW, RatioH: Double;
begin
  if (Image1.Picture.Bitmap.Width = 0) or (Image1.Picture.Bitmap.Height = 0) then Exit;

  // 1. Рассчитываем масштаб
  RatioW := (Self.ClientWidth - 60) / Image1.Picture.Bitmap.Width;
  RatioH := (Self.ClientHeight - 60) / Image1.Picture.Bitmap.Height;

  if RatioW < RatioH then
    SetZoom(RatioW)
  else
    SetZoom(RatioH);

  // 2. Центрируем панель (именно это делает кнопка)
  CanvasPanel.Left := (Self.ClientWidth - CanvasPanel.Width) div 2;
  CanvasPanel.Top := (Self.ClientHeight - CanvasPanel.Height) div 2;

  // 3. Защита от ухода за края
  if CanvasPanel.Left < 0 then CanvasPanel.Left := 0;
  if CanvasPanel.Top < 0 then CanvasPanel.Top := 0;
end;

procedure TFormToCanvas.SetZoom(NewScale: Double);
var
  MousePos: TPoint;
  LocalMouseX, LocalMouseY: Integer;
  PixelX, PixelY: Double;
begin
  // 1. ПОДГОТОВКА: Получаем глобальные координаты мыши в системе Windows
  MousePos := Mouse.CursorPos;

  // Переводим их в локальные координаты относительно нашей CanvasPanel
  MousePos := CanvasPanel.ScreenToClient(MousePos);
  LocalMouseX := MousePos.X;
  LocalMouseY := MousePos.Y;

  // Если мышь находится в пределах видимого холста — рассчитываем пиксель-прицел
  if (LocalMouseX >= 0) and (LocalMouseX <= CanvasPanel.Width) and
     (LocalMouseY >= 0) and (LocalMouseY <= CanvasPanel.Height) and (Scale > 0) then
  begin
    PixelX := LocalMouseX / Scale;
    PixelY := LocalMouseY / Scale;
  end
  else
  begin
    // Если мышь за пределами холста — берем за точку прицела центр панели
    PixelX := (CanvasPanel.Width / Scale) / 2;
    PixelY := (CanvasPanel.Height / Scale) / 2;
  end;

  // 2. Устанавливаем и ограничиваем новый масштаб
  if NewScale < 0.1 then Scale := 0.1
  else if NewScale > 10.0 then Scale := 10.0
  else Scale := NewScale;

  // КРИТИЧЕСКОЕ ИСПРАВЛЕНИЕ (ЗАМОРОЗКА ОКНА):
  // Посылаем сигнал Windows: "Временно отключить перерисовку CanvasPanel и родительской формы".
  // Это полностью заблокирует мерцание, дёрганье и появление белых шлейфов во время изменения размеров!
  SendMessage(CanvasPanel.Handle, WM_SETREDRAW, 0, 0);
  SendMessage(Self.Handle, WM_SETREDRAW, 0, 0);
  try
    Image1.Stretch := True;
    Image1.Proportional := False;

    // 3. Задаем новые физические размеры панели и холста на экране
    CanvasPanel.Width := Round(Image1.Picture.Bitmap.Width * Scale);
    CanvasPanel.Height := Round(Image1.Picture.Bitmap.Height * Scale);

    Image1.Width := CanvasPanel.Width;
    Image1.Height := CanvasPanel.Height;

    // 4. Сдвигаем панель точно под курсор мыши
    MousePos := Mouse.CursorPos;
    MousePos := CanvasPanel.Parent.ScreenToClient(MousePos);

    CanvasPanel.Left := MousePos.X - Round(PixelX * Scale);
    CanvasPanel.Top := MousePos.Y - Round(PixelY * Scale);

    // 5. Перерисовываем холст под новый масштаб в памяти
    RenderLayers;
  finally
    // РАЗМОРОЗКА ОКНА: Сразу после изменения размеров возвращаем отрисовку обратно
    SendMessage(CanvasPanel.Handle, WM_SETREDRAW, 1, 0);
    SendMessage(Self.Handle, WM_SETREDRAW, 1, 0);

    // ИСПРАВЛЕНО: Вызываем глобальную функцию WinAPI, передавая туда Handle объектов
    Winapi.Windows.RedrawWindow(CanvasPanel.Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW or RDW_ALLCHILDREN);
    Winapi.Windows.RedrawWindow(Self.Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW or RDW_ALLCHILDREN);
  end;
end;

procedure TFormToCanvas.HelpClick(Sender: TObject);
begin
  if not Assigned(HelpFrame) then
  begin
    // 1. Создаем фрейм справки
    HelpFrame := TFrameHelpCanvas.Create(Self);
    HelpFrame.Parent := Self;

    // 2. Настраиваем его положение на форме
    HelpFrame.Left := (Self.ClientWidth - HelpFrame.Width) div 2;
    HelpFrame.Top := (Self.ClientHeight - HelpFrame.Height) div 2;
    HelpFrame.Align := alNone;
  end;

  // 4. Показываем фрейм на переднем плане
  HelpFrame.Visible := True;
  HelpFrame.BringToFront;
end;

procedure TFormToCanvas.HistoryColorMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
 begin
  // Берем цвет из квадратика, на который нажали
  SelectedColor := (Sender as TShape).Brush.Color;

  // Обновляем основной индикатор цвета
  shCurrentColor.Brush.Color := SelectedColor;
 end;

 procedure TFormToCanvas.shCurrentColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Открываем диалог выбора цвета
  if ColorDialog1.Execute then
  begin
    // 1. Сохраняем выбранный цвет в переменную
    SelectedColor := ColorDialog1.Color;

    // 2. Устанавливаем для рисования
    Image1.Picture.Bitmap.Canvas.Pen.Color := ColorDialog1.Color;
    Image1.Picture.Bitmap.Canvas.Brush.Color := ColorDialog1.Color;

    // 3. Красим сам основной шейп (ЗАМЕНИТЕ Shape1 на ваше имя компонента!)
    shCurrentColor.Brush.Color := ColorDialog1.Color;

    // Добавляем новый цвет в историю палитры
    AddColorToHistory(SelectedColor);
  end;
end;

procedure TFormToCanvas.TrackBarOpacityChange(Sender: TObject);
begin
  if (Layers = nil) or (ActiveLayerIndex < 0) or (ActiveLayerIndex >= Layers.Count) then
    Exit;

  // ЗАЩИТА: Если значение уже такое же, не насилуем Canvas и AlphaBlend
  if Layers[ActiveLayerIndex].Opacity = TrackBarOpacity.Position then
    Exit;

  Layers[ActiveLayerIndex].Opacity := TrackBarOpacity.Position;

  // Мягко обновляем список
  LayersListBox.Invalidate;

  // Перерисовываем проект
  RenderLayers;
end;

procedure TFormToCanvas.PenWidthChange(Sender: TObject);
begin
  shWidthPreview.Visible:= true;
  // Устанавливаем толщину пера для битмапа
  Image1.Picture.Bitmap.Canvas.Pen.Width := PenWidth.Position;

  // Дополнительно: выводим текущее число в Label, если он есть
  PenWidthEdit.Text  := IntToStr(PenWidth.Position);
  lblWidthDisplay.Caption := 'Толщина: ' + IntToStr(PenWidth.Position) + ' px';
  //
  shWidthPreview.Width := PenWidth.Position + 2;
  shWidthPreview.Height := PenWidth.Position + 2;
end;

procedure TFormToCanvas.PenWidthEditChange(Sender: TObject);
var
  NewWidth: Integer;
begin
  NewWidth := 1;
  // Если поле пустое, временно выходим (даем пользователю ввести цифру)
  if PenWidthEdit.Text = '' then
    Exit;

  // Переводим текст в число. Если введены буквы — сбросит на 1
  NewWidth := StrToIntDef(PenWidthEdit.Text, 1);

  // 1. Блокировка значений меньше 1
  if NewWidth < 1 then
  begin
    PenWidthEdit.Text := '1';
    PenWidthEdit.SelectAll;
    NewWidth := 1;
  end;

  // 2. Блокировка значений выше 50
  if NewWidth > 50 then
  begin
    PenWidthEdit.Text := '50';
    PenWidthEdit.SelectAll;
    NewWidth := 50;
  end;

  // Синхронизируем положение ползунка
  PenWidth.Position := NewWidth;
end;

procedure TFormToCanvas.PenWidthEditExit(Sender: TObject);
begin
  if PenWidthEdit.Text = '' then
  begin
    PenWidthEdit.Text := '1';
    PenWidth.Position := 1;
  end;
end;

procedure TFormToCanvas.PenWidthEditKeyPress(Sender: TObject; var Key: Char);
begin
// СТАЛО (современный вариант без варнингов):
if not CharInSet(Key, ['0'..'9', #8]) then Key := #0;
    Key := #0;

  // Если поле пустое или текст полностью выделен, запрещаем вводить ноль первой цифрой
  if (Key = '0') and ((PenWidthEdit.Text = '') or (PenWidthEdit.SelLength = Length(PenWidthEdit.Text))) then
    Key := #0; // Аннулируем нажатие клавиши
end;

procedure TFormToCanvas.SelectColor;
begin
  // cdFullOpen в настройках ColorDialog1 позволит сразу видеть всю палитру
  if ColorDialog1.Execute then
  begin
    // Назначаем цвет холсту (и перу, и заливке для точек)
    Image1.Picture.Bitmap.Canvas.Pen.Color := ColorDialog1.Color;
    Image1.Picture.Bitmap.Canvas.Brush.Color := ColorDialog1.Color;

    // Обновляем индикатор на панели
    shCurrentColor.Brush.Color := ColorDialog1.Color;
  end;
end;

procedure TFormToCanvas.btnZoomOutClick(Sender: TObject);
begin
  SetZoom(Scale - 0.1); // Отдалить на 10%
end;

procedure TFormToCanvas.ButtonBucketClick(Sender: TObject);
begin
CurrentBrush := btBucket; // Включаем режим заливки
IntrumentIND.Caption := 'Выбранный инструмент: Ведро';
end;

procedure TFormToCanvas.AddLayerClick(Sender: TObject);
var
  NewLayer: TLayer;
  W, H: Integer;
  InsertIndex: Integer;
begin
  if (Layers = nil) or (Layers.Count = 0) then Exit;

  W := Layers[0].Bitmap.Width;
  H := Layers[0].Bitmap.Height;

  // Создаем слой — он автоматически станет прозрачным внутри конструктора
  NewLayer := TLayer.Create(W, H);
  NewLayer.Name := 'Слой ' + IntToStr(Layers.Count + 1);

  if (ActiveLayerIndex >= 0) and (ActiveLayerIndex < Layers.Count) then
    InsertIndex := ActiveLayerIndex + 1
  else
    InsertIndex := Layers.Count;

  Layers.Insert(InsertIndex, NewLayer);
  ActiveLayerIndex := InsertIndex;

  UpdateLayersUI;
  RenderLayers;
end;

procedure TFormToCanvas.DeleteLayerClick(Sender: TObject);
begin
  // 1. Проверка безопасности границ
  if (Layers = nil) or (Layers.Count <= 1) then Exit;
  if (ActiveLayerIndex < 0) or (ActiveLayerIndex >= Layers.Count) then Exit;

  // 2. Сначала очищаем визуальный TListBox, чтобы он забыл старые указатели
  LayersListBox.Items.BeginUpdate;
  try
    LayersListBox.Items.Clear;
  finally
    LayersListBox.Items.EndUpdate;
  end;

  // 3. Удаляем из списка в памяти.
  // Если это TObjectList, он автоматически выполнит Free для этого слоя.
  Layers.Delete(ActiveLayerIndex);

  // 4. Корректируем индекс активного слоя
  if ActiveLayerIndex >= Layers.Count then
    ActiveLayerIndex := Layers.Count - 1;

  // 5. Заново строим UI по актуальным данным из памяти
  UpdateLayersUI;

  // 6. Перерисовываем холст
  RenderLayers;
end;

procedure TFormToCanvas.BrushButtonClick(Sender: TObject);
begin
  // Обязательно проверяем, что Sender — это действительно кнопка TSpeedButton
  if Sender is TSpeedButton then
  begin
    case TSpeedButton(Sender).Tag of
      0: begin
           CurrentBrush := btPencil;
           shWidthPreview.Shape := stRectangle;
           shWidthPreview.Visible := True; // Показываем превью размера
           IntrumentIND.Caption := 'Выбранный инструмент: Карандаш';
         end;

      1: begin
           CurrentBrush := btPen;
           shWidthPreview.Shape := stEllipse;
           shWidthPreview.Visible := True; // Показываем превью размера
           IntrumentIND.Caption := 'Выбранный инструмент: Ручка';
         end;

      2: begin
           CurrentBrush := btEraser;
           shWidthPreview.Shape := stEllipse;
           shWidthPreview.Visible := True; // Показываем превью размера
           IntrumentIND.Caption := 'Выбранный инструмент: Ластик';
         end;

      3: begin
           // ИСПРАВЛЕНО: Ветка для инструмента "Заливка" (Ведро)
           CurrentBrush := btBucket;
           shWidthPreview.Visible := False; // Прячем превью, так как размер заливки не важен
           IntrumentIND.Caption := 'Выбранный инструмент: Ведро';
         end;
    end;

    // Условие активности ползунка толщины (скрываем или блокируем его для ведра)
    PenWidth.Enabled := (CurrentBrush <> btBucket);
  end;
end;

procedure TFormToCanvas.BtnClearLayerClick(Sender: TObject);
var
  ActiveBitmap: TBitmap;
  P: PRGBQuad;
  X, Y: Integer;
  Backup: TBitmap;
begin
  // 1. Проверка безопасности: есть ли вообще слои и выбран ли активный
  if (Layers = nil) or (ActiveLayerIndex < 0) or (ActiveLayerIndex >= Layers.Count) then
    Exit;

  ActiveBitmap := Layers[ActiveLayerIndex].Bitmap;
  if ActiveBitmap = nil then Exit;

  // === ИНТЕГРАЦИЯ С ИСТОРИЕЙ (UNDO) ===
  // Перед очисткой сохраняем текущее состояние слоя в историю,
  // чтобы пользователь мог отменить это действие (Ctrl+Z), если нажал случайно
  if RedoList <> nil then RedoList.Clear;
  if UndoList = nil then UndoList := TObjectList<TBitmap>.Create(True);

  Backup := TBitmap.Create;
  Backup.PixelFormat := ActiveBitmap.PixelFormat;
  Backup.AlphaFormat := ActiveBitmap.AlphaFormat;
  Backup.SetSize(ActiveBitmap.Width, ActiveBitmap.Height);

  BitBlt(Backup.Canvas.Handle, 0, 0, Backup.Width, Backup.Height,
         ActiveBitmap.Canvas.Handle, 0, 0, SRCCOPY);
  UndoList.Add(Backup);
  // ===================================

  // 2. Очистка слоя в абсолютную прозрачность через ScanLine
  // (Для фона rgbReserved := 0 тоже сработает отлично, так как в RenderLayers под ними всегда белый холст)
  ActiveBitmap.Canvas.Lock; // Блокируем холст для безопасного прямого доступа к памяти
  try
    for Y := 0 to ActiveBitmap.Height - 1 do
    begin
      P := ActiveBitmap.ScanLine[Y];
      for X := 0 to ActiveBitmap.Width - 1 do
      begin
        P^.rgbReserved := 0; // Полная прозрачность (Alpha = 0)
        P^.rgbBlue := 0;
        P^.rgbGreen := 0;
        P^.rgbRed := 0;
        Inc(P);
      end;
    end;
  finally
    ActiveBitmap.Canvas.Unlock;
  end;

  // 3. ОБНОВЛЕНИЕ ЭКРАНА
  RenderLayers;             // Перерисовываем главный холст (очищенный слой исчезнет)
  LayersListBox.Invalidate; // Мгновенно обновляем миниатюру этого слоя в списке справа (она станет пустой)
end;

procedure TFormToCanvas.btnResetZoomClick(Sender: TObject);
begin
  // 1. Возвращаем холст в видимую область (вписываем в экран)
  // Мы используем уже созданный метод FitToScreen
  FitToScreen;

  // 2. Дополнительно гарантируем, что панель встала ровно по центру
  // (на случай, если FitToScreen оставил отступы)
  CanvasPanel.Left := (Self.ClientWidth - CanvasPanel.Width) div 2;
  CanvasPanel.Top := (Self.ClientHeight - CanvasPanel.Height) div 2;

  // 3. Если панель всё равно больше экрана (очень маленькое окно),
  // прижимаем к верхнему левому углу
  if CanvasPanel.Left < 0 then CanvasPanel.Left := 0;
  if CanvasPanel.Top < 0 then CanvasPanel.Top := 0;

  // 4. Обновляем экран
  Self.Invalidate;
end;

procedure TFormToCanvas.BtnToggleBackgroundClick(Sender: TObject);
begin
  // 1. Проверка безопасности: есть ли вообще слои
  if (Layers = nil) or (Layers.Count = 0) then Exit;

  // 2. Инвертируем флаг отображения белого листа
  FShowWhiteBackground := not FShowWhiteBackground;

  // 3. Меняем надпись на кнопке
  if FShowWhiteBackground then
    BtnToggleBackground.Caption := '⬜ Белый фон'
  else
    BtnToggleBackground.Caption := '❌ Скрыть фон';

  // 4. === УПОМИНАНИЕ И УПРАВЛЕНИЕ ОБЪЕКТОМ "CanvasPanel" ===
  if FShowWhiteBackground then
  begin
    // Режим 1: Возвращаем плотный белый лист бумаги
    CanvasPanel.ParentBackground := False;
    CanvasPanel.Color := clWhite;
  end
  else
  begin
    // Режим 2: ИДЕЯ ПОЛЬЗОВАТЕЛЯ (Убираем цвет у белой панели)
    // Разрешаем панели стать прозрачной и пропустить сквозь себя клеточки формы!
    CanvasPanel.ParentBackground := True;
  end;
  // ========================================================

  // 5. Полностью сбрасываем кэш штрихов рисования
  if FCacheBitmap <> nil then
  begin
    FCacheBitmap.Free;
    FCacheBitmap := TBitmap.Create;
  end;

  // 6. Перерисовываем слои рисунка в памяти
  RenderLayers;

  // 7. Принудительно обновляем интерфейс, чтобы Windows проявила сетку формы
  CanvasPanel.Refresh;
  Image1.Repaint;
end;



procedure TFormToCanvas.btnZoomInClick(Sender: TObject);
begin
  SetZoom(Scale + 0.1); // Приблизить на 10%
end;

procedure TFormToCanvas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // 1. Показываем кнопку приложения на панели задач
  ShowWindow(Application.Handle, SW_SHOW);

  // 2. Показываем само меню
  MainMenu.Show;

  // 3. ПРИНУДИТЕЛЬНЫЙ ВЫВОД НА ПЕРЕДНИЙ ПЛАН
  // Переводим фокус и выводим поверх всех окон
  SetForegroundWindow(MainMenu.Handle);

  // 4. Дополнительно убираем минимизацию, если она была
  MainMenu.WindowState := wsNormal;
end;

procedure TFormToCanvas.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  FormDlg: TForm;
  DialogResult: Integer;
begin
  // Создаем форму диалога динамически
  FormDlg := CreateMessageDialog('Вы хотите сохранить текущий рисунок перед выходом?', mtConfirmation, [mbYes, mbNo, mbCancel]);
  try
    // Принудительно меняем текст на кнопках
    TButton(FormDlg.FindComponent('Yes')).Caption := 'Да';
    TButton(FormDlg.FindComponent('No')).Caption := 'Нет';
    TButton(FormDlg.FindComponent('Cancel')).Caption := 'Отмена';

    // Задаем заголовок самого окна
    FormDlg.Caption := 'Выход';

    // Показываем окно и получаем результат
    DialogResult := FormDlg.ShowModal;
  finally
    FormDlg.Free; // Освобождаем память
  end;

  case DialogResult of
    mrYes:
      begin
        SaveAsFileClick(Sender);
        CanClose := True;
      end;

    mrNo:
      begin
        CanClose := True;
      end;

    mrCancel:
      begin
        CanClose := False;
      end;
  end;
end;

procedure TFormToCanvas.FormCreate(Sender: TObject);
var
  i: integer;
  BackgroundLayer: TLayer;
  InitialBackup: TBitmap;
  hSysModule: HMODULE;
begin
  // 1. Инициализация холста (задаем физический размер битмапа)
  Scale := 1.0;
  FFrameCounter := 0;

  Image1.Picture.Bitmap.PixelFormat := pf32bit;
  Image1.Picture.Bitmap.AlphaFormat := afDefined;

  Image1.Picture.Bitmap.SetSize(Image1.Width, Image1.Height);
  Image1.Picture.Bitmap.Canvas.Brush.Color := clWhite;
  Image1.Picture.Bitmap.Canvas.Brush.Style := bsSolid;
  Image1.Picture.Bitmap.Canvas.FillRect(Rect(0, 0, Image1.Picture.Bitmap.Width, Image1.Picture.Bitmap.Height));

  PenWidthEdit.Text := IntToStr(PenWidth.Position);
  shWidthPreview.Width := PenWidth.Position + 2;
  shWidthPreview.Height := PenWidth.Position + 2;
  SelectedColor := clBlack;
  shCurrentColor.Brush.Color := SelectedColor;
  CurrentBrush := btPencil;

  Image1.Picture.Bitmap.Canvas.Pen.Width := PenWidth.Position;

  RedoList := TObjectList<TBitmap>.Create(True);
  UndoList := TObjectList<TBitmap>.Create(True);
  Layers := TObjectList<TLayer>.Create(True);
  CurrentFilePath := '';

  BackgroundLayer := TLayer.Create(Image1.Picture.Bitmap.Width, Image1.Picture.Bitmap.Height);
  BackgroundLayer.Name := 'Слой 1';
  Layers.Add(BackgroundLayer);
  ActiveLayerIndex := 0;

   // Заполняем историю цветов базовым белым цветом
  for i := 1 to 18 do
  begin
    ColorHistory[i] := clWhite;
  end;

  // === ДОБАВЛЕНО: Заносим стартовые цвета в историю палитры ===
  // Сначала добавляем белый, затем черный.
  // В итоге черный встанет на самую первую ячейку, а белый сдвинется на вторую.
  AddColorToHistory(clWhite);
  AddColorToHistory(clBlack);

  // Обновляем визуальное отображение квадратиков палитры на форме
  UpdateHistoryUI;
  UpdateLayersUI;
  RenderLayers;

  Self.KeyPreview := True;
  Self.DoubleBuffered := True;
  CanvasPanel.DoubleBuffered := True;
  PanelLayersSetting.DoubleBuffered := True;
  LayersListBox.DoubleBuffered := True;

  Image1.ControlStyle := Image1.ControlStyle + [csOpaque];
  CanvasPanel.TabStop := True;

  InitialBackup := TBitmap.Create;
  InitialBackup.Assign(BackgroundLayer.Bitmap);
  UndoList.Add(InitialBackup);

  FCacheBitmap := TBitmap.Create;
  FShowWhiteBackground := True;
end;

procedure TFormToCanvas.FormDestroy(Sender: TObject);
begin
  // 1. Обязательно освобождаем память глобального кэша формы
  if FCacheBitmap <> nil then
    FCacheBitmap.Free;

  // 2. Уничтожаем список слоев (он автоматически вызовет TLayer.Destroy для каждого слоя)
  Layers.Free;
end;

procedure TFormToCanvas.CreateNewCanvas(W, H: Integer);
var
  BackgroundLayer: TLayer;
  Backup: TBitmap;
  PanelDC: HDC;
  RawColor: DWORD;
  P: PRGBQuad;
  X, Y: Integer;
begin
  // 1. Полностью очищаем старую систему слоев
  if Layers <> nil then
    Layers.Clear
  else
    Layers := TObjectList<TLayer>.Create(True);

  // 2. ЛОГИКА IBIS PAINT: Создаем прозрачный стартовый слой
  BackgroundLayer := TLayer.Create(W, H);
  BackgroundLayer.Name := 'Слой 1';

  // Настраиваем битмап слоя как 32-битный с альфа-каналом
  BackgroundLayer.Bitmap.PixelFormat := pf32bit;
  BackgroundLayer.Bitmap.AlphaFormat := afDefined;
  BackgroundLayer.Bitmap.SetSize(W, H);

  // ЖЕСТКОЕ ИСПРАВЛЕНИЕ: Физически очищаем память "Слоя 1" в кристальную прозрачность!
  // Зануляем альфа-канал (rgbReserved := 0), чтобы слой не перекрывал подложку белым цветом
  BackgroundLayer.Bitmap.Canvas.Lock;
  try
    for Y := 0 to BackgroundLayer.Bitmap.Height - 1 do
    begin
      P := BackgroundLayer.Bitmap.ScanLine[Y];
      for X := 0 to BackgroundLayer.Bitmap.Width - 1 do
      begin
        P^.rgbReserved := 0; // Alpha = 0 (Абсолютная прозрачность пикселя!)
        P^.rgbBlue     := 0;
        P^.rgbGreen    := 0;
        P^.rgbRed      := 0;
        Inc(P);
      end;
    end;
  finally
    BackgroundLayer.Bitmap.Canvas.Unlock;
  end;

  BackgroundLayer.Bitmap.Canvas.MoveTo(0, 0);

  // Добавляем очищенный прозрачный слой в список и делаем его активным
  Layers.Add(BackgroundLayer);
  ActiveLayerIndex := 0;

  // 3. Синхронизируем размеры результирующего Image1 вывода экрана
  Image1.Picture.Bitmap.Handle := 0;
  Image1.Picture.Bitmap.SetSize(W, H);
  Image1.Picture.Bitmap.PixelFormat := pf32bit;
  Image1.Picture.Bitmap.AlphaFormat := afDefined;

  // 4. Сбрасываем историю Undo/Redo
  if UndoList <> nil then UndoList.Free;
  UndoList := TObjectList<TBitmap>.Create(True);

  if RedoList <> nil then RedoList.Free;
  RedoList := TObjectList<TBitmap>.Create(True);

  // Сохраняем начальное ПРОЗРАЧНОЕ состояние как стартовую точку истории (БЕЗ ASSIGN!)
  Backup := TBitmap.Create;
  Backup.PixelFormat := BackgroundLayer.Bitmap.PixelFormat;
  Backup.AlphaFormat := BackgroundLayer.Bitmap.AlphaFormat;
  Backup.SetSize(W, H);
  BitBlt(Backup.Canvas.Handle, 0, 0, W, H, BackgroundLayer.Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
  UndoList.Add(Backup);

  // Обновляем список слоев в интерфейсе (ListBox)
  UpdateLayersUI;

  // Гарантируем, что при создании холста по умолчанию включен белый фон подложки
  FShowWhiteBackground := True;

  // Сбрасываем масштаб отображения
  Scale := 1.0;

 // Обновляем список слоев в интерфейсе (ListBox)
  UpdateLayersUI;

  FShowWhiteBackground := True;
  Scale := 1.0;

  // Весь блок с PanelDC и GetPixel отсюда просто УДАЛИ!

  FitToScreen;
  RenderLayers;
end;

procedure TFormToCanvas.CreateNewLayer(const ALayerName: string);
var
  NewLayer: TLayer;
  InsertIndex: Integer;
begin
  if Layers = nil then Exit;

  // Создаем прозрачный слой размера холста (Image1)
  NewLayer := TLayer.Create(Image1.Picture.Bitmap.Width, Image1.Picture.Bitmap.Height);
  NewLayer.Name := ALayerName;

  // ЛОГИКА IBIS PAINT: Определяем индекс вставки.
  // Если что-то выбрано, вставляем НАД активным слоем (ActiveLayerIndex + 1).
  // Если слоев нет — вставляем в начало.
  if (ActiveLayerIndex >= 0) and (ActiveLayerIndex < Layers.Count) then
    InsertIndex := ActiveLayerIndex + 1
  else
    InsertIndex := Layers.Count;

  // Вставляем слой в память на нужную позицию
  Layers.Insert(InsertIndex, NewLayer);

  // Автоматически делаем новый слой активным
  ActiveLayerIndex := InsertIndex;

  // Синхронизируем визуальный список (ListBox) и перерисовываем экран
  UpdateLayersUI;
  RenderLayers;
end;

procedure TFormToCanvas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Проверяем, зажат ли Ctrl и нажата ли клавиша S (код 'S' или ord('S'))
  if (ssCtrl in Shift) and (Key = ord('S')) then
  begin
    Key := 0; // Сбрасываем ключ, чтобы система не издавала пикающий звук
    SaveFileClick(Sender); // Вызываем ваше сохранение
  end;

  if (ssCtrl in Shift) and (Key = Ord('Z')) then //Ctrl + Z (Отмена действия)
  begin
    PerformUndo;
    Key := 0; // Сбрасываем клавишу, чтобы система не обрабатывала её повторно
  end;

  // Ctrl + Y = Повтор (Redo)
  if (ssCtrl in Shift) and (Key = 89) then
  begin
    PerformRedo;
    Key := 0;
  end;

  if (ssCtrl in Shift) and (Key = Ord('0')) then //Ctrl + 0 (Центрирование)
  begin
   CenterCanvas; // Вызываем общую функцию центрирования
  end;
end;

procedure TFormToCanvas.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  RelativeMousePos: TPoint;
  OldWidth, OldHeight: Integer;
  RatioX, RatioY: Double;
begin
  if ssCtrl in Shift then
  begin
    // 1. Запоминаем положение мыши относительно ПАНЕЛИ и старые размеры
    RelativeMousePos := CanvasPanel.ScreenToClient(MousePos);
    OldWidth := CanvasPanel.Width;
    OldHeight := CanvasPanel.Height;

    // Вычисляем, в каком "проценте" ширины/высоты стоит курсор
    RatioX := RelativeMousePos.X / OldWidth;
    RatioY := RelativeMousePos.Y / OldHeight;

    // 2. Меняем масштаб (вызываем существующий SetZoom)
    if WheelDelta > 0 then
      SetZoom(Scale + 0.1)
    else
      SetZoom(Scale - 0.1);

    // 3. КОРРЕКТИРУЕМ ПОЛОЖЕНИЕ (чтобы точка осталась под курсором)
    // Мы сдвигаем панель на разницу в пикселях, умноженную на коэффициент позиции
    CanvasPanel.Left := CanvasPanel.Left - Round((CanvasPanel.Width - OldWidth) * RatioX);
    CanvasPanel.Top := CanvasPanel.Top - Round((CanvasPanel.Height - OldHeight) * RatioY);

    Handled := True;
  end;
end;

procedure TFormToCanvas.FormPaint(Sender: TObject);
var
  x, y: Integer;
  Step: Integer; // Размер клетки в пикселях
begin
  Step := 20; // Задайте желаемый размер клетки

  // Настройка цвета и стиля линий сетки
  Canvas.Pen.Color := clGray; // Светло-серый цвет линий
  Canvas.Pen.Style := psSolid;     // Сплошная линия
  Canvas.Pen.Width := 1;           // Толщина линии

  // Рисуем вертикальные линии по всей ширине формы
  x := 0;
  while x < ClientWidth do
  begin
    Canvas.MoveTo(x, 0);
    Canvas.LineTo(x, ClientHeight);
    Inc(x, Step);
  end;

  // Рисуем горизонтальные линии по всей высоте формы
  y := 0;
  while y < ClientHeight do
  begin
    Canvas.MoveTo(0, y);
    Canvas.LineTo(ClientWidth, y);
    Inc(y, Step);
  end;
end;

procedure TFormToCanvas.FormResize(Sender: TObject);
begin
  Invalidate; // Принудительно перерисовывает форму при растягивании
end;


procedure TFormToCanvas.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Backup: TBitmap;
  ActualX, ActualY: Integer;
  GP: TGPGraphics;
  GPPen: TGPPen;
  GPPencilBrush: TGPSolidBrush;
  PixelColor: TColor;
  P: PRGBQuad;
begin
    // === 1. ПИПЕТКА НА ПРАВУЮ КНОПКУ МЫШИ ===
  if Button = mbRight then
  begin
    IntrumentIND.Caption := 'Выбранный инструмент: Пипетка';
    if (Layers = nil) or (ActiveLayerIndex < 0) or (ActiveLayerIndex >= Layers.Count) then
      Exit;

    if Scale > 0 then
    begin
      ActualX := Round(X / Scale);
      ActualY := Round(Y / Scale);
    end
    else
    begin
      ActualX := X;
      ActualY := Y;
    end;

    if (ActualX >= 0) and (ActualY >= 0) and
       (ActualX < Layers[ActiveLayerIndex].Bitmap.Width) and
       (ActualY < Layers[ActiveLayerIndex].Bitmap.Height) then
    begin
      P := Layers[ActiveLayerIndex].Bitmap.ScanLine[ActualY];
      Inc(P, ActualX);

      // Если пиксель содержит цвет (не абсолютно прозрачный), считываем его
      if P^.rgbReserved > 0 then
      begin
        PixelColor := RGB(P^.rgbRed, P^.rgbGreen, P^.rgbBlue);
        SelectedColor := PixelColor;
        shCurrentColor.Brush.Color := SelectedColor;
        shCurrentColor.Refresh;

        // === ДОБАВЛЕНО: Сохраняем цвет пипетки в историю палитры ===
        AddColorToHistory(SelectedColor);
      end;
    end;
    Exit; // Выходим, чтобы правый клик не вызывал рисование
  end;


  // === 2. ПЕРЕМЕЩЕНИЕ ХОЛСТА (Удержание Ctrl + Левая кнопка) ===
  if (ssCtrl in Shift) and (Button = mbLeft) then
  begin
    ReleaseCapture;
    FIsDrawing := False;
    CanvasPanel.Perform(WM_SYSCOMMAND, $F012, 0);
    Exit;
  end;

  // === 3. ЛОГИКА РИСОВАНИЯ (Левая кнопка без Ctrl) ===
  if (Button = mbLeft) then
  begin
    if (Layers = nil) or (ActiveLayerIndex < 0) or (ActiveLayerIndex >= Layers.Count) then Exit;
    if (Image1.Width <= 0) or (Image1.Height <= 0) then Exit;

    if Scale > 0 then
    begin
      ActualX := Round(X / Scale);
      ActualY := Round(Y / Scale);
    end
    else
    begin
      ActualX := X;
      ActualY := Y;
    end;

    if ActualX < 0 then ActualX := 0;
    if ActualY < 0 then ActualY := 0;
    if ActualX >= Layers[ActiveLayerIndex].Bitmap.Width then ActualX := Layers[ActiveLayerIndex].Bitmap.Width - 1;
    if ActualY >= Layers[ActiveLayerIndex].Bitmap.Height then ActualY := Layers[ActiveLayerIndex].Bitmap.Height - 1;

    FIsDrawing := True;
    FLastX := ActualX;
    FLastY := ActualY;

    // СИНХРОННАЯ ЛОГИКА ИСТОРИИ (UNDO)
    if RedoList <> nil then RedoList.Clear;
    if UndoList = nil then UndoList := TObjectList<TBitmap>.Create(True);

    Backup := TBitmap.Create;
    Backup.PixelFormat := Layers[ActiveLayerIndex].Bitmap.PixelFormat;
    Backup.AlphaFormat := Layers[ActiveLayerIndex].Bitmap.AlphaFormat;
    Backup.SetSize(Layers[ActiveLayerIndex].Bitmap.Width, Layers[ActiveLayerIndex].Bitmap.Height);

    BitBlt(Backup.Canvas.Handle, 0, 0, Backup.Width, Backup.Height,
           Layers[ActiveLayerIndex].Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
    UndoList.Add(Backup);

    if UndoList.Count > 30 then UndoList.Delete(0);

    Layers[ActiveLayerIndex].Bitmap.PixelFormat := pf32bit;
    Layers[ActiveLayerIndex].Bitmap.AlphaFormat := afDefined;

    // Инструмент "Заливка"
    if CurrentBrush = btBucket then
    begin
      IntrumentIND.Caption := 'Выбранный инструмент: Ведро';
      LayerFloodFill(Layers[ActiveLayerIndex].Bitmap, ActualX, ActualY, SelectedColor);
      RenderLayers;
      LayersListBox.Invalidate;
      Exit;
    end;

    // Инициализируем контекст GDI+ для отрисовки точки в месте клика
    GP := TGPGraphics.Create(Layers[ActiveLayerIndex].Bitmap.Canvas.Handle);
    try
      GP.SetSmoothingMode(SmoothingModeAntiAlias);

      case CurrentBrush of
        btPencil:
          begin
            IntrumentIND.Caption := 'Выбранный инструмент: Карандаш';
            GP.SetSmoothingMode(SmoothingModeNone);
            GPPencilBrush := TGPSolidBrush.Create(MakeColor(255, GetRValue(SelectedColor), GetGValue(SelectedColor), GetBValue(SelectedColor)));
            try
              GP.FillRectangle(GPPencilBrush,
                ActualX - PenWidth.Position div 2,
                ActualY - PenWidth.Position div 2,
                PenWidth.Position,
                PenWidth.Position);
            finally
              GPPencilBrush.Free;
            end;
          end;

        btPen:
          begin
            IntrumentIND.Caption := 'Выбранный инструмент: Ручка';
            GPPen := TGPPen.Create(MakeColor(255, GetRValue(SelectedColor), GetGValue(SelectedColor), GetBValue(SelectedColor)), PenWidth.Position);
            try
              GPPen.SetStartCap(LineCapRound);
              GPPen.SetEndCap(LineCapRound);
              GP.DrawLine(GPPen, ActualX, ActualY, ActualX, ActualY);
            finally
              GPPen.Free;
            end;
          end;

        btEraser:
          begin
            IntrumentIND.Caption := 'Выбранный инструмент: Ластик';
            GP.SetSmoothingMode(SmoothingModeAntiAlias);
            GP.SetCompositingMode(CompositingModeSourceCopy);

            GPPen := TGPPen.Create(MakeColor(0, 0, 0, 0), PenWidth.Position);
            try
              GPPen.SetStartCap(LineCapRound);
              GPPen.SetEndCap(LineCapRound);
              GP.DrawLine(GPPen, ActualX, ActualY, ActualX, ActualY);
            finally
              GPPen.Free;
            end;

            GP.SetCompositingMode(CompositingModeSourceOver);
          end;
      end;
    finally
      GP.Free;
    end;

    // Синхронизируем внутренний курсор стандартного Canvas
    Layers[ActiveLayerIndex].Bitmap.Canvas.MoveTo(ActualX, ActualY);

    // Замораживаем графическое обновление списка слоев на время ведения штриха
    Winapi.Windows.SendMessage(LayersListBox.Handle, WM_SETREDRAW, 0, 0);

    RenderLayers;
  end;
end;



procedure TFormToCanvas.FixLayerAlpha(ABitmap: TBitmap; CX, CY, BrushWidth: Integer);
var
  X, Y: Integer;
  XStart, XEnd, YStart, YEnd: Integer;
  P: PRGBQuad;
begin
  if ABitmap = nil then Exit;

  // Рассчитываем локальный квадрат вокруг точки рисования,
  // чтобы не перебирать весь холст и не вызывать тормозов
  XStart := CX - (BrushWidth div 2) - 2;
  YStart := CY - (BrushWidth div 2) - 2;
  XEnd := CX + (BrushWidth div 2) + 2;
  YEnd := CY + (BrushWidth div 2) + 2;

  // Ограничиваем расчеты строгими физическими рамками битмапа
  if XStart < 0 then XStart := 0;
  if YStart < 0 then YStart := 0;
  if XEnd >= ABitmap.Width then XEnd := ABitmap.Width - 1;
  if YEnd >= ABitmap.Height then YEnd := ABitmap.Height - 1;

  // Быстро восстанавливаем байт альфа-канала через системный массив ScanLine
  for Y := YStart to YEnd do
  begin
    P := ABitmap.ScanLine[Y];
    Inc(P, XStart); // Смещаем указатель к началу нашей горизонтальной линии штриха
    for X := XStart to XEnd do
    begin
      // Если пиксель был закрашен кистью (он не пустой), но Delphi сбросил его альфу в 0
      if (P^.rgbReserved = 0) and ((P^.rgbRed <> 0) or (P^.rgbGreen <> 0) or (P^.rgbBlue <> 0)) then
      begin
        P^.rgbReserved := 255; // Принудительно делаем пиксель на 100% непрозрачным и видимым
      end;
      Inc(P);
    end;
  end;
end;

procedure TFormToCanvas.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ActualX, ActualY: Integer;
  GP: TGPGraphics;
  GPPen: TGPPen;
  LastX, LastY: Integer;
  ActiveBitmap: TBitmap;
begin
  // Полностью игнорируем любые движения мыши, если не зажата ЛЕВАЯ КНОПКА
  if not FIsDrawing then Exit;
  if IsDragging then Exit;
  if not (ssLeft in Shift) then Exit;

  if (Layers = nil) or (ActiveLayerIndex < 0) or (ActiveLayerIndex >= Layers.Count) then Exit;

  ActiveBitmap := Layers[ActiveLayerIndex].Bitmap;
  if (ActiveBitmap = nil) or (ActiveBitmap.Width <= 0) then Exit;

  if Scale > 0 then
  begin
    ActualX := Round(X / Scale);
    ActualY := Round(Y / Scale);
  end
  else
  begin
    ActualX := X;
    ActualY := Y;
  end;

  if (ActualX = FLastX) and (ActualY = FLastY) then Exit;

  if ActualX < 0 then ActualX := 0;
  if ActualY < 0 then ActualY := 0;
  if ActualX >= ActiveBitmap.Width then ActualX := ActiveBitmap.Width - 1;
  if ActualY >= ActiveBitmap.Height then ActualY := ActiveBitmap.Height - 1;

  LastX := FLastX;
  LastY := FLastY;

  GP := TGPGraphics.Create(ActiveBitmap.Canvas.Handle);
  try
    GP.SetSmoothingMode(SmoothingModeAntiAlias);

    case CurrentBrush of
      btPencil:
        begin
          GP.SetSmoothingMode(SmoothingModeNone);
          GPPen := TGPPen.Create(MakeColor(255, GetRValue(SelectedColor), GetGValue(SelectedColor), GetBValue(SelectedColor)), PenWidth.Position);
          try
            GPPen.SetStartCap(LineCapSquare);
            GPPen.SetEndCap(LineCapSquare);
            GPPen.SetLineJoin(LineJoinMiter);
            GP.DrawLine(GPPen, LastX, LastY, ActualX, ActualY);
          finally
            GPPen.Free;
          end;
        end;

      btPen:
        begin
          GPPen := TGPPen.Create(MakeColor(255, GetRValue(SelectedColor), GetGValue(SelectedColor), GetBValue(SelectedColor)), PenWidth.Position);
          try
            GPPen.SetStartCap(LineCapRound);
            GPPen.SetEndCap(LineCapRound);
            GPPen.SetLineJoin(LineJoinRound);
            GP.DrawLine(GPPen, LastX, LastY, ActualX, ActualY);
          finally
            GPPen.Free;
          end;
        end;

      btEraser:
        begin
          GP.SetSmoothingMode(SmoothingModeAntiAlias);
          GP.SetCompositingMode(CompositingModeSourceCopy);
          GPPen := TGPPen.Create(MakeColor(0, 0, 0, 0), PenWidth.Position);
          try
            GPPen.SetStartCap(LineCapRound);
            GPPen.SetEndCap(LineCapRound);
            GPPen.SetLineJoin(LineJoinRound);
            GP.DrawLine(GPPen, LastX, LastY, ActualX, ActualY);
          finally
            GPPen.Free;
          end;
          GP.SetCompositingMode(CompositingModeSourceOver);
        end;
    end;
  finally
    GP.Free;
  end;

  FLastX := ActualX;
  FLastY := ActualY;

  Inc(FFrameCounter);
  if (FFrameCounter mod 3 = 0) then
  begin
    RenderLayers;
  end;
end;

procedure TFormToCanvas.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  { // Если отпустили правую кнопку мыши — возвращаем стандартный курсор
 if Button = mbRight then
  begin
    Image1.Cursor := crDefault;
    Winapi.Windows.SetCursor(Screen.Cursors[crDefault]); // Возвращаем стандартную стрелку
  end;   }
  // Логика завершения рисования (только для левой кнопки мыши)
  if Button = mbLeft then
  begin
    FIsDrawing := False;

    // 1. Снимаем заморозку со списка слоев Windows API, которую мы ставили в MouseDown
    Winapi.Windows.SendMessage(LayersListBox.Handle, WM_SETREDRAW, 1, 0);

    // 2. Полностью перерисовываем миниатюры слоев в списке (превью обновятся мгновенно)
    LayersListBox.Refresh;

    // 3. Вызываем финальную сборку слоев через WinAPI AlphaBlend на холст Image1
    RenderLayers;
  end;

  // Логика завершения ручного перемещения холста мышкой
  if IsDragging then
  begin
    IsDragging := False;
    RenderLayers;
  end;
end;

procedure TFormToCanvas.LayersListBoxDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  OldVisualIndex, NewVisualIndex: Integer;
  OldMemoryIndex, NewMemoryIndex: Integer;
  TempLayer: TLayer;
begin
  if Source = LayersListBox then
  begin
    OldVisualIndex := LayersListBox.ItemIndex;
    NewVisualIndex := LayersListBox.ItemAtPos(Point(X, Y), True);

    if (NewVisualIndex = -1) or (OldVisualIndex = NewVisualIndex) then
      Exit;

    // 1. МЕНЯЕМ СЛОИ МЕСТАМИ В ПАМЯТИ (список Layers)
    OldMemoryIndex := (Layers.Count - 1) - OldVisualIndex;
    NewMemoryIndex := (Layers.Count - 1) - NewVisualIndex;

    TempLayer := Layers[OldMemoryIndex];
    Layers.Extract(TempLayer);
    Layers.Insert(NewMemoryIndex, TempLayer);

    ActiveLayerIndex := NewMemoryIndex;

    // 2. ОПТИМИЗАЦИЯ: Вместо тяжелого UpdateLayersUI двигаем строки прямо в ListBox
    LayersListBox.Items.BeginUpdate;
    try
      // Перемещаем визуальную строку на новую позицию без полной очистки списка
      LayersListBox.Items.Move(OldVisualIndex, NewVisualIndex);

      // Возвращаем выделение на перемещенную строку
      LayersListBox.ItemIndex := NewVisualIndex;
    finally
      LayersListBox.Items.EndUpdate;
    end;

    // 3. Перерисовываем только холст
    RenderLayers;
  end;
end;

procedure TFormToCanvas.LayersListBoxDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  // Разрешаем сброс только в том случае, если источник перетаскивания — этот же ListBox
  Accept := (Source = LayersListBox);
end;

procedure TFormToCanvas.LayersListBoxDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  Layer: TLayer;
  EyeIcon: string;
  TextTop: Integer;
  PreviewRect: TRect;
begin
  if (Index < 0) or (Index >= LayersListBox.Items.Count) then Exit;

  Layer := TLayer(LayersListBox.Items.Objects[Index]);
  if Layer = nil then Exit;

  // 1. Окрашиваем фон строки (выделенный или обычный)
  if odSelected in State then
    LayersListBox.Canvas.Brush.Color := $00F5E6D3
  else
    LayersListBox.Canvas.Brush.Color := clWhite;
  LayersListBox.Canvas.FillRect(Rect);

  // 2. Рисуем иконку видимости (глазик) в левой части (первые 32 пикселя)
  if Layer.Visible then EyeIcon := '👁️' else EyeIcon := '❌';
  LayersListBox.Canvas.Font.Size := 11;
  TextTop := Rect.Top + ((Rect.Height - LayersListBox.Canvas.TextHeight(EyeIcon)) div 2);
  LayersListBox.Canvas.TextOut(Rect.Left + 8, TextTop, EyeIcon);

  // Разделительная линия после глазика (X = 32)
  LayersListBox.Canvas.Pen.Color := clSilver;
  LayersListBox.Canvas.MoveTo(Rect.Left + 32, Rect.Top);
  LayersListBox.Canvas.LineTo(Rect.Left + 32, Rect.Bottom);

  // 3. РИСУЕМ МИНИАТЮРУ СЛОЯ (Превью рисунка)
  // Задаем координаты маленького окошка для превью (ширина ~50px, высота подгоняется с отступами)
  PreviewRect.Left := Rect.Left + 38;
  PreviewRect.Top := Rect.Top + 4;
  PreviewRect.Right := PreviewRect.Left + 50;
  PreviewRect.Bottom := Rect.Bottom - 4;

  // Рисуем рамку вокруг превью, чтобы его было четко видно
  LayersListBox.Canvas.Brush.Color := clWhite;
  LayersListBox.Canvas.FillRect(PreviewRect); // Белая подложка для превью
  LayersListBox.Canvas.Pen.Color := clGray;
  LayersListBox.Canvas.Rectangle(PreviewRect);

  // Сжимаем и копируем изображение слоя в рамку превью
  if (Layer.Bitmap <> nil) and (not Layer.Bitmap.Empty) then
  begin
    // StretchDraw автоматически уменьшает большую картинку слоя до размеров PreviewRect
    LayersListBox.Canvas.StretchDraw(PreviewRect, Layer.Bitmap);
  end;

  // Вторая разделительная линия после превью
  LayersListBox.Canvas.Pen.Color := clSilver;
  LayersListBox.Canvas.MoveTo(PreviewRect.Right + 6, Rect.Top);
  LayersListBox.Canvas.LineTo(PreviewRect.Right + 6, Rect.Bottom);

  // 4. Рисуем название слоя (смещаем его еще правее, учитывая превью)
  LayersListBox.Canvas.Font.Size := 10;
  LayersListBox.Canvas.Font.Color := clWindowText;

  TextTop := Rect.Top + ((Rect.Height - LayersListBox.Canvas.TextHeight(Layer.Name)) div 2);
  LayersListBox.Canvas.TextOut(PreviewRect.Right + 12, TextTop, Layer.Name);
end;

procedure TFormToCanvas.LayersListBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ClickedIndex: Integer;
  TargetLayerIndex: Integer;
  Layer: TLayer;
begin
  if (Layers = nil) or (Layers.Count = 0) then Exit;

  // 1. Определяем, на какую строку кликнули
  ClickedIndex := LayersListBox.ItemAtPos(Point(X, Y), True);
  if ClickedIndex = -1 then Exit;

  TargetLayerIndex := (Layers.Count - 1) - ClickedIndex;
  Layer := Layers[TargetLayerIndex];

  // 2. Если кликнули в зону глазика (первые 32 пикселя) — переключаем видимость
  if X < 32 then
  begin
    Layer.Visible := not Layer.Visible;

    // ИСПРАВЛЕНО: Блок синхронизации старой кнопки BtnToggleVisible полностью удален!

    LayersListBox.Invalidate;
    RenderLayers;
  end
  else
  begin
    // 3. Если кликнули по названию или превью слоя — выделяем его и запускаем Drag and Drop
    if Button = mbLeft then
    begin
      LayersListBox.ItemIndex := ClickedIndex; // Выделяем строку
      ActiveLayerIndex := TargetLayerIndex;    // Меняем активный слой в памяти

      // СИНХРОНИЗАЦИЯ ПОЛЗУНКА: Внешний ползунок принимает прозрачность выбранного слоя
      // (Убедитесь, что имя TrackBarOpacity совпадает с именем вашего ползунка)
      TrackBarOpacity.Position := Layers[ActiveLayerIndex].Opacity;

      RenderLayers;

      LayersListBox.BeginDrag(False, 5);
    end;
  end;
end;

procedure TFormToCanvas.LayersListBoxMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) and (LayersListBox.ItemAtPos(Point(X, Y), True) <> -1) then
  begin
    LayersListBox.BeginDrag(False);
  end;
end;

procedure TFormToCanvas.SaveFileClick(Sender: TObject);
var
  PNG: TPNGImage;
  HistoryFile: string;
  HistoryList: TStringList;
  FileExt: string;
  ExistingIndex: Integer;
begin
  // 1. Если файл еще ни разу не сохранялся, перенаправляем на "Сохранить как..."
  if CurrentFilePath = '' then
  begin
    SaveAsFileClick(Sender);
    Exit;
  end;

  // 2. Принудительно обновляем холст (сливаем слои воедино)
  RenderLayers;

  // Гарантируем, что исходный Bitmap готов к передаче 32-битной графики с альфа-каналом
  Image1.Picture.Bitmap.PixelFormat := pf32bit;
  Image1.Picture.Bitmap.AlphaFormat := afDefined;

  // 3. Определяем формат файла по его расширению
  FileExt := ExtractFileExt(CurrentFilePath);

  if SameText(FileExt, '.png') then
  begin
    PNG := TPNGImage.Create;
    try
      // Корректно переносим структуру пикселей вместе с альфа-каналом
      PNG.Assign(Image1.Picture.Bitmap);
      PNG.SaveToFile(CurrentFilePath);
    finally
      PNG.Free;
    end;
  end
  else if SameText(FileExt, '.bmp') then
  begin
    // Сохраняем как 32-битный BMP (сохраняет альфа-канал, если целевой софт его поддерживает)
    Image1.Picture.Bitmap.SaveToFile(CurrentFilePath);
  end;

  // 4. БЕЗОПАСНАЯ ЗАПИСЬ В ИСТОРИЮ (history.dat)
  HistoryFile := TPath.Combine(ExtractFilePath(ParamStr(0)), 'history.dat');
  HistoryList := TStringList.Create;
  try
    if FileExists(HistoryFile) then
    begin
      try
        HistoryList.LoadFromFile(HistoryFile);
      except
        // Изолируем ошибки чтения (например, если файл заблокирован или поврежден)
      end;
    end;

    // Ищем индекс за один проход для оптимизации скорости
    ExistingIndex := HistoryList.IndexOf(CurrentFilePath);
    if ExistingIndex <> -1 then
      HistoryList.Delete(ExistingIndex);

    // Добавляем обновленный файл в самое начало списка
    HistoryList.Insert(0, CurrentFilePath);

    try
      HistoryList.SaveToFile(HistoryFile);
    except
      // Защита на случай, если диск переполнен или защищен от записи
    end;
  finally
    HistoryList.Free;
  end;
  MainMenu.UpdateHistory;
  ShowMessage('Изменения успешно сохранены!');
end;


procedure TFormToCanvas.SaveAsFileClick(Sender: TObject);
var
  PNG: TPNGImage;
  FinalFileName: string;
  HistoryFile: string;
  HistoryList: TStringList;
  ExistingIndex: Integer;
begin
  // 1. Настройка фильтров диалога
  SaveDialog.Filter := 'Изображение PNG (*.png)|*.png|Точечные рисунки (*.bmp)|*.bmp';
  SaveDialog.DefaultExt := 'png';

  if not SaveDialog.Execute then
    Exit; // Быстрый выход, если пользователь нажал "Отмена"

  // Принудительно рендерим слои перед сохранением
  RenderLayers;

  FinalFileName := SaveDialog.FileName;

  // Автоматическое исправление расширения файла
  if SaveDialog.FilterIndex = 1 then
  begin
    if not SameText(ExtractFileExt(FinalFileName), '.png') then
      FinalFileName := FinalFileName + '.png';
  end
  else
  begin
    if not SameText(ExtractFileExt(FinalFileName), '.bmp') then
      FinalFileName := FinalFileName + '.bmp';
  end;

  // Гарантируем, что исходный Bitmap имеет 32-битный формат с альфа-каналом
  Image1.Picture.Bitmap.PixelFormat := pf32bit;
  Image1.Picture.Bitmap.AlphaFormat := afDefined;

  // 2. Сохранение в формате PNG
  if SaveDialog.FilterIndex = 1 then
  begin
    PNG := TPNGImage.Create;
    try
      // Корректное копирование 32-bit Bitmap с сохранением альфа-канала
      PNG.Assign(Image1.Picture.Bitmap);

      // Запись на диск
      PNG.SaveToFile(FinalFileName);
    finally
      PNG.Free;
    end;
  end
  else
  begin
    // 3. Сохранение в формате BMP (сохраняет 32-битное качество)
    Image1.Picture.Bitmap.SaveToFile(FinalFileName);
  end;

  ShowMessage('Изображение успешно сохранено!');

  // 4. Безопасная работа с историей файлов
  HistoryFile := TPath.Combine(ExtractFilePath(ParamStr(0)), 'history.dat');
  HistoryList := TStringList.Create;
  try
    if FileExists(HistoryFile) then
    begin
      try
        HistoryList.LoadFromFile(HistoryFile);
      except
        // Гасим ошибку чтения, если файл истории поврежден
      end;
    end;

    // Оптимизация поиска: ищем индекс один раз, а не два
    ExistingIndex := HistoryList.IndexOf(FinalFileName);
    if ExistingIndex <> -1 then
      HistoryList.Delete(ExistingIndex);

    // Вставляем элемент на первое место
    HistoryList.Insert(0, FinalFileName);

    // Безопасное сохранение
    HistoryList.SaveToFile(HistoryFile);
  finally
    HistoryList.Free;
  end;
  MainMenu.UpdateHistory;
end;


procedure TFormToCanvas.OpenFileClick(Sender: TObject);
var
  BackgroundLayer: TLayer;
  GPImage: TGPImage;
  GPGraphics: TGPGraphics;
  W, H: Integer;
  Backup: TBitmap;
  X, Y: Integer;
  P: PRGBQuad;
begin
  OpenDialog.Filter := 'Изображения PNG (*.png)|*.png|Точечные рисунки (*.bmp)|*.bmp';
  OpenDialog.DefaultExt := 'png';

  if not OpenDialog.Execute then Exit;

  CurrentFilePath := OpenDialog.FileName;
  GPImage := TGPImage.Create(CurrentFilePath);
  try
    W := GPImage.GetWidth;
    H := GPImage.GetHeight;

    if (W <= 0) or (H <= 0) then
    begin
      ShowMessage('Ошибка чтения размеров файла!');
      Exit;
    end;

    // 1. Исправлено: Корректное пересоздание или очистка списка слоев
    if Layers = nil then
      Layers := TObjectList<TLayer>.Create(True)
    else
      Layers.Clear;

    BackgroundLayer := TLayer.Create(W, H);
    BackgroundLayer.Name := 'Слой 1';
    BackgroundLayer.Bitmap.PixelFormat := pf32bit;
    BackgroundLayer.Bitmap.AlphaFormat := afDefined;

    // 2. Исправлено: Сначала рисуем через GDI+, затем работаем со ScanLine
    GPGraphics := TGPGraphics.Create(BackgroundLayer.Bitmap.Canvas.Handle);
    try
      GPGraphics.DrawImage(GPImage, 0, 0, W, H);
    finally
      GPGraphics.Free;
    end;

    // 3. Безопасная заливка альфа-канала для ФОНА (только если это необходимо)
    for Y := 0 to BackgroundLayer.Bitmap.Height - 1 do
    begin
      P := BackgroundLayer.Bitmap.ScanLine[Y];
      for X := 0 to BackgroundLayer.Bitmap.Width - 1 do
      begin
        // Если вам ОЧЕНЬ нужно сделать фон непрозрачным:
        P^.rgbReserved := 255;
        Inc(P);
      end;
    end;

    // Фиксируем изменения графики в Delphi после ScanLine
    BackgroundLayer.Bitmap.Modified := True;

    Layers.Add(BackgroundLayer);
    ActiveLayerIndex := 0;

    // 4. Настройка целевого изображения
    Image1.Picture.Bitmap.FreeImage; // Вместо Handle := 0
    Image1.Picture.Bitmap.SetSize(W, H);
    Image1.Picture.Bitmap.PixelFormat := pf32bit;
    Image1.Picture.Bitmap.AlphaFormat := afDefined;

    // 5. Исправлено: Безопасное пересоздание списков истории
    if UndoList = nil then
      UndoList := TObjectList<TBitmap>.Create(True)
    else
      UndoList.Clear;

    if RedoList = nil then
      RedoList := TObjectList<TBitmap>.Create(True)
    else
      RedoList.Clear;

    Backup := TBitmap.Create;
    Backup.Assign(BackgroundLayer.Bitmap);
    UndoList.Add(Backup);

    FormToCanvas.UpdateLayersUI;

    FitToScreen;
    RenderLayers;
    CenterCanvas;

    ShowMessage('Файл успешно открыт!');
  finally
    GPImage.Free;
  end;
end;


procedure TFormToCanvas.CenterCanvas;
begin
  // 1. Возвращаем холст в видимую область (вписываем в экран)
  FitToScreen;

  // 2. Дополнительно гарантируем, что панель встала ровно по центру
  CanvasPanel.Left := (Self.ClientWidth - CanvasPanel.Width) div 2;
  CanvasPanel.Top := (Self.ClientHeight - CanvasPanel.Height) div 2;

  // 3. Если панель всё равно больше экрана, прижимаем к верхнему левому углу
  if CanvasPanel.Left < 0 then CanvasPanel.Left := 0;
  if CanvasPanel.Top < 0 then CanvasPanel.Top := 0;

  // 4. Обновляем экран
  Self.Invalidate;
end;

procedure TFormToCanvas.CreateFileClick(Sender: TObject);
begin
FormCreateFile.ShowModal;
end;

procedure TFormToCanvas.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  // Принудительно создаем кнопку на панели задач ТОЛЬКО для этого окна
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
  // Делаем окно независимым от скрытого меню
  Params.WndParent := GetDesktopWindow;
end;

procedure TFormToCanvas.ExitFileClick(Sender: TObject);
begin
Close; // Закрывает текущую форму и завершает программу
end;

procedure TFormToCanvas.PerformUndo;
var
  LastSnapshot: TBitmap;
  CurrentState: TBitmap;
begin
  // 1. Быстрые проверки на корректность списков
  if (UndoList = nil) or (Layers = nil) or (ActiveLayerIndex < 0) or (ActiveLayerIndex >= Layers.Count) then Exit;

  // Если в истории остался только 1 элемент (это наш стартовый чистый лист),
  // значит, отменять больше нечего, выходим.
  if UndoList.Count <= 1 then Exit;

  if RedoList = nil then
    RedoList := TObjectList<TBitmap>.Create(True);

  // 2. Логика Redo (Шаг вперед): сохраняем холст со штрихом, который сейчас сотрем
  CurrentState := TBitmap.Create;
  CurrentState.Assign(Layers[ActiveLayerIndex].Bitmap);
  RedoList.Add(CurrentState);

  // 3. ИСПРАВЛЕНИЕ: Извлекаем снимок, который находится на самой вершине стека Undo.
  // Это состояние холста СТРОГО до того, как был нанесен последний штрих!
  LastSnapshot := UndoList[UndoList.Count - 1];

  // Восстанавливаем пиксели слоя из этого бэкапа
  Layers[ActiveLayerIndex].Bitmap.Handle := 0;
  Layers[ActiveLayerIndex].Bitmap.Assign(LastSnapshot);

  // 4. ИСПРАВЛЕНИЕ: Только ПОСЛЕ применения бэкапа удаляем его из истории Undo,
  // чтобы при следующем нажатии Ctrl+Z откатиться еще на один шаг назад.
  UndoList.Delete(UndoList.Count - 1);

  // 5. Пересобираем слои
  RenderLayers;

  // 6. Принудительное обновление экрана (синхронизация)
  if Layers.Count = 1 then
  begin
    Image1.Picture.Bitmap.Handle := 0;
    Image1.Picture.Bitmap.Assign(Layers[ActiveLayerIndex].Bitmap);
  end;

  Image1.Invalidate;
end;

procedure TFormToCanvas.PerformUndoButtonClick(Sender: TObject);
begin
 PerformUndo;
end;

procedure TFormToCanvas.PerformRedo;
var
  NextSnapshot: TBitmap;
  CurrentState: TBitmap;
begin
  if (RedoList = nil) or (RedoList.Count = 0) then Exit;
  if (Layers = nil) or (ActiveLayerIndex < 0) or (ActiveLayerIndex >= Layers.Count) then Exit;

  // Шаг для Undo: сохраняем текущее состояние, чтобы можно было снова нажать Ctrl+Z
  CurrentState := TBitmap.Create;
  CurrentState.Assign(Layers[ActiveLayerIndex].Bitmap);
  UndoList.Add(CurrentState);

  // Извлекаем снимок из Redo
  NextSnapshot := RedoList[RedoList.Count - 1];
  Layers[ActiveLayerIndex].Bitmap.Assign(NextSnapshot);

  // Удаляем из истории Redo
  RedoList.Delete(RedoList.Count - 1);

  RenderLayers;
end;

procedure TFormToCanvas.PerformRedoButtonClick(Sender: TObject);
begin
PerformRedo;
end;

end.

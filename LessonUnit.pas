unit LessonUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Winapi.GDIPOBJ, Winapi.GDIPAPI, System.Generics.Collections,
  Vcl.ExtDlgs;

type
  TFormLessonDraw = class(TForm)
    lessonChoicePanel: TPanel;
    LessonMenu1: TPopupMenu;
    L1_S1: TMenuItem;
    L1_S2: TMenuItem;
    L1_S3: TMenuItem;
    btnLesson1: TButton;
    btnLesson2: TButton;
    LessonMenu2: TPopupMenu;
    L2_S1: TMenuItem;
    L2_S2: TMenuItem;
    L2_S3: TMenuItem;
    btnLesson3: TButton;
    LessonMenu3: TPopupMenu;
    L3_S1: TMenuItem;
    L3_S2: TMenuItem;
    L3_S3: TMenuItem;
    PanelCanvas: TPanel;
    ImageCanvas: TImage;
    PanelforRefImg: TPanel;
    ImageReference: TImage;
    ButtonRight: TSpeedButton;
    ButtonLeft: TSpeedButton;
    TextLessonSteps: TRichEdit;
    PanelTxTandRef: TPanel;
    ImagePrimer: TImage;
    BTNRight: TSpeedButton;
    BTNleft: TSpeedButton;
    PanelLeft: TPanel;
    Labellesson: TLabel;
    LabelPrimer: TLabel;
    LabelREF: TLabel;
    PanelRight: TPanel;
    Panelforprimer: TPanel;
    PanelforRef: TPanel;
    PanelSetting: TPanel;
    BrushSetting: TPanel;
    ButtonPencil: TSpeedButton;
    ButtonEraser: TSpeedButton;
    PerformUndoButton: TSpeedButton;
    PerformRedoButton: TSpeedButton;
    shCurrentColor: TShape;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    PanelfileSetting: TPanel;
    ButtonSave: TButton;
    SavePictureDialog1: TSavePictureDialog;
    ButtonCreateFile: TButton;
    ButtonOpen: TButton;
    tbPenWidth: TTrackBar;
    min1: TLabel;
    max50: TLabel;
    lblWidthDisplay: TLabel;
    IntrumentIND: TLabel;
    PanelLESSONS: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNleftClick(Sender: TObject);
    procedure BTNRightClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLesson1Click(Sender: TObject);
    procedure btnLesson2Click(Sender: TObject);
    procedure btnLesson3Click(Sender: TObject);
    procedure L1_MenuStepClick(Sender: TObject);
    procedure L2_MenuStepClick(Sender: TObject);
    procedure L3_MenuStepClick(Sender: TObject);
    procedure ButtonLeftClick(Sender: TObject);
    procedure ButtonRightClick(Sender: TObject);
    procedure ButtonPencilClick(Sender: TObject);
    procedure ButtonEraserClick(Sender: TObject);
    procedure ImageCanvasMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageCanvasMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageCanvasMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PerformUndoButtonClick(Sender: TObject);
    procedure PerformRedoButtonClick(Sender: TObject);
    procedure ImageReferenceMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure HisColorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonSaveClick(Sender: TObject);
    procedure tbPenWidthChange(Sender: TObject);
    procedure ButtonOpenClick(Sender: TObject);
    procedure ButtonCreateFileClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  private
    { Private declarations }
  FIsDrawing: Boolean;   // Флаг: зажата ли мышь для рисования
  FLastX, FLastY: Integer; // Предыдущие координаты мыши для плавных линий
  FEraserMode: Boolean;  // True = ластик, False = карандаш
  CurrentLesson: Integer; // Номер активного урока (1, 2 или 3)
  CurrentStep: Integer;   // Номер текущего шага (1, 2 или 3)
  CurrentRef: Integer;    // ТЕКУЩИЙ НОМЕР РЕФЕРЕНСА (1, 2 или 3)
  SelectedColor: TColor;
  UndoList: TObjectList<TBitmap>; // Списки для истории Undo/Redo
  RedoList: TObjectList<TBitmap>;
  FColorHistoryShapes: array[1..4] of TShape;
  procedure AddColorToHistory(AColor: TColor);
  procedure UpdateStep(LessonID, StepNum: Integer); // Наш метод обновления
  procedure UpdateReference(RefNum: Integer);
  procedure PerformRedo;
  procedure PerformUndo;
  procedure SaveStateForUndo;
  procedure HandleScreenPipette;
    procedure ClearCanvas;
    procedure SaveCanvasToFile;
    procedure CheckAndChangeLesson(NewLessonID, NewStepNum: Integer);

  protected
  procedure CreateParams(var Params: TCreateParams); override;


  public
    { Public declarations }

  end;

var
  FormLessonDraw: TFormLessonDraw;

implementation

uses Unit2, Unit1, Unit3;

{$R *.dfm}

procedure TFormLessonDraw.CheckAndChangeLesson(NewLessonID, NewStepNum: Integer);
var
  FormDlg: TForm;
  DialogResult: Integer;
begin
  // 1. Проверяем, меняет ли пользователь УРОК
  if (CurrentLesson <> 0) and (CurrentLesson <> NewLessonID) then
  begin
    // 2. Создаем форму диалога в памяти
    FormDlg := CreateMessageDialog(
      'Вы переходите на другой урок. Сохранить текущий рисунок? ' + #13#10 +
      '(При переходе незафиксированный прогресс будет сброшен)',
      mtConfirmation, [mbYes, mbNo, mbCancel]
    );

    try
      // 3. Переводим текст на кнопках на русский язык
      TButton(FormDlg.FindComponent('Yes')).Caption := 'Да';
      TButton(FormDlg.FindComponent('No')).Caption := 'Нет';
      TButton(FormDlg.FindComponent('Cancel')).Caption := 'Отмена';

      // 4. Устанавливаем заголовок окошка
      FormDlg.Caption := 'Смена урока';

      // 5. Показываем окно и получаем выбор пользователя
      DialogResult := FormDlg.ShowModal;
    finally
      // 6. Освобождаем память
      FormDlg.Free;
    end;

    // 7. Обрабатываем выбор пользователя
    case DialogResult of
      mrYes: begin
        SaveCanvasToFile;   // Вызываем вашу процедуру сохранения
        ClearCanvas;        // Очищаем холст для нового урока
      end;

      mrNo: begin
        ClearCanvas;        // Просто сбрасываем рисунок без сохранения
      end;

      mrCancel: begin
        Exit;               // Нажата "Отмена" — прерываем процедуру, никуда не переходим
      end;
    end;
  end;

  // 8. Если всё хорошо (или это просто смена шага), обновляем панели урока
  UpdateStep(NewLessonID, NewStepNum);
end;


procedure TFormLessonDraw.SaveStateForUndo;
var
  Backup: TBitmap;
begin
  if UndoList = nil then
    UndoList := TObjectList<TBitmap>.Create(True);

  // При каждом новом штрихе очищаем список Redo (вперед идти больше нельзя)
  if RedoList <> nil then
    RedoList.Clear;

  // Делаем копию текущего холста
  Backup := TBitmap.Create;
  Backup.Assign(ImageCanvas.Picture.Bitmap);
  UndoList.Add(Backup);

  // Ограничиваем историю 30 шагами, чтобы не перегружать оперативную память
  if UndoList.Count > 30 then
    UndoList.Delete(0);
end;

procedure TFormLessonDraw.tbPenWidthChange(Sender: TObject);
begin
  // Обновляем текст на экране при каждом движении ползунка
  lblWidthDisplay.Caption := 'Толщина: ' + IntToStr(tbPenWidth.Position) + ' px';
end;
//ОЧИСТКА ХОЛСТА
procedure TFormLessonDraw.ClearCanvas;
begin
  if (ImageCanvas.Width <= 0) or (ImageCanvas.Height <= 0) then Exit;

  // 1. Сохраняем текущий рисунок в историю Undo перед очисткой
  SaveStateForUndo;

  // 2. Настраиваем кисть холста на белый цвет
  ImageCanvas.Picture.Bitmap.Canvas.Brush.Color := clWhite;
  ImageCanvas.Picture.Bitmap.Canvas.Brush.Style := bsSolid;

  // 3. Полностью заливаем весь холст белым прямоугольником
  ImageCanvas.Picture.Bitmap.Canvas.FillRect(
    Rect(0, 0, ImageCanvas.Picture.Bitmap.Width, ImageCanvas.Picture.Bitmap.Height)
  );

  // 4. Принудительно обновляем холст на экране
  ImageCanvas.Invalidate;
end;

procedure TFormLessonDraw.HandleScreenPipette;
var
  DC: HDC;
  ScreenPos: TPoint;
  PickedColor: TColor;
  I: Integer;
begin
  IntrumentIND.Caption := 'Выбранный инструмент: Пипетка';
  GetCursorPos(ScreenPos);
  DC := GetDC(0);
  try
    PickedColor := GetPixel(DC, ScreenPos.X, ScreenPos.Y);
  finally
    ReleaseDC(0, DC);
  end;

  // ФИЛЬТР: Белый цвет полностью игнорируем (не берем с холста в палитру)
  if ColorToRGB(PickedColor) = ColorToRGB(clWhite) then Exit;

  // ЗАЩИТА: Если пипетка взяла тот же цвет, который УЖЕ активен на большом квадрате — ничего не двигаем
  if ColorToRGB(shCurrentColor.Brush.Color) = ColorToRGB(PickedColor) then Exit;

  // === АЛГОРИТМ СДВИГА ИЗ БОЛЬШОГО КВАДРАТА В ИСТОРИЮ ===
  // 1. Сначала двигаем маленькие квадратики истории (с 4-го по 2-й)
  for I := 4 downto 2 do
  begin
    FColorHistoryShapes[I].Brush.Color := FColorHistoryShapes[I - 1].Brush.Color;
  end;

  // 2. Цвет, который ДО ЭТОГО был на большом квадрате, переносим в Shape1
  FColorHistoryShapes[1].Brush.Color := shCurrentColor.Brush.Color;

  // 3. Записываем новый цвет в большой актуальный квадрат и рабочую переменную
  shCurrentColor.Brush.Color := PickedColor;
  SelectedColor := PickedColor;
end;

procedure TFormLessonDraw.HisColorMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ClickedColor: TColor;
  OldCurrentColor: TColor;
  I: Integer;
begin
  ClickedColor := (Sender as TShape).Brush.Color;

  // Если кликнули по пустой (белой) ячейке истории — ничего не делаем
  if ClickedColor = clWhite then Exit;

  // Запоминаем цвет, который СЕЙЧАС горит на большом квадрате
  OldCurrentColor := shCurrentColor.Brush.Color;

  // 1. Сдвигаем историю маленьких квадратиков (освобождаем Shape1)
  for I := 4 downto 2 do
  begin
    FColorHistoryShapes[I].Brush.Color := FColorHistoryShapes[I - 1].Brush.Color;
  end;

  // 2. Бывший основной цвет с большого квадрата падает в Shape1
  FColorHistoryShapes[1].Brush.Color := OldCurrentColor;

  // 3. Большой квадрат принимает цвет ячейки, по которой кликнули
  shCurrentColor.Brush.Color := ClickedColor;
  SelectedColor := ClickedColor;

  FEraserMode := False; // Выключаем ластик, включаем карандаш
  IntrumentIND.Caption := 'Выбранный инструмент: Карандаш';
end;

procedure TFormLessonDraw.PerformUndoButtonClick(Sender: TObject);
begin
PerformUndo;
end;

procedure TFormLessonDraw.PerformRedoButtonClick(Sender: TObject);
begin
PerformRedo;
end;

procedure TFormLessonDraw.PerformUndo;
var
  LastSnapshot: TBitmap;
  CurrentState: TBitmap;
begin
  // Проверяем, инициализирован ли список и есть ли что отменять
  if (UndoList = nil) or (UndoList.Count = 0) then Exit;

  if RedoList = nil then
    RedoList := TObjectList<TBitmap>.Create(True);

  // 1. Сохраняем текущее состояние в Redo перед тем, как откатиться назад
  CurrentState := TBitmap.Create;
  CurrentState.Assign(ImageCanvas.Picture.Bitmap);
  RedoList.Add(CurrentState);

  // 2. Извлекаем последний снимок из истории Undo
  LastSnapshot := UndoList[UndoList.Count - 1];

  // 3. Восстанавливаем холст из бэкапа
  ImageCanvas.Picture.Bitmap.Assign(LastSnapshot);

  // 4. Удаляем использованный снимок из Undo
  UndoList.Delete(UndoList.Count - 1);

  // 5. Обновляем холст на экране
  ImageCanvas.Invalidate;
end;

procedure TFormLessonDraw.PerformRedo;
var
  NextSnapshot: TBitmap;
  CurrentState: TBitmap;
begin
  // Проверяем, есть ли шаги для возврата вперед
  if (RedoList = nil) or (RedoList.Count = 0) then Exit;

  if UndoList = nil then
    UndoList := TObjectList<TBitmap>.Create(True);

  // 1. Сохраняем текущее состояние в Undo, чтобы можно было снова нажать Отмену
  CurrentState := TBitmap.Create;
  CurrentState.Assign(ImageCanvas.Picture.Bitmap);
  UndoList.Add(CurrentState);

  // 2. Извлекаем снимок из Redo и применяем его к холсту
  NextSnapshot := RedoList[RedoList.Count - 1];
  ImageCanvas.Picture.Bitmap.Assign(NextSnapshot);

  // 3. Удаляем снимок из Redo
  RedoList.Delete(RedoList.Count - 1);

  // 4. Обновляем холст на экране
  ImageCanvas.Invalidate;
end;

procedure TFormLessonDraw.UpdateReference(RefNum: Integer);
var
  ExePath, BasePath, FinalPath: string;
begin
  CurrentRef := RefNum;

  // Управление доступностью стрелок референса
  ButtonLeft.Enabled := (CurrentRef > 1);
  ButtonRight.Enabled := (CurrentRef < 3);

  // Загрузка самого референса (PNG или JPG)
  ExePath := ExtractFilePath(ParamStr(0));
  BasePath := ExePath + Format('resources\references\ref%d', [CurrentRef]);
  FinalPath := '';

  if FileExists(BasePath + '.png') then FinalPath := BasePath + '.png'
  else if FileExists(BasePath + '.jpg') then FinalPath := BasePath + '.jpg';

  if FinalPath <> '' then
    ImageReference.Picture.LoadFromFile(FinalPath);

  // МАНЕВР: Перерисовываем картинку шага под новый выбранный референс!
  // Вызываем обновление текущего урока и шага с уже изменившимся CurrentRef
  if (CurrentLesson <> 0) and (CurrentStep <> 0) then
    UpdateStep(CurrentLesson, CurrentStep);
end;

procedure TFormLessonDraw.AddColorToHistory(AColor: TColor);
var
  I: Integer;
  CurrentRGB, NewRGB: Integer;
begin
  // 1. Переводим цвета в RGB-формат для точного сравнения
  NewRGB := ColorToRGB(AColor);
  CurrentRGB := ColorToRGB(FColorHistoryShapes[1].Brush.Color);

  // 2. ФИЛЬТР: Белый цвет полностью игнорируется пипеткой
  if NewRGB = ColorToRGB(clWhite) then Exit;

  // 3. ЗАЩИТА: Если этот цвет УЖЕ выбран и находится в первой ячейке, не дублируем его
  if CurrentRGB = NewRGB then Exit;

  // 4. СДВИГ ИСТОРИИ: Перемещаем все цвета (включая стартовый черный) вправо
  for I := 4 downto 2 do
  begin
    FColorHistoryShapes[I].Brush.Color := FColorHistoryShapes[I - 1].Brush.Color;
  end;

  // 5. ЗАПИСЬ: Помещаем новый цвет в первую ячейку
  FColorHistoryShapes[1].Brush.Color := AColor;

  // 6. ОБНОВЛЕНИЕ: Перекрашиваем большой главный квадрат выбранного цвета
  shCurrentColor.Brush.Color := AColor;
end;

// Клик по стрелочке влево (Назад)
procedure TFormLessonDraw.BTNleftClick(Sender: TObject);
begin
  if CurrentStep > 1 then
    UpdateStep(CurrentLesson, CurrentStep - 1);
end;

// Клик по стрелочке вправо (Вперед)
procedure TFormLessonDraw.btnLesson1Click(Sender: TObject);
var
  SelectedLesson: Integer;
begin
  // Узнаем номер урока из свойства Tag нажатой кнопки (1, 2 или 3)
  SelectedLesson := (Sender as TButton).Tag;

  // Запускаем этот урок сразу с первого шага в нашей нижней панели
  CheckAndChangeLesson(SelectedLesson, 1);
end;

procedure TFormLessonDraw.btnLesson2Click(Sender: TObject);
var
  SelectedLesson: Integer;
begin
  // Узнаем номер урока из свойства Tag нажатой кнопки (1, 2 или 3)
  SelectedLesson := (Sender as TButton).Tag;

  // Запускаем этот урок сразу с первого шага в нашей нижней панели
  CheckAndChangeLesson(SelectedLesson, 1);
end;

procedure TFormLessonDraw.btnLesson3Click(Sender: TObject);
var
  SelectedLesson: Integer;
begin
  // Узнаем номер урока из свойства Tag нажатой кнопки (1, 2 или 3)
  SelectedLesson := (Sender as TButton).Tag;

  // Запускаем этот урок сразу с первого шага в нашей нижней панели
  CheckAndChangeLesson(SelectedLesson, 1);
end;

procedure TFormLessonDraw.BTNrightClick(Sender: TObject);
begin
  if CurrentStep < 3 then
    UpdateStep(CurrentLesson, CurrentStep + 1);
end;
// Клик по нижней левой стрелке (Назад по референсам)
procedure TFormLessonDraw.ButtonSaveClick(Sender: TObject);
begin
SaveCanvasToFile;
end;

procedure TFormLessonDraw.ButtonCreateFileClick(Sender: TObject);
begin
 FormCreateFile.ShowModal;
end;

procedure TFormLessonDraw.ButtonEraserClick(Sender: TObject);
begin
  FEraserMode := True; // Выключаем ластик, включаем карандаш
  IntrumentIND.Caption := 'Выбранный инструмент: Ластик';
end;

procedure TFormLessonDraw.ButtonLeftClick(Sender: TObject);
begin
  if CurrentRef > 1 then
    UpdateReference(CurrentRef - 1);
end;

procedure TFormLessonDraw.ButtonOpenClick(Sender: TObject);
begin
  // 1. Принудительно вызываем диалог открытия файла, который находится на форме рисования
  FormToCanvas.OpenFileClick(Self);

  // 2. Проверяем, выбрал ли пользователь файл (если файл открылся, путь не будет пустым)
  if FormToCanvas.CurrentFilePath <> '' then
  begin
    // Скрываем главное меню, чтобы оно не мешало рисованию
    Self.Hide;
    // Показываем форму рисования и выводим её на передний план
    FormToCanvas.Show;
    FormToCanvas.WindowState := wsMaximized; // Распахиваем на весь экран (опционально)
  end;
end;

procedure TFormLessonDraw.ButtonPencilClick(Sender: TObject);
begin
  FEraserMode := False; // Выключаем карандаш, включаем ластик
  IntrumentIND.Caption := 'Выбранный инструмент: Карандаш';
end;

// Клик по нижней правой стрелке (Вперед по референсам)
procedure TFormLessonDraw.ButtonRightClick(Sender: TObject);
begin
  if CurrentRef < 3 then
    UpdateReference(CurrentRef + 1);
end;

procedure TFormLessonDraw.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  // Назначаем родителем окна рабочий стол, а не главную форму
  Params.WndParent := GetDesktopWindow;
  // Добавляем стиль полноценного независимого приложения
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TFormLessonDraw.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(UndoList);
  FreeAndNil(RedoList);
  Action := caHide; // Форма просто закроется, а метод Free из MainMenu её уничтожит
end;

procedure TFormLessonDraw.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  FormDlg: TForm;
  DialogResult: Integer;
begin
  // 1. Создаем форму диалога в памяти
  FormDlg := CreateMessageDialog('Вы хотите сохранить текущий рисунок перед выходом?',
    mtConfirmation, [mbYes, mbNo, mbCancel]);

  try
    // 2. Переводим текст на кнопках на русский язык
    TButton(FormDlg.FindComponent('Yes')).Caption := 'Да';
    TButton(FormDlg.FindComponent('No')).Caption := 'Нет';
    TButton(FormDlg.FindComponent('Cancel')).Caption := 'Отмена';

    // 3. Устанавливаем заголовок самого окошка
    FormDlg.Caption := 'Сохранение рисунка';

    // 4. Показываем окно ученику и получаем его выбор
    DialogResult := FormDlg.ShowModal;
  finally
    // 5. Обязательно освобождаем память, удаляя форму диалога
    FormDlg.Free;
  end;

  // Обрабатываем выбор ученика
  case DialogResult of
    // 1. Ученик нажал "ДА"
    mrYes:
      begin
        if SavePictureDialog1.Execute then
        begin
          // Место для вашей логики записи файла на диск (например, Image1.Picture.SaveToFile...)
          CanClose := True;
        end
        else
        begin
          // Если передумал сохранять внутри окна Windows, не закрываем программу
          CanClose := False;
        end;
      end;

    // 2. Ученик нажал "НЕТ" -> закрываем без сохранения
    mrNo:
      begin
        CanClose := True;
      end;

    // 3. Ученик нажал "ОТМЕНА" (или крестик диалога) -> отменяем выход
    mrCancel:
      begin
        CanClose := False;
      end;
  end;
end;


procedure TFormLessonDraw.FormCreate(Sender: TObject);
var
  I: Integer;
begin
 // Включаем идеальное центрирование для референса
  ImageReference.Proportional := True;
  ImageReference.Stretch := True;
  ImageReference.Center := True; // <-- ОБЯЗАТЕЛЬНО ДОБАВИТЬ ЭТУ СТРОКУ

  // Делаем то же самое для примера шага урока, чтобы он тоже не съезжал
  ImagePrimer.Proportional := True;
  ImagePrimer.Stretch := True;
  ImagePrimer.Center := True; // <-- И ЭТУ СТРОКУ ТОЖЕ

  // Связываем маленькие квадраты истории с массивом
  FColorHistoryShapes[1] := Shape1;
  FColorHistoryShapes[2] := Shape2;
  FColorHistoryShapes[3] := Shape3;
  FColorHistoryShapes[4] := Shape4;

  // Главный актуальный цвет — черный
  SelectedColor := clBlack;
  shCurrentColor.Brush.Color := clBlack;

  // Все архивные ячейки изначально пустые (белые)
  for I := 1 to 4 do
  begin
    FColorHistoryShapes[I].Brush.Color := clWhite;
    FColorHistoryShapes[I].Pen.Color := clGray; // Серая рамка
  end;

  UndoList := TObjectList<TBitmap>.Create(True);
  RedoList := TObjectList<TBitmap>.Create(True);

  ImageCanvas.Picture.Bitmap.SetSize(ImageCanvas.Width, ImageCanvas.Height);
  ImageCanvas.Picture.Bitmap.Canvas.Brush.Color := clWhite;
  ImageCanvas.Picture.Bitmap.Canvas.FillRect(Rect(0, 0, ImageCanvas.Width, ImageCanvas.Height));

 // Отрываем форму от родительского окна и выводим на панель задач
 SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
 UpdateStep(1, 1);
 UpdateReference(1); // Загружаем первый вариант референса по умолчанию при старте

end;

procedure TFormLessonDraw.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Проверяем, зажат ли Ctrl
  if ssCtrl in Shift then
  begin
    case Key of
      // Буква 'Z' (ord возвращает код символа)
      Ord('Z'), Ord('z'):
        begin
          PerformUndo;
          Key := 0; // Сбрасываем клавишу, чтобы система не обрабатывала её дальше
        end;

      // Буква 'Y'
      Ord('Y'), Ord('y'):
        begin
          PerformRedo;
          Key := 0; // Сбрасываем клавишу
        end;
    end;
  end;
end;

procedure TFormLessonDraw.ImageCanvasMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
  begin
    HandleScreenPipette;
    Exit;
  end;

  if Button = mbLeft then
  begin
    SaveStateForUndo;
    FIsDrawing := True;
    FLastX := X;
    FLastY := Y;

    if FEraserMode then
    begin
      IntrumentIND.Caption := 'Выбранный инструмент: Ластик';
      ImageCanvas.Picture.Bitmap.Canvas.Pen.Color := clWhite;
      // Ластик будет в 4 раза толще текущего значения ползунка
      ImageCanvas.Picture.Bitmap.Canvas.Pen.Width := tbPenWidth.Position * 4;
    end
    else
    begin
      IntrumentIND.Caption := 'Выбранный инструмент: Карандаш';
      ImageCanvas.Picture.Bitmap.Canvas.Pen.Color := SelectedColor;
      // ИСПРАВЛЕНИЕ: Берем толщину карандаша напрямую из ползунка
      ImageCanvas.Picture.Bitmap.Canvas.Pen.Width := tbPenWidth.Position;
    end;

    ImageCanvas.Picture.Bitmap.Canvas.MoveTo(X, Y);
    ImageCanvas.Picture.Bitmap.Canvas.LineTo(X, Y);

    ImageCanvas.Invalidate;
  end;
end;

procedure TFormLessonDraw.ImageCanvasMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if not FIsDrawing then Exit;

  if FEraserMode then
  begin
    ImageCanvas.Picture.Bitmap.Canvas.Pen.Color := clWhite;
    // Синхронизируем ластик с ползунком (в 4 раза толще)
    ImageCanvas.Picture.Bitmap.Canvas.Pen.Width := tbPenWidth.Position * 4;
  end
  else
  begin
    ImageCanvas.Picture.Bitmap.Canvas.Pen.Color := SelectedColor;
    // ИСПРАВЛЕНИЕ: Берем динамическую толщину карандаша из ползунка
    ImageCanvas.Picture.Bitmap.Canvas.Pen.Width := tbPenWidth.Position;
  end;

  ImageCanvas.Picture.Bitmap.Canvas.MoveTo(FLastX, FLastY);
  ImageCanvas.Picture.Bitmap.Canvas.LineTo(X, Y);

  FLastX := X;
  FLastY := Y;

  ImageCanvas.Invalidate;
end;

procedure TFormLessonDraw.ImageCanvasMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    FIsDrawing := False;
end;

procedure TFormLessonDraw.ImageReferenceMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Если нажата правая кнопка мыши на референсе — берем цвет с экрана
  if Button = mbRight then
  begin
    HandleScreenPipette;
  end;
end;

procedure TFormLessonDraw.L1_MenuStepClick(Sender: TObject);
var
  ClickedItem: TMenuItem;
  ParentMenu: TPopupMenu;
  SelectedLesson: Integer;
  SelectedStep: Integer;
begin
  ClickedItem := Sender as TMenuItem;

  // 1. Узнаем номер шага из свойства Tag самого пункта меню (1, 2 или 3)
  SelectedStep := ClickedItem.Tag;

  // 2. Определяем, какому именно меню принадлежит этот пункт
  ParentMenu := ClickedItem.GetParentMenu as TPopupMenu;

  // 3. Вычисляем номер урока по имени выпадающего меню
  if ParentMenu = LessonMenu1 then SelectedLesson := 1
  else if ParentMenu = LessonMenu2 then SelectedLesson := 2
  else if ParentMenu = LessonMenu3 then SelectedLesson := 3
  else Exit;

  // 4. Обновляем нижнюю панель с текстом и графикой
  CheckAndChangeLesson(SelectedLesson, SelectedStep);
end;

procedure TFormLessonDraw.L2_MenuStepClick(Sender: TObject);
var
  ClickedItem: TMenuItem;
  ParentMenu: TPopupMenu;
  SelectedLesson: Integer;
  SelectedStep: Integer;
begin
  ClickedItem := Sender as TMenuItem;

  // 1. Узнаем номер шага из свойства Tag самого пункта меню (1, 2 или 3)
  SelectedStep := ClickedItem.Tag;

  // 2. Определяем, какому именно меню принадлежит этот пункт
  ParentMenu := ClickedItem.GetParentMenu as TPopupMenu;

  // 3. Вычисляем номер урока по имени выпадающего меню
  if ParentMenu = LessonMenu1 then SelectedLesson := 1
  else if ParentMenu = LessonMenu2 then SelectedLesson := 2
  else if ParentMenu = LessonMenu3 then SelectedLesson := 3
  else Exit;

  // 4. Обновляем нижнюю панель с текстом и графикой
  CheckAndChangeLesson(SelectedLesson, SelectedStep);
end;

procedure TFormLessonDraw.L3_MenuStepClick(Sender: TObject);
var
  ClickedItem: TMenuItem;
  ParentMenu: TPopupMenu;
  SelectedLesson: Integer;
  SelectedStep: Integer;
begin  ClickedItem := Sender as TMenuItem;

  // 1. Узнаем номер шага из свойства Tag самого пункта меню (1, 2 или 3)
  SelectedStep := ClickedItem.Tag;

  // 2. Определяем, какому именно меню принадлежит этот пункт
  ParentMenu := ClickedItem.GetParentMenu as TPopupMenu;

  // 3. Вычисляем номер урока по имени выпадающего меню
  if ParentMenu = LessonMenu1 then SelectedLesson := 1
  else if ParentMenu = LessonMenu2 then SelectedLesson := 2
  else if ParentMenu = LessonMenu3 then SelectedLesson := 3
  else Exit;

  // 4. Обновляем нижнюю панель с текстом и графикой
  CheckAndChangeLesson(SelectedLesson, SelectedStep);
end;

procedure TFormLessonDraw.UpdateStep(LessonID, StepNum: Integer);
var
  ExePath: string;        // Путь к папке с программой
  TextFilePath: string;   // Полный путь к файлу lessons.txt
  ImageFilePath: string;  // Полный путь к картинке текущего шага
  FileLines: TStringList; // Список для чтения строк файла
  Marker: string;         // Искомый тег, например: [L2_S1]
  CurrentLine: string;    // Текущая проверяемая строка файла
  I: Integer;             // Счетчик для цикла
  IsReading: Boolean;     // Флаг: читаем ли мы нужный текст прямо сейчас
begin
  // 1. Сохраняем переданные параметры в переменные формы
  CurrentLesson := LessonID;
  Labellesson.Caption := 'Урок ' + IntToStr(LessonID);

  CurrentStep := StepNum;
  LabelPrimer.Caption := 'Пример для шага ' + IntToStr(StepNum);

  // 2. Управляем доступностью кнопок-стрелок на границах (1 и 3 шаги)
  BTNleft.Enabled := (CurrentStep > 1);
  BTNright.Enabled := (CurrentStep < 3);

  // 3. Формируем правильные пути к файлам относительно нашего .exe
  ExePath := ExtractFilePath(ParamStr(0));
  TextFilePath := ExePath + 'data\lessons.txt';

  // Модифицировано: Имя картинки теперь зависит от урока, номера шага и активного референса (CurrentRef)
  ImageFilePath := ExePath + Format('resources\lesson%d\step%d_ref%d.png', [CurrentLesson, CurrentStep, CurrentRef]);

  // 4. Очищаем текстовое поле перед выводом новой инструкции
  TextLessonSteps.Clear;

  // 5. ЗАГРУЗКА И ПОИСК ТЕКСТА
  Marker := Format('[L%d_S%d]', [CurrentLesson, CurrentStep]);
  FileLines := TStringList.Create;
  try
    if FileExists(TextFilePath) then
    begin
      // Загружаем файл с явным указанием UTF8 для поддержки кириллицы
      FileLines.LoadFromFile(TextFilePath, TEncoding.UTF8);
      IsReading := False;

      // Бежим по всем строкам текстового файла
      for I := 0 to FileLines.Count - 1 do
      begin
        CurrentLine := Trim(FileLines[I]);

        // Если строка является маркером (начинается на '[')
        if (CurrentLine <> '') and (CurrentLine[1] = '[') then
        begin
          // Если мы уже читали наш текст и наткнулись на СЛЕДУЮЩИЙ маркер — прекращаем чтение
          if IsReading then Break;

          // Если маркер совпал с искомым (например, [L1_S2]) — включаем режим чтения
          if CurrentLine = Marker then
          begin
            IsReading := True;
            Continue; // Переходим к следующей строке (сам маркер выводить в Memo не нужно)
          end;
        end;

        // Если флаг чтения активен, добавляем строку в текстовое поле
        if IsReading then
          TextLessonSteps.Lines.Add(FileLines[I]);
      end;
    end
    else
    begin
      TextLessonSteps.Lines.Add('Ошибка: Файл с инструкциями не найден!');
      TextLessonSteps.Lines.Add('Ожидаемый путь: ' + TextFilePath);
    end;
  finally
    FileLines.Free; // Обязательно освобождаем память
  end;

  // 6. ЗАГРУЗКА ИЗОБРАЖЕНИЯ-ПРИМЕРА
  if FileExists(ImageFilePath) then
  begin
    ImagePrimer.Picture.LoadFromFile(ImageFilePath);
  end;
end;

procedure TFormLessonDraw.SaveCanvasToFile;
var
  PNG: TPngImage;
begin
  // Проверяем, что холст инициализирован и размеры корректны
  if (ImageCanvas.Picture.Bitmap = nil) or (ImageCanvas.Picture.Bitmap.Width <= 0) then
  begin
    ShowMessage('Холст пуст, сохранять нечего!');
    Exit;
  end;

  // Открываем графическое окно сохранения Windows с панелью предпросмотра
  if SavePictureDialog1.Execute then
  begin
    // Проверяем выбор пользователя в выпадающем списке форматов (1-я строка — PNG)
    if SavePictureDialog1.FilterIndex = 1 then
    begin
      // === СОХРАНЕНИЕ В ФОРМАТ PNG ===
      PNG := TPngImage.Create;
      try
        // Переносим пиксели холста в объект PNG
        PNG.Assign(ImageCanvas.Picture.Bitmap);
        // Записываем файл на диск
        PNG.SaveToFile(SavePictureDialog1.FileName);
      finally
        PNG.Free;
      end;
    end
    else
    begin
      // === СОХРАНЕНИЕ В РОДНОЙ ФОРМАТ BMP ===
      ImageCanvas.Picture.Bitmap.SaveToFile(SavePictureDialog1.FileName);
    end;

    ShowMessage('Рисунок успешно сохранен!');
  end;
end;

end.

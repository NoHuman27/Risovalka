unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Unit1, Unit3, System.IOUtils, System.UITypes, System.Types,
  Vcl.Imaging.pngimage, System.Generics.Defaults, System.Generics.Collections,
  System.DateUtils, Winapi.GDIPOBJ, Winapi.GDIPAPI, LessonUnit;

type
  TMainMenu = class(TForm)
    PanelMain: TPanel;
    PanelButton: TPanel;
    ButtonEXIT: TButton;
    ButtonDRAWINGINSTRUCTIONS: TButton;
    REFERENCEbutton: TButton;
    ButtonOPENFILE: TButton;
    ButtonCREATEFILE: TButton;
    PanelHistoryPictures: TPanel;
    PanelCaption: TPanel;
    LabelPI: TLabel;
    FlowPanel1: TFlowPanel;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    PanelСapHis: TPanel;
    Panel2: TPanel;
    Image2: TImage;
    Label2: TLabel;
    Panel3: TPanel;
    Image3: TImage;
    Label3: TLabel;
    Panel4: TPanel;
    Image4: TImage;
    Label4: TLabel;
    Panel5: TPanel;
    Image5: TImage;
    Label5: TLabel;
    Panel6: TPanel;
    Image6: TImage;
    Label6: TLabel;
    Panel7: TPanel;
    Image7: TImage;
    Label7: TLabel;
    Panel8: TPanel;
    Image8: TImage;
    Label8: TLabel;
    Panel9: TPanel;
    Image9: TImage;
    Label9: TLabel;
    Panel10: TPanel;
    Image10: TImage;
    Label10: TLabel;
    Panel11: TPanel;
    Image11: TImage;
    Label11: TLabel;
    Panel12: TPanel;
    Image12: TImage;
    Label12: TLabel;
    Panel13: TPanel;
    Image13: TImage;
    Label13: TLabel;
    Panel14: TPanel;
    Image14: TImage;
    Label14: TLabel;
    Panel15: TPanel;
    Image15: TImage;
    Label15: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ButtonEXITClick(Sender: TObject);
    procedure ButtonCREATEFILEClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonOPENFILEClick(Sender: TObject);
    procedure REFERENCEbuttonClick(Sender: TObject);
    procedure ButtonDRAWINGINSTRUCTIONSClick(Sender: TObject);

  private
    { Private declarations }
    HelpFrame: TFrame;

    procedure HistoryImageClick(Sender: TObject); // Метод для клика
    procedure HistoryItemMouseEnter(Sender: TObject);
    procedure HistoryItemMouseLeave(Sender: TObject);


protected
  procedure CreateParams(var Params: TCreateParams); override;

  public
    { Public declarations }
     procedure UpdateHistory;

  end;

var
  MainMenu: TMainMenu;

implementation

uses Unit4;
{$R *.dfm}

procedure TMainMenu.ButtonOPENFILEClick(Sender: TObject);
begin
  // 1. Принудительно вызываем диалог открытия файла, который находится на форме рисования
  FormToCanvas.OpenFileClick(Self);
  // 2. Проверяем, выбрал ли пользователь файл (если файл открылся, путь не будет пустым)
  if FormToCanvas.CurrentFilePath <> '' then
  begin
    // Скрываем главное меню, чтобы оно не мешало рисованию
    Self.Hide;  // Показываем форму рисования и выводим её на передний план
    FormToCanvas.Show;
    FormToCanvas.WindowState := wsMaximized; // Распахиваем на весь экран (опционально)
  end;
end;

procedure TMainMenu.ButtonCREATEFILEClick(Sender: TObject);
begin
 FormCreateFile.ShowModal;
end;

procedure TMainMenu.ButtonDRAWINGINSTRUCTIONSClick(Sender: TObject);
begin
  MainMenu.Hide;
  // Создаем форму строго в момент нажатия кнопки
  FormLessonDraw := TFormLessonDraw.Create(Application);
  try
    FormLessonDraw.ShowModal;
  finally
    FormLessonDraw.Free;   // Гарантированно уничтожаем и освобождаем память
    FormLessonDraw := nil; // Обнуляем указатель во избежание багов
  end;
  MainMenu.Show;
  MainMenu.Repaint;
end;


procedure TMainMenu.ButtonEXITClick(Sender: TObject);
begin
close;
Application.Terminate;
end;

procedure TMainMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TMainMenu.FormCreate(Sender: TObject);
begin
 PanelMain.Align := alClient;
 UpdateHistory;
end;

procedure TMainMenu.HistoryImageClick(Sender: TObject);
var
  ClickedImage: TImage;
  FileToOpen: string;
  BackgroundLayer: TLayer;
  GPImage: TGPImage;
  GPGraphics: TGPGraphics;
  W, H: Integer;
  Backup: TBitmap;
begin
  if not (Sender is TImage) then Exit;

  ClickedImage := TImage(Sender);
  FileToOpen := ClickedImage.Hint; // Получаем полный путь к сохраненному файлу

  // Проверяем, существует ли файл физически на диске
  if not FileExists(FileToOpen) then
  begin
    ShowMessage('Ошибка: Файл проекта не найден на диске!');
    Exit;
  end;

  // Указываем форме редактора текущий путь к файлу
  FormToCanvas.CurrentFilePath := FileToOpen;

  // ЗАПУСКАЕМ ВАШ АЛГОРИТМ ИНИЦИАЛИЗАЦИИ СЛОЕВ И ХОЛСТА
  GPImage := TGPImage.Create(FileToOpen);
  try
    W := GPImage.GetWidth;
    H := GPImage.GetHeight;

    if (W <= 0) or (H <= 0) then
    begin
      ShowMessage('Ошибка чтения размеров файла!');
      Exit;
    end;

    // Полностью очищаем старую систему слоев на форме редактора
    if FormToCanvas.Layers <> nil then
      FormToCanvas.Layers.Clear
    else
      FormToCanvas.Layers := TObjectList<TLayer>.Create(True);

    // Создаем новый фоновый слой ПРАВИЛЬНОГО размера
    BackgroundLayer := TLayer.Create(W, H);
    BackgroundLayer.Name := 'Фон';

    // Настраиваем битмап слоя как 32-битный непрозрачный
    BackgroundLayer.Bitmap.PixelFormat := pf32bit;
    BackgroundLayer.Bitmap.AlphaFormat := afDefined;

    // Используя GDI+, аппаратно рисуем открытый файл внутрь битмапа фонового слоя
    GPGraphics := TGPGraphics.Create(BackgroundLayer.Bitmap.Canvas.Handle);
    try
      GPGraphics.DrawImage(GPImage, 0, 0, W, H);
    finally
      GPGraphics.Free;
    end;

    // Принудительно выставляем альфа-канал фонового слоя в 255
    BackgroundLayer.Bitmap.Canvas.MoveTo(0, 0);

    // Добавляем слой в список редактора и делаем его активным
    FormToCanvas.Layers.Add(BackgroundLayer);
    FormToCanvas.ActiveLayerIndex := 0;

    // Синхронизируем размеры результирующего Image1 на холсте
    FormToCanvas.Image1.Picture.Bitmap.Handle := 0;
    FormToCanvas.Image1.Picture.Bitmap.SetSize(W, H);
    FormToCanvas.Image1.Picture.Bitmap.PixelFormat := pf32bit;
    FormToCanvas.Image1.Picture.Bitmap.AlphaFormat := afDefined;

    // Сбрасываем историю Undo/Redo редактора
    if FormToCanvas.UndoList <> nil then FormToCanvas.UndoList.Free;
    FormToCanvas.UndoList := TObjectList<TBitmap>.Create(True);

    if FormToCanvas.RedoList <> nil then FormToCanvas.RedoList.Free;
    FormToCanvas.RedoList := TObjectList<TBitmap>.Create(True);

    // Сохраняем открытую картинку как стартовую точку истории
    Backup := TBitmap.Create;
    Backup.Assign(BackgroundLayer.Bitmap);
    FormToCanvas.UndoList.Add(Backup);

    // Обновляем список слоев в интерфейсе редактора (ListBox)
    FormToCanvas.UpdateLayersUI;

    // Центрируем, масштабируем и собираем экран
    FormToCanvas.FitToScreen;
    FormToCanvas.RenderLayers;

  finally
    GPImage.Free;
  end;

  // ПЕРЕКЛЮЧАЕМ ОКНА
  Self.Hide;         // Скрываем форму Главного меню
  FormToCanvas.Show; // Открываем форму графического редактора
  FormToCanvas.CenterCanvas; // Центрируем перед показом формы редактора
end;

procedure TMainMenu.HistoryItemMouseEnter(Sender: TObject);
var
  TargetPanel: TPanel;
begin
  // Определяем, на что именно навели (на саму панель, картинку или текст)
  if Sender is TPanel then
    TargetPanel := TPanel(Sender)
  else if Sender is TControl then
    TargetPanel := TPanel(TControl(Sender).Parent)
  else
    Exit;

// Было: TargetPanel.BevelOuter := bvSingle;
  TargetPanel.BorderStyle := bsSingle; // Стало (включает плоскую рамку)
  TargetPanel.Color := $00F5F5F5;     // Легкий светло-серый фон (Hex: #F5F5F5)
  TargetPanel.ParentBackground := False; // Разрешаем панели менять цвет фона
end;

procedure TMainMenu.HistoryItemMouseLeave(Sender: TObject);
var
  TargetPanel: TPanel;
begin
  if Sender is TPanel then
    TargetPanel := TPanel(Sender)
  else if Sender is TControl then
    TargetPanel := TPanel(TControl(Sender).Parent)
  else
    Exit;

  // Проверяем, действительно ли курсор покинул всю область карточки
  // (чтобы избежать мерцания при переходе с панели на картинку)
  if not TargetPanel.ClientRect.Contains(TargetPanel.ScreenToClient(Mouse.CursorPos)) then
  begin
    TargetPanel.BorderStyle := bsNone; // Стало (отключает рамку)
    TargetPanel.ParentBackground := True; // Возвращаем прозрачность
  end;
end;

procedure TMainMenu.REFERENCEbuttonClick(Sender: TObject);
begin
  if not Assigned(HelpFrame) then
  begin
    // 1. Создаем фрейм справки
    HelpFrame := TUnitFrameHelp1.Create(Self);
    HelpFrame.Parent := Self;

    // 2. Настраиваем его положение на форме
    HelpFrame.Left := 200;
    HelpFrame.Top := 50;
    HelpFrame.Align := alNone;

    // Запрещаем пользователю редактировать текст справки
    TUnitFrameHelp1(HelpFrame).memohelp.ReadOnly := True;
  end;

  // 4. Показываем фрейм на переднем плане
  HelpFrame.Visible := True;
  HelpFrame.BringToFront;
end;

procedure TMainMenu.UpdateHistory;
var
  HistoryFile: string;
  HistoryList: TStringList;
  ValidFiles: TStringList;
  ItemPanel: TPanel;
  NewImg: TImage;
  NewLbl: TLabel;
  Count: Integer;
  i: Integer;
  ItemWidth, ItemHeight: Integer;
  SpacingX, SpacingY: Integer;
  CustomHint: string;
  // Переменные для правильного совмещения прозрачности с белым фоном
  Png: TPngImage;
  Bmp: TBitmap;
begin
  // 1. Очищаем старые контейнеры с панели на экране
  while PanelHistoryPictures.ControlCount > 0 do
       PanelHistoryPictures.Controls[0].Free;

  // 2. Ищем файл истории history.dat рядом с .exe
  HistoryFile := TPath.Combine(ExtractFilePath(ParamStr(0)), 'history.dat');
  if not FileExists(HistoryFile) then
    Exit; // Если истории еще нет, просто выходим

  HistoryList := TStringList.Create;
  ValidFiles := TStringList.Create;
  try
    // Загружаем все сохраненные ранее пути
    HistoryList.LoadFromFile(HistoryFile);

    for i := 0 to HistoryList.Count - 1 do
    begin
      if FileExists(HistoryList[i]) then
        ValidFiles.Add(HistoryList[i]);
    end;

    // СРАЗУ ОБНОВЛЯЕМ ФАЙЛ НА ДИСКЕ: записываем только существующие пути!
    ValidFiles.SaveToFile(HistoryFile);

    // Определяем, сколько карточек выводить (максимум 16 для сетки 4х4)
    Count := ValidFiles.Count;
    if Count > 16 then
      Count := 16;

    if Count = 0 then
      Exit;

    // Размеры одной карточки и отступы
    ItemWidth := 120;
    ItemHeight := 145;
    SpacingX := 30;
    SpacingY := 25;

    // 3. Динамически создаем элементы на панели из отфильтрованного списка
    for i := 0 to Count - 1 do
    begin
      // Формируем красивый многострочный текст подсказки при наведении мыши
      CustomHint := 'Проект: ' + TPath.GetFileNameWithoutExtension(ValidFiles[i]) + #13#10 +
                    'Формат: ' + UpperCase(Copy(TPath.GetExtension(ValidFiles[i]), 2, 3)) + #13#10 +
                    'Изменен: ' + DateTimeToStr(TFile.GetLastWriteTime(ValidFiles[i]));

      // А) Контейнер-подложка
      ItemPanel := TPanel.Create(PanelHistoryPictures);
      ItemPanel.Parent := PanelHistoryPictures;
      ItemPanel.Width := ItemWidth;
      ItemPanel.Height := ItemHeight;
      ItemPanel.Left := 20 + (i mod 4) * (ItemWidth + SpacingX);
      ItemPanel.Top := 20 + (i div 4) * (ItemHeight + SpacingY);
      ItemPanel.BevelOuter := bvNone;
      ItemPanel.ParentBackground := True;

      ItemPanel.OnMouseEnter := HistoryItemMouseEnter;
      ItemPanel.OnMouseLeave := HistoryItemMouseLeave;
      ItemPanel.Hint := CustomHint;
      ItemPanel.ShowHint := True;

      // Б) Миниатюра картинки
      NewImg := TImage.Create(ItemPanel);
      NewImg.Parent := ItemPanel;
      NewImg.Left := 6;
      NewImg.Top := 6;
      NewImg.Width := ItemWidth - 12;
      NewImg.Height := 104;
      NewImg.Proportional := True;
      NewImg.Stretch := True;

      // КРИТИЧЕСКИ ВАЖНО: Выключаем Transparent, чтобы не ломать альфа-канал!
      NewImg.Transparent := False;

      // === БЛОК СЛИЯНИЯ ТЕКСТУРЫ PNG С БЕЛЫМ ФОНОМ В ПАМЯТИ ===
      if SameText(TPath.GetExtension(ValidFiles[i]), '.png') then
      begin
        Png := TPngImage.Create;
        Bmp := TBitmap.Create;
        try
          Png.LoadFromFile(ValidFiles[i]);

          // Подгоняем размеры белого холста под размеры загруженного PNG
          Bmp.SetSize(Png.Width, Png.Height);

          // Заливаем холст сплошным чистым белым цветом
          Bmp.Canvas.Brush.Color := clWhite;
          Bmp.Canvas.FillRect(Rect(0, 0, Png.Width, Png.Height));

          // Рисуем PNG поверх белого холста (альфа-канал наложится идеально встроенными средствами Windows)
          Bmp.Canvas.Draw(0, 0, Png);

          // Загружаем получившийся готовый рисунок без прозрачности в TImage
          NewImg.Picture.Assign(Bmp);
        finally
          Png.Free;
          Bmp.Free;
        end;
      end
      else
      begin
        // Для JPG и BMP оставляем стандартную загрузку
        NewImg.Picture.LoadFromFile(ValidFiles[i]);
      end;
      // =======================================================

      NewImg.Hint := ValidFiles[i];
      NewImg.ShowHint := False;

      NewImg.OnClick := HistoryImageClick;
      NewImg.OnMouseEnter := HistoryItemMouseEnter;
      NewImg.OnMouseLeave := HistoryItemMouseLeave;

      // В) Текстовая подпись под картинкой
      NewLbl := TLabel.Create(ItemPanel);
      NewLbl.Parent := ItemPanel;
      NewLbl.Left := 0;
      NewLbl.Top := 115;
      NewLbl.Width := ItemWidth;
      NewLbl.Alignment := taCenter;
      NewLbl.AutoSize := False;
      NewLbl.Caption := TPath.GetFileNameWithoutExtension(ValidFiles[i]);
      NewLbl.Font.Name := 'Segoe UI';
      NewLbl.Font.Size := 9;
      NewLbl.Font.Color := clBlack;

      NewLbl.OnMouseEnter := HistoryItemMouseEnter;
      NewLbl.OnMouseLeave := HistoryItemMouseLeave;
      NewLbl.OnClick := HistoryImageClick;
      NewLbl.Hint := CustomHint;
      NewLbl.ShowHint := True;

      ItemPanel.Visible := True;
      ItemPanel.BringToFront;
    end;

  finally
    HistoryList.Free;
    ValidFiles.Free;
  end;
end;

procedure TMainMenu.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  // Превращаем главное окно в ToolWindow (оно исчезнет с панели задач)
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW;
end;

end.

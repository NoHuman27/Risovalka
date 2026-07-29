unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections, Unit3;

type
  TFormCreateFile = class(TForm)
    ButtonCreateCanvas: TButton;
    Label2: TLabel;
    RadioGroup1: TRadioGroup;
    EditWidth: TEdit;
    EditHeight: TEdit;
    Label1: TLabel;
    на: TLabel;
    procedure ButtonCreateCanvasClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure EditWidthChange(Sender: TObject);
    procedure EditHeightChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCreateFile: TFormCreateFile;
  CanvasWidth, CanvasHeight: integer;

implementation

uses Unit2;

{$R *.dfm}

procedure TFormCreateFile.ButtonCreateCanvasClick(Sender: TObject);
begin
  // 1. Определяем размеры на основе выбора пользователя
  if RadioGroup1.ItemIndex = 5 then
  begin
    CanvasWidth := StrToIntDef(EditWidth.Text, 800);
    CanvasHeight := StrToIntDef(EditHeight.Text, 600);
  end;

  // Сбрасываем путь к старому файлу для работы быстрого сохранения (Ctrl+S)
  FormToCanvas.CurrentFilePath := '';

  // 2. Вызываем метод создания холста и истории
  FormToCanvas.CreateNewCanvas(CanvasWidth, CanvasHeight);

  // Настройка начальной толщины пера
  FormToCanvas.Image1.Picture.Bitmap.Canvas.Pen.Width := FormToCanvas.PenWidth.Position;

  // 3. Скрываем интерфейс главного меню СНАЧАЛА
  // (Чтобы Windows успела пересчитать размеры рабочего стола ДО центрирования холста)
  if MainMenu.Visible then
  begin
    ShowWindow(Application.Handle, SW_HIDE);
    MainMenu.Hide;
  end;

  // 4. Показываем форму рисования
  FormToCanvas.Show;
  if FormToCanvas.WindowState = wsMinimized then
    FormToCanvas.WindowState := wsNormal;

  FormToCanvas.BringToFront;
  FormToCanvas.SetFocus;

  if FormToCanvas.CanvasPanel.CanFocus then
    FormToCanvas.CanvasPanel.SetFocus;

  // === КРИТИЧЕСКОЕ ИСПРАВЛЕНИЕ ДЛЯ ЦЕНТРИРОВАНИЯ ===
  // Принудительно заставляем Windows обработать все изменения размеров окон
  Application.ProcessMessages;

  // Теперь, когда Главное меню скрыто, а холст отображен,
  // вызываем центрирование. Размеры будут рассчитаны идеально!
  FormToCanvas.FitToScreen;
  FormToCanvas.RenderLayers; // Перерисовываем экран под новые координаты
  // =================================================

  Close; // Закрываем окно создания файла
end;

procedure TFormCreateFile.EditHeightChange(Sender: TObject);
begin
  CanvasHeight := StrToIntDef(EditHeight.Text, 100); // Было CanvasWidth
  label1.Caption := 'Вы создаёте пустой лист ' + EditWidth.Text + ' на ' + EditHeight.Text;
  RadioGroup1.ItemIndex := 5;
end;

procedure TFormCreateFile.EditWidthChange(Sender: TObject);
begin
 CanvasWidth:= StrToIntDef(EditWidth.Text, 100);
 label1.Caption:= 'Вы создаёте пустой лист ' + EditWidth.Text + ' на ' + EditHeight.Text;
 RadioGroup1.ItemIndex:= 5;
end;

procedure TFormCreateFile.FormCreate(Sender: TObject);
begin
RadioGroup1.ItemIndex := 5;
end;

procedure TFormCreateFile.RadioGroup1Click(Sender: TObject);
  //var W,H: integer;
begin
Case RadioGroup1.ItemIndex of
 0:
   Begin
   label1.Caption:= 'Вы создаёте лист формата A5';
   CanvasWidth:= 1748;
   CanvasHeight:= 2480;
   end;
 1:
   Begin
   label1.Caption:= 'Вы создаёте лист формата A4';
   CanvasWidth:= 2480;
   CanvasHeight:= 3508;
   end;
 2:
   Begin
   label1.Caption:= 'Вы создаёте лист формата A3';
   CanvasWidth:= 3508;
   CanvasHeight:= 4961;
   end;
 3:
   Begin
    label1.Caption:= 'Вы создаёте лист формата A2';
   CanvasWidth:= 4961;
   CanvasHeight:= 7016;
   end;
 4:
   Begin
   label1.Caption:= 'Вы создаёте лист формата A1';
   CanvasWidth:= 7016;
   CanvasHeight:= 9933;
   end;
 5:                    //Пользовательская настройка
   Begin
    CanvasWidth:= StrToIntDef(EditHeight.Text, 100);
    CanvasWidth:= StrToIntDef(EditWidth.Text, 100);
   label1.Caption:= 'Вы создаёте пустой лист ' + EditWidth.Text + ' на ' + EditHeight.Text;
   end;
end;
end;

end.

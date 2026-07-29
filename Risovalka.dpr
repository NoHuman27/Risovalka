program Risovalka;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {MainMenu},
  Unit1 in 'Unit1.pas' {FormCreateFile},
  Unit3 in 'Unit3.pas' {FormToCanvas},
  Vcl.Themes,
  Vcl.Styles,
  Unit4 in 'Unit4.pas' {UnitFrameHelp1: TFrame},
  UnitCanvasHelp in 'UnitCanvasHelp.pas' {FrameHelpCanvas: TFrame},
  LessonUnit in 'LessonUnit.pas' {FormLessonDraw};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Light');
  Application.CreateForm(TMainMenu, MainMenu);
  Application.CreateForm(TFormCreateFile, FormCreateFile);
  Application.CreateForm(TFormToCanvas, FormToCanvas);
  Application.CreateForm(TFormLessonDraw, FormLessonDraw);
  Application.Run;
end.

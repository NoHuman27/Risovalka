unit UnitCanvasHelp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrameHelpCanvas = class(TFrame)
    Panel: TPanel;
    Memo: TMemo;
    ButtonBack: TButton;
    procedure ButtonBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrameHelpCanvas.ButtonBackClick(Sender: TObject);
begin
 Self.Visible := False; // Фрейм станет невидимым и полностью исчезнет с экрана
end;


end.

unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TUnitFrameHelp1 = class(TFrame)
    memohelp: TMemo;
    Buttonback: TButton;
    Panel1: TPanel;
    procedure ButtonbackClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

  end;

implementation

{$R *.dfm}


procedure TUnitFrameHelp1.ButtonbackClick(Sender: TObject);
begin
  Self.Visible := False; // Фрейм станет невидимым и полностью исчезнет с экрана
end;

end.

unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, SortGrid;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;



var
  Form1: TForm1;
  SortGrid1 : TSortGrid;

implementation


{$R *.lfm}

{ TForm1 }

procedure TForm1.FormActivate(Sender: TObject);
var
  x, y: integer;
  ClickedOK: boolean;
  Zeilen: string;
  val: double;
  Grid : TSortGrid;
begin
  try
    Grid := SortGrid1;

    Application.ProcessMessages;


    Randomize;

    Zeilen := '50';

    //ClickedOK := InputQuery('Insert Test-Data into Grid', 'Insert how many lines?', Zeilen);

    ClickedOK := true;
    if ClickedOK then
    begin
      Grid.Columns.Clear;

      for x := 0 to 5 do
      begin
        Grid.Columns.Add;
      end;



      Grid.RowCount := StrToIntDef(Zeilen, 1);
      Grid.Columns[0].Title.Caption:='Integer';
      Grid.Columns[1].Title.Caption:='Float';
      Grid.Columns[2].Title.Caption:='Date';
      Grid.Columns[3].Title.Caption:='DateTime';
      Grid.Columns[4].Title.Caption:='Time';
      Grid.Columns[5].Title.Caption:='String';
      Application.ProcessMessages;
    end;

    (* Testdaten eintragen *)
    (* Zeile *)
    for x := 1 to Grid.RowCount - 1 do
    begin
      (* Spalte *)
      for y := 0 to Grid.ColCount - 1 do
      begin
        case y of
          0: (* integer *)
          begin
            Grid.Cells[y, x] := IntToStr(Random(10000));
          end;
          1: (* Float *)
          begin
            Grid.Cells[y, x] := FormatFloat('0.00',Random(10000) * Random());
          end;
          2: (* Date *)
          begin
            Grid.Cells[y, x] := FormatDateTime('dd.mm.yyyy',Date + x);
          end;
          3: (* DateTime *)
          begin
            Grid.Cells[y, x] := FormatDateTime('dd.mm.yyyy hh:nn:ss',Date +  Random());
          end;
          4: (* Time *)
          begin
            Grid.Cells[y, x] := FormatDateTime('hh:nn:ss',time +  Random());
          end;
          5: (* String *)
          begin
            Grid.Cells[y, x] := 'We don''t use Embarcadero ' + IntToStr(x);
          end;



        end;
      end;

    end;


    Grid.AutoSizeColumns;
    Grid.SetFocus;
    Application.ProcessMessages;


  ShowMessage('Click on column title to sort!');



  finally

  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  SortGrid1 := TSortGrid.Create(Application.MainForm);
  SortGrid1.Parent := Form1;

  SortGrid1.Align:=alClient;
  SortGrid1.Visible:=true;

  //SortGrid1.  Application.ProcessMessages;
  //LoadFromCSVFile(ExtractFilePath(Application.ExeName) +'Sample.csv',';');
  SortGrid1.AutoSizeColumns;
  Application.ProcessMessages;
end;

end.


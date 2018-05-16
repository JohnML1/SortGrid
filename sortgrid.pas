unit SortGrid;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF LINUX}  clocale,  {$ENDIF} Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, Grids;

type

  { TSortGrid }

  TSortGrid = class(TStringGrid)
  private

  protected
    function  DoCompareCells(Acol,ARow,Bcol,BRow: Integer): Integer; override;


  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;


  published

  end;

procedure Register;

implementation

procedure Register;
begin
  {$I sortgrid.lrs}
  RegisterComponents('Additional',[TSortGrid]);
end;

{ TSortGrid }

function SortStringGridByColumn(Grid: TCustomStringGrid; ACol, ARow, BCol, BRow: Integer): integer;
var   AFloat, AFloat1 : Double;
      int, int1 : integer;
      d, d1 : TDateTime;
      t, t1 : TTime;
      s, s1 : string;
begin
     try

     (* Spalte für das UpDown-icon *)
     //FLastColumn := ACol;


     Result := 0;

     (* die zwei Zeichenketten in Variable speichern *)
     s := trim(Grid.Cells[ACol, ARow]);
     s1 := trim(Grid.Cells[BCol, BRow]);


     (* Float *)
     if TryStrToFloat(s,AFloat) or TryStrToFloat(s1, AFloat1) then
     begin
       AFloat := StrToFloatDef(s, 0) - StrToFloatDef(s1, 0);
       if AFloat < 0 then Result := -1
       else if AFLoat > 0 then Result := +1
       else Result := 0;
       if Grid.SortOrder = soDescending then
         Result := -Result;
     end
     (* Integer *)
     else if TryStrToInt(s,int) or TryStrToInt(s1, int1) then
     begin
       int := StrToIntDef(s, 0) - StrToIntDef(s1, 0);
       if int < 0 then Result := -1
       else if int > 0 then Result := +1
       else Result := 0;
       if Grid.SortOrder = soDescending then
         Result := -Result;

     end
     (* Time *)
     else if TryStrToTime(s,t) or TryStrToTime(s1, t1) then
     begin
       t := StrToTimeDef(s, 0) - StrToTimeDef(s1, 0);
       if t < 0 then Result := -1
       else if t > 0 then Result := +1
       else Result := 0;
       if Grid.SortOrder = soDescending then
         Result := -Result;
     end
     (* DateTime *)
     else if TryStrToDateTime(s,d) or TryStrToDateTime(s1, d1) then
     begin
       d := StrToDateTimeDef(s, 0) - StrToDateTimeDef(s1, 0);
       if d < 0 then Result := -1
       else if d > 0 then Result := +1
       else Result := 0;
       if Grid.SortOrder = soDescending then
         Result := -Result;
     end
     else
     (* String, also alles andere
      laut Docu Embarcadero: AnsiCompareStr: Compares strings based on the current locale with case sensitivity.
      *)
     begin
       d := AnsiCompareStr(s,s1);
       if d < 0 then Result := -1
       else if d > 0 then Result := +1
       else Result := 0;
       if Grid.SortOrder = soDescending then
         Result := -Result;
     end;



  finally
  end;

end;

function TSortGrid.DoCompareCells(Acol, ARow, Bcol, BRow: Integer): Integer;
begin
  //Result:=inherited DoCompareCells(Acol, ARow, Bcol, BRow);

  result := 0;
  Result := SortStringGridByColumn(Self , ACol, ARow, BCol,BRow);

end;

constructor TSortGrid.Create(AOwner: TComponent);
var x : integer;
begin
  inherited Create(AOwner);

  (* sortieren, wenn auf Spaltentitel geklickt wurde *)
  Self.ColumnClickSorts:=true;

  (* optische Rückmeldung, wenn auf Spaltentitel geklickt wurde *)
  Self.Options := Self.Options + [goHeaderPushedLook];

  (* ImageIndex auf 1 setzen *)

  //self.Columns.Clear;
  //Self.RowCount:=2;
  //Self.ColCount:=1;

  self.FixedCols:=0;

  if  not (csDesigning in ComponentState) then
  begin

    for x := 0 to 0 do
    begin
      self.Columns.Add;
      self.Columns[x].Title.ImageIndex:=1;
    end;

  end;

end;

destructor TSortGrid.Destroy;
begin
  inherited Destroy;
end;

initialization
{$I sortgrid.lrs}
end.

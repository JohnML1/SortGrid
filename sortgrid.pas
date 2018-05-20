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

uses
  Math;

procedure Register;
begin
  {$I sortgrid.lrs}
  RegisterComponents('Additional',[TSortGrid]);
end;

{ TSortGrid }

(* Thanks to Werner Pamler :-)  *)
function GeneralCompareValues(s1, s2: String): Integer;
var
  float1, float2: Double;
  int1, int2: Integer;
  dt1, dt2: TDateTime;
  t1, t2: TTime;
begin
  if (s1 = '') and (s2 = '') then
    Result := 0
  else
  if (s1 = '') then
    Result := +1
  else
  if (s2 = '') then
    Result := -1
  else begin
    if TryStrToFloat(s1, float1) and TryStrToFloat(s2, float2) then
      Result := CompareValue(float1, float2)
    else
    if TryStrToInt(s1, int1) and TryStrToInt(s2, int2) then
      Result := CompareValue(int1, int2)
    else
    if TryStrToDateTime(s1, dt1) and TryStrToDateTime(s2, dt2) then
      Result := CompareValue(dt1, dt2)
    else
    if TryStrToTime(s1, t1) and TryStrToTime(s2, t2) then
      Result := CompareValue(t1, t2)
    else
      Result := CompareStr(s1, s2);
  end;
end;

(* Thanks to Werner Pamler :-)  *)
function TSortGrid.DoCompareCells(Acol, ARow, Bcol, BRow: Integer): Integer;
var
  s1, s2: String;
begin
  s1 := TStringGrid(self).Cells[ACol, ARow];
  s2 := TStringGrid(self).Cells[BCol, BRow];
  Result := GeneralCompareValues(s1, s2);
  if TStringGrid(self).SortOrder = soDescending then Result := -Result;
end;

constructor TSortGrid.Create(AOwner: TComponent);
var x : integer;
begin
  inherited Create(AOwner);

  (* sortieren, wenn auf Spaltentitel geklickt wurde *)
  Self.ColumnClickSorts:=true;

  (* optische Rückmeldung, wenn auf Spaltentitel geklickt wurde *)
  Self.Options := Self.Options + [goHeaderPushedLook];

  self.FixedCols:=0;

   (* für alle die kein lazarus trunk verwenden *)
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

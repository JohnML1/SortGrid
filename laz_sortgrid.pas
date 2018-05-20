{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit laz_sortgrid;

{$warn 5023 off : no warning about unused units}
interface

uses
  SortGrid, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('SortGrid', @SortGrid.Register);
end;

initialization
  RegisterPackage('laz_sortgrid', @Register);
end.

namespace ANJ.Tools.IDRangeChecker;
using System.Apps;
using System.Reflection;

/// <summary>
/// "Fields_ANJ" (ID 99998).
/// </summary>
page 99999 Fields_ANJ
{
    ApplicationArea = All;
    Caption = 'Fields';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = Field;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(TableNo; Rec.TableNo)
                {
                    ToolTip = 'Specifies the table number.';
                }
                field(TableName; Rec.TableName)
                {
                    ToolTip = 'Specifies the table name.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the field number.';
                }
                field(FieldName; Rec.FieldName)
                {
                    ToolTip = 'Specifies the field name.';
                }
                field("App Name"; GetAppName())
                {
                    Caption = 'App Name';
                    ToolTip = 'Specifies the name of the app that owns the object.';
                }
            }
        }
    }

    /// <summary>
    /// GetAppName
    /// </summary>
    /// <returns></returns>
    local procedure GetAppName(): Text[250]
    var
        NAVAppInstalledApp: Record "NAV App Installed App";
    begin
        NAVAppInstalledApp.SetRange("Package ID", Rec."App Runtime Package ID");
        NAVAppInstalledApp.SetLoadFields(Name);
        if not NAVAppInstalledApp.FindFirst() then
            exit;

        exit(NAVAppInstalledApp.Name);
    end;

    /// <summary>
    /// ApplyEmptyFilter
    /// </summary>
    internal procedure ApplyEmptyFilter()
    begin
        Rec.Reset();
        Rec.SetRange(FieldName, EmptyFilterTok);
    end;

    /// <summary>
    /// ApplyFilter
    /// </summary>
    /// <param name="FromID"></param>
    /// <param name="ToID"></param>
    internal procedure ApplyFilter(FromID: Integer; ToID: Integer)
    begin
        Rec.Reset();
        Rec.SetRange("No.", FromID, ToID);
        Rec.SetFilter(RelationTableNo, '<>%1', 0);
    end;

    var
        EmptyFilterTok: Label 'Its ugly, I know :)', Locked = true;
}
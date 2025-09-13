namespace ANJ.Tools.IDRangeChecker;
using System.Apps;
using System.Reflection;

/// <summary>
/// Objects_ANJ (ID 99998).
/// </summary>
page 99998 Objects_ANJ
{
    ApplicationArea = All;
    Caption = 'Objects';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = AllObjWithCaption;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the object type.';
                }
                field("Object ID"; Rec."Object ID")
                {
                    ToolTip = 'Specifies the object ID.';
                }
                field("Object Name"; Rec."Object Name")
                {
                    ToolTip = 'Specifies the name of the object.';
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
        Rec.SetRange("Object Name", EmptyFilterTok);
    end;

    /// <summary>
    /// ApplyFilter
    /// </summary>
    /// <param name="FromID"></param>
    /// <param name="ToID"></param>
    internal procedure ApplyFilter(FromID: Integer; ToID: Integer)
    begin
        Rec.Reset();
        Rec.SetRange("Object ID", FromID, ToID);
        Rec.SetFilter("Object Type", '<>%1', 0);
    end;

    var
        EmptyFilterTok: Label 'Its ugly, I know :)', Locked = true;
}
namespace ANJ.Tools.IDRangeChecker;

/// <summary>
/// IDRangeChecker_ANJ (ID 99997).
/// </summary>
page 99997 IDRangeChecker_ANJ
{
    ApplicationArea = All;
    Caption = 'ID Range Checker';
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(From; FromID)
                {
                    BlankZero = true;
                    Caption = 'From ID';
                    MaxValue = 99999;
                    MinValue = 50000;
                    QuickEntry = true;
                    ToolTip = 'Specifies the starting ID of the range of records to be processed.';

                    trigger OnValidate()
                    begin
                        CheckRange();
                    end;
                }
                field("To"; ToID)
                {
                    BlankZero = true;
                    Caption = 'To ID';
                    MaxValue = 99999;
                    MinValue = 50000;
                    QuickEntry = true;
                    ToolTip = 'Specifies the ending ID of the range of records to be processed.';

                    trigger OnValidate()
                    begin
                        CheckRange();
                    end;
                }
            }
            part(Objects_ANJ; Objects_ANJ)
            {
            }
            part(Fields_ANJ; Fields_ANJ)
            {
            }
        }
    }

    trigger OnOpenPage()
    begin
        ToID := 50000;
        FromID := 50000;
        ApplyEmptyFilter();
    end;

    /// <summary>
    /// CheckRange
    /// </summary>
    local procedure CheckRange()
    begin
        DoCheckRange();
        SubFormUpdate();
    end;

    /// <summary>
    /// ValidateRange
    /// </summary>
    local procedure ValidateRange()
    begin
        if ToID < FromID then
            Error(IDComparisonErr);
    end;

    /// <summary>
    /// ApplyEmptyFilter
    /// </summary>
    local procedure ApplyEmptyFilter()
    begin
        CurrPage.Objects_ANJ.Page.ApplyEmptyFilter();
        CurrPage.Fields_ANJ.Page.ApplyEmptyFilter();
    end;

    /// <summary>
    /// ApplyFilter
    /// </summary>
    local procedure ApplyFilter()
    begin
        CurrPage.Objects_ANJ.Page.ApplyFilter(FromID, ToID);
        CurrPage.Fields_ANJ.Page.ApplyFilter(FromID, ToID);
    end;

    local procedure DoCheckRange()
    begin
        ApplyEmptyFilter();
        ValidateRange();
        ApplyFilter();
    end;

    /// <summary>
    /// SubFormUpdate
    /// </summary>
    local procedure SubFormUpdate()
    begin
        CurrPage.Objects_ANJ.Page.Update();
        CurrPage.Fields_ANJ.Page.Update();
    end;

    var
        FromID: Integer;
        ToID: Integer;
        IDComparisonErr: Label 'The To ID must be greater than or equal to the From ID.';
}
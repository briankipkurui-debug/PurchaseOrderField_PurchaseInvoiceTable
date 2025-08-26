pageextension 50128 PurchaseInvoiceSubformExt extends "Purch. Invoice Subform"
{
    layout
    {
        addbefore(Description)
        {
            field("PO No."; OrderNoToShow)
            {
                ApplicationArea = All;
                Caption = 'PO No.';
                Editable = false;
                ToolTip = 'Shows the PO only on the Receipt comment row.';
            }
        }
    }

    var
        OrderNoToShow: Code[20];

    trigger OnAfterGetRecord()
    begin
        OrderNoToShow := '';

        if IsReceiptCommentRow(Rec) then
            OrderNoToShow := GetOrderNoFromFollowingBlock(Rec);
    end;

    local procedure IsReceiptCommentRow(purchLine: Record "Purchase Line"): Boolean
    begin
        exit((purchLine.Type = purchLine.Type::" ")
          and (StrPos(UpperCase(purchLine.Description), 'RECEIPT NO.') > 0));
    end;

    local procedure GetOrderNoFromFollowingBlock(currLine: Record "Purchase Line"): Code[20]
    var
        line: Record "Purchase Line";
    begin
        line.SetCurrentKey("Document Type", "Document No.", "Line No.");
        line.SetRange("Document Type", currLine."Document Type");
        line.SetRange("Document No.", currLine."Document No.");
        line.SetFilter("Line No.", '>%1', currLine."Line No.");

        if line.FindSet() then
            repeat
                if line.Type <> line.Type::" " then
                    exit(line."Order No.");
            until line.Next() = 0;

        exit('');
    end;
}
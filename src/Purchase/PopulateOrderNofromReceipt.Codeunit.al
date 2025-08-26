codeunit 50128 "Populate Order No. Receipt"
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInsertEvent', '', true, true)]
    local procedure PurchaseLineOnAfterInsert(var Rec: Record "Purchase Line")
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        if (Rec."Order No." = '') and (Rec."Receipt No." <> '') then begin
            if PurchRcptLine.Get(Rec."Receipt No.", Rec."Receipt Line No.") then begin
                Rec."Order No." := PurchRcptLine."Order No.";
                Rec.Modify();
            end;
        end;
    end;
}

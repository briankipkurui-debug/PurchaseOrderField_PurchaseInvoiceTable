pageextension 50128 PurchaseInvoiceSubformExt extends "Purch. Invoice Subform"
{
    layout
    {
        addbefore(Description)
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
                Caption = 'PO No.';
                ToolTip = 'Specifies the related Purchase Order No. for this invoice line.';
            }

        }
    }

}

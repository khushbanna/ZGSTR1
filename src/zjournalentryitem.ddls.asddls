@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I_JournalEntryItem'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZJournalEntryItem as select from I_JournalEntryItem
{
    key AccountingDocument,
    key CompanyCode,
    key FiscalYear,
    key Product,
      ProfitCenter

        
}  where    Ledger = '0L'  and Product <> ''
group by
  AccountingDocument,
        CompanyCode,
        FiscalYear,
        Product,
        ProfitCenter


        
      

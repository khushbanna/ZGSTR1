@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Profit center'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPROFIT_CENTER22 as select from I_OperationalAcctgDocItem
{
    key AccountingDocument,
    key CompanyCode,
    key FiscalYear,
        TaxItemAcctgDocItemRef,
        ProfitCenter 
}  
where ProfitCenter <> ''

group by 
AccountingDocument,
CompanyCode,
FiscalYear,
TaxItemAcctgDocItemRef,
ProfitCenter 

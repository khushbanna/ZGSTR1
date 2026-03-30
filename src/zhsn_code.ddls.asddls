@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Hsn Code'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZHSN_CODE as select from I_OperationalAcctgDocItem
{
    key AccountingDocument,
    key CompanyCode,
    key FiscalYear,
        TaxItemAcctgDocItemRef,
    IN_HSNOrSACCode 
}  
where IN_HSNOrSACCode <> ''

group by 
AccountingDocument,
CompanyCode,
FiscalYear,
TaxItemAcctgDocItemRef,
IN_HSNOrSACCode 

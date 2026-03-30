@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZCDS_JOURNAL_SUM'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_JOURNAL_SUM2
 with parameters
    P_Language : abap.lang
 as select from ZCDS_JOURNAL_SUM( P_Language: $parameters.P_Language )
{
    key CompanyCode,
    key AccountingDocument,
    key FiscalYear,
    ReferenceDocumentItem,
    CompanyCodeCurrency,
    ReferenceDocument,
    Ledger,
    ConsumptionTaxCtrlCode,
   sum( TotalAmountInCoCodeCrcy ) as TotalAmountInCoCodeCrcy
}
group by
    CompanyCode,
    AccountingDocument,
    FiscalYear,
    ReferenceDocumentItem,
    CompanyCodeCurrency,
    ReferenceDocument,
    Ledger,
    ConsumptionTaxCtrlCode

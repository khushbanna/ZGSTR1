@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Round of gl'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZROUND_GL as select from I_OperationalAcctgDocItem
{
    key AccountingDocument,
    key CompanyCode,
    key FiscalYear,
    CompanyCodeCurrency,
  //  @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
   cast (AmountInCompanyCodeCurrency as abap.dec( 23, 2 ) ) as AmountInCompanyCodeCurrency
}    where 
     GLAccount          = '0004651011' 


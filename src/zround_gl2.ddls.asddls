@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZROUND_GL'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZROUND_GL2 as select from I_OperationalAcctgDocItem
{
    key AccountingDocument,
    key CompanyCode,
    key FiscalYear,
    CompanyCodeCurrency,
    @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
    AmountInCompanyCodeCurrency
}    where 
     GLAccount          = '0004651011' 
and( AccountingDocument = '9400000000' or 
     AccountingDocument = '9400000002' or 
     AccountingDocument = '9400000003' or 
     AccountingDocument = '9400000007' or 
     AccountingDocument = '9400000008' or 
     AccountingDocument = '9400000009' or 
     AccountingDocument = '9400000010' or 
     AccountingDocument = '9400000011' or 
     AccountingDocument = '9400000014' or 
     AccountingDocument = '9400000015' or 
     AccountingDocument = '9400000016' or 
     AccountingDocument = '9400000017' or 
     AccountingDocument = '9400000018' or 
     AccountingDocument = '9400000019' or 
     AccountingDocument = '9400000020' or 
     AccountingDocument = '9400000021' or 
     AccountingDocument = '9400000022' or 
     AccountingDocument = '9400000023' or 
     AccountingDocument = '9400000024' or 
     AccountingDocument = '9400000025' or 
     AccountingDocument = '9400000026' or 
     AccountingDocument = '9400000028' or 
     AccountingDocument = '9400000029' or 
     AccountingDocument = '9400000030' or 
     AccountingDocument = '9400000031' or 
     AccountingDocument = '9400000032' or 
     AccountingDocument = '9400000033' or 
     AccountingDocument = '9400000034' or 
     AccountingDocument = '9400000041'
 
  ) 

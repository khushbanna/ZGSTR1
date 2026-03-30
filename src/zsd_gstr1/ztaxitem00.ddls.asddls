@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Doc with 00 items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZTAXITEM00
  as select from    I_OperationalAcctgDocItem as A
    inner join      I_OperationalAcctgDocItem as B on(
      B.AccountingDocument  = A.AccountingDocument
      and B.CompanyCode     = A.CompanyCode
      and B.FiscalYear      = A.FiscalYear
      and B.BillingDocument is not initial
    )
    left outer join I_JournalEntry            as C on(
      C.AccountingDocument = A.AccountingDocument
      and C.CompanyCode    = A.CompanyCode
      and C.FiscalYear     = A.FiscalYear
    )

{
  key  A.AccountingDocument,
       A.CompanyCode,
       A.FiscalYear,
       A.AccountingDocumentType,
       B.BillingDocument,

       C.PostingDate,
       C.DocumentReferenceID





}
where
      A.TaxItemAcctgDocItemRef     = '000000'
  and A.AccountingDocumentItemType = 'T'

group by
  A.AccountingDocument,
  A.CompanyCode,
  A.FiscalYear,
  A.AccountingDocumentType,
  B.BillingDocument,

  C.PostingDate,
  C.DocumentReferenceID

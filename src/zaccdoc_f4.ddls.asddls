@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'AccountingDocument F4'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZACCDOC_F4
  as select from I_JournalEntry as A
{
 key A.AccountingDocument as accdoc,
     A.AccountingDocumentType
}
where
      A.IsReversal <> 'X'
  and A.IsReversed <> 'X'


group by
  A.AccountingDocument,
  A.AccountingDocumentType

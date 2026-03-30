@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZBILL_MAT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBILL_MAT
  as select from I_BillingDocumentItem as A
{
  A.BillingDocument,
  A.BillingDocumentItem,
  max(A.Product) as Product,
  A.TransactionCurrency,
  @Semantics.amount.currencyCode: 'TransactionCurrency' 
  sum(A.NetAmount) as NetAmount 
  
}
where
  A.Product is not initial
group by
  A.BillingDocument,
  A.BillingDocumentItem,
  A.TransactionCurrency

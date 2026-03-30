@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZBILL_PLANT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBILL_PLANT
  as select from I_BillingDocumentItem as A
{
  A.BillingDocument,
  max(A.Plant) as PLANT

}
where
  A.Product is not initial
group by
  A.BillingDocument

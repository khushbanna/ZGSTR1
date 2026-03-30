@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'tax code'
@Metadata.ignorePropagatedAnnotations: true
define view entity ztax_code22 as select from I_BillingDocumentItem
{
   key BillingDocument,
   key BillingDocumentItem,
   TaxCode
}  group by  BillingDocument,
   BillingDocumentItem,
   TaxCode

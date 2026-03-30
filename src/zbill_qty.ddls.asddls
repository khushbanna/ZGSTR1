@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZBILL_QTY'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBILL_QTY as select from  I_BillingDocumentItem as a
{
    key a.BillingDocument ,
    key a.BillingDocumentItem,
        a.Product,
        a.TaxCode ,
        BillingQuantityUnit,
        sum(cast(a.BillingQuantity as abap.dec( 20, 3 ) ) ) as BillingQuantity,
        a.TransactionCurrency,
         @Semantics.amount.currencyCode: 'TransactionCurrency'
        sum( a.NetAmount ) as NetAmount 
} group by
 a.BillingDocument,
 a.TaxCode ,
 a.Product,
 BillingQuantityUnit,
 a.BillingDocumentItem,
 a.TransactionCurrency
 

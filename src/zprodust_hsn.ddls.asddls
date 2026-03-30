@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product HSN'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPRODUST_HSN as select from I_ProductPlantBasic as A
{
    key A.Product ,
     max(A.ConsumptionTaxCtrlCode) as ConsumptionTaxCtrlCode
} group by
   A.Product 

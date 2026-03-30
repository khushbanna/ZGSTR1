@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'sum of journal entry cds'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_JOURNAL_SUM 
 with parameters
    P_Language : abap.lang
as select from I_AccountingDocumentJournal( P_Language: $parameters.P_Language )   
as a 
left outer join I_ProductPlantBasic as b on ( b.Product = a.Material and b.Plant = a.Plant  )
{
  key a.CompanyCode,
  key a.AccountingDocument,
  key a.FiscalYear,
//   a.SalesOrderItem,
     a.ReferenceDocumentItem,
   a.CompanyCodeCurrency,
//   a.SalesOrder,
   a.ReferenceDocument,
   a.Ledger,
//   Material,
//   Plant,
   b.ConsumptionTaxCtrlCode,
    
    cast(
      case a.DebitCreditCode
        when 'H' then cast(a.CreditAmountInCoCodeCrcy as abap.dec(23,2))
        when 'S' then cast(a.DebitAmountInCoCodeCrcy  as abap.dec(23,2))
        else cast( 0 as abap.dec(23,2) )
      end
      as abap.dec(23,2)
    )
  as TotalAmountInCoCodeCrcy
}
where a.Ledger = '0L' and a.SalesOrder != ''

 

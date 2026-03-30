@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 B2B CDS 2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zgstr1_b2b_cds2
  as select from    ZGSTR1B2B_CDS1       as A
    left outer join ZPRODUST_HSN         as pb on(
      pb.Product = A.product
    )
    left outer join I_ProductDescription as pd on(
      pd.Product      = A.product
      and pd.Language = 'E'
    )
//    left outer join ZBILL_QTY            as bi on(
//      bi.BillingDocument = A.BillingDocument and
//      bi.BillingDocumentItem = A.BillingDocumentItem
//      and bi.TaxCode     = A.TaxCode
 //   )
    left outer join I_Product            as p  on(
       p.Product = A.product
     )
//    left outer join ygst_det as q on ( q.BillingDocument = A.BillingDocument and q.BillingDocumentItem = A.BillingDocumentItem ) 

{
  A.CompanyCode,
  A.AccountingDocument,
  A.FiscalYear,
  A.FiscalPeriod,
  A.ProfitCenter,
  A.DocumentDate,
  A.PostingDate,
  A.GLAccount,
  A.AccountingDocumentType,
  A.TransactionCurrency,
  A.TaxItemAcctgDocItemRef,
  A.BusinessPlace,
  //case when A.BillingDocument is not initial
  // then A.BillingDocument
  // else A.DocumentReferenceID end as BillingDocument ,
  A.BillingDocument,
  A.DocumentReferenceID,
  A.BillingDocumentType,
//  A.ewbnumber,
  A.Irn,
  A.Customer,
  A.CustomerName,
  A.TaxNumber3                    as customer_gst,
  A.product,
  pd.ProductDescription,
  pb.ConsumptionTaxCtrlCode       as hsn_code,
  A.IsReversal,
  A.IsReversed,
  A.Region,
  A.TaxCode,
  A.Plant,
  A.Quantity,
//  case when  A.Quantity > 0
//   then A.Quantity
//   else
//   bi.BillingQuantity
//   end as Quantity,

//  case when  A.Quantity > 0
//  then A.BaseUnit
//  else
//  p.BaseUnit
//  end                           
  A.BaseUnit  as BaseUnit,

  A.JOCG_RATE,
  A.JOSG_RATE,
  A.JOIG_RATE,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  sum( A.TaxAmountInCoCodeCrcy ) as TaxAmountInCoCodeCrcy,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  sum( A.AmountInCompanyCodeCurrency ) as AmountInCompanyCodeCurrency,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  sum(A.JOCG_AMT)                 as JOCG_AMT,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  sum(A.JOSG_AMT)                 as JOSG_AMT,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  sum(A.JOIG_AMT)                 as JOIG_AMT,
  
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  sum(A.TCS_AMT)                  as TCS_AMT,


  case
   when  A.REPORT = 'EXPORT'
         then A.REPORT
    when A.TaxNumber3 = ''   then cast('B2CS'     as abap.char(10) )
    else A.REPORT   end           as REPORT,
    
    '' as BillingDocumentDate,
    '' as BillingDocumentItem,
 //   @Semantics.amount.currencyCode: 'TransactionCurrency'
   cast(A.NetAmount as abap.dec( 23, 2)) as NetAmount,
    '0.00' as rATE,
//    @Semantics.amount.currencyCode: 'TransactionCurrency'
    '0.00' as TaxAmount


}

where
  A.JOCG_AMT is not null 
  or A.JOIG_AMT is not null


group by
  A.CompanyCode,
  A.AccountingDocument,
  A.FiscalYear,
  A.FiscalPeriod,
  A.ProfitCenter,
  A.DocumentDate,
  A.PostingDate,
  A.GLAccount,
  A.AccountingDocumentType,
  A.DocumentReferenceID,
  A.TransactionCurrency,
  A.TaxItemAcctgDocItemRef,
  A.BusinessPlace,
  A.BillingDocument,
  A.BillingDocumentType,
//  A.ewbnumber,
  A.Irn,
  A.BaseUnit,
  A.Customer,
  A.CustomerName,
  A.TaxNumber3,
  A.product,
  pd.ProductDescription,
  pb.ConsumptionTaxCtrlCode,
  A.IsReversal,
  A.IsReversed,
  A.Region,
  A.TaxCode,
  A.Quantity,
  p.BaseUnit,
  //bi.BillingQuantity,
  A.JOCG_RATE,
  A.JOSG_RATE,
  A.JOIG_RATE,
  A.TaxAmountInCoCodeCrcy,
  A.AmountInCompanyCodeCurrency,
  A.REPORT ,
  A.Plant,
  
//  A.BillingDocumentDate,
//  A.BillingDocumentItem, 
  A.NetAmount
//  q.rATE

  
  

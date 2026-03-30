@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 CDNR CDS 2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGSTR1_CDNR_CDS2
  as select from    ZGSTR1_CDNR_CDS1     as A
    left outer join ZPRODUST_HSN         as PB on(
      PB.Product = A.product
    )
    left outer join I_ProductDescription as pd on(
      pd.Product      = A.product
      and pd.Language = 'E'
    )
    left outer join ZBILL_QTY            as bi on(
      bi.BillingDocument = A.BillingDocument
      and bi.BillingDocumentItem = A.TaxItemAcctgDocItemRef
    )
    left outer join I_Product            as p  on(
       p.Product = A.product
     )

   left outer join ZCDS_JOURNAL_SUM2( P_Language: $session.system_language ) as j
      on j.CompanyCode        = A.CompanyCode
      and j.AccountingDocument = A.AccountingDocument
      and j.FiscalYear         = A.FiscalYear
//      and j.SalesOrderItem      = bitem.BillingDocumentItem
      and j.ReferenceDocumentItem = bi.BillingDocumentItem
      and j.ReferenceDocument     = bi.BillingDocument
      and j.Ledger             = '0L'
//      and j.Material           = a.Material     
     
//    left outer join ygst_det as q on ( q.BillingDocument = bi.BillingDocument and q.BillingDocumentItem = bi.BillingDocumentItem ) 

{
  A.CompanyCode,
  A.AccountingDocument,
  A.FiscalYear,
  A.ProfitCenter,
  A.FiscalPeriod,
  A.DocumentDate,
  A.PostingDate,
  A.GLAccount as GLAccount,
  A.AccountingDocumentType,
  A.DocumentReferenceID,
  A.TransactionCurrency,
  A.TaxItemAcctgDocItemRef,
  A.BusinessPlace,
  '' as Plant,

  //case when A.BillingDocument is not initial
  // then A.BillingDocument
  // else A.DocumentReferenceID end as BillingDocument ,
  A.BillingDocument,
  A.BillingDocumentType,
//  A.ewbnumber,
  A.Irn,
  A.Customer,
  A.CustomerName,
  A.TaxNumber3                         as customer_gst,
  A.product,
  pd.ProductDescription,
  PB.ConsumptionTaxCtrlCode            as hsn_code,
  A.Region,
  A.TaxCode,
 // A.Quantity as QTY1 ,
//   bi.BillingQuantity as QTY2 ,
//  case when A.Quantity > 0
//   then A.Quantity
   //else
   bi.BillingQuantity
   //end
                                    as Quantity,

//  case when  A.Quantity > 0
//  then A.BaseUnit
//  else
//  p.BaseUnit
 // end  
   bi.BillingQuantityUnit                               as BaseUnit,

  A.JOCG_RATE,
  A.JOSG_RATE,
  A.JOIG_RATE,
  //  case when A.REPORT  = 'EXPWP'
  //  then A.AmountInCompanyCodeCurrency
  //  else  A.TaxAmountInCoCodeCrcy   end                 as TaxAmountInCoCodeCrcy,

  @Semantics.amount.currencyCode: 'TransactionCurrency'
  sum( j.TotalAmountInCoCodeCrcy )       as TaxAmountInCoCodeCrcy,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  sum( A.AmountInCompanyCodeCurrency ) as AmountInCompanyCodeCurrency,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  sum(A.JOCG_AMT)                      as JOCG_AMT,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  sum(A.JOSG_AMT)                      as JOSG_AMT,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  sum(A.JOIG_AMT)                      as JOIG_AMT,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  sum(A.TCS_AMT)                      as TCS_AMT,

  case
    when  A.REPORT = 'EXPORT' then A.REPORT
     when A.TaxNumber3 = ''   then cast('CDNUR'     as abap.char(10) )
     else A.REPORT   end               as REPORT,
     
     '' as BillingDocumentDate,
     '' as BillingDocumentItem,
//     @Semantics.amount.currencyCode: 'TransactionCurrency'
     cast( 0 as abap.dec( 23, 2) ) as NetAmount,
     '0.00' as rATE,
//     @Semantics.amount.currencyCode: 'TransactionCurrency'
     '0.00' as TaxAmount



}

where
  A.JOCG_AMT is not null 
  or A.JOIG_AMT is not null
group by
    A.CompanyCode,
    A.AccountingDocument,
    A.FiscalYear,
    A.ProfitCenter,
    A.FiscalPeriod,
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
    A.Customer,
    A.CustomerName,
    A.TaxNumber3,
    A.Irn,
    A.product,
    pd.ProductDescription,
    PB.ConsumptionTaxCtrlCode,
    A.Region,
    A.TaxCode,
    bi.BillingQuantity,
    bi.BillingQuantityUnit,
    A.JOCG_RATE,
    A.JOSG_RATE,
    A.JOIG_RATE,
    A.REPORT


   

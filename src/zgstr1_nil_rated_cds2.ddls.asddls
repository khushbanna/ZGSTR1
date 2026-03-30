@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR NIL RATED CDS2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGSTR1_NIL_RATED_CDS2 as select distinct from ZGSTR1_NIL_RATED_CDS1 as A
left outer join ZBILL_QTY as bi on ( bi.BillingDocument = A.BillingDocument and bi.BillingDocumentItem = A.BillingDocumentItem )
//left outer join I_ProductDescription as pd on ( pd.Product = A.product and pd.Language = 'E' )
//left outer join ZBILL_QTY as bi on ( bi.BillingDocument = A.BillingDocument  and bi.TaxCode = A.TaxCode  )
left outer join I_Product as p on ( p.Product = A.product  )





{
key A.CompanyCode,
key A.AccountingDocument,
key A.FiscalYear,
key A.TaxItemAcctgDocItemRef,
A.FiscalPeriod,
A.DocumentDate,
A.PostingDate,
//A.GLAccount,
A.AccountingDocumentType,
A.DocumentReferenceID,
A.TransactionCurrency,
//A.TaxItemAcctgDocItemRef,
A.ProfitCenter,
A.BusinessPlace,

case when A.BillingDocument is not initial  
 then A.BillingDocument
 else A.AccountingDocument end as BillingDocument ,

//A.BillingDocument,
A.BillingDocumentType,
A.ewbnumber,
case when A.Irn <> '' then 'Updated' else ' ' end as Irn,
A.Customer,
A.CustomerName,
A.TaxNumber3 as customer_gst ,
case when bi.Product <> '' then bi.Product else A.product end as Product ,
//A.ProductDescription,
//A.hsn_code,
//A.ConsumptionTaxCtrlCode as hsn_code ,
bi.BillingDocumentItem,                  
A.IsReversal,
A.IsReversed,
//A.Region ,
A.TaxCode,
//A.Quantity,
//case when A.Quantity > 0
// then A.Quantity 
// else 
// bi.BillingQuantity 
// end as Quantity ,
 bi.BillingQuantity  as Quantity,
 
bi.BillingQuantityUnit  as BaseUnit ,

//A.BaseUnit ,

@Semantics.amount.currencyCode: 'TransactionCurrency'
//A.TaxAmountInCoCodeCrcy,
//case when A.REPORT  = 'EXPWP'
 A.AmountInCompanyCodeCurrency
 as TaxAmountInCoCodeCrcy ,

@Semantics.amount.currencyCode: 'TransactionCurrency'
A.AmountInCompanyCodeCurrency,

  @Semantics.amount.currencyCode: 'TransactionCurrency'
  
    case 
    when A.TotalAmountInCoCodeCrcy  < 0 
    then A.TotalAmountInCoCodeCrcy  * -1 
    else A.TotalAmountInCoCodeCrcy  
    end  as INVOICE_AMT,
//  case when  A.JOIG_AMT  is not null
//  then
//   (cast(A.JOIG_AMT as abap.dec( 23, 2 )) + A.TotalAmountInCoCodeCrcy )
//  else
//   ( cast(A.JOCG_AMT as abap.dec( 23, 2 ))  + A.TotalAmountInCoCodeCrcy ) end      as INVOICE_AMT,
 
  case when A.DistributionChannel = '17' then 'EXPORT'
  else A.REPORT
  end as REPORT ,
//  case  A.REPORT when 'NRTEXP'
 case when A.TransactionCurrency <> 'INR'
  then '97' 
  else A.Region 
  end as Region
//   A.Region ,

//case
//  when  A.REPORT = 'EXPWP' then A.REPORT
//   when A.TaxNumber3 = ''   then cast('B2CS'     as abap.char(10) )
//   else A.REPORT   end as REPORT
//case
//  when  A.REPORT = 'NIL RATED' then A.REPORT
//   when A.TaxNumber3 = ''   then cast('NIL RATED'     as abap.char(10) )
//   else A.REPORT   end as REPORT

}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZGSTR1_B2B_SERVICE_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGSTR1_B2B_SERVICE_CDS
 as select distinct from zgstr1_b2b_cds2 as A   
 left outer join Zroundof_VALUE_GSTR1 as R on( R.AccountingDocument     = A.AccountingDocument
      and R.CompanyCode            = A.CompanyCode 
      and R.FiscalYear             = A.FiscalYear )
 
{ 
    key A.CompanyCode,
    key A.AccountingDocument,
    key A.FiscalYear,
    key A.REPORT as REPORT ,
    key A.DocumentDate,
    key A.PostingDate,
    key A.AccountingDocumentType,
    key A.TaxItemAcctgDocItemRef as doc_item,
    key A.BillingDocument,
    key A.BillingDocumentType,
    key A.Customer,
    key A.CustomerName,
    key A.customer_gst,
    key A.product,
    key A.ProductDescription,
    key A.hsn_code,
    key A.GLAccount,
    key A.ProfitCenter,
    key A.Region,
    key A.DocumentReferenceID ,
    key A.TaxCode,
    key A.BusinessPlace,
//    key A.ewbnumber,  
//    key A.Irn,  
    key A.BaseUnit,
    
    key  (A.Quantity) as Quantity,
    key A.TransactionCurrency,
    
    @Semantics.amount.currencyCode: 'TransactionCurrency'
//    key  (TaxAmountInCoCodeCrcy * (-1 ) ) as table_value,
    
    case when  A.REPORT  = 'EXPORT' 
    then (A.AmountInCompanyCodeCurrency * (-1 )  )
    else ( A.TaxAmountInCoCodeCrcy * (-1 )  ) end as table_value ,
    
    @Semantics.amount.currencyCode: 'TransactionCurrency'
       (A.JOCG_AMT * (-1 ) ) as JOCG_AMT ,
    
       ( A.JOCG_RATE) as JOCG_RATE,
    
    
    @Semantics.amount.currencyCode: 'TransactionCurrency'
       (A.JOSG_AMT * (-1 ) ) as JOSG_AMT,
    
       (A.JOSG_RATE) as JOSG_RATE ,
    
    @Semantics.amount.currencyCode: 'TransactionCurrency'
       (A.JOIG_AMT * (-1 ) ) as JOIG_AMT,
    
       (A.JOIG_RATE) as JOIG_RATE ,
    
    @Semantics.amount.currencyCode: 'TransactionCurrency'
//       ( INVOICE_AMT * (-1 ) ) as INVOICE_AMT 
  A.NetAmount,
  case when  A.JOIG_AMT  is not null
  then
       (cast(A.JOIG_AMT as abap.dec( 23, 2 )) + case when A.REPORT  = 'EXPORT'
    then (case when A.GLAccount = '0003101000' and A.AccountingDocumentType = 'DR'
          then coalesce( cast( A.AmountInCompanyCodeCurrency as abap.dec( 23, 2 )), 0 ) + coalesce( cast( R.AmountInCompanyCodeCurrency as abap.dec( 23, 2 )),0)  else cast(A.AmountInCompanyCodeCurrency as abap.dec( 23, 2 )) end )
    else (case when A.GLAccount = '0003101000' and A.AccountingDocumentType = 'DR'
          then coalesce( cast( A.TaxAmountInCoCodeCrcy as abap.dec( 23, 2 )),0) + coalesce( cast(R.AmountInCompanyCodeCurrency as abap.dec( 23, 2 )),0 ) else cast( A.TaxAmountInCoCodeCrcy as abap.dec( 23, 2 )) end ) end )  * (-1 )
  else
      ( cast(A.JOCG_AMT as abap.dec( 23, 2 )) * 2 + case when A.REPORT  = 'EXPORT'
    then (case when A.GLAccount = '0003101000' and A.AccountingDocumentType = 'DR'
          then coalesce( cast( A.AmountInCompanyCodeCurrency as abap.dec( 23, 2 )),0 ) + coalesce( cast( R.AmountInCompanyCodeCurrency as abap.dec( 23, 2 )),0 ) else cast( A.AmountInCompanyCodeCurrency as abap.dec( 23, 2 )) end )
    else (case when A.GLAccount = '0003101000' and A.AccountingDocumentType = 'DR'
          then coalesce( cast( A.TaxAmountInCoCodeCrcy as abap.dec( 23, 2 )) ,0 ) + coalesce(cast( R.AmountInCompanyCodeCurrency as abap.dec( 23, 2 )),0 ) else cast( A.TaxAmountInCoCodeCrcy as abap.dec( 23, 2 )) end ) end )  * (-1 )  end      as INVOICE_AMT ,
      
      
//    IsReversal,
//    IsReversed,
//    AmountInCompanyCodeCurrency
      
      
      A.FiscalPeriod as ReturnPeriod ,
      case  A.REPORT when 'EXPORT'
      then cast( '97' as abap.char(10) )
       else cast( '' as abap.char(10) ) end as PortCode ,
    
    cast('' as abap.char(10) ) as SourceIdentifier,
    cast('' as abap.char(10) ) as SourceFileName,
    cast('' as abap.char(10) ) as GLAccountCode,
    cast('' as abap.char(10) ) as Division,
    cast('' as abap.char(10) ) as SubDivision,
    cast('' as abap.char(10) ) as ProfitCentre1,
    cast('' as abap.char(10) ) as ProfitCentre2,
    cast('' as abap.char(10) ) as PlantCode,
    cast('' as abap.char(10) ) as SupplierGSTIN,
    cast('' as abap.char(10) ) as CRDRPreGST,
    cast('' as abap.char(10) ) as UINorComposition,
    cast('' as abap.char(10) ) as OriginalCustomerGSTIN,
    cast('' as abap.char(10) ) as BillToState,
    cast('' as abap.char(10) ) as ShipToState,
//    cast('' as abap.char(10) ) as PortCode,
    cast('' as abap.char(10) ) as ShippingBillNumber,
    cast('' as abap.char(10) ) as ShippingBillDate,
    cast('' as abap.char(10) ) as FOB,
    cast('' as abap.char(10) ) as ExportDuty,
    cast('' as abap.char(10) ) as CategoryOfProduct,
    cast('' as abap.char(10) ) as CessRateAdvalorem,
    cast('' as abap.char(10) ) as CessAmountAdvalorem,
    cast('' as abap.char(10) ) as CessRateSpecific,
    cast('' as abap.char(10) ) as CessAmountSpecific,
    cast('' as abap.char(10) ) as ReverseChargeFlag,
    cast('' as abap.char(10) ) as TCSFlag,
    cast('' as abap.char(10) ) as eComGSTIN,
    cast('' as abap.char(10) ) as ITCFlag,
    cast('' as abap.char(10) ) as ReasonForCreditDebitNote,
    cast('' as abap.char(10) ) as AccountingVoucherDate,
    cast('' as abap.char(10) ) as Userdefinedfield1,
    cast('' as abap.char(10) ) as Userdefinedfield2,
    cast('' as abap.char(10) ) as Userdefinedfield3
//    A.AckNo,
//    A.AckDate,
//    A.TEXT1,
   // A.TEXT2
//    A.GLAccountName    
    
} 


// group by
// A.CompanyCode,
//   A.AccountingDocument,
//   A.FiscalYear,
//   A.DocumentDate,
//   A.PostingDate,
//   A.GLAccount,
//   A.AccountingDocumentType,
//   A.DocumentReferenceID,
//   A.TransactionCurrency,
//   A.TaxItemAcctgDocItemRef,
//   A.ProfitCenter,
//   A.Region ,
//   A.BusinessPlace,
//   A.BillingDocument,
//   A.BillingDocumentType,
//   A.ewbnumber,
//   A.Irn,
//   A.BaseUnit,
//   A.Customer,
//   A.CustomerName,
//   A.customer_gst,
//   A.product,
//   A.ProductDescription,
//   A.hsn_code,
//   A.IsReversal,
//   A.IsReversed,
//   A.TaxCode ,
//   A.REPORT ,
//   TaxAmountInCoCodeCrcy,
//   INVOICE_AMT
//   
//   A.Quantity,
//   A.JOCG_RATE,
//   A.JOSG_RATE,
//   A.JOIG_RATE,
//   A.TaxAmountInCoCodeCrcy,
//   A.AmountInCompanyCodeCurrency,
//   A.JOCG_AMT,
//   A.JOSG_AMT,
//   A.JOIG_AMT
 


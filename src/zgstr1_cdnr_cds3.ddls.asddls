@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 CDNR CDS 3'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGSTR1_CDNR_CDS3
  as select from    ZGSTR1_CDNR_CDS22       as A
  left outer join ZHSN_CODE as HSN on A.AccountingDocument = HSN.AccountingDocument and A.CompanyCode = HSN.CompanyCode and A.FiscalYear = HSN.FiscalYear and A.TaxItemAcctgDocItemRef = HSN.TaxItemAcctgDocItemRef  

{
  key  A.CompanyCode,
  key  A.AccountingDocument,
  key  A.FiscalYear,
       A.REPORT                                             as REPORT,
       A.DocumentDate,
       A.PostingDate,
       A.AccountingDocumentType,
       A.TaxItemAcctgDocItemRef                             as doc_item,
       A.BillingDocument,
       A.BillingDocumentType,
       A.Customer,
       A.CustomerName,
       A.customer_gst,
       A.product,
       A.ProductDescription,
       case when A.hsn_code <> '' then A.hsn_code else HSN.IN_HSNOrSACCode end as hsn_code ,
       '' as GLAccount,
       A.Region,
       A.DocumentReferenceID,
       A.TaxCode,
       A.BusinessPlace,
//       A.ewbnumber,
       A.Irn,
       A.Plant,
       A.BaseUnit,
       A.ProfitCenter,
       case when A.BillingDocumentType = 'G2' or A.BillingDocumentType = 'L2'
       then 0
       else (A.Quantity) end as Quantity, 
       A.TransactionCurrency,

       @Semantics.amount.currencyCode: 'TransactionCurrency'
      //   ( A.TaxAmountInCoCodeCrcy * (-1 ) )                  as table_value,
       ( A.AmountInCompanyCodeCurrency  * (-1 ) )                  as table_value,
       //       case when A.REPORT  = 'EXPORT'
       //       then (A.AmountInCompanyCodeCurrency * (-1 )  )
       //       else ( A.TaxAmountInCoCodeCrcy * (-1 )  ) end                                as table_value,

       @Semantics.amount.currencyCode: 'TransactionCurrency'
       (A.JOCG_AMT * (-1 ) )                                as JOCG_AMT,

       ( A.JOCG_RATE)                                       as JOCG_RATE,


       @Semantics.amount.currencyCode: 'TransactionCurrency'
       (A.JOSG_AMT * (-1 ) )                                as JOSG_AMT,

       (A.JOSG_RATE)                                        as JOSG_RATE,

       @Semantics.amount.currencyCode: 'TransactionCurrency'
       (A.JOIG_AMT * (-1 ) )                                as JOIG_AMT,
       @Semantics.amount.currencyCode: 'TransactionCurrency'
       (A.TCS_AMT * (-1 ) )                                as TCS_AMT,

       (A.JOIG_RATE)                                        as JOIG_RATE,

       //       ( INVOICE_AMT * (-1 ) ) as INVOICE_AMT

       @Semantics.amount.currencyCode: 'TransactionCurrency'
       cast( coalesce( A.TaxAmountInCoCodeCrcy , 0 ) + coalesce( A.JOCG_AMT, 0 ) + coalesce( A.JOSG_AMT, 0 )
       + coalesce( A.JOIG_AMT, 0 )  
       + coalesce( A.TCS_AMT, 0 )  
        as abap.dec( 20, 2 ) ) * ( -1 )  as INVOICE_AMT,
        
      case when  cast( coalesce( A.TaxAmountInCoCodeCrcy , 0 ) + coalesce( A.JOCG_AMT, 0 ) + coalesce( A.JOSG_AMT, 0 )
       + coalesce( A.JOIG_AMT, 0 )  
       + coalesce( A.TCS_AMT, 0 )  
        as abap.dec( 20, 2 ) )  < 0 
        then
        cast( coalesce( A.TaxAmountInCoCodeCrcy , 0 ) + coalesce( A.JOCG_AMT, 0 ) + coalesce( A.JOSG_AMT, 0 )
       + coalesce( A.JOIG_AMT, 0 )  
       + coalesce( A.TCS_AMT, 0 )  
        as abap.dec( 20, 2 ) ) * -1
        else
        cast( coalesce( A.TaxAmountInCoCodeCrcy , 0 ) + coalesce( A.JOCG_AMT, 0 ) + coalesce( A.JOSG_AMT, 0 )
       + coalesce( A.JOIG_AMT, 0 )  
       + coalesce( A.TCS_AMT, 0 )  
        as abap.dec( 20, 2 ) ) end as INVOICE_AMT2,
        
       A.BillingDocumentDate,
       A.BillingDocumentItem,
//       @Semantics.amount.currencyCode: 'TransactionCurrency'
       A.NetAmount,
       A.rATE,
//       @Semantics.amount.currencyCode: 'TransactionCurrency'
       A.TaxAmount
      

       //       case when  A.JOIG_AMT  is not null
       //       then
       //            (A.JOIG_AMT + A.AmountInCompanyCodeCurrency )  * (-1 )
       //       else
       //           (A.JOCG_AMT + A.JOSG_AMT + A.AmountInCompanyCodeCurrency )  * (-1 )  end as INVOICE_AMT
       
       

}




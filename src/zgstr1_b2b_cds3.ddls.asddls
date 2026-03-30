@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 B2B CDS 3'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zgstr1_b2b_cds3
  as select from zgstr1_b2b_cds2 as A
  left outer join ZROUND_GL      as b on A.AccountingDocument = b.AccountingDocument and A.CompanyCode = b.CompanyCode and A.FiscalYear = b.FiscalYear
  left outer join ZBUSINESSPLACE as K on A.AccountingDocument = K.AccountingDocument and A.CompanyCode = K.CompanyCode and A.FiscalYear = K.FiscalYear
  left outer join ZHSN_CODE as HSN on A.AccountingDocument = HSN.AccountingDocument and A.CompanyCode = HSN.CompanyCode and A.FiscalYear = HSN.FiscalYear and A.TaxItemAcctgDocItemRef = HSN.TaxItemAcctgDocItemRef
  
 
  

{
  key  A.CompanyCode,
  key  A.AccountingDocument,
  key  A.FiscalYear,
//       case when A.REPORT <> 'EXPORT' then 
//       case when A.customer_gst = '' then
//       case when A.Region <> K.region then 
//       case when  cast( coalesce( A.TaxAmountInCoCodeCrcy , 0 ) * -1 + coalesce( A.JOCG_AMT, 0 ) * -1 + coalesce( A.JOSG_AMT, 0 ) * -1 + coalesce( A.JOIG_AMT, 0 ) * -1  + coalesce( A.TCS_AMT, 0 )  as abap.dec( 20, 2 ) )  > 100000 then 'B2CL' else 'B2CS' end 
//       when A.Region = K.region then 'B2CS' else A.REPORT
//       end else A.REPORT
//       end else A.REPORT
//       end as REPORT,
       A.DocumentDate,
       A.PostingDate,
       A.AccountingDocumentType,
       A.TaxItemAcctgDocItemRef                             as doc_item,
       case when A.BillingDocument <> '' then A.BillingDocument
            else A.AccountingDocument end as BillingDocument ,
       A.BillingDocumentType,
       A.Customer,
       A.CustomerName,
       A.customer_gst,
       A.product,
       A.ProductDescription,
       case when A.hsn_code <> '' then A.hsn_code else HSN.IN_HSNOrSACCode end as hsn_code ,
     //  A.GLAccount,
       A.Region,
       A.DocumentReferenceID,
       A.TaxCode,
       A.BusinessPlace,
//       A.ewbnumber,
       A.Irn,
       A.Plant,
       A.BaseUnit,
       A.ProfitCenter,

       (A.Quantity)                                         as Quantity,
       A.TransactionCurrency,

       @Semantics.amount.currencyCode: 'TransactionCurrency'
       ( A.TaxAmountInCoCodeCrcy * (-1 ) )                  as table_value,
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

       (A.JOIG_RATE)                                        as JOIG_RATE,

       (A.TCS_AMT * (-1 ) )                                as TCS_AMT,
       //       ( INVOICE_AMT * (-1 ) ) as INVOICE_AMT

//       @Semantics.amount.currencyCode: 'TransactionCurrency'
//       cast( coalesce( A.TaxAmountInCoCodeCrcy , 0 ) + coalesce( A.JOCG_AMT, 0 ) + coalesce( A.JOSG_AMT, 0 )
//       + coalesce( A.JOIG_AMT, 0 ) 
//       + coalesce( A.TCS_AMT, 0 ) 
//        as abap.dec( 20, 2 ) ) * ( -1 ) as INVOICE_AMT,

 case when A.NetAmount <> 0 then cast( coalesce(cast(A.NetAmount as abap.dec( 23, 2) ), 0 )
       + coalesce( cast(A.JOCG_AMT as abap.dec( 23, 2)), 0 ) * -1
       + coalesce( cast(A.JOSG_AMT as abap.dec( 23, 2)), 0 ) * -1
       + coalesce( cast(A.JOIG_AMT as abap.dec( 23, 2)), 0 ) * -1
       + coalesce( cast(A.TCS_AMT  as abap.dec( 23, 2)), 0 ) * -1
        as abap.dec( 20, 2 ) ) 
        else   cast( coalesce( cast(A.TaxAmountInCoCodeCrcy  as abap.dec( 23, 2) ), 0 )
//         + case when b.AmountInCompanyCodeCurrency < 0 then coalesce( b.AmountInCompanyCodeCurrency  , 0 )  * -1
//           else coalesce( b.AmountInCompanyCodeCurrency  , 0 ) end
       + coalesce( b.AmountInCompanyCodeCurrency  , 0 ) 
       + coalesce( cast( A.JOCG_AMT as abap.dec( 23, 2 )), 0 ) 
       + coalesce( cast(A.JOSG_AMT as abap.dec( 23, 2) ), 0 )
       + coalesce( cast(A.JOIG_AMT as abap.dec( 23,2) ), 0 ) 
       + coalesce( cast(A.TCS_AMT as abap.dec( 23, 2) ), 0 ) 
        as abap.dec( 20, 2 ) ) * ( -1 ) end
        as INVOICE_AMT,
        
        
      case when A.REPORT <> 'EXPORT' then 
       case when A.customer_gst = '' then
        case when A.Region <> K.region then 
//         case when  cast( coalesce( A.TaxAmountInCoCodeCrcy , 0 ) * -1 + coalesce( A.JOCG_AMT, 0 ) * -1 + coalesce( A.JOSG_AMT, 0 ) * -1 + coalesce( A.JOIG_AMT, 0 ) * -1  + coalesce( A.TCS_AMT, 0 )  as abap.dec( 20, 2 ) )  > 100000 then 'B2CL' else 'B2CS' end 
         case when $projection.INVOICE_AMT > 100000 then 'B2CL' else 'B2CS' end 
          when A.Region = K.region then 'B2CS' else A.REPORT
           end else A.REPORT
             end else A.REPORT
     end as REPORT,

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
group by
    A.CompanyCode,
    A.AccountingDocument,
    A.FiscalYear,
    A.REPORT,
    A.customer_gst,
    A.Region,
    K.region,
    A.TaxAmountInCoCodeCrcy,
    A.JOCG_AMT,
    A.JOSG_AMT,
    A.JOIG_AMT,
    A.TCS_AMT,
    A.DocumentDate,
    A.PostingDate,
    A.AccountingDocumentType,
    A.TaxItemAcctgDocItemRef,
    A.BillingDocument,
    A.BillingDocumentType,
    A.Customer,
    A.CustomerName,
    A.product,
    A.ProductDescription,
    A.hsn_code,
    A.DocumentReferenceID,
    A.TaxCode,
    A.BusinessPlace,
    A.Plant,
    A.BaseUnit,
    A.ProfitCenter,
    A.Quantity,
    A.Irn,
    A.TransactionCurrency,
     A.JOCG_RATE,
    A.JOSG_RATE,
    A.JOIG_RATE,
    A.BillingDocumentDate,
    HSN.IN_HSNOrSACCode,
    A.BillingDocumentItem,
    A.NetAmount,
    A.rATE,
    b.AmountInCompanyCodeCurrency,
    A.TaxAmount 



union all

select from ZSD_GSTR1_CDS2 as b
left outer join ZBUSINESSPLACE as K on b.AccountingDocument = K.AccountingDocument and b.CompanyCode = K.CompanyCode and b.FiscalYear = K.FiscalYear
left outer join ZHSN_CODE as HSN on b.AccountingDocument = HSN.AccountingDocument and b.CompanyCode = HSN.CompanyCode and b.FiscalYear = HSN.FiscalYear and b.doc_item = HSN.TaxItemAcctgDocItemRef
{
  key b.CompanyCode,
  key b.AccountingDocument,
  key b.FiscalYear,
//  case when ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000010' and b.FiscalYear = '2025' and b.doc_item = '000020' ) or
//            ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000022' and b.FiscalYear = '2025' and b.doc_item = '000010' ) or
//            ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000023' and b.FiscalYear = '2025' and b.doc_item = '000020' ) or
//            ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000030' and b.FiscalYear = '2025' and b.doc_item = '000020' ) or
//            ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000031' and b.FiscalYear = '2025' and b.doc_item = '000020' ) or
//            ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000033' and b.FiscalYear = '2025' and b.doc_item = '000010' ) or
//            ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000041' and b.FiscalYear = '2025' and b.doc_item = '000010' ) or
//            ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000013' and b.FiscalYear = '2025' and b.doc_item = '000010' ) 
//       then 'NILRAT' else
//       case when b.Report <> 'EXPORT' then 
//       case when b.customer_gst = '' then
//       case when b.Region <> K.region then 
//       case when  cast( b.INVOICE_AMT as abap.dec( 20, 2 ) )  > 100000 then 'B2CL' else 'B2CS' end 
//       when b.Region = K.region then 'B2CS' else b.Report 
//       end else b.Report
//       end else b.Report
//       end end as REPORT,
      b.DocumentDate,
      b.PostingDate,
      b.AccountingDocumentType,
      b.doc_item,
      b.BillingDocument,
      b.BillingDocumentType,
      b.Customer,
      b.CustomerName,
      b.customer_gst,
      b.product,
      b.ProductDescription,
      case when b.hsn_code <> '' then b.hsn_code else HSN.IN_HSNOrSACCode end as hsn_code ,
   //   b.GLAccount,
      b.Region,
      b.DocumentReferenceID,
      b.TaxCode,
      b.BusinessPlace,
//      b.ewbnumber,
      b.Irn,
      b.Plant,
      b.BaseUnit,
      b.ProfitCenter,
      case when b.BillingDocumentType = 'G2' or b.BillingDocumentType = 'L2'
      then 0
      else  b.Quantity end as Quantity,
      b.TransactionCurrency,
      b.table_value,
      b.JOCG_AMT,
      b.JOCG_Rate,
      b.JOSG_AMT,
      b.JOSG_RATE,
      b.JOIG_AMT,
      b.JOIG_RATE,
      b.ZTCS_AMT as TCS_AMT,
      b.INVOICE_AMT,
      
       case when ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000010' and b.FiscalYear = '2025' and b.doc_item = '000020' ) or
            ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000022' and b.FiscalYear = '2025' and b.doc_item = '000010' ) or
            ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000023' and b.FiscalYear = '2025' and b.doc_item = '000020' ) or
            ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000030' and b.FiscalYear = '2025' and b.doc_item = '000020' ) or
            ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000031' and b.FiscalYear = '2025' and b.doc_item = '000020' ) or
            ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000033' and b.FiscalYear = '2025' and b.doc_item = '000010' ) or
            ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000041' and b.FiscalYear = '2025' and b.doc_item = '000010' ) or
            ( b.CompanyCode = '3000' and b.AccountingDocument = '9400000013' and b.FiscalYear = '2025' and b.doc_item = '000010' ) 
       then 'NILRAT' else
       case when b.Report <> 'EXPORT' then 
       case when b.customer_gst = '' then
       case when b.Region <> K.region then 
       case when  cast( b.INVOICE_AMT as abap.dec( 20, 2 ) )  > 100000 then 'B2CL' else 'B2CS' end 
       when b.Region = K.region then 'B2CS' else b.Report 
       end else b.Report
       end else b.Report
       end end as REPORT,
       
//      b.BillingDocumentDate,
      '' as BillingDocumentDate,
      b.BillingDocumentItem,
      b.NetAmount,
      b.rATE,
      b.TaxAmount
}

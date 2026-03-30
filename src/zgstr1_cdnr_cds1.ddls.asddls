@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 CDNR CDS 1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGSTR1_CDNR_CDS1
  as select from    I_JournalEntry            as b
    left outer join I_OperationalAcctgDocItem as a    on(
         b.AccountingDocument = a.AccountingDocument
         and b.CompanyCode    = a.CompanyCode
         and b.FiscalYear     = a.FiscalYear
       )
    left outer join I_OperationalAcctgDocItem as D    on(
         D.AccountingDocument       = b.AccountingDocument
         and D.CompanyCode          = b.CompanyCode
         and D.FiscalYear           = b.FiscalYear
         and D.FinancialAccountType = 'D'
       )
    left outer join I_Customer                as d2   on(
        d2.Customer = D.Customer
      )
    left outer join I_OperationalAcctgDocItem as B1   on(
        B1.AccountingDocument  = b.AccountingDocument
        and B1.CompanyCode     = b.CompanyCode
        and B1.FiscalYear      = b.FiscalYear
        and B1.BillingDocument is not initial
      )
    left outer join I_BillingDocument         as BI   on(
        BI.BillingDocument     = B1.BillingDocument
        and BI.BillingDocument is not initial
      )
     left outer join ztax_code22              as B12   on(
       B12.BillingDocument = BI.BillingDocument
       and B12.BillingDocumentItem = a.TaxItemAcctgDocItemRef
      )     
    left outer join zgstr1_b2b_cds3           as BI2  on(
       BI2.BillingDocument = BI.BillingDocument
       and BI2.doc_item = a.TaxItemAcctgDocItemRef
     )

    left outer join ZBILL_PLANT               as PL   on(
        PL.BillingDocument = BI.BillingDocument
      )
//    left outer join ZEWAY_CDS                 as EW   on(
//        EW.Docno     = B1.BillingDocument
//        and EW.Gjahr = b.FiscalYear
//        and EW.Bukrs = b.CompanyCode
//      )
//    left outer join ZIRN_CDS                  as IR   on(
//        IR.Docno       = B1.BillingDocument
//        and IR.DocYear = b.FiscalYear
//        and IR.Bukrs   = b.CompanyCode
//      )
//    left outer join ZEWAY_CDS                 as EW2  on(
//       EW2.Docno     = b.AccountingDocument
//       and EW2.Gjahr = b.FiscalYear
//       and EW2.Bukrs = b.CompanyCode
//     )
//    left outer join ZIRN_CDS                  as IR2  on(
//       IR2.Docno       = b.AccountingDocument
//       and IR2.DocYear = b.FiscalYear
//       and IR2.Bukrs   = b.CompanyCode
//     )


    left outer join I_OperationalAcctgDocItem as CGST on(
      CGST.AccountingDocument         = a.AccountingDocument
      and CGST.CompanyCode            = b.CompanyCode
      and CGST.FiscalYear             = a.FiscalYear
      and CGST.TaxItemAcctgDocItemRef = a.TaxItemAcctgDocItemRef
      and( ( CGST.TaxCode                = a.TaxCode and a.GLAccount <> '0003061001' ) or (  a.TaxCode  = 'Z1' and a.GLAccount = '0003061001' ) )
//      and CGST.GLAccount              = '0001501004'
      and CGST.GLAccount              = '0001481000'
    )
    left outer join I_OperationalAcctgDocItem as SGST on(
      SGST.AccountingDocument         = a.AccountingDocument
      and SGST.CompanyCode            = b.CompanyCode
      and SGST.FiscalYear             = a.FiscalYear
      and SGST.TaxItemAcctgDocItemRef = a.TaxItemAcctgDocItemRef
      and( ( SGST.TaxCode                = a.TaxCode and a.GLAccount <> '0003061001' ) or (  a.TaxCode  = 'Z1' and a.GLAccount = '0003061001'  ) )
//      and SGST.GLAccount              = '0001501005'
      and SGST.GLAccount              = '0001481001'
    )
    left outer join I_OperationalAcctgDocItem as IGST on(
      IGST.AccountingDocument         = a.AccountingDocument
      and IGST.CompanyCode            = b.CompanyCode
      and IGST.FiscalYear             = a.FiscalYear
      and( ( IGST.TaxCode                = a.TaxCode and a.GLAccount <> '0003061001' ) or (  a.TaxCode  = 'Z1' and a.GLAccount = '0003061001' ) )
      and IGST.TaxItemAcctgDocItemRef = a.TaxItemAcctgDocItemRef
//      and IGST.GLAccount              = '0001501006'
      and IGST.GLAccount              = '0001481002'
    )
    
    
    
    left outer join I_OperationalAcctgDocItem as TCS on(
          TCS.AccountingDocument     = a.AccountingDocument
      and TCS.CompanyCode            = b.CompanyCode
      and TCS.FiscalYear             = a.FiscalYear
      and TCS.TaxItemAcctgDocItemRef = a.TaxItemAcctgDocItemRef
      and TCS.TransactionTypeDetermination = 'JTC'
    )
    left outer join ZTAXCODE_SUMMARY          as T    on(
        ( T.taxcode = a.TaxCode and a.GLAccount <> '0003061001' )  or ( T.taxcode = B12.TaxCode and a.TaxCode  = 'Z1' and a.GLAccount = '0003061001' )
       )
     

    left outer join Y1IG_INVREFNUM_DD    as IR      
     on ((BI.BillingDocument = IR.Docno and BI.BillingDocument <>'' ) or ( a.AccountingDocument = IR.Docno and a.AccountingDocument <>'' )) and
        a.CompanyCode = IR.Bukrs and 
        a.FiscalYear  = IR.DocYear and 
        IR.IrnStatus = 'ACT'

{
  a.CompanyCode,
  a.AccountingDocument,
  a.FiscalYear,
  a.ProfitCenter,
  b.FiscalPeriod,
  a.DocumentDate,
  a.PostingDate,
  a.GLAccount,
  case when  a.TaxCode  = 'Z1' then B12.TaxCode else a.TaxCode end as TaxCode ,
  b.DocumentReferenceID,
  a.AccountingDocumentType,

  a.TransactionCurrency,
  a.TaxItemAcctgDocItemRef,
  a.BusinessPlace,
  BI.BillingDocument,
  BI.BillingDocumentType,
  case when  IR.Irn is not initial
       then 'Updated'
       else ' ' end  as Irn,
//  case when  EW.Ewbnumber is not initial
//       then EW.Ewbnumber
//       else EW2.Ewbnumber end                                                 as ewbnumber,
//  case when  IR.Irn is not initial
//       then IR.Irn
//       else IR2.Irn end                                                       as Irn,

  D.Customer,
  d2.CustomerName,
  d2.TaxNumber3,
  case when a.Product is not initial
   then     a.Product
   else BI2.product end                                                       as product,
  case when a.Plant is not initial
   then  a.Plant
   else  PL.PLANT end                                                         as Plant,
  d2.Region,

  T.gstrate,
  case CGST.GLAccount when '0001481000' then  T.gstrate end                   as JOCG_RATE,
  case SGST.GLAccount when '0001481001' then  T.gstrate end                   as JOSG_RATE,
  case IGST.GLAccount when '0001481002' then  T.gstrate end                   as JOIG_RATE,


  cast( CGST.AmountInCompanyCodeCurrency as abap.dec( 20, 2 ) )               as JOCG_AMT,
  cast( SGST.AmountInCompanyCodeCurrency as abap.dec( 20, 2 ) )               as JOSG_AMT,
  cast( IGST.AmountInCompanyCodeCurrency as abap.dec( 20, 2 ) )               as JOIG_AMT,
  cast( TCS.AmountInCompanyCodeCurrency as abap.dec( 20, 2 ) )               as TCS_AMT,
  a.BaseUnit,

  cast( (a.Quantity ) as abap.dec( 20, 3 ) )                                  as Quantity,

  cast(0 as abap.dec( 23, 3) ) as TaxAmountInCoCodeCrcy,

  @Semantics.amount.currencyCode: 'TransactionCurrency'
  cast( (a.AmountInCompanyCodeCurrency ) as abap.dec( 20, 2 ) )               as AmountInCompanyCodeCurrency,


  case  a.TransactionCurrency when 'INR'
  then  cast( 'CDNR' as abap.char(10) )
   else   cast( 'EXPORT' as abap.char(10) )
   end                                                                        as REPORT,
   BI.BillingDocumentDate


}
where
  (
    (
           b.AccountingDocumentType         =  'DG'
      or   b.AccountingDocumentType         =  'DN'
    )
    or(
           b.AccountingDocumentType         =  'RV'
      and(
           BI.BillingDocumentType           =  'G2'
        or BI.BillingDocumentType           =  'L2'
        or BI.BillingDocumentType           =  'CBRE'
      )
    )
  )

  and      b.IsReversal                     <> 'X'
  and      b.IsReversed                     <> 'X'
  and      a.ProfitLossAccountType          =  'X'
//  and     a.GLAccount                      <> '0003201008'  // CARTAGE
//  and     a.GLAccount                      <> '0003201009'  // ROUND OFF_JV
//  and     a.GLAccount                      <> '0004701000'  // SALES DISCOUNT CHGS
//  and     a.GLAccount                      <> '0003201010'  // INSURENCE
//  and     a.GLAccount                      <> '0004701005'  // PACKING CHARGES EXPANCE
  and      a.TaxItemAcctgDocItemRef         <> '000000'


@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GST B2B REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGSTR1B2B_CDS1
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
    left outer join I_BillingDocumentItem         as BI   on(
        BI.BillingDocument     = B1.BillingDocument
        and BI.BillingDocumentItem = a.TaxItemAcctgDocItemRef
      )
      left outer join I_BillingDocument        as BILL   on(
        BI.BillingDocument     = BILL.BillingDocument
      )    
    left outer join ZBILL_MAT                 as BI2  on(
       BI2.BillingDocument = BI.BillingDocument
       and BI2.BillingDocumentItem = BI.BillingDocumentItem
     )
    left outer join ZBILL_PLANT               as BI3  on(
       BI3.BillingDocument = BI.BillingDocument
     )


//    left outer join ZEWAY_CDS                 as EW   on(
//        EW.Docno     = B1.BillingDocument
//        and EW.Gjahr = b.FiscalYear
//        and EW.Bukrs = b.CompanyCode
//      )
    left outer join Y1IG_INVREFNUM_DD    as IR      
     on ((BILL.BillingDocument = IR.Docno and BILL.BillingDocument <>'' ) or ( a.AccountingDocument = IR.Docno and a.AccountingDocument <>'' )) and 
        a.CompanyCode = IR.Bukrs and 
        a.FiscalYear  = IR.DocYear and 
        IR.IrnStatus = 'ACT'
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
//      and CGST.TaxCode                = a.TaxCode
      and CGST.GLAccount              = '0001481000'
    )
    left outer join I_OperationalAcctgDocItem as SGST on(
      SGST.AccountingDocument         = a.AccountingDocument
      and SGST.CompanyCode            = b.CompanyCode
      and SGST.FiscalYear             = a.FiscalYear
      and SGST.TaxItemAcctgDocItemRef = a.TaxItemAcctgDocItemRef
//      and SGST.TaxCode                = a.TaxCode
      and SGST.GLAccount              = '0001481001'
    )
    left outer join I_OperationalAcctgDocItem as IGST on(
      IGST.AccountingDocument         = a.AccountingDocument
      and IGST.CompanyCode            = b.CompanyCode
      and IGST.FiscalYear             = a.FiscalYear
//      and IGST.TaxCode                = a.TaxCode
      and IGST.TaxItemAcctgDocItemRef = a.TaxItemAcctgDocItemRef
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
        ( T.taxcode = BI.TaxCode and BI.TaxCode <> '' ) or ( T.taxcode = a.TaxCode and a.TaxCode <> '' )
       )


{
  a.CompanyCode,
  a.AccountingDocument,
  a.FiscalYear,
  b.FiscalPeriod,
  a.ProfitCenter,
  cast(a.DocumentDate as abap.char(10)  )                                                                                                                 as DocumentDate,
  a.PostingDate,
  a.GLAccount,
  case when BI.Division = '40'
  then BI.TaxCode 
  else a.TaxCode end as TaxCode,
  b.DocumentReferenceID,
  a.AccountingDocumentType,

  a.TransactionCurrency,
  a.TaxItemAcctgDocItemRef,
  BI.BillingDocumentItem ,

  a.BusinessPlace,
  BI.BillingDocument,
  BI.BillingDocumentType,

//  case when  EW.Ewbnumber is not initial
//       then EW.Ewbnumber
//       else EW2.Ewbnumber end                                                                                                                             as ewbnumber,
  case when  IR.Irn is not initial
       then 'Updated'
       else ' ' end  as Irn,


  D.Customer,
  d2.CustomerName,
  d2.TaxNumber3,
  case when a.Product is not initial
   then  a.Product
   else BI2.Product end                                                                                                                                   as product,
  case when a.Plant is not initial
   then  a.Plant
   else BI3.PLANT end                                                                                                                                     as Plant,
  b.IsReversal,
  b.IsReversed,
  case when BI.DistributionChannel = '16'
  then BI.Region 
  else d2.Region end as Region ,

//  T.gstrate,
  case CGST.GLAccount when '0001481000' then  T.gstrate end                                                                                               as JOCG_RATE,
  case SGST.GLAccount when '0001481001' then  T.gstrate end                                                                                               as JOSG_RATE,
  case IGST.GLAccount when '0001481002' then  T.gstrate end                                                                                               as JOIG_RATE,


  cast( CGST.AmountInCompanyCodeCurrency as abap.dec( 20, 2 ) )                                                                                           as JOCG_AMT,
  cast( SGST.AmountInCompanyCodeCurrency as abap.dec( 20, 2 ) )                                                                                           as JOSG_AMT,
  cast( IGST.AmountInCompanyCodeCurrency as abap.dec( 20, 2 ) )                                                                                           as JOIG_AMT,
  cast( TCS.AmountInCompanyCodeCurrency as abap.dec( 20, 2 ) )                                                                                            as TCS_AMT,

  BI.BillingQuantityUnit as BaseUnit,

  cast(  (BI.BillingQuantity ) as abap.dec( 20, 2 ) )                                                                                                             as Quantity,


  @Semantics.amount.currencyCode: 'TransactionCurrency'
  coalesce( cast( CGST.TaxBaseAmountInCoCodeCrcy as abap.dec( 20, 2 ) ) , 0 ) + coalesce( cast(IGST.TaxBaseAmountInCoCodeCrcy as abap.dec( 20, 2 ) ), 0 ) as TaxAmountInCoCodeCrcy,

  @Semantics.amount.currencyCode: 'TransactionCurrency'
  cast( (a.AmountInCompanyCodeCurrency ) as abap.dec( 20, 2 ) )    
                                                                                         as AmountInCompanyCodeCurrency,
  BI.DistributionChannel ,
  case when BI.DistributionChannel = '17'
  then cast( 'EXPORT'  as abap.char(10) )
   when a.TransactionCurrency <> 'INR'
  then cast( 'EXPORT'  as abap.char(10) )
     else cast( 'B2B'     as abap.char(10) )
     end   as REPORT,
     
     '' as BillingDocumentDate,
//     '' as BillingDocumentItem,
 //    @Semantics.amount.currencyCode: 'TransactionCurrency'
   cast( BI.NetAmount as abap.dec( 15, 2 )) * cast( BILL.AccountingExchangeRate as abap.dec( 10, 2) )as NetAmount



}
where
  (
    (
          b.AccountingDocumentType         =  'RV'
      and ( BI.BillingDocumentType           =  'F2' or BI.BillingDocumentType           =  'JSTO')
    )
    or    b.AccountingDocumentType         =  'DR'
  )
  and     b.IsReversal                     <> 'X'
  and     b.IsReversed                     <> 'X'
  and     a.ProfitLossAccountType         =  'X'
//  and     a.GLAccount                      <> '0003201008'  // CARTAGE
//  and     a.GLAccount                      <> '0003201009'  // ROUND OFF_JV
//  and     a.GLAccount                      <> '0004701000'  // SALES DISCOUNT CHGS
//  and     a.GLAccount                      <> '0003201010'  // INSURENCE
//  and     a.GLAccount                      <> '0004701005'  // PACKING CHARGES EXPANCE
  and     a.TaxItemAcctgDocItemRef         <> '000000'
//  and(
//          CGST.AmountInCompanyCodeCurrency is not null
//    or    IGST.AmountInCompanyCodeCurrency is not null
//  )



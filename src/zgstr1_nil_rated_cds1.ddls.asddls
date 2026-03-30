@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR NIL RATED'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGSTR1_NIL_RATED_CDS1 as select from  I_JournalEntry  as b
    left outer join I_OperationalAcctgDocItem as a    on(
         b.AccountingDocument = a.AccountingDocument
         and b.CompanyCode    = a.CompanyCode
         and b.FiscalYear     = a.FiscalYear )
 //        and a.FinancialAccountType = 'D'  ) 
         
left outer join ZCUSTOMER as kk on a.AccountingDocument = kk.AccountingDocument and
                                   a.CompanyCode        = kk.CompanyCode and 
                                   a.FiscalYear         = kk.FiscalYear 
         
//          left outer join ZAMOUNITCOCODE as ac    on(
//         ac.AccountingDocument = a.AccountingDocument
//         and ac.CompanyCode    = a.CompanyCode
//         and ac.FiscalYear     = a.FiscalYear
////         and ac.TaxCode        = a.TaxCode
//         and ac.TaxItemAcctgDocItemRef     = a.TaxItemAcctgDocItemRef
//       )
//    left outer join I_OperationalAcctgDocItem as D    on(
//         D.AccountingDocument       = b.AccountingDocument
//         and D.Compa      nyCode          = b.CompanyCode
//         and D.FiscalYear           = b.FiscalYear
//         and D.FinancialAccountType = 'D'
//       )
    left outer join I_Customer                as d2   on(
        d2.Customer = kk.Customer
      )
    left outer join I_OperationalAcctgDocItem as B1   on(
        B1.AccountingDocument  = b.AccountingDocument
        and B1.CompanyCode     = b.CompanyCode
        and B1.FiscalYear      = b.FiscalYear
        and B1.BillingDocument is not initial
      )
    left outer join I_BillingDocument         as BI   on(
        BI.BillingDocument     = B1.BillingDocument
//           BI.BillingDocument     = a.BillingDocument
        and BI.BillingDocument is not initial
      )
      left outer join I_BillingDocumentItem as bitem  on ( 
         bitem.BillingDocument = BI.BillingDocument
         and bitem.BillingDocumentItem = a.TaxItemAcctgDocItemRef
       )
//    left outer join zgstr1_b2b_cds3           as BI2  on(
//       BI2.BillingDocument = BI.BillingDocument 
//     )

    left outer join ZGSTR1_PLANT              as BI3  on(
       BI3.BillingDocument = BI.BillingDocument
     )
    left outer join yj1ig_ewaybill            as EW   on(
//        EW.docno     = B1.BillingDocument
        EW.docno     = a.BillingDocument
        and EW.gjahr = b.FiscalYear
        and EW.bukrs = b.CompanyCode
      )
    left outer join Y1IG_INVREFNUM_DD         as IR   on(
          IR.Docno       = B1.BillingDocument
       // IR.Docno       = a.BillingDocument
        and IR.DocYear = b.FiscalYear
        and IR.Bukrs   = b.CompanyCode
      )
  left outer join yj1ig_ewaybill            as EW2   on(
        EW2.docno     = b.AccountingDocument
        and EW2.gjahr = b.FiscalYear
        and EW2.bukrs = b.CompanyCode
      )
    left outer join Y1IG_INVREFNUM_DD      as IR2   on(
        IR2.Docno       = b.AccountingDocument
        and IR2.DocYear = b.FiscalYear
        and IR2.Bukrs   = b.CompanyCode
      )

//    left outer join I_OperationalAcctgDocItem as CGST on(
//      CGST.AccountingDocument         = a.AccountingDocument
//      and CGST.CompanyCode            = a.CompanyCode // PR.AccountingDocumentItem = a.AccountingDocumentItem  and
//      and CGST.FiscalYear             = a.FiscalYear
//      and CGST.TaxItemAcctgDocItemRef = a.TaxItemAcctgDocItemRef
//      and CGST.TaxCode                = a.TaxCode
//      and CGST.GLAccount              = '0001481000'
//    )
//    left outer join I_OperationalAcctgDocItem as SGST on(
//      SGST.AccountingDocument         = a.AccountingDocument
//      and SGST.CompanyCode            = a.CompanyCode // PR.AccountingDocumentItem = a.AccountingDocumentItem  and
//      and SGST.FiscalYear             = a.FiscalYear
//      and SGST.TaxItemAcctgDocItemRef = a.TaxItemAcctgDocItemRef
//      and SGST.TaxCode                = a.TaxCode
//      and SGST.GLAccount              = '0001481001'
//    )
//    left outer join I_OperationalAcctgDocItem as IGST on(
//      IGST.AccountingDocument         = a.AccountingDocument
//      and IGST.AccountingDocumentItem = a.AccountingDocumentItem
//      and IGST.CompanyCode            = b.CompanyCode // PR.AccountingDocumentItem = a.AccountingDocumentItem  and
//      and IGST.FiscalYear             = a.FiscalYear
//      and IGST.TaxCode                = a.TaxCode
//      and IGST.TaxItemAcctgDocItemRef = a.TaxItemAcctgDocItemRef
//      and IGST.GLAccount              = '0001481002'
//    )

    left outer join I_OperationalAcctgDocItem as TCS on(
          TCS.AccountingDocument     = a.AccountingDocument
      and TCS.CompanyCode            = a.CompanyCode
      and TCS.FiscalYear             = a.FiscalYear
      and TCS.TaxItemAcctgDocItemRef = a.TaxItemAcctgDocItemRef
      and TCS.TransactionTypeDetermination = 'JTC'
    )

    left outer join ZTAXCODE_SUMMARY               as T    on(
         T.taxcode = a.TaxCode
       )

        left outer join ZCDS_JOURNAL_SUM2( P_Language: $session.system_language ) as j
      on j.CompanyCode        = b.CompanyCode
      and j.AccountingDocument = b.AccountingDocument
      and j.FiscalYear         = b.FiscalYear
//      and j.SalesOrderItem      = bitem.BillingDocumentItem
      and j.ReferenceDocumentItem = bitem.BillingDocumentItem
      and j.ReferenceDocument     = bitem.BillingDocument
      and j.Ledger             = '0L'
//      and j.Material           = a.Material


{
  a.CompanyCode,
  a.AccountingDocument,
  a.FiscalYear,
  a.ProfitCenter                                                        as ProfitCenter,
  b.FiscalPeriod,
  a.DocumentDate,
  a.PostingDate,
  //a.GLAccount,
  a.TaxCode,
  b.DocumentReferenceID,
  a.AccountingDocumentType,

  a.TransactionCurrency,
  case when   a.CompanyCode = '3000' and a.AccountingDocument = '9400000054' and  a.FiscalYear = '2025'
  and a.Product = 'F7000074' then '000130' else  a.TaxItemAcctgDocItemRef end as TaxItemAcctgDocItemRef,
  //  a.ProfitCenter,
  a.BusinessPlace,
  BI.BillingDocument,
  bitem.BillingDocumentItem,
  bitem.DistributionChannel,
  BI.BillingDocumentType,
//  j.TotalAmountInCoCodeCrcy,
 coalesce( case when j.TotalAmountInCoCodeCrcy < 0 then cast( j.TotalAmountInCoCodeCrcy as abap.dec( 23, 3 )) * -1 else cast( j.TotalAmountInCoCodeCrcy as abap.dec( 23, 3 )) end ,0 ) +
           coalesce( cast( TCS.AmountInCompanyCodeCurrency as abap.dec( 23, 3 )) , 0 )
  as TotalAmountInCoCodeCrcy,
 cast( TCS.AmountInCompanyCodeCurrency as abap.dec( 23, 3 )) as  TCS,

  j.ConsumptionTaxCtrlCode,
//  EW.ewbnumber,
//  IR.Irn,

  case when  EW.ewbnumber is not initial
       then EW.ewbnumber 
       else EW2.ewbnumber end as ewbnumber ,
 
//   case when  IR.Irn is not initial
//       then 'Updated'
//       else ' ' end  as Irn,
//       
  case when IR.Irn is not initial
       then IR.Irn 
       else IR2.Irn end as Irn ,
       
  kk.Customer,
  d2.CustomerName,
  d2.TaxNumber3,
//  case when a.Product is not initial
//   then  a.Product
//   else BI2.product end          
      case when a.CompanyCode = '3000' and a.AccountingDocument = '9400000000' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'TF7000809'
           when a.CompanyCode = '3000' and a.AccountingDocument = '9400000001' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'TF7000809'
           when a.CompanyCode = '3000' and a.AccountingDocument = '9400000004' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'TF7000809'
           when a.CompanyCode = '3000' and a.AccountingDocument = '9400000012' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'TF7000809'  
           when a.CompanyCode = '3000' and a.AccountingDocument = '9400000035' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'TF7000809'
           when a.CompanyCode = '3000' and a.AccountingDocument = '9400000036' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'TF7000809'
           when a.CompanyCode = '3000' and a.AccountingDocument = '9400000037' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'TF7000809'
           when a.CompanyCode = '3000' and a.AccountingDocument = '9400000038' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'TF7000809'
           when a.CompanyCode = '3000' and a.AccountingDocument = '9400000039' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'TF7000809'
           when a.CompanyCode = '3000' and a.AccountingDocument = '9400000040' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'TF7000809'           
           when a.CompanyCode = '3000' and a.AccountingDocument = '9400000053' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'F7000077'
           when a.CompanyCode = '3000' and a.AccountingDocument = '9400000055' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'F7000077'
           when a.CompanyCode = '3000' and a.AccountingDocument = '9400000061' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'F7000077'
           when a.CompanyCode = '3000' and a.AccountingDocument = '9400000322' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'F7000072'  
           when a.CompanyCode = '1000' and a.AccountingDocument = '9400001426' and a.FiscalYear = '2025' and a.TaxItemAcctgDocItemRef = '000000' then 'F7000000'
           else a.Product         end                   as product,
  case when a.Plant is not initial
   then  a.Plant
   else BI3.PLANT end                                       as Plant,
//  a.Plant,
  b.IsReversal,
  b.IsReversed,
  d2.Region ,

//  case CGST.GLAccount when '0001481000' then  T.gstrate end as JOCG_RATE,
//  case SGST.GLAccount when '0001481001' then  T.gstrate end as JOSG_RATE,
//  case IGST.GLAccount when '0001481002' then  T.gstrate end as JOIG_RATE,
  T.gstrate,


//  @Semantics.amount.currencyCode: 'TransactionCurrency'
//  (CGST.AmountInCompanyCodeCurrency  )                      as JOCG_AMT,
//  @Semantics.amount.currencyCode: 'TransactionCurrency'
//  (SGST.AmountInCompanyCodeCurrency  )                      as JOSG_AMT,
//  @Semantics.amount.currencyCode: 'TransactionCurrency'
//  (IGST.AmountInCompanyCodeCurrency  )                      as JOIG_AMT,

  bitem.BaseUnit,

//  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  cast( ( sum(a.Quantity ) ) as abap.dec( 20, 2 ) )                as Quantity,


  //b.TransactionCurrency,
//  @Semantics.amount.currencyCode: 'TransactionCurrency'
//  case when  CGST.TaxBaseAmountInCoCodeCrcy  is not null
//  then
//   (CGST.TaxBaseAmountInCoCodeCrcy )
//  else
//  (IGST.TaxBaseAmountInCoCodeCrcy ) end              
 
 cast( 0 as abap.dec( 22, 3 )) as TaxAmountInCoCodeCrcy,
  
  
//  case when  CGST.AmountInCompanyCodeCurrency  is not null
//  then
//   (CGST.AmountInCompanyCodeCurrency )
//  else
//   (IGST.AmountInCompanyCodeCurrency ) end      as AmountInCompanyCodeCurrency,



  @Semantics.amount.currencyCode: 'TransactionCurrency'
     sum( a.AmountInCompanyCodeCurrency )     as AmountInCompanyCodeCurrency,
//        j.TotalAmountInCoCodeCrcy       as TotalAmountInCoCodeCrcyNEW ,
              
      
      
      
//    ac.AmountInCompanyCodeCurrency as AmountInCompanyCodeCurrency ,
   
   
   
//  @Semantics.amount.currencyCode: 'TransactionCurrency'
//  (IGST.TaxBaseAmountInCoCodeCrcy)                          as AmountInCompanyCodeCurrency,
  //   (a.AmountInCompanyCodeCurrency)            as AmountInCompanyCodeCurrency,


  ''                                                        as ProductDescription,
  ''                                                        as hsn_code,


  cast( 'NILRAT' as abap.char(10) ) as REPORT
//  case  a.TransactionCurrency when 'INR'
//  then  cast( 'NRAT' as abap.char(10) )
//   else   cast( 'NRTEXP' as abap.char(10) )
//   end                                                      as REPORT

    
}
where 
   //  ( b.AccountingDocument like '94%' )
      //and
//       ( a.BillingDocument like 'SS%'
//        or a.BillingDocument like 'SI%' 
//        or a.BillingDocument like 'SX%' 
//        or a.BillingDocument like 'RN%'
//        or a.BillingDocument like 'SB%')
//    and 
//    ( a.TaxCode = 'A0' or a.TaxCode = '' ) and  b.IsReversal <> 'X' and  b.IsReversed  <> 'X'   
//and ( ( b.AccountingDocumentType = 'DG' or b.AccountingDocumentType =  'DN' or b.AccountingDocumentType = 'DR' ) or 
//      ( b.AccountingDocumentType  =  'RV' and( BI.BillingDocumentType = 'G2' or BI.BillingDocumentType =  'F2' or BI.BillingDocumentType  =  'L2' or BI.BillingDocumentType  =  'CBRE' ) ) )
//  )
    ( ( a.TaxCode = '' ) or (a.TaxCode = 'A0' and a.FinancialAccountType <> 'D' ) ) and  b.IsReversal <> 'X' and  b.IsReversed  <> 'X'   
and ( ( b.AccountingDocumentType = 'DG' or b.AccountingDocumentType =  'DN' or b.AccountingDocumentType = 'DR' ) or ( b.AccountingDocumentType  =  'RV' and  BI.BillingDocumentType <> 'F8' ))
// 
//  and      b.IsReversal                     <> 'X'
//  and      b.IsReversed                     <> 'X'
//  and      a.ProfitLossAccountType          =  'X' 
  and      a.GLAccount                      <> '0004651011'
group by
    a.CompanyCode,
    a.AccountingDocument,
    a.FiscalYear,
    b.FiscalPeriod,
    a.DocumentDate,
    a.PostingDate,
    a.TaxCode,
    b.DocumentReferenceID,
    a.AccountingDocumentType,
    a.TransactionCurrency,
    a.TaxItemAcctgDocItemRef,
    TCS.AmountInCompanyCodeCurrency,
    a.BusinessPlace,
    BI.BillingDocument,
    bitem.BillingDocumentItem,
     bitem.DistributionChannel,
    BI.BillingDocumentType,
   // TCS.AmountInCompanyCodeCurrency,
    j.TotalAmountInCoCodeCrcy,
    j.ConsumptionTaxCtrlCode,
    EW2.ewbnumber,
    EW.ewbnumber,
    IR2.Irn,
    IR.Irn,
    kk.Customer,
    d2.CustomerName,
    d2.TaxNumber3,
    a.Product,
    BI3.PLANT,
    a.Plant,
    b.IsReversal,
    a.ProfitCenter ,
    b.IsReversed,
    d2.Region,
    T.gstrate,
//    CGST.GLAccount,
//    SGST.GLAccount,
//    IGST.GLAccount,
//    CGST.AmountInCompanyCodeCurrency  ,
//    SGST.AmountInCompanyCodeCurrency  ,
//    IGST.AmountInCompanyCodeCurrency  ,
    bitem.BaseUnit
//   
//    IGST.TaxBaseAmountInCoCodeCrcy ,
//    CGST.TaxBaseAmountInCoCodeCrcy,
//    CGST.TaxBaseAmountInCoCodeCrcy 
 
//  and( 
//    (
//           CGST.AmountInCompanyCodeCurrency is not null
//      and  SGST.AmountInCompanyCodeCurrency is not null
//    )
//    or(
//           IGST.AmountInCompanyCodeCurrency is not null
//    )
//  )

//


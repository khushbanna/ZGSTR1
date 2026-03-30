@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZGSTR1_NIL_RATES_SER_CDS_FIN'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZGSTR1_NIL_RATES_SER_CDS_FIN as select from ZGSTR1_NIL_RATES_SER_CDS_NEW as A 
   left outer join I_RegionText as b on A.Region = b.Region and b.Language = 'E' and b.Country = 'IN'
     left outer join ZHSN_DES as c on A.hsn_code = c.ConsumptionTaxCtrlCode 
// left outer join ZJournalEntryItem as k on A.AccountingDocument = k.AccountingDocument and A.CompanyCode = k.CompanyCode and A.FiscalYear = k.FiscalYear
// and A.Product = k.Product   
left outer join I_OperationalAcctgDocItem as k on A.AccountingDocument = k.AccountingDocument and A.CompanyCode = k.CompanyCode and A.FiscalYear = k.FiscalYear
and k.FinancialAccountType = 'S' and k.ProfitCenter <> ''



//  
// 
//     left outer join zexport_data_tab as b on( b.docno = A.BillingDocument
//      and b.doctype = 'PO' )     
 
 {
  key  A.CompanyCode,
  key A.AccountingDocument,
  key  A.FiscalYear,
  key case when A.CompanyCode = '3000' and A.AccountingDocument = '9400000036' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000037' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000038' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000035' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000055' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000040' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000000' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000039' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000004' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000001' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3100'
           when A.CompanyCode = '1000' and A.AccountingDocument = '9400001426' and A.FiscalYear = '2025' and A.doc_item = '000001' then '1100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000012' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000053' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000054' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000054' and A.FiscalYear = '2025' and A.doc_item = '000130' then '3100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000061' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3100'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000322' and A.FiscalYear = '2025' and A.doc_item = '000001' then '3300'
           else
           k.ProfitCenter end as ProfitCenter,
  key  A.DocumentDate,
  key  A.PostingDate,
  key  A.AccountingDocumentType,
  key case when A.CompanyCode = '3000' and A.AccountingDocument = '9400000322' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000020'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000053' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000030'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000054' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000120'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000061' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000090'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000036' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000010'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000037' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000010'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000038' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000010'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000035' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000010'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000040' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000010'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000000' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000010'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000039' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000010'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000004' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000010'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000001' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000010'
           when A.CompanyCode = '1000' and A.AccountingDocument = '9400001426' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000010'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000055' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000010'
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000012' and A.FiscalYear = '2025' and A.doc_item = '000001' then '000010'          
           else
    A.doc_item end as doc_item ,
  key  A.BillingDocument,
  key  A.BillingDocumentType, // 1
  key  A.Customer,
  key A.CustomerName,
  key A.customer_gst,
  key A.Product,
  key A.ProductDescription,
  key A.hsn_code,
  key c.ConsumptionTaxCtrlCodeText1 ,
  key concat( concat( A.Region, '-' ), b.RegionName ) as RegionName ,
  key A.DocumentReferenceID,
  key case
  when A.CompanyCode = '3000' and A.AccountingDocument = '9400000053' and A.FiscalYear = '2025' and A.doc_item = '000001' then 'A0'
  when A.CompanyCode = '3000' and A.AccountingDocument = '9400000054' and A.FiscalYear = '2025' and A.doc_item = '000001' then 'A0'
  when A.CompanyCode = '3000' and A.AccountingDocument = '9400000054' and A.FiscalYear = '2025' and A.doc_item = '000130' then 'A0'
  when A.CompanyCode = '3000' and A.AccountingDocument = '9400000055' and A.FiscalYear = '2025' and A.doc_item = '000001' then 'A0'
  when A.CompanyCode = '3000' and A.AccountingDocument = '9400000061' and A.FiscalYear = '2025' and A.doc_item = '000001' then 'A0'
  when A.CompanyCode = '3000' and A.AccountingDocument = '9400000322' and A.FiscalYear = '2025' and A.doc_item = '000001' then 'A0'
  else  A.TaxCode end as TaxCode ,
  key A.BusinessPlace,
//  KEY A.ewbnumber,
  key A.Irn,
  key A.PlantCode as Plant,
  key case when A.BaseUnit = 'CS' then 'CTN' when A.BaseUnit = 'NO' then 'NOS' when A.BaseUnit = 'KG' then 'KGS'
  else A.BaseUnit end as BaseUnit ,
  key case when  A.BillingDocumentType = 'CBRE'
  then  A.Quantity * -1 else A.Quantity end as Quantity ,
  key A.TransactionCurrency,
  key case when A.CompanyCode = '3000' and A.AccountingDocument = '9400000322' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '2179.18' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000053' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '356.10' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000054' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '711.84' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000061' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '813.60' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000036' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '1584.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000037' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '1584.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000038' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '1584.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000035' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '4752.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000040' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '7920.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000000' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '9504.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000039' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '15048.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000004' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '22572.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000001' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '112860.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '1000' and A.AccountingDocument = '9400001426' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '136968.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000055' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '593.20' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000012' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '24703.55' as abap.dec( 23, 3 ))
           else
           case when A.BillingDocumentType = 'CBRE' then
           case when A.table_value > 0
           then  cast(A.table_value as abap.dec(  23, 3 ) ) * -1 
           else cast(A.table_value as abap.dec(  23, 3 ) ) end
           else
           case when A.table_value < 0
           then  cast(A.table_value as abap.dec(  23, 3 ) ) * -1 
           else cast(A.table_value as abap.dec(  23, 3 ) ) end 
           end
           end as table_value,
  key cast(0 as abap.dec(  23, 3 ) ) as JOCG_AMT,
  key 0 as JOCG_RATE,
  key cast(0 as abap.dec(  23, 3 ) ) as JOSG_AMT,
  key 0 as JOSG_RATE,
  key cast(0 as abap.dec(  23, 3 ) ) as JOIG_AMT,
  key 0 as TCS_AMT,
  key 0 as JOIG_RATE,
  key cast( 0 as abap.dec( 3, 0 )) as taxrate, 
  key cast( 0 as abap.dec( 23, 3 )) as taxamt,
  key case when A.CompanyCode = '3000' and A.AccountingDocument = '9400000322' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '2179.20' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000053' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '356.08' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000054' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '711.87' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000054' and A.FiscalYear = '2025' and A.doc_item = '000130' then cast( '711.87' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000061' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '813.60' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000036' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '1584.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000037' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '1584.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000038' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '1584.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000035' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '4751.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000040' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '7920.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000000' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '9504.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000039' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '15048.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000004' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '22572.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000001' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '112860.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '1000' and A.AccountingDocument = '9400001426' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '136968.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000055' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '593.00' as abap.dec( 23, 3 ))
           when A.CompanyCode = '3000' and A.AccountingDocument = '9400000012' and A.FiscalYear = '2025' and A.doc_item = '000001' then cast( '24704.00' as abap.dec( 23, 3 ))
           else
           case when A.BillingDocumentType = 'CBRE' then
           case when A.INVOICE_AMT > 0
           then  cast(A.INVOICE_AMT as abap.dec(  23, 3 ) ) * -1 
           else cast(A.INVOICE_AMT as abap.dec(  23, 3 ) ) end
           else
           case when A.INVOICE_AMT < 0
           then  cast(A.INVOICE_AMT as abap.dec(  23, 3 ) ) * -1 
           else cast(A.INVOICE_AMT as abap.dec(  23, 3 ) ) end 
           end
           end as INVOICE_AMT,
           
//      case when A.INVOICE_AMT < 0
//           then cast(A.INVOICE_AMT as abap.dec( 20, 2 )) * -1
//           else cast(A.INVOICE_AMT as abap.dec( 20, 2 )) end
//           end as INVOICE_AMT, 
   case when A.CompanyCode = '1000' and A.AccountingDocument = '9400001426' and A.FiscalYear = '2025' and A.doc_item = '000001'
   then 'EXPORT' else A.REPORT end as REPORT,
   A.BillingDocumentDate,
   A.BillingDocumentItem as  BillingDocumentItem,
   A.NetAmount,   
   A.rATE,
   A.TaxAmount,
      '' as GLAccount
      
      
  
  
 
 }

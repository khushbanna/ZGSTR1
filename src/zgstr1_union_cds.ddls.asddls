@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Union Cds For gstr1 report'
@Metadata.ignorePropagatedAnnotations: true
@UI: { headerInfo: { typeName: 'Report', typeNamePlural: 'GSTR1 Report'  } }
define root view entity ZGSTR1_UNION_CDS
  as select distinct from zgstr1_b2b_cds3 as A
  left outer join I_RegionText as b on A.Region = b.Region and b.Language = 'E' and b.Country = 'IN'
left outer join ZHSN_DES as c on A.hsn_code = c.ConsumptionTaxCtrlCode
//left outer join ZJournalEntryItem as k on A.AccountingDocument = k.AccountingDocument and A.CompanyCode = k.CompanyCode and A.FiscalYear = k.FiscalYear
//and A.product = k.Product
left outer join I_OperationalAcctgDocItem as k on A.AccountingDocument = k.AccountingDocument and A.CompanyCode = k.CompanyCode and A.FiscalYear = k.FiscalYear
and k.FinancialAccountType = 'S' and k.ProfitCenter <> ''
{
      @UI.lineItem       : [{position: 10}]
      @UI.selectionField : [{position: 10}]
      @EndUserText.label: 'Company Code'
  key A.CompanyCode,
      @UI.lineItem      : [{ position: 20 }]
      @UI.selectionField : [{position: 10}]
      @Consumption.valueHelpDefinition: [ { entity : { name: 'ZACCDOC_F4', element : 'accdoc' } }]
      @EndUserText.label: 'Accounting Document'
  key A.AccountingDocument,
      @UI.lineItem      : [{ position: 30 }]
      @UI.selectionField : [{position: 10}]
      @EndUserText.label: 'Fiscal Year'
  key A.FiscalYear,
  key k.ProfitCenter,  
  key A.DocumentDate,
  key A.PostingDate,
  key A.AccountingDocumentType,
  key A.doc_item,
  @EndUserText.label: 'BillingDocument'  
  key case when A.BillingDocument <> '' then A.BillingDocument
            else A.AccountingDocument end as BillingDocument ,
  key A.BillingDocumentType,
  key A.Customer,
  key A.CustomerName,
     @EndUserText.label: 'GST IN'
  key A.customer_gst,
  key A.product,
  key A.ProductDescription,
  key A.hsn_code,
       @EndUserText.label: 'HSN Description'
  key c.ConsumptionTaxCtrlCodeText1 ,
      @EndUserText.label: 'Region Name'
  key concat( concat( A.Region, '-' ), b.RegionName ) as RegionName ,
//      @EndUserText.label: 'Region Name'
//  key b.RegionName,
  key A.DocumentReferenceID,
  key A.TaxCode,
  key A.BusinessPlace,
//  key A.ewbnumber,
  @EndUserText.label: 'IRN Status'
  key A.Irn,
  key A.Plant,
  key case when A.BaseUnit = 'CS' then 'CTN' when A.BaseUnit = 'NO' then 'NOS'  when A.BaseUnit = 'KG' then 'KGS'
  else A.BaseUnit end as BaseUnit ,
      @DefaultAggregation: #SUM
  key case when  A.BillingDocumentType = 'CBRE'
  then  A.Quantity * -1 else A.Quantity end as Quantity ,
  key A.TransactionCurrency,
      @EndUserText.label: 'Taxable Amount'
      @DefaultAggregation: #SUM
  key A.table_value,
      @EndUserText.label: 'CGST Amount'
      @DefaultAggregation: #SUM
  key A.JOCG_AMT,
      @EndUserText.label: 'CGST Rate'
  key A.JOCG_RATE,
      @EndUserText.label: 'SGST Amount'
      @DefaultAggregation: #SUM
  key A.JOSG_AMT,
      @EndUserText.label: 'SGST Rate'
  key A.JOSG_RATE,
      @EndUserText.label: 'IGST Amount'
      @DefaultAggregation: #SUM
  key A.JOIG_AMT,
      @EndUserText.label: 'TCS Amount'
      @DefaultAggregation: #SUM
  key A.TCS_AMT,
      @EndUserText.label: 'IGST Rate'
  key A.JOIG_RATE,
      @EndUserText.label: 'HSN Total Amount'
      @DefaultAggregation: #SUM    
  key cast(coalesce(A.table_value,0) + coalesce(A.JOCG_AMT,0) + coalesce(A.JOSG_AMT,0) + coalesce(A.JOIG_AMT,0) as abap.dec( 20, 2 )) as hsn_tot_amt,
 
      @EndUserText.label: 'Tax Rate'
  key cast (coalesce(A.JOCG_RATE,0) + coalesce(A.JOSG_RATE,0) + coalesce(A.JOIG_RATE,0) as abap.dec( 3, 0 )) as taxrate,
  
        @EndUserText.label: 'Tax Amount'
      @DefaultAggregation: #SUM
  key cast (coalesce(A.JOCG_AMT,0) + coalesce(A.JOSG_AMT,0) + coalesce(A.JOIG_AMT,0) as abap.dec( 23, 3 )) as taxamt,
      @EndUserText.label: 'Invoice Amount'
      @DefaultAggregation: #SUM
  key A.INVOICE_AMT,
 
      @UI.lineItem             : [{ position: 65 }]
      @UI.selectionField       : [{position: 80}]
 
      @Consumption.filter.multipleSelections: false
    //  @Consumption.filter.mandatory: true
      @Consumption.defaultValue: 'B2B'
      @EndUserText.label       : 'Report'
      @Consumption.valueHelpDefinition: [
      { entity                  :  { name:    'ZGSTR1_F4',
                  element      : 'subrep_type' }
      }]
      A.REPORT,
      A.BillingDocumentDate,
      A.BillingDocumentItem,
      //       @Semantics.amount.currencyCode: 'TransactionCurrency'
      A.NetAmount,
      A.rATE,
      //       @Semantics.amount.currencyCode: 'TransactionCurrency'
      @UI.hidden: true
      A.TaxAmount ,
      ' ' as GLAccount
 
}
 
union select distinct from ZGSTR1_CDNR_CDS3 as B
left outer join I_RegionText as a on a.Region = B.Region and a.Language = 'E' and a.Country = 'IN'
  left outer join ZHSN_DES as c on B.hsn_code = c.ConsumptionTaxCtrlCode
//   left outer join ZJournalEntryItem as k on B.AccountingDocument = k.AccountingDocument and B.CompanyCode = k.CompanyCode and B.FiscalYear = k.FiscalYear
//and B.product = k.Product

left outer join I_OperationalAcctgDocItem as k on B.AccountingDocument = k.AccountingDocument and B.CompanyCode = k.CompanyCode and B.FiscalYear = k.FiscalYear
and k.FinancialAccountType = 'S' and k.ProfitCenter <> ''
 
{
  key B.CompanyCode,
  key B.AccountingDocument,
  key B.FiscalYear,
  key k.ProfitCenter,
  key B.DocumentDate,
  key B.PostingDate,
  key B.AccountingDocumentType,
  key B.doc_item,
  key case when B.BillingDocument <> '' then B.BillingDocument
            else B.AccountingDocument end as BillingDocument,
  key B.BillingDocumentType,
  key B.Customer,
  key B.CustomerName,
  key B.customer_gst,
  key B.product,
  key B.ProductDescription,
  key B.hsn_code,
  key c.ConsumptionTaxCtrlCodeText1 ,
//  key B.GLAccount,
  key concat( concat( B.Region, '-' ), a.RegionName ) as RegionName ,
  key B.DocumentReferenceID,
  key B.TaxCode,
  key B.BusinessPlace,
//  key B.ewbnumber,
  key B.Irn,
  key B.Plant,
  key case when B.BaseUnit = 'CS' then 'CTN' when B.BaseUnit = 'NO' then 'NOS' when B.BaseUnit = 'KG' then 'KGS'
  else B.BaseUnit end as BaseUnit ,
  key case when  B.BillingDocumentType = 'CBRE'
  then  B.Quantity * -1 else B.Quantity end as Quantity ,
  key B.TransactionCurrency,
  key B.table_value,
  key B.JOCG_AMT,
  key B.JOCG_RATE,
  key B.JOSG_AMT,
  key B.JOSG_RATE,
  key B.JOIG_AMT,
  key B.TCS_AMT,
  key B.JOIG_RATE,
  key cast(coalesce(B.table_value,0) + coalesce(B.JOCG_AMT,0) + coalesce(B.JOSG_AMT,0) + coalesce(B.JOIG_AMT,0) as abap.dec( 20, 2 )) as hsn_tot_amt,
  key cast (coalesce(B.JOCG_RATE,0) + coalesce(B.JOSG_RATE,0) + coalesce(B.JOIG_RATE,0) as abap.dec( 3, 0 )) as taxrate,
  key cast (coalesce(B.JOCG_AMT,0) + coalesce(B.JOSG_AMT,0) + coalesce(B.JOIG_AMT,0) as abap.dec( 23, 3 )) as taxamt,
  key B.INVOICE_AMT,
 
       case when B.REPORT = 'CDNUR' then
       case when B.INVOICE_AMT2 < 100000 then 'B2CS'
       else B.REPORT end
       else B.REPORT end as REPORT,
       
      B.BillingDocumentDate,
      B.BillingDocumentItem,
      //      @Semantics.amount.currencyCode: 'TransactionCurrency'
      B.NetAmount,
      B.rATE,
      B.TaxAmount,
      ' ' as GLAccount
 
}
 
union select distinct from ZGSTR1_NIL_RATES_SER_CDS_FIN as A
  
  {
key CompanyCode,
key AccountingDocument,
key FiscalYear,
key ProfitCenter,
key DocumentDate,
key PostingDate,
key AccountingDocumentType,
key doc_item,
  key case when BillingDocument <> '' then BillingDocument
            else AccountingDocument end as BillingDocument ,
key BillingDocumentType,
key Customer,
key CustomerName,
key customer_gst,
key Product,
key ProductDescription,
key hsn_code,
key ConsumptionTaxCtrlCodeText1,
key RegionName,
key DocumentReferenceID,
key TaxCode,
key BusinessPlace,
key Irn,
key Plant,
key BaseUnit,
key Quantity,
key TransactionCurrency,
key table_value,
key JOCG_AMT,
key JOCG_RATE,
key JOSG_AMT,
key JOSG_RATE,
key JOIG_AMT,
key TCS_AMT,
key JOIG_RATE,
key cast(A.table_value as abap.dec( 20, 2 )) as hsn_tot_amt,
key taxrate,
key taxamt,
key INVOICE_AMT,
REPORT,
BillingDocumentDate,
BillingDocumentItem,
NetAmount,
rATE,
TaxAmount,
GLAccount
}
 
//union select distinct from ZGSTR1_HSN_SUMMARY_1 as a
//left outer join I_RegionText as b on a.Region = b.Region and b.Language = 'E' and b.Country = 'IN'
// left outer join ZHSN_DES as c on a.hsn_code = c.ConsumptionTaxCtrlCode
// left outer join ZJournalEntryItem as k on a.AccountingDocument = k.AccountingDocument and a.CompanyCode = k.CompanyCode and a.FiscalYear = k.FiscalYear
// and a.product = k.Product
//{    
//key a.CompanyCode,
//key a.AccountingDocument,
//key a.FiscalYear,
//key k.ProfitCenter,
//key a.DocumentDate,
//key a.PostingDate,
//key a.AccountingDocumentType,
//key '000000' as doc_item ,
//key a.BillingDocument,
//key a.BillingDocumentType,
//key a.Customer,
//key a.CustomerName,
//key a.customer_gst,
//key a.product,
//key a.productDescription,
//key a.hsn_code,
//key c.ConsumptionTaxCtrlCodeText1 ,
//key concat( concat( a.Region, '-' ), b.RegionName ) as RegionName ,
//key a.DocumentReferenceID,
//key a.TaxCode,
//key a.BusinessPlace,
//key '' as Irn,
//key a.PlantCode as plant,
//  key case when a.BaseUnit = 'CS' then 'CTN' when a.BaseUnit = 'NO' then 'NOS' when a.BaseUnit = 'KG' then 'KGS'
//  else a.BaseUnit end as BaseUnit ,
//key a.Quantity,
//key a.TransactionCurrency,
//key cast(a.table_value as abap.dec(  23, 3 ) ) as table_value,
//key cast(a.JOCG_AMT as abap.dec(  23, 3 ) ) as JOCG_AMT,
//key a.JOCG_RATE,
//  key cast(a.JOSG_AMT as abap.dec(  23, 3 ) ) as JOSG_AMT,
//  key a.JOSG_RATE,
//  key cast(a.JOIG_AMT as abap.dec(  23, 3 ) ) as JOIG_AMT,
//  key 0 as TCS_AMT,
//  key a.JOIG_RATE,
//  key cast (coalesce(a.JOCG_RATE,0) + coalesce(a.JOSG_RATE,0) + coalesce(a.JOIG_RATE,0) as abap.dec( 3, 0 )) as taxrate,
//  key coalesce(cast(a.JOCG_AMT as abap.dec(  23, 3 ) ),0) + coalesce(cast(a.JOSG_AMT as abap.dec(  23, 3 ) ),0) + coalesce(cast(a.JOIG_AMT as abap.dec(  23, 3 ) ) ,0) as taxamt,
//  key a.INVOICE_AMT,
//   a.REPORT,
//    a.BillingDocumentDate,
//    a.BillingDocumentItem as  BillingDocumentItem,
//    a.NetAmount,
//    a.rATE,
//    a.TaxAmount,
//      '' as GLAccount
//
//}
 
 
 
 
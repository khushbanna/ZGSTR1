@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZSD_GSTR1_CDS2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_GSTR1_CDS2
  as select from ZSD_GSTR1_CDS1 as a left outer join
  ZROUND_GL2 as b on a.CompanyCode = b.CompanyCode and a.AccountingDocument = b.AccountingDocument and a.FiscalYear = b.FiscalYear
 left outer join ZBUSINESSPLACE as K on a.AccountingDocument = K.AccountingDocument and a.CompanyCode = K.CompanyCode and a.FiscalYear = K.FiscalYear
  
  //define view entity ZSD_GSTR1_CDS2 as select from zgstr1_b2b_cds3 as a
{
  key a.CompanyCode,
      a.AccountingDocument,
      a.FiscalYear,
      a.Report,
      a.DocumentDate, 
      a.PostingDate,
      a.AccountingDocumentType,
      a.BillingDocumentItem                        as doc_item,
      a.BillingDocument,
      a.BillingDocumentType,
      a.CUSTOMER_CODE                              as Customer,
      a.CUSTOMER_NAME                              as CustomerName,
      a.CustomerGSTIN                              as customer_gst,
      a.ProductCode                                as product,
      a.ProductDescription,
      a.ConsumptionTaxCtrlCode                     as hsn_code,
      a.Irn,
      ' '                                          as GLAccount,
      a.Region,
      ' '                                          as DocumentReferenceID,
      a.TaxCode,
      K.BusinessPlace                                          as BusinessPlace,
      cast( ' ' as abap.numc( 12 ) )               as ewbnumber,
      a.Plant,
      a.BillingQuantityUnit                        as BaseUnit,
      ' '                                          as ProfitCenter,
      cast(a.Quantity as abap.dec( 20, 3 ) )       as Quantity,
      a.TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
   case when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000003' and a.BillingDocumentItem = '000010' then cast('7857.15'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000002' and a.BillingDocumentItem = '000010' then cast('8223.75'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000007' and a.BillingDocumentItem = '000010' then cast('2360.95'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000008' and a.BillingDocumentItem = '000010' then cast('3078.60'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000008' and a.BillingDocumentItem = '000020' then cast('1744.97'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000008' and a.BillingDocumentItem = '000030' then cast('2300.79'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000009' and a.BillingDocumentItem = '000010' then cast('3542.86'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000009' and a.BillingDocumentItem = '000020' then cast('3142.86'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000009' and a.BillingDocumentItem = '000030' then cast('1428.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000009' and a.BillingDocumentItem = '000040' then cast('2464.15'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000010' and a.BillingDocumentItem = '000010' then cast('4928.30'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000010' and a.BillingDocumentItem = '000020' then cast('1504.80'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000011' and a.BillingDocumentItem = '000010' then cast('8223.75'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000011' and a.BillingDocumentItem = '000020' then cast('9428.58'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000014' and a.BillingDocumentItem = '000010' then cast('1525.42'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000014' and a.BillingDocumentItem = '000020' then cast('1525.42'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000014' and a.BillingDocumentItem = '000030' then cast('2464.15'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000014' and a.BillingDocumentItem = '000040' then cast('2448.98'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000015' and a.BillingDocumentItem = '000010' then cast('3542.86'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000015' and a.BillingDocumentItem = '000020' then cast('7857.15'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000016' and a.BillingDocumentItem = '000010' then cast('31428.60'  as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000016' and a.BillingDocumentItem = '000020' then cast('8857.15'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000016' and a.BillingDocumentItem = '000030' then cast('10000.00'  as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000017' and a.BillingDocumentItem = '000010' then cast('3142.86'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000017' and a.BillingDocumentItem = '000020' then cast('1771.43'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000017' and a.BillingDocumentItem = '000030' then cast('8223.75'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000018' and a.BillingDocumentItem = '000010' then cast('12320.75'  as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000019' and a.BillingDocumentItem = '000010' then cast('32895.00'  as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000020' and a.BillingDocumentItem = '000010' then cast('49342.50'  as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000021' and a.BillingDocumentItem = '000010' then cast('1525.42'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000021' and a.BillingDocumentItem = '000020' then cast('2448.98'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000022' and a.BillingDocumentItem = '000010' then cast('3009.60'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000022' and a.BillingDocumentItem = '000020' then cast('2464.15'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000022' and a.BillingDocumentItem = '000030' then cast('3142.86'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000022' and a.BillingDocumentItem = '000040' then cast('1771.43'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000022' and a.BillingDocumentItem = '000050' then cast('3289.50'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000022' and a.BillingDocumentItem = '000060' then cast('2448.98'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000023' and a.BillingDocumentItem = '000010' then cast('15714.30'  as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000023' and a.BillingDocumentItem = '000020' then cast('3009.60'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000024' and a.BillingDocumentItem = '000010' then cast('2360.95'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000025' and a.BillingDocumentItem = '000010' then cast('3403.17'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000026' and a.BillingDocumentItem = '000010' then cast('3265.31'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000028' and a.BillingDocumentItem = '000010' then cast('4928.30'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000029' and a.BillingDocumentItem = '000010' then cast('4714.29'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000029' and a.BillingDocumentItem = '000020' then cast('3542.86'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000029' and a.BillingDocumentItem = '000030' then cast('1428.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000029' and a.BillingDocumentItem = '000040' then cast('1430.43'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000029' and a.BillingDocumentItem = '000050' then cast('2464.15'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000030' and a.BillingDocumentItem = '000010' then cast('2464.15'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000030' and a.BillingDocumentItem = '000020' then cast('1504.80'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000031' and a.BillingDocumentItem = '000010' then cast('1571.43'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000031' and a.BillingDocumentItem = '000020' then cast('3862.22'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000031' and a.BillingDocumentItem = '000030' then cast('1932.44'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000032' and a.BillingDocumentItem = '000010' then cast('2288.14'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000032' and a.BillingDocumentItem = '000020' then cast('2856.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000032' and a.BillingDocumentItem = '000030' then cast('1430.43'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000032' and a.BillingDocumentItem = '000040' then cast('1546.88'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000033' and a.BillingDocumentItem = '000010' then cast('1584.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000033' and a.BillingDocumentItem = '000020' then cast('1634.40'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000034' and a.BillingDocumentItem = '000010' then cast('3905.09'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000041' and a.BillingDocumentItem = '000010' then cast('3009.60'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000041' and a.BillingDocumentItem = '000020' then cast('4934.25'   as abap.dec( 23,2 ))
        when a.CompanyCode = '2000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000000' and a.BillingDocumentItem = '000010' then cast('561690.00' as abap.dec( 23,2 ))
        when a.CompanyCode = '2000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000002' and a.BillingDocumentItem = '000020' then cast('581115.00' as abap.dec( 23,2 ))
        when a.CompanyCode = '2000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000003' and a.BillingDocumentItem = '000010' then cast('526050.00' as abap.dec( 23,2 ))
        else coalesce( cast(a.TaxableValue   as abap.dec( 20, 2 ) ),0 ) + coalesce (cast( b.AmountInCompanyCodeCurrency as abap.dec( 20, 2 )),0) end as table_value,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cast(a.JOCG_AMOUNT  as abap.dec( 20, 2 ) )   as JOCG_AMT,
      a.JOCG_Rate,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cast(a.JOSG_AMOUNT as abap.dec( 20, 2 ) )    as JOSG_AMT,
      a.JOSG_RATE,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cast(a.JOIG_AMOUNT as abap.dec( 20, 2 ) )    as JOIG_AMT,
      a.JOIG_RATE,
      
      cast(a.ZTCS_AMT as abap.dec( 20, 2 ) )    as ZTCS_AMT,
      
      @Semantics.amount.currencyCode: 'TransactionCurrency'
   //   coalesce( cast(a.InvoiceValue as abap.dec( 20, 2 ) ),0 )  + coalesce (cast( b.AmountInCompanyCodeCurrency as abap.dec( 20, 2 )),0)   as INVOICE_AMT,
   case when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000003' and a.BillingDocumentItem = '000010' then cast('8250.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000002' and a.BillingDocumentItem = '000010' then cast('8635.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000007' and a.BillingDocumentItem = '000010' then cast('2479.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000008' and a.BillingDocumentItem = '000010' then cast('3232.67'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000008' and a.BillingDocumentItem = '000020' then cast('1832.29'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000008' and a.BillingDocumentItem = '000030' then cast('2715.04'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000009' and a.BillingDocumentItem = '000010' then cast('3719.97'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000009' and a.BillingDocumentItem = '000020' then cast('3299.97'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000009' and a.BillingDocumentItem = '000030' then cast('1499.39'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000009' and a.BillingDocumentItem = '000040' then cast('2907.67'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000010' and a.BillingDocumentItem = '000010' then cast('5815.24'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000010' and a.BillingDocumentItem = '000020' then cast('1504.76'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000011' and a.BillingDocumentItem = '000010' then cast('8634.96'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000011' and a.BillingDocumentItem = '000020' then cast('9900.04'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000014' and a.BillingDocumentItem = '000010' then cast('1799.98'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000014' and a.BillingDocumentItem = '000020' then cast('1799.98'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000014' and a.BillingDocumentItem = '000030' then cast('2907.65'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000014' and a.BillingDocumentItem = '000040' then cast('2571.39'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000015' and a.BillingDocumentItem = '000010' then cast('3720.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000015' and a.BillingDocumentItem = '000020' then cast('8250.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000016' and a.BillingDocumentItem = '000010' then cast('33000.01'  as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000016' and a.BillingDocumentItem = '000020' then cast('9300.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000016' and a.BillingDocumentItem = '000030' then cast('10499.99'  as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000017' and a.BillingDocumentItem = '000010' then cast('3300.01'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000017' and a.BillingDocumentItem = '000020' then cast('1860.02'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000017' and a.BillingDocumentItem = '000030' then cast('8634.97'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000018' and a.BillingDocumentItem = '000010' then cast('14538.00'  as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000019' and a.BillingDocumentItem = '000010' then cast('34540.00'  as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000020' and a.BillingDocumentItem = '000010' then cast('51810.00'  as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000021' and a.BillingDocumentItem = '000010' then cast('1799.83'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000021' and a.BillingDocumentItem = '000020' then cast('2571.17'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000022' and a.BillingDocumentItem = '000010' then cast('3009.65'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000022' and a.BillingDocumentItem = '000020' then cast('2907.74'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000022' and a.BillingDocumentItem = '000030' then cast('3300.06'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000022' and a.BillingDocumentItem = '000040' then cast('1860.04'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000022' and a.BillingDocumentItem = '000050' then cast('3454.04'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000022' and a.BillingDocumentItem = '000060' then cast('2571.47'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000023' and a.BillingDocumentItem = '000010' then cast('16500.34'  as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000023' and a.BillingDocumentItem = '000020' then cast('3009.66'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000024' and a.BillingDocumentItem = '000010' then cast('2479.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000025' and a.BillingDocumentItem = '000010' then cast('3573.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000026' and a.BillingDocumentItem = '000010' then cast('3429.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000028' and a.BillingDocumentItem = '000010' then cast('5815.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000029' and a.BillingDocumentItem = '000010' then cast('4950.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000029' and a.BillingDocumentItem = '000020' then cast('3719.99'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000029' and a.BillingDocumentItem = '000030' then cast('1499.39'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000029' and a.BillingDocumentItem = '000040' then cast('1501.94'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000029' and a.BillingDocumentItem = '000050' then cast('2907.68'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000030' and a.BillingDocumentItem = '000010' then cast('2907.37'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000030' and a.BillingDocumentItem = '000020' then cast('1504.63'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000031' and a.BillingDocumentItem = '000010' then cast('1650.11'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000031' and a.BillingDocumentItem = '000020' then cast('3862.47'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000031' and a.BillingDocumentItem = '000030' then cast('2280.42'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000032' and a.BillingDocumentItem = '000010' then cast('2700.01'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000032' and a.BillingDocumentItem = '000020' then cast('2998.80'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000032' and a.BillingDocumentItem = '000030' then cast('1501.96'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000032' and a.BillingDocumentItem = '000040' then cast('1624.23'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000033' and a.BillingDocumentItem = '000010' then cast('1584.18'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000033' and a.BillingDocumentItem = '000020' then cast('1928.82'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000034' and a.BillingDocumentItem = '000010' then cast('4608.00'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000041' and a.BillingDocumentItem = '000010' then cast('3009.76'   as abap.dec( 23,2 ))
        when a.CompanyCode = '3000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000041' and a.BillingDocumentItem = '000020' then cast('5181.24'   as abap.dec( 23,2 ))
        when a.CompanyCode = '2000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000000' and a.BillingDocumentItem = '000010' then cast('589775.00' as abap.dec( 23,2 ))
        when a.CompanyCode = '2000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000002' and a.BillingDocumentItem = '000020' then cast('610171.00' as abap.dec( 23,2 ))
        when a.CompanyCode = '2000' and a.FiscalYear = '2025' and a.AccountingDocument = '9400000003' and a.BillingDocumentItem = '000010' then cast('552353.00' as abap.dec( 23,2 ))
        else cast(a.InvoiceValue as abap.dec( 20, 2 ) ) end as INVOICE_AMT,
      a.BillingDocumentDate,
      ' '                                          as BillingDocumentItem,

      cast(0 as abap.dec( 23, 2) )                                      as NetAmount,
      '0.00'                                       as rATE,
      '0.00'                                       as TaxAmount


}

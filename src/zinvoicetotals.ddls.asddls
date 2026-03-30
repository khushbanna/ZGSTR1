@AbapCatalog.sqlViewName: 'ZINV_TOTALS'
@EndUserText.label: 'Invoice Total per BillingDocument'
define view ZInvoiceTotals as select from ZGSTR1_CDNR_CDS3
{
  key BillingDocument,
  sum(INVOICE_AMT) as TotalInvoiceAmount
}
group by BillingDocument

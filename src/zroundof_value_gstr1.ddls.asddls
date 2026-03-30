@AbapCatalog.sqlViewName: 'YFJFHFBDFF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ROUNDOF VALUE GSTR1'
@Metadata.ignorePropagatedAnnotations: true
define view Zroundof_VALUE_GSTR1 as select from I_OperationalAcctgDocItem as A
{
    key A.AccountingDocument,
    key A.AccountingDocumentItem,
    key A.CompanyCode,
    key A.FiscalYear,
        A.DebitCreditCode,
         A.TransactionCurrency,
         @Semantics.amount.currencyCode: 'TransactionCurrency'
  case when A.DebitCreditCode = 'S' then  sum( A.AmountInCompanyCodeCurrency ) * 1 
     else    sum( A.AmountInCompanyCodeCurrency ) end  as AmountInCompanyCodeCurrency  
}
where A.GLAccount = '0004651011'
group by
    A.AccountingDocument,
    A.AccountingDocumentItem,
    A.CompanyCode,
    A.FiscalYear,
    A.DebitCreditCode,
    A.TransactionCurrency

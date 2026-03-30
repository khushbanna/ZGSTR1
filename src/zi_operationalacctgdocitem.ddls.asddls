@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I_OperationalAcctgDocItem'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_OperationalAcctgDocItem as select from I_OperationalAcctgDocItem as A
{
    key A.AccountingDocument,
    key A.CompanyCode,
    key A.FiscalYear,
    A.TaxItemAcctgDocItemRef,
    A.TaxCode,
    A.ProfitCenter,
  A.DocumentDate           as DocumentDate,
  A.PostingDate,
  A.GLAccount,
  A.AccountingDocumentType,
  A.TransactionCurrency,
  A.BusinessPlace,
  A.Plant,
  A.Product,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  A.AmountInCompanyCodeCurrency,
  A.ProfitLossAccountType  
}

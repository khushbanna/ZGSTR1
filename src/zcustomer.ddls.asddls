@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCUSTOMER as select from I_OperationalAcctgDocItem
{
    key AccountingDocument ,
    key FiscalYear,
    key CompanyCode,
       Customer
} where FinancialAccountType = 'D'

  group by 
    AccountingDocument ,
    FiscalYear,
    CompanyCode,
    Customer

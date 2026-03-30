@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BUSINESSPLACE'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBUSINESSPLACE as select from I_OperationalAcctgDocItem as a 
left outer join I_KR_BusinessPlace as b on a.BusinessPlace = b.Branch
{
    key a.AccountingDocument,
    key a.FiscalYear,
    key a.CompanyCode,
    key a.BusinessPlace,
    substring( b.TaxNumber1,1,2) as region
} where a.BusinessPlace <> ''

group by 
    a.AccountingDocument,
    a.FiscalYear,
    a.CompanyCode,
    a.BusinessPlace,
    b.TaxNumber1


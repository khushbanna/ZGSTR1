@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Total Invoice Amount'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZTOTAL_INVOICE_AMOUNT as select from ZGSTR1_UNION_CDS
{

key AccountingDocument,
key Plant,
key CompanyCode,
key FiscalYear,
cast(sum( INVOICE_AMT ) as abap.dec(20,2)) as TOTAL_INVOICE_AMT,

 case
    when cast( sum( INVOICE_AMT ) as abap.dec(20,2) ) < 100000
      then 'B2CS'
    else 'B2CL'
  end as REPORT1



    
}

group by 
AccountingDocument,
Plant,
CompanyCode,
FiscalYear

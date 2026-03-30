@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZSD_GSTR1_CDS1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_GSTR1_CDS1
  as select from    I_BillingDocument              as A
    inner join      ZTAXITEM00                     as AB  on(
       AB.BillingDocument = A.BillingDocument
     )
    left outer join I_BillingDocumentItem          as B   on(
        A.BillingDocument = B.BillingDocument
      )
    left outer join I_BillingDocumentPartner       as RE  on(
       A.BillingDocument      = RE.BillingDocument
       and RE.PartnerFunction = 'RE'
     )
    left outer join I_Customer                     as REC on(
      RE.Customer = REC.Customer
    )
    left outer join I_Address_2                    as D   on(
        RE.AddressID = D.AddressID
      )
    left outer join I_ProductPlantBasic            as PL  on(
       PL.Plant       = B.Plant
       and PL.Product = B.Product
     )
    left outer join I_ProductDescription_2         as pd  on(
       pd.Product      = B.Product
       and pd.Language = 'E'
     )
    left outer join I_BillingDocumentItemPrcgElmnt as CG  on(
       CG.BillingDocument         = B.BillingDocument
       and CG.BillingDocumentItem = B.BillingDocumentItem
       and CG.ConditionType       = 'JOCG'
     )
    left outer join I_BillingDocumentItemPrcgElmnt as SG  on(
       SG.BillingDocument         = B.BillingDocument
       and SG.BillingDocumentItem = B.BillingDocumentItem
       and SG.ConditionType       = 'JOSG'
     )

    left outer join I_BillingDocumentItemPrcgElmnt as IG  on(
       IG.BillingDocument         = B.BillingDocument
       and IG.BillingDocumentItem = B.BillingDocumentItem
       and IG.ConditionType       = 'JOIG'
     )
    left outer join I_BillingDocumentItemPrcgElmnt as ZTCS  on(
       ZTCS.BillingDocument         = B.BillingDocument
       and ZTCS.BillingDocumentItem = B.BillingDocumentItem
       and ZTCS.ConditionType       = 'ZTCS'
     )
    left outer join Y1IG_INVREFNUM_DD    as IR      
     on A.BillingDocument = IR.Docno and 
        A.CompanyCode = IR.Bukrs and 
        A.FiscalYear  = IR.DocYear and 
        IR.IrnStatus = 'ACT'


{

  key A.BillingDocument             as BillingDocument,
      A.CompanyCode                 as CompanyCode,
      A.FiscalYear                  as FiscalYear,
      AB.AccountingDocument,
      AB.AccountingDocumentType,
      AB.PostingDate,
      A.BillingDocumentDate         as DocumentDate,
      A.BillingDocumentType,
      A.BillingDocumentDate,
      B.BillingDocumentItem,
      B.Plant,
      B.TaxCode,
      B.Product                     as ProductCode,
      pd.ProductDescription,
        case when  IR.Irn is not initial
       then 'Updated'
       else ' ' end  as Irn,
      B.BillingQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      B.BillingQuantity             as Quantity,
      //          cast(B.BillingQuantity as abap.dec( 20, 3 ) ) as BillingQuantity ,
      B.TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case when ( A.BillingDocumentType = 'CBRE' or A.BillingDocumentType = 'G2' )
      then B.NetAmount   * -1 
      else  B.NetAmount end as TaxableValue,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case when ( A.BillingDocumentType = 'CBRE' or A.BillingDocumentType = 'G2' )
      then ( B.TaxAmount + B.NetAmount ) * -1 
      else ( B.TaxAmount + B.NetAmount ) end as InvoiceValue,

      RE.Customer                   as CUSTOMER_CODE,
      REC.CustomerName              as CUSTOMER_NAME,
      REC.TaxNumber3                as CustomerGSTIN,
      REC.AddressID,
      case when B.DistributionChannel = '16'
      then B.Region 
      else REC.Region end as Region ,
     // REC.Region                    as Region,
      PL.ConsumptionTaxCtrlCode,
      CG.ConditionRateValue         as JOCG_Rate,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case when ( A.BillingDocumentType = 'CBRE' or A.BillingDocumentType = 'G2' )
      then CG.ConditionAmount * -1
      else CG.ConditionAmount end      as JOCG_AMOUNT,

      SG.ConditionRateValue         as JOSG_RATE,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case when ( A.BillingDocumentType = 'CBRE' or A.BillingDocumentType = 'G2' )      
      then SG.ConditionAmount * -1
      else SG.ConditionAmount end      as JOSG_AMOUNT,
      
      IG.ConditionRateValue         as JOIG_RATE,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case when ( A.BillingDocumentType = 'CBRE' or A.BillingDocumentType = 'G2' )         
      then IG.ConditionAmount * -1
      else IG.ConditionAmount end      as JOIG_AMOUNT,
      
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ZTCS.ConditionAmount           as ZTCS_AMT,
      case when A.BillingDocumentType = 'F2' or A.BillingDocumentType = 'JSTO'
        then cast('B2B' as abap.char( 10 ) ) 
        when A.BillingDocumentType = 'G2' or A.BillingDocumentType = 'L2' or  A.BillingDocumentType = 'CBRE'
        then cast('CDNR' as abap.char( 10 ) ) end as Report
        
      

      //      concat(
      //      concat(coalesce(D.OrganizationName1, ''), coalesce(D.OrganizationName2, '')),
      //      concat(coalesce(D.OrganizationName3, ''), coalesce(D.OrganizationName4, ''))
      //      )                             as CustomerName




}


where
      A.BillingDocumentIsCancelled <> 'X'
  and A.BillingDocumentType        <> 'S1'
  and A.BillingDocumentType        <> 'S2'
  and A.BillingDocumentType        <> 'S3'
  
  and B.TaxCode <> 'F4'

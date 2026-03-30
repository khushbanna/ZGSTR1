@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'hsn description'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZHSN_DES as select from  I_AE_CnsmpnTaxCtrlCodeTxt
{
    key ConsumptionTaxCtrlCode,
        ConsumptionTaxCtrlCodeText1
} 
 where Language = 'E' and CountryCode = 'IN'
 
 group by ConsumptionTaxCtrlCode,
          ConsumptionTaxCtrlCodeText1

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 F4'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZGSTR1_F4
  as select from zgstreport_f4 as A
{
  key A.subrep_type
}
where
      A.rep_type =  'GSTR1'
  and A.zdelete  <> 'X' and A.subrep_type <> 'HSNB2B' and A.subrep_type <> 'HSNB2C'

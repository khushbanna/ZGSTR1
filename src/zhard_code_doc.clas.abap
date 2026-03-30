CLASS zhard_code_doc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun .
    CLASS-METHODS uploaddata .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZHARD_CODE_DOC IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main .
    me->uploaddata(  ) .
  ENDMETHOD.


  METHOD uploaddata .
    DATA : lttable TYPE TABLE OF zhard_code_ab.

    DATA action TYPE string .

      lttable = VALUE #(
      ( comcode = '3000' doc = '9400000010'  zyear = '2025' report = 'NILRAT' item = '000000' del = 'X'  )
      ( comcode = '3000' doc = '9400000022'  zyear = '2025' report = 'NILRAT' item = '000000' del = 'X'  )
      ( comcode = '3000' doc = '9400000023'  zyear = '2025' report = 'NILRAT' item = '000000' del = 'X'  )
      ( comcode = '3000' doc = '9400000030'  zyear = '2025' report = 'NILRAT' item = '000000' del = 'X'  )
      ( comcode = '3000' doc = '9400000031'  zyear = '2025' report = 'NILRAT' item = '000000' del = 'X'  )
      ( comcode = '3000' doc = '9400000033'  zyear = '2025' report = 'NILRAT' item = '000000' del = 'X'  )
      ( comcode = '3000' doc = '9400000041'  zyear = '2025' report = 'NILRAT' item = '000000' del = 'X'  )
      ( comcode = '3000' doc = '9400000013'  zyear = '2025' report = 'NILRAT' item = '000000' del = 'X'  )
      ).

    MODIFY zhard_code_ab FROM TABLE @lttable .
    COMMIT WORK AND WAIT .
endMETHOD.
ENDCLASS.

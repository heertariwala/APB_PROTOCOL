
vsim -assertdebug -novopt apb_top
add wave /apb_top/inf/IDLE_STATE /apb_top/inf/SETUP_STATE /apb_top/inf/ACCESS_STATE_WAIT /apb_top/inf/ACCESS_STATE_LAST /apb_top/inf/PR_GENERIC_STABLE /apb_top/inf/PWDATA_IN_TRANSFER /apb_top/inf/PENABLE_IN_TRANSFER /apb_top/inf/PSELX_IN_TRANSFER /apb_top/inf/PSLVERR_DEASSERT
run -all
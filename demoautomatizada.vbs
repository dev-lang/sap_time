If Not IsObject(application) Then
   Set SapGuiAuto  = GetObject("SAPGUI")
   Set application = SapGuiAuto.GetScriptingEngine
End If
If Not IsObject(connection) Then
   Set connection = application.Children(0)
End If
If Not IsObject(session) Then
   Set session    = connection.Children(0)
End If
If IsObject(WScript) Then
   WScript.ConnectObject session,     "on"
   WScript.ConnectObject application, "on"
End If
session.findById("wnd[0]").maximize
session.findById("wnd[0]/usr/txtRSYST-BNAME").text = "DDIC"
session.findById("wnd[0]/usr/pwdRSYST-BCODE").text = "minisap"
session.findById("wnd[0]/usr/pwdRSYST-BCODE").setFocus
session.findById("wnd[0]/usr/pwdRSYST-BCODE").caretPosition = 7
session.findById("wnd[0]").sendVKey 0
session.findById("wnd[0]/tbar[0]/okcd").text = "SU01"
session.findById("wnd[0]").sendVKey 0
session.findById("wnd[0]/usr/ctxtUSR02-BNAME").text = "KOSMENTI"
session.findById("wnd[0]/usr/ctxtUSR02-BNAME").caretPosition = 7
session.findById("wnd[0]").sendVKey 0
session.findById("wnd[0]/tbar[1]/btn[8]").press
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSZA5:0900/cmbSZA5_D0700-TITLE_MEDI").key = "Ms."
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSZA5:0900/txtADDR3_DATA-NAME_LAST").text = "OSMENTI"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSZA5:0900/txtADDR3_DATA-NAME_FIRST").text = "KEITH"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSZA5:0900/txtADDR3_DATA-FUNCTION").text = "OPERADOR DE TI"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSZA5:0900/txtADDR3_DATA-DEPARTMENT").text = ""
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSZA5:0900/txtADDR3_DATA-ROOMNUM_C").text = "C"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSZA5:0900/txtADDR3_DATA-FLOOR_C").text = "2"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSZA5:0900/txtADDR3_DATA-BUILDING_C").text = "ABA"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSZA5:0900/txtSZA5_D0700-TEL_NUMBER").text = "1144443333"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSZA5:0900/txtSZA5_D0700-TEL_EXTENS").text = "123"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSZA5:0900/txtSZA5_D0700-MOB_NUMBER").text = "1155556666"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSZA5:0900/txtSZA5_D0700-SMTP_ADDR").text = "kosment@vk.com"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSZA5:0900/txtSZA5_D0700-SMTP_ADDR").setFocus
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSZA5:0900/txtSZA5_D0700-SMTP_ADDR").caretPosition = 14
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssubMAINAREA:SAPLSUU5:0101/pwdG_PASSWORD1").text = "prueba"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssubMAINAREA:SAPLSUU5:0101/pwdG_PASSWORD2").text = "prueba"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssubMAINAREA:SAPLSUU5:0101/ctxtUSLOGOND-GLTGV").setFocus
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssubMAINAREA:SAPLSUU5:0101/ctxtUSLOGOND-GLTGV").caretPosition = 0
session.findById("wnd[0]").sendVKey 4
session.findById("wnd[1]/tbar[0]/btn[12]").press
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssubMAINAREA:SAPLSUU5:0101/txtUSDEFAULTS-KOSTL").text = "3000"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssubMAINAREA:SAPLSUU5:0101/txtUSDEFAULTS-KOSTL").setFocus
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssubMAINAREA:SAPLSUU5:0101/txtUSDEFAULTS-KOSTL").caretPosition = 4
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpSNC").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpDEFA").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPARAM").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpACTG").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpACTG/ssubMAINAREA:SAPLSUU5:0106/tblSAPLSUU5TC_AGR/ctxtUSAGR-AGR_NAME[1,0]").text = "operadordeti"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpACTG/ssubMAINAREA:SAPLSUU5:0106/tblSAPLSUU5TC_AGR/ctxtUSAGR-AGR_NAME[1,0]").caretPosition = 12
session.findById("wnd[0]").sendVKey 0
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpACTG/ssubMAINAREA:SAPLSUU5:0106/tblSAPLSUU5TC_AGR/ctxtUSAGR-AGR_NAME[1,1]").text = "SAP_ALL"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpACTG/ssubMAINAREA:SAPLSUU5:0106/tblSAPLSUU5TC_AGR/ctxtUSAGR-AGR_NAME[1,1]").setFocus
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpACTG/ssubMAINAREA:SAPLSUU5:0106/tblSAPLSUU5TC_AGR/ctxtUSAGR-AGR_NAME[1,1]").caretPosition = 7
session.findById("wnd[0]").sendVKey 0
session.findById("wnd[1]/tbar[0]/btn[0]").press
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssubMAINAREA:SAPLSUU5:0103/tblSAPLSUU5TC_PROFILES/ctxtUSPROF-PROFILE[0,1]").text = "SAP_ALL"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssubMAINAREA:SAPLSUU5:0103/tblSAPLSUU5TC_PROFILES/ctxtUSPROF-PROFILE[0,1]").setFocus
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssubMAINAREA:SAPLSUU5:0103/tblSAPLSUU5TC_PROFILES/ctxtUSPROF-PROFILE[0,1]").caretPosition = 7
session.findById("wnd[0]").sendVKey 0
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssubMAINAREA:SAPLSUU5:0103/tblSAPLSUU5TC_PROFILES/ctxtUSPROF-PROFILE[0,2]").text = "SAP_new"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssubMAINAREA:SAPLSUU5:0103/tblSAPLSUU5TC_PROFILES/ctxtUSPROF-PROFILE[0,2]").setFocus
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssubMAINAREA:SAPLSUU5:0103/tblSAPLSUU5TC_PROFILES/ctxtUSPROF-PROFILE[0,2]").caretPosition = 7
session.findById("wnd[0]").sendVKey 0
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpGRUP").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPERS").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLAW").select
session.findById("wnd[0]/tbar[0]/btn[11]").press
session.findById("wnd[0]/tbar[0]/btn[15]").press
session.findById("wnd[0]/tbar[0]/btn[15]").press
session.findById("wnd[1]/usr/btnSPOP-OPTION1").press

' Eliminar este comentario si falla script
' Adaptado para SAP 7.31

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
session.findById("wnd[0]/usr/txtRSYST-BNAME").text = "SAP*"
session.findById("wnd[0]/usr/pwdRSYST-BCODE").text = "1234567"
session.findById("wnd[0]/usr/pwdRSYST-BCODE").setFocus
session.findById("wnd[0]/usr/pwdRSYST-BCODE").caretPosition = 7
session.findById("wnd[0]").sendVKey 0
session.findById("wnd[0]/tbar[0]/okcd").text = "su01"
session.findById("wnd[0]").sendVKey 0
session.findById("wnd[0]/usr/ctxtSUID_ST_BNAME-BNAME").text = "RGA"
session.findById("wnd[0]/usr/ctxtSUID_ST_BNAME-BNAME").caretPosition = 10
session.findById("wnd[0]/tbar[1]/btn[8]").press
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSUID_MAINTENANCE:1900/cmbSUID_ST_NODE_PERSON_NAME_EXT-TITLE_MEDI").key = "0001"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSUID_MAINTENANCE:1900/txtSUID_ST_NODE_PERSON_NAME-NAME_LAST").text = "G"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSUID_MAINTENANCE:1900/txtSUID_ST_NODE_PERSON_NAME-NAME_FIRST").text = "R"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSUID_MAINTENANCE:1900/cmbSUID_ST_NODE_PERSON_NAME-LANGU").key = "IT"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSUID_MAINTENANCE:1900/txtSUID_ST_NODE_WORKPLACE-FUNCTION").text = "Operador de TI"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSUID_MAINTENANCE:1900/txtSUID_ST_NODE_WORKPLACE-DEPARTMENT").text = "ABA"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSUID_MAINTENANCE:1900/txtSUID_ST_NODE_WORKPLACE-ROOMNUMBER").text = "1"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSUID_MAINTENANCE:1900/txtSUID_ST_NODE_WORKPLACE-FLOOR").text = "3"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSUID_MAINTENANCE:1900/txtSUID_ST_NODE_COMM_DATA-TEL_NUMBER").text = "+5491144445555"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSUID_MAINTENANCE:1900/txtSUID_ST_NODE_COMM_DATA-TEL_EXTENS").text = "3555"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSUID_MAINTENANCE:1900/txtSUID_ST_NODE_COMM_DATA-MOB_NUMBER").text = "+5491155567788"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSUID_MAINTENANCE:1900/txtSUID_ST_NODE_COMM_DATA-SMTP_ADDR").text = "rga@vk.com"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssubMAINAREA:SAPLSUID_MAINTENANCE:1900/btnGS_ADDR_OTHERS-PUSH_NCMP").press
session.findById("wnd[1]/tbar[0]/btn[12]").press
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssubMAINAREA:SAPLSUID_MAINTENANCE:1101/pwdSUID_ST_NODE_PASSWORD_EXT-PASSWORD").text = "1234567"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssubMAINAREA:SAPLSUID_MAINTENANCE:1101/pwdSUID_ST_NODE_PASSWORD_EXT-PASSWORD2").text = "1234567"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssubMAINAREA:SAPLSUID_MAINTENANCE:1101/txtSUID_ST_NODE_LOGONDATA-KOSTL").text = "3000"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssubMAINAREA:SAPLSUID_MAINTENANCE:1101/txtSUID_ST_NODE_LOGONDATA-KOSTL").setFocus
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssubMAINAREA:SAPLSUID_MAINTENANCE:1101/txtSUID_ST_NODE_LOGONDATA-KOSTL").caretPosition = 4
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpSNC").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpDEFA").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPARAM").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpACTG").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpACTG/ssubMAINAREA:SAPLSUID_MAINTENANCE:1106/cntlG_ROLES_CONTAINER/shellcont/shell").modifyCell 0,"AGR_NAME","operadordeti"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpACTG/ssubMAINAREA:SAPLSUID_MAINTENANCE:1106/cntlG_ROLES_CONTAINER/shellcont/shell").currentCellColumn = "AGR_NAME"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpACTG/ssubMAINAREA:SAPLSUID_MAINTENANCE:1106/cntlG_ROLES_CONTAINER/shellcont/shell").pressEnter
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssubMAINAREA:SAPLSUID_MAINTENANCE:1103/cntlG_PROFILES_CONTAINER/shellcont/shell").modifyCell 1,"PROFILE","SAP_ALL"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssubMAINAREA:SAPLSUID_MAINTENANCE:1103/cntlG_PROFILES_CONTAINER/shellcont/shell").currentCellRow = 1
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssubMAINAREA:SAPLSUID_MAINTENANCE:1103/cntlG_PROFILES_CONTAINER/shellcont/shell").pressEnter
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssubMAINAREA:SAPLSUID_MAINTENANCE:1103/cntlG_PROFILES_CONTAINER/shellcont/shell").modifyCell 2,"PROFILE","SAP_NEW"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssubMAINAREA:SAPLSUID_MAINTENANCE:1103/cntlG_PROFILES_CONTAINER/shellcont/shell").currentCellRow = 2
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssubMAINAREA:SAPLSUID_MAINTENANCE:1103/cntlG_PROFILES_CONTAINER/shellcont/shell").pressEnter
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpGRUP").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPERS").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLAW").select
session.findById("wnd[0]/tbar[0]/btn[11]").press

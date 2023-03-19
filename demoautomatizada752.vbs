' Eliminar este comentario si falla script
' Adaptado para SAP 7.52 SP04

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
session.findById("wnd[0]/usr/txtRSYST-BNAME").text = "DEVELOPER"
session.findById("wnd[0]/usr/pwdRSYST-BCODE").text = "Down1oad"
session.findById("wnd[0]/usr/pwdRSYST-BCODE").setFocus
session.findById("wnd[0]/usr/pwdRSYST-BCODE").caretPosition = 8
session.findById("wnd[0]").sendVKey 0
session.findById("wnd[0]/tbar[0]/okcd").text = "SU01"
session.findById("wnd[0]").sendVKey 0
session.findById("wnd[0]/usr/ctxt[0]").text = "DEVLANG"
session.findById("wnd[0]/usr/ctxt[1]").setFocus
session.findById("wnd[0]/usr/ctxt[1]").caretPosition = 0
session.findById("wnd[0]/tbar[1]/btn[8]").press
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssub/1/2/cmb[0]").key = "0002"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssub/1/2/txt[0]").text = "Lang"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssub/1/2/txt[1]").text = "Dev"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssub/1/2/cmb[1]").key = "IT"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssub/1/2/txt[3]").text = "Operador de TI"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssub/1/2/txt[4]").text = "ABA"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssub/1/2/txt[5]").text = "1"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssub/1/2/txt[6]").text = "3"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssub/1/2/txt[8]").text = "44443333"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssub/1/2/txt[10]").text = "55556666"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssub/1/2/txt[13]").text = "dev-lang@github.com"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssub/1/2/cmb[2]").key = "INT"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpADDR/ssub/1/2/cmb[2]").setFocus
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssub/1/2/pwd[0]").text = "12345678"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssub/1/2/pwd[1]").text = "12345678"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssub/1/2/txt[4]").text = "3000"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssub/1/2/txt[4]").setFocus
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLOGO/ssub/1/2/txt[4]").caretPosition = 4
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpSNC").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpDEFA").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPARAM").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpACTG").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpACTG/ssub/1/2/cntlG_ROLES_CONTAINER/shellcont/shell").modifyCell 0,"AGR_NAME","OPERADORDETI"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpACTG/ssub/1/2/cntlG_ROLES_CONTAINER/shellcont/shell").currentCellColumn = "AGR_NAME"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpACTG/ssub/1/2/cntlG_ROLES_CONTAINER/shellcont/shell").pressEnter
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssub/1/2/cntlG_PROFILES_CONTAINER/shellcont/shell").modifyCell 1,"PROFILE","SAP_ALL"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssub/1/2/cntlG_PROFILES_CONTAINER/shellcont/shell").currentCellRow = 1
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssub/1/2/cntlG_PROFILES_CONTAINER/shellcont/shell").pressEnter
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssub/1/2/cntlG_PROFILES_CONTAINER/shellcont/shell").modifyCell 2,"PROFILE","SAP_NEW"
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssub/1/2/cntlG_PROFILES_CONTAINER/shellcont/shell").currentCellRow = 2
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPROF/ssub/1/2/cntlG_PROFILES_CONTAINER/shellcont/shell").pressEnter
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpGRUP").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpPERS").select
session.findById("wnd[0]/usr/tabsTABSTRIP1/tabpLAW").select
session.findById("wnd[0]/tbar[0]/btn[11]").press

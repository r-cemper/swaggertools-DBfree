Import User

Class ZX.dbdash Extends %CSP.Page [ Not ProcedureBlock ]
{

ClassMethod OnPreHTTP() As %Boolean [ ServerOnly = 1 ]
{
	do ##class(%ZX.dbfree).Load()
	set sc=##class(%DeepSee.Utils).%BuildCube("ZX.DBdata",,0)
	set sc=##class(%DeepSee.Utils).%BuildCube("ZX.DBlog",,0)
	Set %response.ServerSideRedirect="/csp/user/_DeepSee.UserPortal.DashboardViewer.zen?DASHBOARD=ZXfree.dashboard"
	quit $$$OK
}

ClassMethod OnPage() As %Status
{
	quit $$$OK
}

}

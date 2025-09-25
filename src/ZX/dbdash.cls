Import User
Class ZX.dbdash Extends %CSP.Page [ Not ProcedureBlock ]
{
ClassMethod OnPreHTTP() As %Boolean [ ServerOnly = 1 ]
{
	set SERVER=$lfs($get(%request.Data("SERVER",1)),":")
	if $ll(SERVER) do ..Remote(SERVER)
	else  do ##class(%ZX.dbfree).Load()
	set sc=##class(%DeepSee.Utils).%BuildCube("ZX.DBdata",,0)
	set sc=##class(%DeepSee.Utils).%BuildCube("ZX.DBlog",,0)
	Set %response.ServerSideRedirect="/csp/user/_DeepSee.UserPortal.DashboardViewer.zen?DASHBOARD=ZXfree.dashboard"
	quit $$$OK
}
ClassMethod OnPage() As %Status
{
	quit $$$OK
}
ClassMethod Remote(SERVER As %List)
{
	set ip=$lg(SERVER,1,"127.0.0.1")
	set port=$lg(SERVER,2,1972)
	set ns="%SYS"
	set user=$lg(SERVER,3,"_SYSTEM")
	set pw=$lg(SERVER,4,"SYS")
	
  try {
    set conn=##class(%Net.DB.DataSource).CreateConnection(ip
                           ,port
						   ,ns
						   ,user
						   ,pw)
    set iris=conn.CreateIris()
    }
  catch { zw  b  quit }  ;; do some error handling
 #; create a local copy before a complete replacement 
 	do iris.ClassMethodVoid("%ZX.dbfree","Load")  
	kill ^||ZX
	set ^||ZX=iris.Get("^mtemp.ZXD")
	set db=""
	For  {
		set ans=iris.GetNext(1,1,0,"^mtemp.ZXD",db)
		set db=$lg(ans,1)
		set val=$lg(ans,2)
		if db="" quit
		set ^||ZX(db)=val
		}
	do conn.Close()
	kill ^mtemp.ZXD
	merge ^mtemp.ZXD=^||ZX
	quit
}
}


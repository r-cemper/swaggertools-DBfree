tClass ZX.nacl Extends %CSP.Page
{

ClassMethod echo(xx) As %String
{
 quit "ECHO := "_xx
}

ClassMethod sql() As %String
{
	new $namespace
	zn "%SYS"
	&sql(
	    select  List(
		DatabaseName||'*'||SizeInt||'*'||AvailableNum||'*'||free)
		into %rcc 
		from %SYS.SYS.Database_FreeSpace()
	)
	kill ^%zrcc
	for j=1:1:4 { set r=""
		for i=1:1:$l(%rcc,",") set r=r_$s(i>1:" ",1:"")_$p($p(%rcc,",",i),"*",j)
		set ^%zrcc(j)=r
	}
	quit %rcc
}

ClassMethod upd()
{
	set jpg=$g(^%zrcc,"/ext/tab.jpg")
	set txt=$p(jpg,".")_".txt"
	set csp=$system.Util.ManagerDirectory()
	set sep=$s(csp["/":"/",1:"\")
	set $p(csp,sep,*-1)="csp"
	set csp=csp_$zcvt($namespace,"L")_sep
	do ##class(%File).CopyFile(jpg,csp)
	do ##class(%File).CopyFile(txt,csp)
	quit
}

/// generate the content of a csp page.
ClassMethod OnPage() As %Status [ ServerOnly = 1 ]
{
	do ..upd()
	&html<
<html>
<head>
<title>	Disk Free Viewer </title>
</head>

<body>
<table><tr><td>
<img src="tab.jpg?#($h)#">
</td><td>
<iframe src="tab.txt?#($h)#" frameborder="1" height=350 align='top'  width=400 ></iframe>
</td></tr></table>
</body>
</html>
	>
	Quit $$$OK
}

}



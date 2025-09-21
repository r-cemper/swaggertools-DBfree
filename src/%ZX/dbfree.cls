Class %ZX.dbfree Extends %Persistent [ Final, SqlRowIdPrivate ]
{

Parameter MANAGEDEXTENT As INTEGER [ Constraint = "0,1", Flags = ENUM ] = 0;

Parameter DEFAULTGLOBAL = "^mtemp.ZX";

Property DatabaseName As %String;

Property mbSize As %Integer;

Property logSize As %Decimal(SCALE = 2) [ Calculated, SqlComputeCode = {set {*}=$s({mbSize}<1:0,1:$ZLOG({mbSize}))}, SqlComputed ];

Property mbAvail As %Decimal(SCALE = 1);

Property logAvail As %Decimal(SCALE = 2) [ Calculated, SqlComputeCode = {set {*}=$s({mbAvail}<1:0,1:$ZLOG({mbAvail}))}, SqlComputed ];

Property FreePrz As %Decimal(SCALE = 2);

Property logFreePrz As %Decimal(SCALE = 2) [ Calculated, SqlComputeCode = {set {*}=$s({FreePrz}<1:0,1:$ZLOG({FreePrz}))}, SqlComputed ];

Method freePrzGet() As %Integer [ ServerOnly = 1 ]
{
	Quit +i%freePrz
}

Index idx On DatabaseName [ IdKey ];

ClassMethod Load()
{
	set ns=$ZCVT($namespace,"L")
	New $namespace
	zn "%SYS"
	do EnableDeepSee^%SYS.cspServer("/csp/"_ns_"/")
	do ..%KillExtent()
	&sql(
	INSERT or UPDATE Into %ZX.dbfree 
		(DatabaseName, mbSize, mbAvail,freePrz)
	select 
		DatabaseName, SizeInt, AvailableNum, free
	from %SYS.SYS.Database_FreeSpace()
	)
#; keep time + date	
	set ^mtemp.ZXD=$ZDT($h,3)
	quit
}

Storage Default
{
<Data name="dbfreeDefaultData">
<Value name="1">
<Value>mbSize</Value>
</Value>
<Value name="2">
<Value>mbAvail</Value>
</Value>
<Value name="3">
<Value>FreePrz</Value>
</Value>
</Data>
<DataLocation>^mtemp.ZXD</DataLocation>
<DefaultData>dbfreeDefaultData</DefaultData>
<IdLocation>^mtemp.ZXD</IdLocation>
<IndexLocation>^mtemp.ZXI</IndexLocation>
<StreamLocation>^mtemp.ZXS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}


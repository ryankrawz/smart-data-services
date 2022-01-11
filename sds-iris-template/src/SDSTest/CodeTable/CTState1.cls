Class SDSTest.CodeTable.CTState1 Extends (%Persistent, %Populate)
{

Property StateCode As %String;

Property StateName As %String(MAXLEN = "");

Index StateIdx On StateCode [ IdKey ];

Storage Default
{
<Data name="CTState1DefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>StateCode</Value>
</Value>
<Value name="3">
<Value>StateName</Value>
</Value>
</Data>
<DataLocation>^SDSTest.CodeTable.CTState1D</DataLocation>
<DefaultData>CTState1DefaultData</DefaultData>
<IdLocation>^SDSTest.CodeTable.CTState1D</IdLocation>
<IndexLocation>^SDSTest.CodeTable.CTState1I</IndexLocation>
<StreamLocation>^SDSTest.CodeTable.CTState1S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

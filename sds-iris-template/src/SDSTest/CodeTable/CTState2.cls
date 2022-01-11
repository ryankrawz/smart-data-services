Class SDSTest.CodeTable.CTState2 Extends (%Persistent, %Populate)
{

Property SCode As %String;

Property SDescription As %String(MAXLEN = "");

Index SCodeIndex On SCode [ IdKey ];

Storage Default
{
<Data name="CTState2DefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>SCode</Value>
</Value>
<Value name="3">
<Value>SDescription</Value>
</Value>
</Data>
<DataLocation>^SDSTest.CodeTable.CTState2D</DataLocation>
<DefaultData>CTState2DefaultData</DefaultData>
<IdLocation>^SDSTest.CodeTable.CTState2D</IdLocation>
<IndexLocation>^SDSTest.CodeTable.CTState2I</IndexLocation>
<StreamLocation>^SDSTest.CodeTable.CTState2S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

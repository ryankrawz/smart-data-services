Include %occInclude

Class IRISConfig.Installer Extends IRISConfig.InstallerBase
{
ClassMethod ImportSwaggerAPIDefinition() As %Status
{
    Set tSC = $System.Status.OK()

    Try
    {
        Set tNS = $Namespace
        ZN "USER" 
        Set file = "/swagger/swagger.json"
        Set obj = ##class(%DynamicAbstractObject).%FromJSON(file)
        
        Set tSC = ##class(%REST.API).CreateApplication("intersystems.sds.v1",.obj)
        Quit:$$$ISERR(tSC)

        set tSC = ##class(%SYS.REST).DeployApplication("intersystems.sds.v1", "/intersystems/sds/v1")
    }

    Catch (oException)
	{
		Set tSC = oException.AsStatus()
	}
    ZN tNS

    Quit tSC
}
/// You can customize this to run code during docker build
XData Install [ XMLNamespace = INSTALLER ]
{
<Manifest>
	
	<Namespace Name="${Namespace}" Create="no">
		<IfDef Var="SourceDir">
            <Log Text="SourceDir defined - offline install from ${SourceDir}" Level="0"/>
            <Import File="${SourceDir}" Recurse="true"/>
        </IfDef>

	</Namespace>
    <!-- <Log Text="Importing API Swagger Definitions" Level="0"/> -->
    <!-- <Invoke Class="IRISConfig.Installer" Method="ImportSwaggerAPIDefinition" CheckStatus="true">
    </Invoke> -->
		
</Manifest>
}

}

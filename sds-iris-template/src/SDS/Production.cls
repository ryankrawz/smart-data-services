Class SDS.Production Extends SDS.BaseProduction
{

ClassMethod OnStart(pTimeStarted As %String) As %Status
{
	s ^Ens.Debug("TraceCat")=1
  
  Quit ##super(pTimeStarted)
}

XData ProductionDefinition
{
<Production Name="SDS.Production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>1</ActorPoolSize>
  <Item Name="Service Notification Service" Category="" ClassName="SDS.ServiceNotification.BS.Notification.Service" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="sds-cp" Category="" ClassName="SDS.ServiceNotification.BO.Notification.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Create Task Process" Category="" ClassName="SDSTest.Workflow.BP.CreateTask.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Task Create" Category="" ClassName="SDS.Time.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ServicesToTrigger">Create Task Process</Setting>
    <Setting Target="Adapter" Name="CallInterval">10</Setting>
  </Item>
  <Item Name="Queue Collector Service" Category="" ClassName="SDS.MRDM.BS.QueueCollectorService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="CallInterval">30</Setting>
  </Item>
</Production>
}

}

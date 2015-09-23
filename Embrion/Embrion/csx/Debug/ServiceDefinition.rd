<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="Embrion" generation="1" functional="0" release="0" Id="f2a76e15-5fd5-431b-a8bd-e5a1914e3048" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="EmbrionGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput" protocol="tcp">
          <inToChannel>
            <lBChannelMoniker name="/Embrion/EmbrionGroup/LB:MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput" />
          </inToChannel>
        </inPort>
        <inPort name="Web Role:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/Embrion/EmbrionGroup/LB:Web Role:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="Certificate|InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapCertificate|InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
          </maps>
        </aCS>
        <aCS name="Certificate|JobCreation:Cami" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapCertificate|JobCreation:Cami" />
          </maps>
        </aCS>
        <aCS name="Certificate|JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapCertificate|JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
          </maps>
        </aCS>
        <aCS name="Certificate|MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapCertificate|MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
          </maps>
        </aCS>
        <aCS name="Certificate|Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapCertificate|Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
          </maps>
        </aCS>
        <aCS name="InterroleCommons:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapInterroleCommons:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapInterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" />
          </maps>
        </aCS>
        <aCS name="InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapInterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" />
          </maps>
        </aCS>
        <aCS name="InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapInterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" />
          </maps>
        </aCS>
        <aCS name="InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapInterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" />
          </maps>
        </aCS>
        <aCS name="InterroleCommonsInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapInterroleCommonsInstances" />
          </maps>
        </aCS>
        <aCS name="JobCreation:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapJobCreation:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapJobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" />
          </maps>
        </aCS>
        <aCS name="JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapJobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" />
          </maps>
        </aCS>
        <aCS name="JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapJobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" />
          </maps>
        </aCS>
        <aCS name="JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapJobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" />
          </maps>
        </aCS>
        <aCS name="JobCreation:StorageConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapJobCreation:StorageConnectionString" />
          </maps>
        </aCS>
        <aCS name="JobCreationInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapJobCreationInstances" />
          </maps>
        </aCS>
        <aCS name="MessageProcessing:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapMessageProcessing:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapMessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" />
          </maps>
        </aCS>
        <aCS name="MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapMessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" />
          </maps>
        </aCS>
        <aCS name="MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapMessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" />
          </maps>
        </aCS>
        <aCS name="MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapMessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" />
          </maps>
        </aCS>
        <aCS name="MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteForwarder.Enabled" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapMessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteForwarder.Enabled" />
          </maps>
        </aCS>
        <aCS name="MessageProcessing:StorageConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapMessageProcessing:StorageConnectionString" />
          </maps>
        </aCS>
        <aCS name="MessageProcessingInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapMessageProcessingInstances" />
          </maps>
        </aCS>
        <aCS name="Web Role:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapWeb Role:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapWeb Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" />
          </maps>
        </aCS>
        <aCS name="Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapWeb Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" />
          </maps>
        </aCS>
        <aCS name="Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapWeb Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" />
          </maps>
        </aCS>
        <aCS name="Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapWeb Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" />
          </maps>
        </aCS>
        <aCS name="Web Role:StorageConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapWeb Role:StorageConnectionString" />
          </maps>
        </aCS>
        <aCS name="Web RoleInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/Embrion/EmbrionGroup/MapWeb RoleInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput">
          <toPorts>
            <inPortMoniker name="/Embrion/EmbrionGroup/MessageProcessing/Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput" />
          </toPorts>
        </lBChannel>
        <lBChannel name="LB:Web Role:Endpoint1">
          <toPorts>
            <inPortMoniker name="/Embrion/EmbrionGroup/Web Role/Endpoint1" />
          </toPorts>
        </lBChannel>
        <sFSwitchChannel name="SW:InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp">
          <toPorts>
            <inPortMoniker name="/Embrion/EmbrionGroup/InterroleCommons/Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
          </toPorts>
        </sFSwitchChannel>
        <sFSwitchChannel name="SW:JobCreation:JobSubmissionServiceEndPoint">
          <toPorts>
            <inPortMoniker name="/Embrion/EmbrionGroup/JobCreation/JobSubmissionServiceEndPoint" />
          </toPorts>
        </sFSwitchChannel>
        <sFSwitchChannel name="SW:JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp">
          <toPorts>
            <inPortMoniker name="/Embrion/EmbrionGroup/JobCreation/Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
          </toPorts>
        </sFSwitchChannel>
        <sFSwitchChannel name="SW:MessageProcessing:ClientInputServiceEndPoint">
          <toPorts>
            <inPortMoniker name="/Embrion/EmbrionGroup/MessageProcessing/ClientInputServiceEndPoint" />
          </toPorts>
        </sFSwitchChannel>
        <sFSwitchChannel name="SW:MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp">
          <toPorts>
            <inPortMoniker name="/Embrion/EmbrionGroup/MessageProcessing/Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
          </toPorts>
        </sFSwitchChannel>
        <sFSwitchChannel name="SW:Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp">
          <toPorts>
            <inPortMoniker name="/Embrion/EmbrionGroup/Web Role/Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
          </toPorts>
        </sFSwitchChannel>
      </channels>
      <maps>
        <map name="MapCertificate|InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" kind="Identity">
          <certificate>
            <certificateMoniker name="/Embrion/EmbrionGroup/InterroleCommons/Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
          </certificate>
        </map>
        <map name="MapCertificate|JobCreation:Cami" kind="Identity">
          <certificate>
            <certificateMoniker name="/Embrion/EmbrionGroup/JobCreation/Cami" />
          </certificate>
        </map>
        <map name="MapCertificate|JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" kind="Identity">
          <certificate>
            <certificateMoniker name="/Embrion/EmbrionGroup/JobCreation/Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
          </certificate>
        </map>
        <map name="MapCertificate|MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" kind="Identity">
          <certificate>
            <certificateMoniker name="/Embrion/EmbrionGroup/MessageProcessing/Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
          </certificate>
        </map>
        <map name="MapCertificate|Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" kind="Identity">
          <certificate>
            <certificateMoniker name="/Embrion/EmbrionGroup/Web Role/Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
          </certificate>
        </map>
        <map name="MapInterroleCommons:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/InterroleCommons/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapInterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/InterroleCommons/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" />
          </setting>
        </map>
        <map name="MapInterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/InterroleCommons/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" />
          </setting>
        </map>
        <map name="MapInterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/InterroleCommons/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" />
          </setting>
        </map>
        <map name="MapInterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/InterroleCommons/Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" />
          </setting>
        </map>
        <map name="MapInterroleCommonsInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/Embrion/EmbrionGroup/InterroleCommonsInstances" />
          </setting>
        </map>
        <map name="MapJobCreation:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/JobCreation/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapJobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/JobCreation/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" />
          </setting>
        </map>
        <map name="MapJobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/JobCreation/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" />
          </setting>
        </map>
        <map name="MapJobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/JobCreation/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" />
          </setting>
        </map>
        <map name="MapJobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/JobCreation/Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" />
          </setting>
        </map>
        <map name="MapJobCreation:StorageConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/JobCreation/StorageConnectionString" />
          </setting>
        </map>
        <map name="MapJobCreationInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/Embrion/EmbrionGroup/JobCreationInstances" />
          </setting>
        </map>
        <map name="MapMessageProcessing:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/MessageProcessing/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapMessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/MessageProcessing/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" />
          </setting>
        </map>
        <map name="MapMessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/MessageProcessing/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" />
          </setting>
        </map>
        <map name="MapMessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/MessageProcessing/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" />
          </setting>
        </map>
        <map name="MapMessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/MessageProcessing/Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" />
          </setting>
        </map>
        <map name="MapMessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteForwarder.Enabled" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/MessageProcessing/Microsoft.WindowsAzure.Plugins.RemoteForwarder.Enabled" />
          </setting>
        </map>
        <map name="MapMessageProcessing:StorageConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/MessageProcessing/StorageConnectionString" />
          </setting>
        </map>
        <map name="MapMessageProcessingInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/Embrion/EmbrionGroup/MessageProcessingInstances" />
          </setting>
        </map>
        <map name="MapWeb Role:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/Web Role/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapWeb Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/Web Role/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" />
          </setting>
        </map>
        <map name="MapWeb Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/Web Role/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" />
          </setting>
        </map>
        <map name="MapWeb Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/Web Role/Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" />
          </setting>
        </map>
        <map name="MapWeb Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/Web Role/Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" />
          </setting>
        </map>
        <map name="MapWeb Role:StorageConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/Embrion/EmbrionGroup/Web Role/StorageConnectionString" />
          </setting>
        </map>
        <map name="MapWeb RoleInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/Embrion/EmbrionGroup/Web RoleInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="InterroleCommons" generation="1" functional="0" release="0" software="C:\Users\camila\Documents\Visual Studio 2012\Projects\Embrion\Embrion\csx\Debug\roles\InterroleCommons" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaWorkerHost.exe " memIndex="-1" hostingEnvironment="consoleroleadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp" portRanges="3389" />
              <outPort name="InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
              <outPort name="JobCreation:JobSubmissionServiceEndPoint" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:JobCreation:JobSubmissionServiceEndPoint" />
                </outToChannel>
              </outPort>
              <outPort name="JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
              <outPort name="MessageProcessing:ClientInputServiceEndPoint" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:MessageProcessing:ClientInputServiceEndPoint" />
                </outToChannel>
              </outPort>
              <outPort name="MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
              <outPort name="Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;InterroleCommons&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;InterroleCommons&quot;&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;JobCreation&quot;&gt;&lt;e name=&quot;JobSubmissionServiceEndPoint&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;MessageProcessing&quot;&gt;&lt;e name=&quot;ClientInputServiceEndPoint&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;Web Role&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
            <storedcertificates>
              <storedCertificate name="Stored0Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" certificateStore="My" certificateLocation="System">
                <certificate>
                  <certificateMoniker name="/Embrion/EmbrionGroup/InterroleCommons/Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
                </certificate>
              </storedCertificate>
            </storedcertificates>
            <certificates>
              <certificate name="Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
            </certificates>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/Embrion/EmbrionGroup/InterroleCommonsInstances" />
            <sCSPolicyUpdateDomainMoniker name="/Embrion/EmbrionGroup/InterroleCommonsUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/Embrion/EmbrionGroup/InterroleCommonsFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
        <groupHascomponents>
          <role name="JobCreation" generation="1" functional="0" release="0" software="C:\Users\camila\Documents\Visual Studio 2012\Projects\Embrion\Embrion\csx\Debug\roles\JobCreation" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaWorkerHost.exe " memIndex="-1" hostingEnvironment="consoleroleadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="JobSubmissionServiceEndPoint" protocol="tcp" />
              <inPort name="Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp" portRanges="3389" />
              <outPort name="InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
              <outPort name="JobCreation:JobSubmissionServiceEndPoint" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:JobCreation:JobSubmissionServiceEndPoint" />
                </outToChannel>
              </outPort>
              <outPort name="JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
              <outPort name="MessageProcessing:ClientInputServiceEndPoint" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:MessageProcessing:ClientInputServiceEndPoint" />
                </outToChannel>
              </outPort>
              <outPort name="MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
              <outPort name="Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" defaultValue="" />
              <aCS name="StorageConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;JobCreation&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;InterroleCommons&quot;&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;JobCreation&quot;&gt;&lt;e name=&quot;JobSubmissionServiceEndPoint&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;MessageProcessing&quot;&gt;&lt;e name=&quot;ClientInputServiceEndPoint&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;Web Role&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
            <storedcertificates>
              <storedCertificate name="Stored0Cami" certificateStore="My" certificateLocation="User">
                <certificate>
                  <certificateMoniker name="/Embrion/EmbrionGroup/JobCreation/Cami" />
                </certificate>
              </storedCertificate>
              <storedCertificate name="Stored1Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" certificateStore="My" certificateLocation="System">
                <certificate>
                  <certificateMoniker name="/Embrion/EmbrionGroup/JobCreation/Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
                </certificate>
              </storedCertificate>
            </storedcertificates>
            <certificates>
              <certificate name="Cami" />
              <certificate name="Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
            </certificates>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/Embrion/EmbrionGroup/JobCreationInstances" />
            <sCSPolicyUpdateDomainMoniker name="/Embrion/EmbrionGroup/JobCreationUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/Embrion/EmbrionGroup/JobCreationFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
        <groupHascomponents>
          <role name="MessageProcessing" generation="1" functional="0" release="0" software="C:\Users\camila\Documents\Visual Studio 2012\Projects\Embrion\Embrion\csx\Debug\roles\MessageProcessing" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaWorkerHost.exe " memIndex="-1" hostingEnvironment="consoleroleadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput" protocol="tcp" />
              <inPort name="ClientInputServiceEndPoint" protocol="tcp" />
              <inPort name="Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp" portRanges="3389" />
              <outPort name="InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
              <outPort name="JobCreation:JobSubmissionServiceEndPoint" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:JobCreation:JobSubmissionServiceEndPoint" />
                </outToChannel>
              </outPort>
              <outPort name="JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
              <outPort name="MessageProcessing:ClientInputServiceEndPoint" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:MessageProcessing:ClientInputServiceEndPoint" />
                </outToChannel>
              </outPort>
              <outPort name="MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
              <outPort name="Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteForwarder.Enabled" defaultValue="" />
              <aCS name="StorageConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;MessageProcessing&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;InterroleCommons&quot;&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;JobCreation&quot;&gt;&lt;e name=&quot;JobSubmissionServiceEndPoint&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;MessageProcessing&quot;&gt;&lt;e name=&quot;ClientInputServiceEndPoint&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;Web Role&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
            <storedcertificates>
              <storedCertificate name="Stored0Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" certificateStore="My" certificateLocation="System">
                <certificate>
                  <certificateMoniker name="/Embrion/EmbrionGroup/MessageProcessing/Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
                </certificate>
              </storedCertificate>
            </storedcertificates>
            <certificates>
              <certificate name="Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
            </certificates>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/Embrion/EmbrionGroup/MessageProcessingInstances" />
            <sCSPolicyUpdateDomainMoniker name="/Embrion/EmbrionGroup/MessageProcessingUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/Embrion/EmbrionGroup/MessageProcessingFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
        <groupHascomponents>
          <role name="Web Role" generation="1" functional="0" release="0" software="C:\Users\camila\Documents\Visual Studio 2012\Projects\Embrion\Embrion\csx\Debug\roles\Web Role" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="-1" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
              <inPort name="Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp" portRanges="3389" />
              <outPort name="InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:InterroleCommons:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
              <outPort name="JobCreation:JobSubmissionServiceEndPoint" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:JobCreation:JobSubmissionServiceEndPoint" />
                </outToChannel>
              </outPort>
              <outPort name="JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:JobCreation:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
              <outPort name="MessageProcessing:ClientInputServiceEndPoint" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:MessageProcessing:ClientInputServiceEndPoint" />
                </outToChannel>
              </outPort>
              <outPort name="MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
              <outPort name="Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" protocol="tcp">
                <outToChannel>
                  <sFSwitchChannelMoniker name="/Embrion/EmbrionGroup/SW:Web Role:Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp" />
                </outToChannel>
              </outPort>
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountEncryptedPassword" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountExpiration" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.AccountUsername" defaultValue="" />
              <aCS name="Microsoft.WindowsAzure.Plugins.RemoteAccess.Enabled" defaultValue="" />
              <aCS name="StorageConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;Web Role&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;InterroleCommons&quot;&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;JobCreation&quot;&gt;&lt;e name=&quot;JobSubmissionServiceEndPoint&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;MessageProcessing&quot;&gt;&lt;e name=&quot;ClientInputServiceEndPoint&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;Web Role&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;e name=&quot;Microsoft.WindowsAzure.Plugins.RemoteAccess.Rdp&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="Web Role.svclog" defaultAmount="[1000,1000,1000]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
            <storedcertificates>
              <storedCertificate name="Stored0Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" certificateStore="My" certificateLocation="System">
                <certificate>
                  <certificateMoniker name="/Embrion/EmbrionGroup/Web Role/Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
                </certificate>
              </storedCertificate>
            </storedcertificates>
            <certificates>
              <certificate name="Microsoft.WindowsAzure.Plugins.RemoteAccess.PasswordEncryption" />
            </certificates>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/Embrion/EmbrionGroup/Web RoleInstances" />
            <sCSPolicyUpdateDomainMoniker name="/Embrion/EmbrionGroup/Web RoleUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/Embrion/EmbrionGroup/Web RoleFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyUpdateDomain name="Web RoleUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyUpdateDomain name="MessageProcessingUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyUpdateDomain name="JobCreationUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyUpdateDomain name="InterroleCommonsUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="InterroleCommonsFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyFaultDomain name="JobCreationFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyFaultDomain name="MessageProcessingFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyFaultDomain name="Web RoleFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="InterroleCommonsInstances" defaultPolicy="[1,1,1]" />
        <sCSPolicyID name="JobCreationInstances" defaultPolicy="[1,1,1]" />
        <sCSPolicyID name="MessageProcessingInstances" defaultPolicy="[1,1,1]" />
        <sCSPolicyID name="Web RoleInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="68e53df7-2f79-4401-8cf5-ac0132827f65" ref="Microsoft.RedDog.Contract\ServiceContract\EmbrionContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="9c1dfee4-d72e-461a-932b-f02872c4075f" ref="Microsoft.RedDog.Contract\Interface\MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/Embrion/EmbrionGroup/MessageProcessing:Microsoft.WindowsAzure.Plugins.RemoteForwarder.RdpInput" />
          </inPort>
        </interfaceReference>
        <interfaceReference Id="bd954bf1-6098-450e-a9a0-67d71fc28b08" ref="Microsoft.RedDog.Contract\Interface\Web Role:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/Embrion/EmbrionGroup/Web Role:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>
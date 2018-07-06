<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Test</fullName>
        <description>Test</description>
        <protected>false</protected>
        <recipients>
            <recipient>s_a_n_k_a_r_a_n@yahoo.co.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/UpdateConnEmail</template>
    </alerts>
    <rules>
        <fullName>Opp Update Test</fullName>
        <actions>
            <name>Test</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

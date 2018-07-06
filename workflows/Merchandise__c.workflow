<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_Email_To_San</fullName>
        <description>Send Email To San</description>
        <protected>false</protected>
        <recipients>
            <recipient>s_a_n_k_a_r_a_n@yahoo.co.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/CommunityChangePasswordEmailTemplate</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Price</fullName>
        <field>Price__c</field>
        <formula>100</formula>
        <name>Update Price</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Change Quantity</fullName>
        <actions>
            <name>Update_Price</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>True</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Time Trigger Test</fullName>
        <actions>
            <name>Send_Email_To_San</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>Price__c &gt; 500</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>

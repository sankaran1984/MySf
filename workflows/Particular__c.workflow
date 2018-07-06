<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Copy_Unit_Price</fullName>
        <field>Unit_Price__c</field>
        <formula>Stock__r.Price__c</formula>
        <name>Copy_Unit_Price</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Revert_Unit_Price</fullName>
        <field>Unit_Price__c</field>
        <formula>Stock__r.Price__c</formula>
        <name>Revert_Unit_Price</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Stock_Quantity</fullName>
        <field>Quantity__c</field>
        <formula>IF( Quantity__c  &gt;  PRIORVALUE(Quantity__c) , 
     Stock__r.Quantity__c - ( Quantity__c -  PRIORVALUE(Quantity__c))  , 
     Stock__r.Quantity__c + (PRIORVALUE(Quantity__c) - Quantity__c)
   )</formula>
        <name>Update_Stock_Quantity</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Stock__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Copy_Unit_Price</fullName>
        <actions>
            <name>Copy_Unit_Price</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Particular__c.Quantity__c</field>
            <operation>greaterOrEqual</operation>
            <value>1</value>
        </criteriaItems>
        <description>Copy unit price from stock</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update_Stock_Quantity</fullName>
        <actions>
            <name>Update_Stock_Quantity</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order__c.Status__c</field>
            <operation>equals</operation>
            <value>Open</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>

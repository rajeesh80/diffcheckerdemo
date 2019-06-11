<aura:application extends="ltng:outApp" access="GLOBAL" >
	<aura:dependency resource="aura:if"/>
	<aura:dependency resource="aura:set"/>
	<aura:dependency resource="lightning:datatable"/>
	<aura:dependency resource="lightning:card"/>
	<aura:dependency resource="lightning:buttonIcon"/>
	<aura:dependency resource="lightning:icon"/>
	<aura:dependency resource="lightning:button"/>
	<aura:dependency resource="lightning:overlayLibrary"/>
	<aura:dependency resource="force:recordData"/>
	<aura:dependency resource="c:DataTableCmp"/>
	<aura:dependency resource="c:FooterCmp"/>
	<aura:dependency resource="c:HeaderCmp"/>
	<aura:dependency resource="c:ContactDetailsCmp"/>
    <aura:dependency resource="markup://force:showToast" type="EVENT"/>
</aura:application>
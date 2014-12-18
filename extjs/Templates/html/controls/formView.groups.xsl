<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:px="urn:panax"
    xmlns:str="http://exslt.org/strings"
	xmlns="http://www.w3.org/TR/xhtml1/strict"
	exclude-result-prefixes="px"
>
<xsl:template mode="formView" match="px:tabPanel">
<xsl:if test="position()&gt;1">,</xsl:if>{
	xtype:'panel'
	,frame:true
	,tabConfig: {
		title: '<xsl:value-of select="@name"/>'
	}
	,items:[<xsl:apply-templates select="*" mode="formView"/>]
}
</xsl:template>


</xsl:stylesheet>
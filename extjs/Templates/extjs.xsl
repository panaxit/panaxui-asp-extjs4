<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/TR/xhtml1/strict"
	>
<xsl:import href="attributeSets.xsl" />
<xsl:output method="text" omit-xml-declaration="yes"/> 
<xsl:include href="html/global_variables.xsl" />
<xsl:include href="stylesheets.xsl" />
<xsl:include href="html/list.controls.xsl" />
<xsl:include href="customStylesheets.xsl" />

<xsl:template name="none" match="*[@mode='none']"><!-- ancestor-or-self::*[@mode!='inherit'][1]/@mode='readonly' or  -->
	<xsl:value-of select="$nbsp"/>
</xsl:template>

<xsl:template name="pageManager" match="/">
<xsl:apply-templates select="*" />
</xsl:template>
</xsl:stylesheet>
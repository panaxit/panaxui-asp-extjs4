<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/TR/xhtml1/strict"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	>

<xsl:import href="html.xsl" />
<xsl:import href="attributeSets.xsl" />
<xsl:include href="../custom/templates/mapSite.xsl" /> 
<xsl:output method="html" omit-xml-declaration="yes"/> 

<xsl:template match="/">
	<xsl:apply-templates select="siteMap" />
</xsl:template>

<xsl:template match="/siteMap" priority="-1">
{ 
text: '.',
children: [<xsl:apply-templates select="siteMapNode[string(@showInMenu)!='false']" />]
}
</xsl:template>

<xsl:template match="siteMapNode[string(@showInMenu)='false']" priority="-1">
</xsl:template>

<xsl:template match="@*" mode="mapSite"><xsl:if test="position()&gt;1">,</xsl:if><xsl:value-of select="name(.)"/>:"<xsl:value-of select="."/>"</xsl:template>

<xsl:template match="siteMapNode[string(@showInMenu)!='false']" priority="-1">
	<xsl:variable name="rootPath" select="/*/@rootPath"/>
	<xsl:if test="position()&gt;1">,</xsl:if>{
		text: "<xsl:value-of select="normalize-space(@title)"/>",
		<xsl:apply-templates select="@catalogName|@mode|@url|@pageSize" mode="mapSite"></xsl:apply-templates>
		<xsl:choose>
			<xsl:when test="siteMapNode[string(@showInMenu)!='false']">children: [<xsl:apply-templates select="siteMapNode[string(@showInMenu)!='false']" />]</xsl:when>
			<xsl:otherwise>,leaf: true, lang: '<xsl:value-of select="ancestor-or-self::*[@xml:lang][1]/@xml:lang"/>'</xsl:otherwise>
		</xsl:choose>
	}
<!-- 	<xsl:element name="LI">
	<xsl:attribute name="style">cursor:hand;</xsl:attribute>
	<xsl:attribute name="onclick"><xsl:if test="script">with (window.parent) {<xsl:value-of select="script"/>}</xsl:if> <xsl:if test="@target">top.frames('<xsl:value-of select="@target"/>').</xsl:if>location.href="<xsl:choose>
	<xsl:when test="@url"><xsl:value-of select="@url"/><xsl:if test="not(contains(@url, '?'))">?</xsl:if></xsl:when><xsl:when test="not(@catalogName)">Menus.asp?Path=<xsl:value-of select="$rootPath"/><xsl:for-each select="ancestor-or-self::*[not(position()=last() and string($rootPath)!='')]">/<xsl:value-of select="name(.)"/><xsl:if test="@title">[@title='<xsl:value-of select="@title"/>']</xsl:if></xsl:for-each></xsl:when>	
	<xsl:otherwise>../Templates/request.asp?catalogName=<xsl:value-of select="@catalogName"/><xsl:for-each select="@mode|@filters|@pageSize">&amp;<xsl:value-of select="name(.)"/>=<xsl:value-of select="."/></xsl:for-each>
</xsl:otherwise>
</xsl:choose><xsl:for-each select="parameters/parameter">&amp;<xsl:value-of select="@name"/>=<xsl:value-of select="."/></xsl:for-each>"</xsl:attribute>
	<a href="#"><span><xsl:value-of select="normalize-space(@title)"/></span></a>
	</xsl:element> -->
</xsl:template>

<xsl:template match="//siteMapNode[@rootPath]" priority="-1">
	<ul id="crumbs">
		<xsl:for-each select="ancestor::*"><li><a class="subTitle"><xsl:attribute name="href">Menus.asp?Path=<xsl:for-each select="ancestor-or-self::*">/<xsl:value-of select="name(.)"/><xsl:if test="@title">[@title='<xsl:value-of select="normalize-space(@title)"/>']</xsl:if></xsl:for-each>
</xsl:attribute><xsl:value-of select="@title"/></a></li></xsl:for-each>
		<li><label class="subTitle"><xsl:value-of select="@title"/></label></li>
	</ul><br/>
	<label class="title">MENUS:</label><xsl:value-of select="$nbsp"/><br/>
	<xsl:apply-templates select="*" />
</xsl:template>


</xsl:stylesheet>

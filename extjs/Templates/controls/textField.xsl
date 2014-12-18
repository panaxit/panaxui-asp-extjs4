<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/TR/xhtml1/strict"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt">

	<xsl:template name="textBox" match="*[@controlType='textBox' or @controlType='default' and ((
		@dataType='nchar' or @dataType='char'
		or @dataType='int' or @dataType='tinyint'
		or (@dataType='float' or @dataType='decimal') and not(@format) or @dataType='real'
		) or not((
		@dataType='nvarchar' or @dataType='varchar' or @dataType='text') and @length&gt;=256))]">
		<xsl:param name="name" select="name(.)"/>
		<xsl:param name="id" select="concat('input_', name(.), '_', generate-id(.))"/>
		<xsl:param name="mode" select="'readonly'"/>
		<xsl:param name="cssClass" select="@cssClass"/>
		<xsl:param name="required"/>
		<xsl:param name="text" select="string(@text)"/>
		<xsl:param name="value" select="string(@value)"/>
		<xsl:param name="maxlength" select="@length"/>

		<xsl:param name="size" select="@length" />
		<xsl:param name="format"><xsl:choose>
			<xsl:when test="@format"><xsl:value-of select="@format"/></xsl:when>	
			<xsl:when test="@dataType='int' or @dataType='tinyint' or @dataType='float' and not(@format) or @dataType='real'">numero</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose></xsl:param>
		<!-- COMMON PROPERTIES -->
		<xsl:variable name="control.attributeSet"><xsl:copy><xsl:apply-templates select="." mode="control.attributeSet" /></xsl:copy></xsl:variable>
		<!-- <xsl:param name="onchange"/> -->
		xtype: 'textfield'
		, name: '<xsl:value-of select="$name"/>'
		, value: null
		, defaultValue: '<xsl:value-of select="@text"/>'
		, enforceMaxLength: true
		
		<xsl:choose>
			<!-- READONLY -->
			<xsl:when test="$mode='readonly'">
				, readOnly: true
			</xsl:when>
			<!-- EDITABLE -->
			<xsl:otherwise>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>

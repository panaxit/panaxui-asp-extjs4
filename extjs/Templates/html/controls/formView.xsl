<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:px="urn:panax"
    xmlns:str="http://exslt.org/strings"
	xmlns="http://www.w3.org/TR/xhtml1/strict"
	exclude-result-prefixes="px"
>
<xsl:import href="formView.groups.xsl"/>
<xsl:strip-space elements="*"/>

<!-- <xsl:template match="*[@dataType='table']" mode="formView.groupTabPanel.Container">
/*groupTabPanel: <xsl:value-of select="px:fields/*[@groupTabPanel]/@groupTabPanel"/>*/
	<xsl:choose><xsl:when test="px:fields[*/@fieldSet]">
	<xsl:apply-templates select="px:fields/*[@groupTabPanel][count(. | key('groupTabPanel', @groupTabPanel)[1]) = 1]" mode="formView.groupTabPanel"/>
	</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="px:fields/*[@dataType!='identity']" mode="fieldContainer"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template> -->


<!-- <xsl:template match="px:data/px:dataRow" mode="formView.table.form.Template">

</xsl:template> -->


<!-- 
<xsl:template match="*[@dataType='table']/px:data/px:dataRow/*" mode="fieldSetGroup.Template">
<xsl:param name="contiguousFields"/>
	<tr>
		<td><fieldset><legend><xsl:value-of select="$nbsp"/><xsl:apply-templates select="@fieldSet" mode="fieldSetGroup.legend.text" /></legend>
		<table>
			<tbody>
			 <xsl:apply-templates select=".|following-sibling::*[key('visibleFields',@fieldId)][position()&lt;count(msxsl:node-set($contiguousFields)/*)]" mode="formView.table.dataRow.Fields" />
			</tbody>
		</table>
	</fieldset></td>
	</tr>
</xsl:template> -->

<xsl:attribute-set name="table.dataRow">
	<xsl:attribute name="class">
	  dataRow <xsl:choose>
	    <xsl:when test="position() mod 2 = 1"> alt</xsl:when>
	    <xsl:otherwise></xsl:otherwise>
	  </xsl:choose>
	</xsl:attribute>
</xsl:attribute-set>

<xsl:template name="formView.fieldSet.fieldHeaderRow">
	<xsl:param name="context" select="*"/>
	<tr><xsl:apply-templates select="." mode="formView.rowNumber"><xsl:with-param name="rowType">headerRow</xsl:with-param></xsl:apply-templates><xsl:apply-templates select="$context" mode="formView.fieldSet.fieldHeaderRow.header"/></tr>
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.fieldSet.fieldHeaderRow.header"><!-- Header (<xsl:value-of select="position()"/> vs <xsl:value-of select="count(preceding-sibling::*[@mode!='hidden' and not(@controlType='tab') and not(@Column_Name=ancestor-or-self::*[@dataType='foreignTable'][1]/@foreignReference)])"/>):  -->
	<th style="border:1pt white solid;"><xsl:apply-templates select="." mode="formView.fieldSet.field.header.Wrapper"/></th>
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.fieldSet.field.header.Wrapper">
<xsl:apply-templates select="." mode="headerText"/>
</xsl:template>

<!-- Header - -->

<!-- Footer -->


<xsl:template match="*" mode="formView.hiddenFields">
	<xsl:param name="rowType" />
	<th class="hiddenFields" style="display:'none';"><xsl:if test="$rowType='dataRow'"><xsl:for-each select="*[@mode='hidden']"><xsl:apply-templates select="." mode="dataField" /></xsl:for-each></xsl:if></th>
</xsl:template>

<xsl:template match="*" mode="formView.rowNumber.Template">
<xsl:param name="rowType" />
	<th class="rowNumberCell" nowrap="nowrap"><xsl:apply-templates select="." mode="formView.rowNumber.Wrapper"><xsl:with-param name="rowType" select="$rowType"/></xsl:apply-templates></th>
</xsl:template>

<xsl:template match="*" mode="formView.rowNumber.text.Template">
<xsl:param name="rowType" />
	<xsl:choose>
		<xsl:when test="$rowType='headerRow'">#</xsl:when>
		<xsl:when test="$rowType='dataRow'"># <span class="rowNumber"><xsl:value-of select="@rowNumber" /></span></xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="px:data/px:dataRow" mode="formView.table.tableGroup.Header.Template">
	<xsl:param name="tableGroup"/>
	<tr class="tableGroupHeader"><xsl:apply-templates select="." mode="formView.table.tableGroup.Header.Wrapper"><xsl:with-param name="tableGroup" select="$tableGroup"/></xsl:apply-templates></tr>
</xsl:template>

<xsl:template match="*[@dataType='table'][@controlType='gridView']/px:data/px:dataRow/*" mode="formView.table.tableGroup.Header.fields.Template">
	<xsl:param name="tableGroup"/>
	<th colspan="{count(following-sibling::*)}"><xsl:apply-templates select="."  mode="formView.table.tableGroup.Header.fields.Wrapper"><xsl:with-param name="tableGroup" select="$tableGroup"/></xsl:apply-templates></th>
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.table.tableGroup.Header.commands.Template">
	<xsl:param name="tableGroup"/>
	<th><xsl:value-of select="$nbsp"/></th>
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.table.tableGroup.Header.rowNumber.Template">
	<xsl:param name="tableGroup"/>
	<th><xsl:value-of select="$nbsp"/></th>
</xsl:template>

<xsl:template match="px:data/px:dataRow" mode="formView.table.footer.commandButtons.Template">
	<th class="CommandButtons"><xsl:value-of select="$nbsp"/></th>
</xsl:template>

<xsl:template match="px:data/px:dataRow|fields" mode="formView.table.header.commandButtons.Template">
<xsl:param name="disableInsert"/>
<th class="CommandButtons"><!-- <b style="color:black">@disableInsert: <xsl:value-of select="@disableInsert"/></b> -->
	<xsl:value-of select="$nbsp"/><xsl:if test="number($disableInsert)=0"><xsl:apply-templates select="." mode="insertButton" /></xsl:if>
</th>
</xsl:template>

<xsl:template match="px:data/px:dataRow" mode="formView.table.body.commandButtons.Template">
<xsl:param name="disableDetails"/>
<xsl:param name="disableDelete"/>
	<th class="CommandButtons">
		<xsl:if test="$disableDetails=0"><xsl:apply-templates select="." mode="editButton" /></xsl:if><xsl:value-of select="$nbsp"/><xsl:if test="$disableDelete=0"><xsl:apply-templates select="." mode="deleteButton" /></xsl:if>
	</th>
</xsl:template>


<!-- <xsl:template match="*[@dataType='table'][@controlType='gridView']" mode="formView.table.thead.header.Template">
	<tr class="tableHeader"><xsl:apply-templates select="*" mode="formView.table.thead.header.fields" /></tr>
</xsl:template> -->
 
<!-- <xsl:template match="*[@dataType='table'][@controlType='gridView']/px:data/px:dataRow/*" mode="formView.table.tableGroup.Header.Content.Template">
	<xsl:param name="tableGroup"/>
	<th colspan="{count(following-sibling::*)}"><xsl:choose>
	<xsl:when test="../@headerText"><xsl:value-of select="../@headerText"/></xsl:when>	
	<xsl:when test="$tableGroup/*/@groupByColumn"><xsl:value-of select="$tableGroup/*[@groupByColumn='true']/@text"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="$nbsp"/></xsl:otherwise></xsl:choose></th>
</xsl:template> -->

<!-- <xsl:template match="*[@dataType='table'][@controlType='gridView']/px:data/px:dataRow/*" mode="formView.table.thead.header.fields.Template">
<th colspan="{count(.|following-sibling::*)}"><xsl:apply-templates select="." mode="formView.table.thead.header.fields.Wrapper"/></th>
</xsl:template> -->


<xsl:template match="px:data/px:dataRow" mode="formView.table.tableGroup.Footer.Default">
	<xsl:param name="tableGroup"/>
	<tr class="tableGroupFooter"><xsl:apply-templates select="." mode="formView.rowNumber"><xsl:with-param name="rowType">footerRow</xsl:with-param></xsl:apply-templates>
	<xsl:apply-templates select="*[1]" mode="formView.table.tableGroup.Footer.Wrapper"><xsl:with-param name="tableGroup" select="$tableGroup"/></xsl:apply-templates></tr>
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.table.tableGroup.Footer.Content.Default">
	<xsl:param name="tableGroup"/>
	<th colspan="{count(following-sibling::*)}"><xsl:choose>
	<xsl:when test="../@footerText"><xsl:value-of select="../@footerText"/></xsl:when>	
	<xsl:when test="$tableGroup/*/@groupByColumn"><xsl:value-of select="$tableGroup/*[@groupByColumn='true']/@text"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="$nbsp"/></xsl:otherwise>
</xsl:choose></th>
</xsl:template>

	
</xsl:stylesheet>
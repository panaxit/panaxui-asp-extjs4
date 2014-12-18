<?xml version="1.0" encoding="utf-8"?>
<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:func="http://exslt.org/functions" xmlns:math="http://exslt.org/math" version="1.0" extension-element-prefixes="math" math:doc="http://www.exslt.org/math">
	<xsl:import href="math.power.template.xsl"/>
	<xsl:import href="math.power.msxsl.xsl"/><!-- <func:script language="exslt:msxsl" implements-prefix="math" src="math.power.msxsl.xsl"/> -->
	<func:script language="exslt:javascript" implements-prefix="math" src="math.power.js"/>
	<func:script language="exslt:exsl" implements-prefix="math" src="math.power.function.xsl"/>
</stylesheet>
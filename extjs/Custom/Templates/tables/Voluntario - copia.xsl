<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:px="urn:panax">

<xsl:template match="Voluntario/px:fields/Telefono|Voluntario/px:fields/TelefonoCasa|Voluntario/px:fields/TelefonoOficina|Voluntario/px:fields/TelefonoPadre|Voluntario/px:fields/TelefonoMadre|Voluntario/px:fields/TelefonoCasaContactoEmergencia|Voluntario/px:fields/OtroTelefonoContactoEmergencia|Voluntario/px:fields/Celular|Voluntario/px:fields/CelularPadre|Voluntario/px:fields/CelularMadre|Voluntario/px:fields/CP|Voluntario/px:fields/CelularContactoEmergencia" mode="field.config">
hideTrigger:true, emptyText:''
</xsl:template>

<xsl:template match="Voluntario/px:fields/*[@fieldContainer='Teléfono de Casa' or @fieldContainer='Teléfono de Oficina']" mode="field.config">
emptyText:"<xsl:apply-templates select="." mode="headerText"/>"
</xsl:template>

<xsl:template match="Voluntario/px:fields/Personalidad|Voluntario/px:fields/ActividadesFavoritas" mode="field.config">
maxSelections: 4
</xsl:template>

<xsl:template match="Voluntario//px:fieldContainer[@name='Email' or @name='Facebook' or @name='Twitter']" mode="container.items.defaultConfig">
hideLabel: true
</xsl:template>

<xsl:template mode="dataField" match="
Voluntario/px:fields/Dominio |
Voluntario/px:fields/DominioOtroCorreo |
Voluntario/px:fields/Twitter"><xsl:if test="position()&gt;1">,</xsl:if>
{xtype:"displayfield", value:"@"},<xsl:call-template name="dataField"/>
</xsl:template>

<xsl:template mode="control.config.insertEnabled" match="
Voluntario/px:fields/Dominio/*|Voluntario/px:fields/Religion/*">true</xsl:template>

<xsl:template match="Voluntario/px:fields/*/@fieldContainer[.='TieneOtroCorreo']" mode="container.items.defaultConfig">
hideLabel: true, layout: 'hbox'
</xsl:template>

<xsl:template match="
Voluntario/px:fields/Facebook" mode="dataField"><xsl:if test="position()&gt;1">,</xsl:if>
{xtype:"displayfield", value:"www.facebook.com/"},<xsl:call-template name="dataField"/>
</xsl:template>
<!-- 
<xsl:template mode="dataField" match="Voluntario/px:fields/NoTengoFacebook">
{xtype:'facebook', user:'_unidos_', lang:'es'},<xsl:call-template name="dataField"/>
</xsl:template> -->

<xsl:template match="Voluntario/px:fields/Twitter" mode="container.config">layout: 'vbox', hideLabel:false
</xsl:template>

<xsl:template match="Voluntario/px:fields/Twitter" mode="dataField"><xsl:if test="position()&gt;1">,</xsl:if>
{
xtype: "fieldcontainer", layout: "hbox", defaults:{hideLabel:true}, items:[
{xtype:"displayfield", value:"@"},<xsl:call-template name="dataField"/>,<xsl:apply-templates mode="dataField" select="../NoTengoTwitter"/>]
},{xtype:'twitter', user:'_unidos_', lang:'es'}
</xsl:template>

<xsl:template match="Voluntario/px:fields/CorreoElectronico" mode="field.config">width: 200</xsl:template>

<!-- <xsl:template match="Voluntario/px:fields/FechaNacimiento" mode="field.config">xtype:'iphonedatepicker',settings: {dayField: {name:'dayField'},monthField: {name:'monthField'},yearField: {name:'yearField'}}</xsl:template> -->

<xsl:template match="Voluntario/px:fields/MesNacimiento" mode="field.config">
maxLength: undefined
</xsl:template>

<xsl:template match="Voluntario/px:fields/LadaCasa|Voluntario/px:fields/LadaOficina" mode="field.config">
width: 40
</xsl:template>

<xsl:template match="Voluntario/px:fields/DiaNacimiento" mode="field.config">
minValue: 1,
maxValue: 31
</xsl:template>

<xsl:template mode="field.config" match="Voluntario/px:fields/AnioNacimiento">
minValue: 1900,
maxValue: new Date().getFullYear()
</xsl:template>			

<xsl:template mode="field.config" match="Voluntario/px:fields/AnioIntegracion">
endYear: 1987
</xsl:template>			
		<!-- 	
<xsl:template match="Voluntario/px:fields/MedicamentoPeriodico" mode="fieldContainer">
<xsl:call-template name="fieldContainer.checkBoxToggle"/>
</xsl:template> -->

<xsl:template mode="field.config" match="Voluntario/px:fields/AnioNacimiento">
endYear: 1920
, startYear: new Date().getFullYear()
, forceSelection: false
, width: 80
</xsl:template>	

<xsl:template match="Voluntario/px:fields/*/@fieldContainer[.='OtroContacto']" mode="container.config">
layout: 'vbox', hideEmptyLabel: false, fieldLabel: '', id: 'OtroContacto', hidden: true
</xsl:template>
<!-- 
<xsl:template match="Voluntario/px:fields/*/@fieldContainer[.='OtroContacto']" mode="container.items.defaultConfig">
hideLabel: false, labelAlign: 'left'
</xsl:template> -->

<xsl:template match="Voluntario/px:fields/*/@fieldContainer[.='Teléfono de Casa' or .='Teléfono de Oficina' or .='Celular']" mode="container.items.defaultConfig">
hideLabel: true
</xsl:template>


<xsl:template match="Voluntario/px:layout//px:fieldContainer[@name='FechaNacimiento']" mode="headerText">Fecha de Nacimiento</xsl:template>

<xsl:template match="Voluntario/px:layout//px:fieldContainer[@name='MedicamentoPeriodico']" mode="headerText">¿Tomas algún medicamento periódicamente?</xsl:template>

<xsl:template match="Voluntario/px:fields/MedicamentoPeriodico" mode="headerText">¿Cuál?</xsl:template>

<xsl:template match="Voluntario/px:fields/*/@fieldContainer[.='ServicioSocial']" mode="headerText"><xsl:apply-templates select=".." mode="headerText"/></xsl:template>

<xsl:template match="Voluntario/px:fields/Sexo" mode="field.config">columns: 3, width: 400</xsl:template>

<xsl:template match="Voluntario/px:fields/*[name(.)='ServicioSocial']" mode="field.config">insertEnabled:true</xsl:template>

<xsl:template match="Voluntario/px:fields/*[name(.)='EstadoCivilPadres' or name(.)='Religion' or name(.)='ContactoDeEmergencia' or name(.)='TipoSangre' or name(.)='MedioCaptacion']" mode="field.config">insertEnabled:false</xsl:template>

<xsl:template match="Voluntario/px:fields/*[name(.)='AnioIntegracion']/*" mode="control.config">sortDirection: "DESC"</xsl:template>

<xsl:template match="Voluntario/px:fields/Calle" mode="field.config">height: 27</xsl:template>

<xsl:template match="Voluntario/px:fields/Sexo/px:data/*[@value='-Vacio-']" mode="checkboxGroup.option">/*opción "<xsl:value-of select="@value"/>" fue quitada*/</xsl:template>

<xsl:template match="
Voluntario/px:fields/ServicioSocial/*|Voluntario/px:fields/MedioCaptacion/*|Voluntario/px:fields/Religion/*
" mode="control.onchange">function(combo, records, eOptions) { 
	var oNextChild = Ext.ComponentQuery.query("#<xsl:apply-templates select="../following-sibling::*[1]" mode="field_id"/>")[0]
	if ((combo.value || {text:''}).text.toUpperCase()=='OTRO')
		oNextChild.show(true); 
	else
		oNextChild.hide(true); 
	return true;
	}
</xsl:template>

<xsl:template match="
Voluntario/px:fields/OtroServicioSocial|Voluntario/px:fields/OtroMedioCaptacion|Voluntario/px:fields/OtraReligion" mode="field.config">
hidden: true
</xsl:template>

<xsl:template match="Voluntario/px:fields/ContactoDeEmergencia/*" mode="control.onchange">function(combo, records, eOptions) { 
<xsl:text disable-output-escaping="yes"><![CDATA[ 	if (combo.value && combo.value.id=='3') //Otro ]]></xsl:text>/*<xsl:value-of select="name(../following-sibling::*[1])"/>*/
		Ext.ComponentQuery.query("#<xsl:apply-templates select="../following-sibling::*[1]" mode="container_id"/>")[0].show(true); 
	else
		Ext.ComponentQuery.query("#<xsl:apply-templates select="../following-sibling::*[1]" mode="container_id"/>")[0].hide(true); 
	return true;
	}
</xsl:template>

<xsl:template mode="field.config" match="
Voluntario/px:fields/NoTengoTelefono |
Voluntario/px:fields/NoTengoCelular |
Voluntario/px:fields/NoTengoFacebook |
Voluntario/px:fields/NoTengoTwitter |
Voluntario/px:fields/NoTengoAlergias">
boxLabel: '<xsl:apply-templates select="." mode="headerText"/>'
</xsl:template>

<xsl:template mode="onChange" match="Voluntario/px:fields/NoTengoTelefono">function(newValue, oldValue) { 
	var txtLada = Ext.ComponentQuery.query("#<xsl:apply-templates select="../LadaCasa" mode="field_id"/>")[0];
	txtLada.setDisabled(newValue);
	var txtTelefono = Ext.ComponentQuery.query("#<xsl:apply-templates select="../TelefonoCasa" mode="field_id"/>")[0];
	txtTelefono.setDisabled(newValue);
}
</xsl:template>
<xsl:template mode="onChange" match="Voluntario/px:fields/NoTengoCelular">function(newValue, oldValue) { 
	var txtBox = Ext.ComponentQuery.query("#<xsl:apply-templates select="../Celular" mode="field_id"/>")[0];
	txtBox.setDisabled(newValue);
}
</xsl:template>
<xsl:template mode="onChange" match="Voluntario/px:fields/NoTengoFacebook">function(newValue, oldValue) { 
	var txtBox = Ext.ComponentQuery.query("#<xsl:apply-templates select="../Facebook" mode="field_id"/>")[0];
	txtBox.setDisabled(newValue);
}
</xsl:template>
<xsl:template mode="onChange" match="Voluntario/px:fields/NoTengoTwitter">function(newValue, oldValue) { 
	var txtBox = Ext.ComponentQuery.query("#<xsl:apply-templates select="../Twitter" mode="field_id"/>")[0];
	txtBox.setDisabled(newValue);
}
</xsl:template>
<xsl:template mode="onChange" match="Voluntario/px:fields/NoTengoAlergias">function(newValue, oldValue) { 
	var txtBox = Ext.ComponentQuery.query("#<xsl:apply-templates select="../Alergias" mode="field_id"/>")[0];
	txtBox.setDisabled(newValue);
}
</xsl:template>

<xsl:template mode="dockedItems" match="Voluntario/px:fields/HermanosVoluntario">
</xsl:template>

<xsl:template mode="control.onchange" match="Voluntario/px:fields/NumeroDeHermanos">function(control, newValue, oldValue, eOptions) { 
var grid = Ext.ComponentQuery.query("#HermanosVoluntario");
if (Ext.isArray(grid)) grid=grid[0];
<xsl:text disable-output-escaping="yes"><![CDATA[ 
	for (var i=grid.store.data.length; i<(newValue||0); ++i) {
		grid.onAddClick()
		}
	for (var i=grid.store.data.length; i>(newValue||0); --i) {
		grid.store.removeAt(i-1);
	}]]></xsl:text>
	
}
</xsl:template>


<xsl:template mode="field.config" match="Voluntario/px:fields/PoblacionResidencia">
hideLabel:true
</xsl:template>

<xsl:template mode="field.items.defaultConfig" match="Voluntario/px:fields/PoblacionResidencia">
hideLabel:false
</xsl:template>

<xsl:template mode="dataField" match="Voluntario/px:fields/EstadoResidencia">
<xsl:call-template name="dataField"/>,
<xsl:apply-templates select="../MunicipioResidencia" mode="dataField"/>,
<xsl:apply-templates select="../OtraPoblacionResidencia" mode="dataField"/>
</xsl:template>


<xsl:template mode="container.config" match="Voluntario/px:fields/PoblacionResidencia">
hideLabel: true, layout: 'vbox', defaults: { hideLabel: false, anchor: 'none', flex: 0}
</xsl:template>

<xsl:template mode="container.config" match="Voluntario/px:fields/EstadoResidencia">
hideLabel: true, layout: 'vbox', defaults: { hideLabel: false, anchor: 'none', flex: 0}
</xsl:template>

<!-- <xsl:template mode="dataField" match="Voluntario/px:fields/PoblacionResidencia//Pais">
{xtype:"displayfield", value:"Lugar de Residencia"},<xsl:call-template name="dataField"/>
</xsl:template> -->

<!-- <xsl:template mode="control.onchange" match="Voluntario/px:fields/PoblacionResidencia//Ciudad[1]">function(combo, records, eOptions) { 
var ciudadLabel = Ext.ComponentQuery.query("#Ciudad")[0];
if (ciudadLabel) 
	ciudadLabel.setValue(combo.value?combo.value.text:'');
}
</xsl:template>

<xsl:template mode="control.onchange" match="Voluntario/px:fields/PoblacionResidencia//Estado[1]">function(combo, records, eOptions) { 
var estadoLabel = Ext.ComponentQuery.query("#Estado")[0];
if (estadoLabel) 
	estadoLabel.setValue(combo.value?combo.value.text:'');
}
</xsl:template>

<xsl:template mode="dataField" match="Voluntario/px:fields/Ciudad">
{ xtype: 'displayfield', itemId: 'Ciudad', fieldLabel:'Ciudad', value:''},
</xsl:template>

<xsl:template mode="dataField" match="Voluntario/px:fields/Estado">
{ xtype: 'displayfield', itemId: 'Estado', fieldLabel:'Estado', value:''},
</xsl:template> -->

<xsl:template mode="control.onchange" match="Voluntario/px:fields/PoblacionResidencia//Pais[1]">function(combo, records, eOptions) { 
<!-- var ciudadLabel = Ext.ComponentQuery.query("#Ciudad")[0];
if (ciudadLabel) {
	ciudadLabel.setValue('');
}
var estadoLabel = Ext.ComponentQuery.query("#Estado")[0];
if (estadoLabel) {
	estadoLabel.setValue('');
} -->
if (!(combo.value)) return false;
if (combo.value.id=='') {
	combo.select(combo.findRecordByDisplay('México'));
	return false;
}
if (combo.value.text=='Otro') {
	Ext.ComponentQuery.query('#<xsl:apply-templates select="ancestor::px:fields[1]/OtroPaisResidencia" mode="container_id"/>')[0].show(true);
	} else {
	Ext.ComponentQuery.query('#<xsl:apply-templates select="ancestor::px:fields[1]/OtroPaisResidencia" mode="container_id"/>')[0].hide(true);
	} 

if (combo.value.text!='México') 
	{
	Ext.ComponentQuery.query('#<xsl:apply-templates select=".." mode="field_id"/>')[0].hide(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="../.." mode="field_id"/>')[0].hide(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="../../.." mode="field_id"/>')[0].hide(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="ancestor::px:fields[1]/EstadoResidencia" mode="field_id"/>')[0].show(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="ancestor::px:fields[1]/MunicipioResidencia" mode="field_id"/>')[0].show(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="ancestor::px:fields[1]/OtraPoblacionResidencia" mode="field_id"/>')[0].show(true);
	}
else
	{
	Ext.ComponentQuery.query('#<xsl:apply-templates select=".." mode="field_id"/>')[0].show(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="../.." mode="field_id"/>')[0].show(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="../../.." mode="field_id"/>')[0].show(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="ancestor::px:fields[1]/EstadoResidencia" mode="field_id"/>')[0].hide(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="ancestor::px:fields[1]/MunicipioResidencia" mode="field_id"/>')[0].hide(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="ancestor::px:fields[1]/OtraPoblacionResidencia" mode="field_id"/>')[0].hide(true);
	}
}
</xsl:template>

<xsl:template match="Voluntario/px:fields/OtraPoblacionResidencia|Voluntario/px:fields/MunicipioResidencia|Voluntario/px:fields/EstadoResidencia" mode="field.config">hidden: true
</xsl:template>

<xsl:template match="Voluntario/px:fields/OtroPaisResidencia" mode="container.config">hidden: true, hideEmptyLabel: false
</xsl:template>

<xsl:template match="__Voluntario[@dataType='table']" mode="layout">
Ext.onReady(function() {
    // create some portlet tools using built in Ext tool ids
    var tools = [{
        type: 'gear',
        handler: function () {
            Ext.Msg.alert('Message', 'The Settings tool was clicked.');
        }
    }, {
        type: 'close',
        handler: function (e, target, panel) {
            panel.ownerCt.remove(panel, true);
        }
    }];

	var grouptabpanel = Ext.create('Ext.ux.GroupTabPanel', {
            xtype: 'grouptabpanel',
            activeGroup: 0,
            items: [
			<xsl:apply-templates select="." mode="formView.groupTabPanel"/>
			]
        });
	grouptabpanel.items.items[0].width=250; //se tiene que definir así porque no tiene configuración
    container.add(grouptabpanel);
});
</xsl:template>

<xsl:template mode="field.config" match="
HorariosDisponibilidadVoluntario/px:fields/De|HorariosDisponibilidadVoluntario/px:fields/A">
minValue: 08
, maxValue: 23
, increment: 60
</xsl:template>


</xsl:stylesheet>
<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:px="urn:panax">


<xsl:template mode="defaultAttributes" match="PersonaConDiscapacidad/px:fields/*/@fieldContainer[.='Email' or .='Facebook']">
hideLabel: true
</xsl:template>

<xsl:template mode="labelWidth" match="PersonaConDiscapacidad/px:fields/*[@fieldContainer='TrabajoAntes']">200</xsl:template>

<xsl:template match="
PersonaConDiscapacidad/px:fields/Dominio |
PersonaConDiscapacidad/px:fields/DominioFacebook |
PersonaConDiscapacidad/px:fields/Twitter" mode="dataField">
{xtype:"displayfield", value:"@"},<xsl:call-template name="dataField"/>
</xsl:template>

<xsl:template mode="dataField" match="PersonaConDiscapacidad/px:fields/Twitter">
{
xtype: "fieldcontainer", layout: "hbox", defaults:{hideLabel:true}, items:[
{xtype:"displayfield", value:"@"},<xsl:call-template name="dataField"/>,<xsl:apply-templates mode="dataField" select="../NoTieneTwitter"/>]
},{xtype:'twitter', user:'_unidos_', lang:'es'},
</xsl:template>

<xsl:template mode="boxLabel" match="
PersonaConDiscapacidad/px:fields/NoTieneTelefono |
PersonaConDiscapacidad/px:fields/NoTieneCelular |
PersonaConDiscapacidad/px:fields/NoTieneCorreo |
PersonaConDiscapacidad/px:fields/NoTieneTwitter |
PersonaConDiscapacidad/px:fields/NoTieneAlergias">
<xsl:apply-templates select="." mode="headerText"/>
</xsl:template>

<xsl:template mode="onChange" match="PersonaConDiscapacidad/px:fields/NoTieneTelefono">function(newValue, oldValue) { 
	var txtLada = Ext.ComponentQuery.query("#<xsl:apply-templates select="../LadaCasa" mode="field_id"/>")[0];
	txtLada.setDisabled(newValue);
	var txtTelefono = Ext.ComponentQuery.query("#<xsl:apply-templates select="../TelefonoCasa" mode="field_id"/>")[0];
	txtTelefono.setDisabled(newValue);
}
</xsl:template>
<xsl:template mode="onChange" match="PersonaConDiscapacidad/px:fields/NoTieneCelular">function(newValue, oldValue) { 
	var txtCelular = Ext.ComponentQuery.query("#<xsl:apply-templates select="../Celular" mode="field_id"/>")[0];
	txtCelular.setDisabled(newValue);
}
</xsl:template>
<xsl:template mode="onChange" match="PersonaConDiscapacidad/px:fields/NoTieneCorreo">function(newValue, oldValue) { 
	var txtBox = Ext.ComponentQuery.query("#<xsl:apply-templates select="../CorreoElectronico" mode="field_id"/>")[0];
	txtBox.setDisabled(newValue);
	var txtBox = Ext.ComponentQuery.query("#<xsl:apply-templates select="../Dominio" mode="field_id"/>")[0];
	txtBox.setDisabled(newValue);
}
</xsl:template>
<xsl:template mode="onChange" match="PersonaConDiscapacidad/px:fields/NoTieneAlergias">function(newValue, oldValue) { 
	var txtBox = Ext.ComponentQuery.query("#<xsl:apply-templates select="../Alergias" mode="field_id"/>")[0];
	txtBox.setDisabled(newValue);
}
</xsl:template>
<xsl:template mode="onChange" match="PersonaConDiscapacidad/px:fields/NoTieneTwitter">function(newValue, oldValue) { 
	var txtBox = Ext.ComponentQuery.query("#<xsl:apply-templates select="../Twitter" mode="field_id"/>")[0];
	txtBox.setDisabled(newValue);
}
</xsl:template>

<!-- <xsl:template match="
PersonaConDiscapacidad/px:fields/LadaTrabajoPadre" mode="dataField">
<xsl:call-template name="dataField"/>,<xsl:apply-templates select="../TelefonoTrabajoPadre" mode="dataField"/>
</xsl:template>

<xsl:template match="
PersonaConDiscapacidad/px:fields/LadaTrabajoMadre" mode="dataField">
<xsl:call-template name="dataField"/>,<xsl:apply-templates select="../TelefonoTrabajoMadre" mode="dataField"/>
</xsl:template> -->

<xsl:template mode="dockedItems" match="PersonaConDiscapacidad/px:fields/Ingresos">
</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/CorreoElectronico" mode="field.config">width: 200</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/MedicamentoPeriodico" mode="fieldContainer">
<xsl:call-template name="fieldContainer.checkBoxToggle"/>
</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/*/@fieldContainer[.='OtroContacto']" mode="attributes">
layout: 'vbox', hideEmptyLabel: false, fieldLabel: '', id: 'OtroContacto', hidden: true
</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/*/@fieldContainer[.='Teléfono de Casa' or .='Teléfono de Oficina']" mode="defaultAttributes">
hideLabel: true
</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/*[@fieldContainer='Teléfono de Casa' or @fieldContainer='Teléfono de Oficina']" mode="field.config">
emptyText:'<xsl:apply-templates select="." mode="headerText"/>'
</xsl:template>


<xsl:template match="PersonaConDiscapacidad/px:fields/*/@fieldContainer[.='MedicamentoPeriodico']" mode="headerText">Tomas algún medicamento periódicamente?</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/MedicamentoPeriodico" mode="headerText">Cuál?</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/*/@fieldContainer[.='ServicioSocial']" mode="headerText"><xsl:apply-templates select=".." mode="headerText"/></xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/Sexo" mode="field.config">columns: 3, width: 400</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/*[name(.)='ServicioSocial']" mode="field.config">insertEnabled:true</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/*[name(.)='EstadoCivilPadres' or name(.)='Religion' or name(.)='ContactoDeEmergencia' or name(.)='TipoSangre']" mode="field.config">insertEnabled:false</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/Calle" mode="field.config">height: 27</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/Sexo/px:data/*[@value='-Vacio-']" mode="checkboxGroup.option">/*opción "<xsl:value-of select="@value"/>" fue quitada*/</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/ContactoDeEmergencia/*" mode="control.onchange">function(combo, records, eOptions) { 
	if (combo.value.id=='3') //Otro
		Ext.ComponentQuery.query("#<xsl:apply-templates select="../following-sibling::*[1]" mode="container_id"/>")[0].show(true); 
	else
		Ext.ComponentQuery.query("#<xsl:apply-templates select="../following-sibling::*[1]" mode="container_id"/>")[0].hide(true); 
	return true;
	}
</xsl:template>

<xsl:template mode="dockedItems" match="PersonaConDiscapacidad/px:fields/Ingresos">
</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/NumeroSueldos" mode="control.onchange">function(control, newValue, oldValue, eOptions) { 
var grid = Ext.ComponentQuery.query("#Ingresos");
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


<xsl:template mode="dockedItems" match="PersonaConDiscapacidad/px:fields/Hermanos">
</xsl:template>

<xsl:template mode="control.onchange" match="PersonaConDiscapacidad/px:fields/NumeroHermanos">function(control, newValue, oldValue, eOptions) { 
var grid = Ext.ComponentQuery.query("#Hermanos");
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


<xsl:template match="__PersonaConDiscapacidad[@dataType='table']" mode="layout">
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










<xsl:template match="PersonaConDiscapacidad/px:fields/*/@fieldContainer[.='HaEstadoHospitalizado' or .='SostieneLaCabezaSolo' or .='UtilizaSondaParaComerOBanio' or .='ReconoceLasPersonas' or .='ComePorSiSolo' or .='PresentaSalivacion' or .='PresentaTics' or .='UtilizaMarcapasos' or .='PresentaTranstornosVista' or .='PresentaTranstornosAudicion' or .='PresentaConvulsiones' or .='VaAlBanioPorSiSolo' or .='MantieneContactoVisual' or .='ImitaSonidos' or .='FormulaFrases' or .='SeAdaptaAlClima' or .='ReaccionaConSuNombre' or .='PuedePermanecerSinTutores' or .='PlaticaConOtrasPersonas' or .='ManifiestaAgresividad' or .='PresentaArranquesDeFuria']" mode="headerText"><xsl:apply-templates select=".." mode="headerText"/></xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/SostieneLaCabezaSolo" mode="fieldContainer"><xsl:call-template name="fieldContainer"/></xsl:template>
<!-- <xsl:template match="PersonaConDiscapacidad/px:fields/SostieneLaCabezaSolo" mode="datafield"><xsl:call-template name="yesNo"/></xsl:template> -->

<xsl:template match="PersonaConDiscapacidad/px:fields/*/@fieldContainer[.='Teléfono de Casa' or .='Teléfono de Oficina' or .='Email' or .='Facebook' or .='SostieneLaCabezaSolo' or .='ProporcionanteDatos' or .='FechaNacimiento']" mode="defaultAttributes">
hideLabel: true
</xsl:template>	

<xsl:template match="
PersonaConDiscapacidad/px:fields/ProporcionanteDatos/*|
PersonaConDiscapacidad/px:fields/MedioCaptacion/*
" mode="control.onchange">function(combo, records, eOptions) { 
	if (combo.value.text.toUpperCase()=='OTRO')
		Ext.ComponentQuery.query("#<xsl:apply-templates select="../following-sibling::*[1]" mode="field_id"/>")[0].show(true); 
	else
		Ext.ComponentQuery.query("#<xsl:apply-templates select="../following-sibling::*[1]" mode="field_id"/>")[0].hide(true); 
	return true;
	}
</xsl:template>

<xsl:template match="
PersonaConDiscapacidad/px:fields/EstatusHabitacion/*
" mode="control.onchange">function(combo, records, eOptions) { 
	if (combo.value.text.toUpperCase().indexOf ('CASA HOGAR')==-1) {
		Ext.ComponentQuery.query("#<xsl:apply-templates select="ancestor::px:fields[1]/TipoVivienda" mode="container_id"/>")[0].show(true); 
		Ext.ComponentQuery.query("#<xsl:apply-templates select="ancestor::px:fields[1]/ServiciosDomicilioPcD" mode="container_id"/>")[0].show(true); 
		}
	else {
		Ext.ComponentQuery.query("#<xsl:apply-templates select="ancestor::px:fields[1]/TipoVivienda" mode="container_id"/>")[0].hide(true); 
		Ext.ComponentQuery.query("#<xsl:apply-templates select="ancestor::px:fields[1]/ServiciosDomicilioPcD" mode="container_id"/>")[0].hide(true); 
		}
	return true;
	}
</xsl:template>

<xsl:template match="
PersonaConDiscapacidad/px:fields/OtroProporcionanteDatos|
PersonaConDiscapacidad/px:fields/OtroMedioCaptacion" mode="field.config">
hidden: true
</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/MesNacimiento" mode="field.config">
</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/DiaNacimiento" mode="field.config">
minValue: 1,
maxValue: 31
</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/AnioNacimiento" mode="field.config">
minValue: 1900,
maxValue: new Date().getFullYear()
</xsl:template>			

<xsl:template match="PersonaConDiscapacidad/px:fields/*/@fieldContainer[.='FechaNacimiento']" mode="headerText">Fecha de Nacimiento</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/TipoTrabajoConNosotros" mode="field.config">
hideLabel:false, labelWidth: 180
</xsl:template>

<xsl:template mode="field.config" match="PersonaConDiscapacidad/px:fields/PorcentajeBeca">
minValue: 0,
maxValue: 100,
step:.5
</xsl:template>

<xsl:template mode="field.config" match="PersonaConDiscapacidad/px:fields/AnioIntegracion">
minValue: 1987,
maxValue: new Date().getFullYear()
</xsl:template>

<xsl:template mode="dataField" match="PersonaConDiscapacidad/px:fields/PoblacionNacimiento">
<xsl:call-template name="dataField"/>
</xsl:template>

<xsl:template mode="dataField" match="PersonaConDiscapacidad/px:fields/EstadoNacimiento">
<xsl:call-template name="dataField"/>,
<xsl:apply-templates select="../MunicipioNacimiento" mode="dataField"/>,
<xsl:apply-templates select="../OtraPoblacionNacimiento" mode="dataField"/>
</xsl:template>


<xsl:template mode="container.config" match="PersonaConDiscapacidad/px:fields/PoblacionNacimiento">
hideLabel: true, layout: 'vbox', defaults: { hideLabel: false, anchor: 'none', flex: 0}
</xsl:template>

<xsl:template mode="container.config" match="PersonaConDiscapacidad/px:fields/EstadoNacimiento">
hideLabel: true, layout: 'vbox', defaults: { hideLabel: false, anchor: 'none', flex: 0}
</xsl:template>

<xsl:template mode="dataField" match="PersonaConDiscapacidad/px:fields/PoblacionNacimiento//Pais">
{xtype:"displayfield", value:"población Nacimiento"},<xsl:call-template name="dataField"/>
</xsl:template>

<xsl:template mode="control.onchange" match="PersonaConDiscapacidad/px:fields/PoblacionNacimiento//Ciudad[1]">function(combo, records, eOptions) { 
var ciudadLabel = Ext.ComponentQuery.query("#Ciudad")[0];
if (ciudadLabel) 
	ciudadLabel.setValue(combo.value?combo.value.text:'');
}
</xsl:template>

<xsl:template mode="control.onchange" match="PersonaConDiscapacidad/px:fields/PoblacionNacimiento//Estado[1]">function(combo, records, eOptions) { 
var estadoLabel = Ext.ComponentQuery.query("#Estado")[0];
if (estadoLabel) 
	estadoLabel.setValue(combo.value?combo.value.text:'');
}
</xsl:template>

<xsl:template mode="dataField" match="PersonaConDiscapacidad/px:fields/Ciudad">
{ xtype: 'displayfield', itemId: 'Ciudad', fieldLabel:'Ciudad', value:''},
</xsl:template>

<xsl:template mode="dataField" match="PersonaConDiscapacidad/px:fields/Estado">
{ xtype: 'displayfield', itemId: 'Estado', fieldLabel:'Estado', value:''},
</xsl:template>

<xsl:template mode="control.onchange" match="PersonaConDiscapacidad/px:fields/PoblacionNacimiento//Pais[1]">function(combo, records, eOptions) { 
var ciudadLabel = Ext.ComponentQuery.query("#Ciudad")[0];
if (ciudadLabel) {
	ciudadLabel.setValue('');
}
var estadoLabel = Ext.ComponentQuery.query("#Estado")[0];
if (estadoLabel) {
	estadoLabel.setValue('');
}
if (!(combo.value)) return false;
if (combo.value.id=='')
	return false;
if (combo.value.text!='México') 
	{
	Ext.ComponentQuery.query('#<xsl:apply-templates select=".." mode="cmp_id"/>')[0].hide(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="../.." mode="cmp_id"/>')[0].hide(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="../../.." mode="cmp_id"/>')[0].hide(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="ancestor::px:fields[1]/EstadoNacimiento" mode="field_id"/>')[0].show(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="ancestor::px:fields[1]/MunicipioNacimiento" mode="field_id"/>')[0].show(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="ancestor::px:fields[1]/OtraPoblacionNacimiento" mode="field_id"/>')[0].show(true);
	}
else
	{
	Ext.ComponentQuery.query('#<xsl:apply-templates select=".." mode="cmp_id"/>')[0].show(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="../.." mode="cmp_id"/>')[0].show(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="../../.." mode="cmp_id"/>')[0].show(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="ancestor::px:fields[1]/EstadoNacimiento" mode="field_id"/>')[0].hide(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="ancestor::px:fields[1]/MunicipioNacimiento" mode="field_id"/>')[0].hide(true);
	Ext.ComponentQuery.query('#<xsl:apply-templates select="ancestor::px:fields[1]/OtraPoblacionNacimiento" mode="field_id"/>')[0].hide(true);
	}
}
</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/OtraPoblacionNacimiento|PersonaConDiscapacidad/px:fields/MunicipioNacimiento|PersonaConDiscapacidad/px:fields/EstadoNacimiento" mode="field.config">hidden: true
</xsl:template>

<!-- 
<xsl:template match="PersonaConDiscapacidad/px:fields/*[@fieldContainer[.='Teléfono de Casa' or .='Teléfono de Oficina' or .='Email' or .='Facebook']]" mode="field.config">
emptyText:'<xsl:apply-templates select="." mode="headerText"/>'
</xsl:template> -->

<xsl:template match="PersonaConDiscapacidad/px:fields/*[@Column_Name='LadaCasa' or @Column_Name='LadaOficina']" mode="field.config">
emptyText:'Lada'
</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/*[@Column_Name='TelefonoCasa' or @Column_Name='TelefonoOficina']" mode="field.config">
emptyText:'Telefono'
</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/*[@Column_Name='TelefonoCasa' or @Column_Name='TelefonoOficina']" mode="field.config">
emptyText:'Telefono'
</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/*[@Column_Name='CorreoElectronico' or @Column_Name='Facebook']" mode="field.config">
emptyText:'Correo'
</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/SostieneLaCabezaSoloComentarios" mode="field.config">emptyText:'Escribe aquí tus comentarios o sugerencias'</xsl:template>

<xsl:template match="PersonaConDiscapacidad/px:fields/IndicacionesParaComer|PersonaConDiscapacidad/px:fields/IndicacionesParaBanio" mode="field.config">emptyText:'Indicaciones, prevenciones'</xsl:template>

</xsl:stylesheet>
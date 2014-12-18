<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:px="urn:panax"
    xmlns:str="http://exslt.org/strings"
	xmlns="http://www.w3.org/TR/xhtml1/strict"
	exclude-result-prefixes="px"
>
<xsl:strip-space elements="*"/>

<xsl:template match="*[@dataType='table']" mode="formView.groupTabPanel.Container">
/*<xsl:value-of select="px:fields/*[@groupTabPanel]/@groupTabPanel"/>*/
	<xsl:choose><xsl:when test="px:fields[*/@fieldSet]">
	<xsl:apply-templates select="px:fields/*[@groupTabPanel][count(. | key('groupTabPanel', @groupTabPanel)[1]) = 1]" mode="formView.groupTabPanel"/>
	</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="px:fields/*[@dataType!='identity']" mode="fieldContainer"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="*[@dataType='table']/px:fields/*[@groupTabPanel]" mode="formView.groupTabPanel">
<xsl:param name="groupTabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'groupTabPanel'"/></xsl:call-template></xsl:param>
{
	mainItem: 0,
	items: [
	{
		xtype: 'portalpanel',
		title: '<xsl:value-of select="@groupTabPanel"/>',
		tabTip: '',
		border: false,
		items: [{
			flex: 1,
			items: [null<xsl:call-template name="portlet.private"><xsl:with-param name="groupTabPanel" select="$groupTabPanel"/><xsl:with-param name="subGroupTabPanel" select="''"/></xsl:call-template>]
		}]
	}<xsl:call-template name="subGroupTabPanel.private"><xsl:with-param name="groupTabPanel" select="$groupTabPanel"/></xsl:call-template>]
},
</xsl:template>
					
<xsl:template match="*[@dataType='table']/px:fields/*[@subGroupTabPanel]" mode="formView.subGroupTabPanel.Template">
<xsl:param name="groupTabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'groupTabPanel'"/></xsl:call-template></xsl:param>
<xsl:param name="subGroupTabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'subGroupTabPanel'"/></xsl:call-template></xsl:param>, 
{
		xtype: 'portalpanel',
		title: '<xsl:value-of select="@subGroupTabPanel"/>',
		iconCls: 'x-icon-users',
		tabTip: '',
		//style: 'padding: 10px;',
		border: false,
		layout: 'fit',
		items: [{
			flex: 1,
			items: [null,<xsl:call-template name="portlet.private"><xsl:with-param name="groupTabPanel" select="$groupTabPanel"/><xsl:with-param name="subGroupTabPanel" select="$subGroupTabPanel"/></xsl:call-template>]
		}]
	}
</xsl:template>
					
<xsl:template match="*[@dataType='table']/px:fields/*[not(@portlet)]" mode="formView.portlet.Template">
	<xsl:param name="groupTabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'groupTabPanel'"/></xsl:call-template></xsl:param>
	<xsl:param name="subGroupTabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'subGroupTabPanel'"/></xsl:call-template></xsl:param>
	<xsl:param name="portlet"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'tabPanel'"/></xsl:call-template></xsl:param>,
{
	title: '<xsl:value-of select="$groupTabPanel"/><xsl:if test="$subGroupTabPanel!=''"> - <xsl:value-of select="$subGroupTabPanel"/></xsl:if>',
	closable: false,
	items: [null<xsl:call-template name="fieldSetGroup.private"><xsl:with-param name="groupTabPanel" select="$groupTabPanel"/><xsl:with-param name="subGroupTabPanel" select="$subGroupTabPanel"/><xsl:with-param name="portlet" select="$portlet"/></xsl:call-template>]
}
</xsl:template>
					
<xsl:template match="*[@dataType='table']/px:fields/*[@portlet]" mode="formView.portlet.Template">
<xsl:param name="groupTabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'groupTabPanel'"/></xsl:call-template></xsl:param>
<xsl:param name="subGroupTabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'subGroupTabPanel'"/></xsl:call-template></xsl:param>
<xsl:param name="portlet"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'tabPanel'"/></xsl:call-template></xsl:param>,
{
	title: '<xsl:value-of select="@portlet"/>!!',
	closable: false,
	items: [{
		xtype:'tabpanel',
		activeTab: 0,
		defaults:{
			bodyPadding: 10,
			layout: 'anchor'
		},
		items:[null<xsl:call-template name="fieldSetGroup.private"><xsl:with-param name="groupTabPanel" select="$groupTabPanel"/><xsl:with-param name="subGroupTabPanel" select="$subGroupTabPanel"/><xsl:with-param name="portlet" select="$portlet"/></xsl:call-template>]
	}]	
}
</xsl:template>

<xsl:template match="*[@dataType='table']/px:fields/*[not(@tabPanel)]" mode="formView.tabPanel.Template">
	<xsl:param name="groupTabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'groupTabPanel'"/></xsl:call-template></xsl:param>
	<xsl:param name="subGroupTabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'subGroupTabPanel'"/></xsl:call-template></xsl:param>
	<xsl:param name="portlet"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'tabPanel'"/></xsl:call-template></xsl:param>
	<xsl:param name="tabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'tabPanel'"/></xsl:call-template></xsl:param>,
	<xsl:call-template name="fieldSetGroup.private"><xsl:with-param name="groupTabPanel" select="$groupTabPanel"/><xsl:with-param name="subGroupTabPanel" select="$subGroupTabPanel"/><xsl:with-param name="portlet" select="$portlet"/><xsl:with-param name="tabPanel" select="$tabPanel"/></xsl:call-template>
</xsl:template>

<xsl:template match="*[@dataType='table']/px:fields/*[@tabPanel]" mode="formView.tabPanel.Template">
<xsl:param name="groupTabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'groupTabPanel'"/></xsl:call-template></xsl:param>
<xsl:param name="subGroupTabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'subGroupTabPanel'"/></xsl:call-template></xsl:param>
<xsl:param name="portlet"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'tabPanel'"/></xsl:call-template></xsl:param>
<xsl:param name="tabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'tabPanel'"/></xsl:call-template></xsl:param>,
{
	title:'<xsl:value-of select="@tabPanel"/>',
	defaultType: 'textfield',
	items: [<xsl:call-template name="fieldSetGroup.private"><xsl:with-param name="groupTabPanel" select="$groupTabPanel"/><xsl:with-param name="subGroupTabPanel" select="$subGroupTabPanel"/><xsl:with-param name="portlet" select="$portlet"/><xsl:with-param name="tabPanel" select="$tabPanel"/></xsl:call-template>]
}
</xsl:template>

<xsl:template match="px:data/px:dataRow/*|px:fields/*" mode="formView.fieldSetGroup.Template">
<xsl:param name="groupTabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'groupTabPanel'"/></xsl:call-template></xsl:param>
<xsl:param name="subGroupTabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'subGroupTabPanel'"/></xsl:call-template></xsl:param>
<xsl:param name="tabPanel"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'tabPanel'"/></xsl:call-template></xsl:param>
<xsl:param name="fieldSet"><xsl:call-template name="getGroupName"><xsl:with-param name="key" select="'fieldSet'"/></xsl:call-template></xsl:param>,
<xsl:variable name="siblings" select=".|following-sibling::*"/>
<xsl:variable name="items" select="$siblings[key('groupTabPanel',concat(generate-id(),'::',$groupTabPanel))][key('subGroupTabPanel',concat(generate-id(),'::',$subGroupTabPanel))][key('tabPanel',concat(generate-id(),'::',$tabPanel))][key('fieldSet',concat(generate-id(),'::',$fieldSet))]"/>,
<xsl:if test="$items">
{
	xtype:'fieldset',
	title: '<!-- <xsl:value-of select="$groupTabPanel"/>::<xsl:value-of select="$subGroupTabPanel"/>::<xsl:value-of select="$tabPanel"/>::<xsl:value-of select="$fieldSet"/>:  --><xsl:apply-templates select="@fieldSet" mode="fieldSetGroup.attributeSet" />',
	defaultType: 'textfield',
	layout: 'anchor',
	defaults: {
	    anchor: '100%'
	},
	items :[<xsl:apply-templates select=".|following-sibling::*[key('groupTabPanel',concat(generate-id(),'::',$groupTabPanel))][key('subGroupTabPanel',concat(generate-id(),'::',$subGroupTabPanel))][key('tabPanel',concat(generate-id(),'::',$tabPanel))][key('fieldSet',concat(generate-id(),'::',$fieldSet))]" mode="fieldContainer" />]
}
</xsl:if>
</xsl:template>

<xsl:template match="*[@dataType='table']" mode="Form">
Ext.define('Panax.Form', {
    extend: 'Ext.form.Panel',
    alias: 'widget.panaxform',

    requires: ['Ext.form.field.Text'],

    initComponent: function(){
        this.addEvents('create');
		
		this.on({
                create: function(form, data){
                    store.insert(0, data);
                }
            });
			
        Ext.apply(this, {
			title: '<xsl:apply-templates select="." mode="headerText"/>',
			activeRecord: null,
            frame: true,
			width: 600,
			autoScroll: true,
			defaults: {
				xtype: 'textfield',
				labelAlign: 'right',
				labelWidth: 85,
				<!-- labelAlign: 'top', -->
				<!-- anchor: '100%' -->
			},
			layout: {
				type: 'fit',
			},
			
			items: function() { var grouptabpanel = Ext.create('Ext.ux.GroupTabPanel', {
				xtype: 'grouptabpanel',
				padding: '10 5 3 10',
				activeGroup: 0,
				items: [
				<xsl:apply-templates select="." mode="formView.groupTabPanel"/>
				]
			});
			grouptabpanel.items.items[0].width=250; //se tiene que definir así porque no tiene configuración
			return grouptabpanel;
			}(),
            dockedItems: [{
                xtype: 'toolbar',
                dock: 'top',
                ui: 'header',
				ignoreParentFrame: true,
				ignoreBorderManagement: true,
                items: ['->', {
                    iconCls: 'icon-save',
                    itemId: 'save',
                    text: 'Save',
                    formBind: true,
					disabled: true,
                    scope: this,
                    handler: this.onSave
                },'-',{
                 text: 'Print',
                 iconCls: 'icon-print'
				}, {
                    iconCls: 'icon-user-add',
                    text: 'Create',
                    scope: this,
                    handler: this.onCreate
                }, {
                    iconCls: 'icon-reset',
                    text: 'Reset',
                    scope: this,
                    handler: this.onReset
                }]
            }]
        });
        this.callParent();
    },

    setActiveRecord: function(record){
        this.activeRecord = record;
        if (record) {
            this.down('#save').enable();
            this.getForm().loadRecord(record);
        } else {
            this.down('#save').disable();
            this.getForm().reset();
        }
    },

    onSave: function(){
			<!-- var active = this.activeRecord,
            form = this.getForm(); -->

<!--         if (!active) {
//            return;
        }
        if (form.isValid()) {
            form.updateRecord(active);
            this.onReset();
        } -->
		var form = this.getForm(), // get the basic form
			record = form.getRecord();
		if (form.isValid()) {
			form.updateRecord(record);
			record.save({
				success: function(record, args) {
					Ext.Msg.alert('Éxito', 'Datos guardados con éxito')
				},
				failure: function(record, args) {
					Ext.Msg.alert('Falló', args.error)
				}
			});
		}
    },

    onCreate: function(){
        var form = this.getForm();

        if (form.isValid()) {
            this.fireEvent('create', this, form.getValues());
            this.onReset();
        }

    },

    onReset: function(){
        this.setActiveRecord(null);
        this.getForm().reset();
    }
});

</xsl:template>

<xsl:template match="*[@dataType='table']" mode="Model">
Ext.define("<xsl:value-of select="@Table_Schema" />.<xsl:value-of select="@Table_Name" />", {
    extend: 'Ext.data.Model',
    idProperty: '<xsl:value-of select="@identityKey"/>',
    fields: [<xsl:apply-templates select="px:fields/*[@dataType!='foreignTable']" mode="Model.fields"/>],
	validations: [],
	proxy: {
		type: 'ajax',
		api: {
			read: "../Templates/request.asp",
			create: "../Scripts/update.asp",
			update: "../Scripts/update.asp",
			destroy: "../Scripts/update.asp",
		},
		reader: {
			type: 'json',
			root: 'data',
			successProperty: 'success',
			messageProperty: 'message',
			totalProperty: 'total'
		},
		writer: {
			type: 'xml',
			writeAllFields: false,
			root: 'data'				
		},
		pageParam: 'pageIndex',
		limitParam: 'pageSize',
		sortParam: 'sorters',
		extraParams: {
			catalogName: "<xsl:value-of select="@Table_Schema" />.<xsl:value-of select="@Table_Name" />",
			filters: "<xsl:value-of select="@filters" />",
			identityKey: "<xsl:value-of select="@identityKey" />",
			primaryKey: "<xsl:value-of select="@primaryKey" />",
			mode: 'readonly',
			output: 'json', 
		<!-- "@param1": 'test', 
		"param2": 'test2' -->
		},
		listeners: {
			exception: function(proxy, response, operation){
				//alert(response.responseText)
				Ext.MessageBox.show({
					title: 'RESPUESTA DEL SERVIDOR',
					msg: operation.getError(),
					icon: Ext.MessageBox.ERROR,
					buttons: Ext.Msg.OK
				});
			}
		},
	},
	associations: [
        { type: 'hasMany', model: "<xsl:value-of select="@Table_Schema" />.PhoneNumbers", name: "phonenumbers", primaryKey: 'IdProspecto', foreignKey: 'Prospecto' }
    ]
});

Ext.define("<xsl:value-of select="@Table_Schema" />.PhoneNumbers", {
    extend: 'Ext.data.Model',
    fields: [{name: 'Prospecto', mapping:'phonenumbers.Prospecto'}, {name: 'home', mapping:'phonenumbers.home'}, {name: 'business', mapping:'phonenumbers.business'}, {name: 'mobile', mapping:'phonenumbers.mobile'}, {name: 'fax', mapping:'phonenumbers.fax'}],
	validations: []
});
</xsl:template>

<xsl:template match="*[@dataType='table']" mode="formView.table.Template">
Ext.require([
    //'Ext.form.*',
    //'Ext.layout.container.Column',
    //'Ext.tab.Panel'
    '*'
]);
var store;
<xsl:apply-templates select="." mode="Form"/>
var url = {
	local:  'localData',//'temp_data.js',  // static data file
	remote: 'request.asp'
};

// configure whether filter query is encoded or not (initially)
var encode = false;

// configure whether filtering is performed locally or remotely (initially)
var local = false;
var showSummary = false;

<xsl:apply-templates select="." mode="Model"/>

Ext.onReady(function() {
    Ext.QuickTips.init();
    <xsl:apply-templates select="." mode="data.Store"/>
    <xsl:apply-templates select="px:data/px:dataRow" mode="formView.table.form.Template" />
	<xsl:for-each select="px:data/px:dataRow[1]">
	var newRecord = new <xsl:value-of select="ancestor::*[@dataType='table'][1]/@Table_Schema" />.<xsl:value-of select="ancestor::*[@dataType='table'][1]/@Table_Name" />({<xsl:for-each select="*[@dataType!='foreignTable']">"<xsl:value-of select="@Column_Name"/>":<xsl:apply-templates select="." mode="json.value"/>,</xsl:for-each>});
	</xsl:for-each>
	<!-- newRecord.phonenumbers().add({home:'123456'}); -->
	formView.loadRecord(newRecord);
	//formView.setActiveRecord(store.getAt(0));
	<xsl:apply-templates select="." mode="layout"/>
});
<!-- 	<xsl:element name="div" use-attribute-sets="query.parameters">
		<xsl:apply-templates select="." mode="formView.table.Wrapper" />
	</xsl:element> -->
</xsl:template>

<xsl:template match="*[@dataType='table']" mode="layout">
container.add(formView)
</xsl:template>



<xsl:template match="px:data/px:dataRow/*" mode="json.value">'<xsl:value-of disable-output-escaping="no" select="str:escapeApostrophe(string(@text))"/>'</xsl:template>

<xsl:template match="px:data/px:dataRow/*[@dataType='money' or @dataType='smallmoney' or @dataType='int' or @dataType='identity' or @dataType='float']" mode="json.value"><xsl:value-of disable-output-escaping="yes" select="@value"/></xsl:template>

<xsl:template match="px:data/px:dataRow/*[@dataType='date' or @dataType='datetime' or @dataType='smalldatetime']" mode="json.value">new Date('<xsl:value-of select="@value"/>')</xsl:template>

<xsl:template match="px:data/px:dataRow/*[string(@value)='']" mode="json.value">null</xsl:template>

<xsl:template match="*[@dataType='table']" mode="data.Store">
    store = Ext.create('Ext.data.Store', {
        autoLoad: true,
        autoSync: true,
        autoDestroy: true,
        pageSize: <xsl:value-of select="@pageSize" />,
        remoteSort: true,
        model: "<xsl:value-of select="@Table_Schema" />.<xsl:value-of select="@Table_Name" />",
		<xsl:if test="*[@groupByColumn='true'] or 1=0">groupField: 'ApellidoPaterno',//'<xsl:value-of select="*[@groupByColumn='true'][1]/@Column_Name"/>',</xsl:if>
        listeners: {
            write: function(proxy, operation){
                <!-- if (operation.action == 'destroy') {
                    main.child('#form').setActiveRecord(null);
                } -->
                Ext.example.msg(operation.action, operation.resultSet.message);
            }
        },
    });
</xsl:template>

<xsl:template match="px:data/px:dataRow" mode="formView.table.form.Template">
var formView = Ext.create('Panax.Form')
</xsl:template>


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

<xsl:template match="px:data/px:dataRow/*" mode="formView.table.dataRow.Fields">
<!-- nothing (si no se pone esta condición se puede aplicar al siguiente hijo) -->
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.table.dataRow.Fields">
	<xsl:element name="tr" use-attribute-sets="table.dataRow"><xsl:apply-templates select="." mode="formView.table.dataRow.cells" /></xsl:element>
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.table.dataRow.cells">
	<xsl:apply-templates select="." mode="formView.table.dataRow.cells.header" />
	<xsl:apply-templates select="." mode="formView.table.dataRow.cells.data" />
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.table.dataRow.cells.header">
	<th nowrap="nowrap" style="text-align:'right';">
	  <xsl:apply-templates select="." mode="headerText"></xsl:apply-templates>
	</th>
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.table.dataRow.cells.data">
	<td class="FieldContainer_{@Column_Name}">
		<xsl:apply-templates select="." mode="table.cell.attributeSet" />
	  	<xsl:apply-templates select="." mode="fieldContainer" />
	</td>
</xsl:template>


<xsl:template match="*" mode="formView.table.tabManager.tabStrip.tab.Template">
	<xsl:element name="li">
		
	</xsl:element>
</xsl:template>

<xsl:template match="*" mode="formView.table.tabManager.tabStrip.tab.contentTemplate">
<xsl:apply-templates select="." mode="headerText"/><!-- <xsl:choose>
	<xsl:when test="string(@headerText)!=''"><xsl:value-of select="@headerText"/></xsl:when>	
	<xsl:when test="string(@catalogName)!=''"><xsl:value-of select="@catalogName"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="name(.)"/></xsl:otherwise>
</xsl:choose> -->
</xsl:template>

<xsl:template match="*[@dataType='table']" mode="formView.table.tabManager.tabStrip.Template">
<xsl:element name="ul">
	<xsl:attribute name="id">tabs</xsl:attribute>
	<xsl:attribute name="class">tabSelector</xsl:attribute>
	<xsl:attribute name="oncontextmenu">return false;</xsl:attribute>
	<xsl:apply-templates select=".|px:data/px:dataRow/*[key('visibleTabs', @fieldId)]" mode="formView.table.tabManager.tabStrip.tab.Template" />
</xsl:element>
</xsl:template>

<xsl:template match="*[@dataType='table']" mode="formView.table.tabManager.Template">
	<xsl:apply-templates select="." mode="formView.table.tabManager.tabStrip.Template" />
    	<div class="tabManager" enableFloating="false">
           <div class="tabPanel">
             <xsl:attribute name="isUpdated">true</xsl:attribute>
             <xsl:attribute name="tabId">
               <xsl:value-of select="concat(name(.), '_', generate-id(.))"/>
             </xsl:attribute>
             <xsl:apply-templates select="." mode="formView.table.Default" />
           </div>
           <xsl:for-each select="px:data/px:dataRow/*[@controlType='tab'][not(@mode='hidden' or @mode='none') and not(ancestor::*[@dataType='table' and @mode='insert'])]">
             <div class="tabPanel" style="display:none;" parent_object="db_{ancestor::*[@dataType='table'][1]/@Table_Name}_dataRow_{generate-id(ancestor::dataRow[1])}">
               <xsl:variable name="table" select="ancestor-or-self::*[@dataType='table']"/>
               <xsl:attribute name="fullPath"><xsl:value-of select="$table/@fullPath"/>[<xsl:value-of select="name($table)"/>][<xsl:value-of select="name(.)"/>](<xsl:value-of select="$table/@controlType"/>:<xsl:value-of select="$table/@mode"/>)</xsl:attribute>
               <xsl:attribute name="tabId">
                 <xsl:value-of select="concat('field_', name(.), '_', generate-id(.))"/>
               </xsl:attribute>
               <xsl:attribute name="catalogName">
                 <xsl:value-of select="@foreignSchema"/>.<xsl:value-of select="@foreignTable"/>
               </xsl:attribute>
               <xsl:attribute name="pageIndex">DEFAULT</xsl:attribute>
               <xsl:attribute name="pageSize">DEFAULT</xsl:attribute>
               <xsl:attribute name="viewMode">formView</xsl:attribute>
               <xsl:attribute name="mode">readonly</xsl:attribute>
               <!--<xsl:value-of select="ancestor-or-self::*[@mode!='inherit'][1]/@mode"/>-->
			
			<xsl:if test="@foreignReference!=''"><xsl:attribute name="db_foreign_key"><xsl:value-of select="@foreignReference"/></xsl:attribute></xsl:if>
               <xsl:attribute name="filter">{<xsl:value-of select="@foreignReference"/>}=<xsl:choose>
                   <xsl:when test="ancestor-or-self::dataRow/@primaryValue!=''">'<xsl:value-of select="ancestor-or-self::dataRow/@primaryValue"/>'</xsl:when>
                   <xsl:otherwise>NULL</xsl:otherwise>
                 </xsl:choose></xsl:attribute>
               <xsl:attribute name="parameters">@#<xsl:value-of select="@foreignReference"/>=<xsl:choose>
                   <xsl:when test="ancestor-or-self::dataRow/@primaryValue!=''">'<xsl:value-of select="ancestor-or-self::dataRow/@primaryValue"/>'</xsl:when>
                   <xsl:otherwise>NULL</xsl:otherwise>
                 </xsl:choose></xsl:attribute>
               <b>Cargando... </b>
             </div>
           </xsl:for-each>
         </div>
</xsl:template>

<xsl:template match="*[@dataType='table']/px:data/px:dataRow" mode="formView.table.dataRow.head.Template">
</xsl:template>

<xsl:template match="*[@dataType='table']/px:data/px:dataRow" mode="formView.table.dataRow.foot.Template">
</xsl:template>

<xsl:template match="*[@dataType='table']" mode="formView.table.thead.Template">
	<xsl:if test="not(@showHeader=0 or @showHeader='false')">
		<xsl:element name="thead">
			<xsl:apply-templates select="." mode="formView.table.thead.Wrapper" />
		</xsl:element>
	</xsl:if>
</xsl:template>

<xsl:template match="*[@dataType='table']/px:data/px:dataRow" mode="formView.table.tbody.row.attributes">
</xsl:template>

<xsl:template match="*[@dataType='table']" mode="formView.table.tbody.tableGroup.Template">
	<xsl:param name="tableGroup"/>
	<xsl:element name="tbody" use-attribute-sets="gridView.datatable.table.tbodyGroup">
		<xsl:apply-templates select="$tableGroup" mode="formView.table.tbody.row.Template" />
	</xsl:element>
</xsl:template>

<xsl:template match="*[@dataType='table']/px:data/px:dataRow" mode="formView.table.tbody.columnGroup.Template">
		<xsl:variable name="currentRowNumber" select="@rowNumber"/>
		<xsl:variable name="tableGroup"><xsl:apply-templates select="*[@groupByColumn='true'][1]" mode="formView.tableGroup"><xsl:with-param name="position" select="'first'"/></xsl:apply-templates>
</xsl:variable>
		<xsl:apply-templates select="." mode="formView.table.tableGroup.Header"><xsl:with-param name="tableGroup" select="msxsl:node-set($tableGroup)/*"/></xsl:apply-templates>
		<xsl:element name="tbody" use-attribute-sets="gridView.datatable.table.tbodyGroup">
			<xsl:apply-templates select=".|following-sibling::*[string(*[@groupByColumn='true']/@value)=string(current()/*[@groupByColumn='true']/@value) and not(preceding-sibling::*[number(@rowNumber)>=number($currentRowNumber)][string(*[@groupByColumn='true']/@value)!=string(current()/*[@groupByColumn='true']/@value)])]" mode="formView.table.tbody.row.Template"/>
		</xsl:element>
		<xsl:apply-templates select="." mode="formView.table.tableGroup.Footer"><xsl:with-param name="tableGroup" select="msxsl:node-set($tableGroup)/*"/></xsl:apply-templates>
</xsl:template>

<xsl:template match="*[@dataType='table']/px:data/px:dataRow" mode="formView.table.tbody.groupByHeader.Template">
	<xsl:variable name="currentRowNumber" select="@rowNumber"/>
		<xsl:variable name="tableGroup"><xsl:apply-templates select="." mode="formView.tableGroup"><xsl:with-param name="position" select="'first'"/></xsl:apply-templates>
</xsl:variable>
		<xsl:apply-templates select="." mode="formView.table.tableGroup.Header"><xsl:with-param name="tableGroup" select="msxsl:node-set($tableGroup)/*"/></xsl:apply-templates>
		<xsl:element name="tbody" use-attribute-sets="gridView.datatable.table.tbodyGroup">
			<xsl:apply-templates select=".|following-sibling::*[string(*[@groupByColumn='true']/@value)=string(current()/*[@groupByColumn='true']/@value) and not(preceding-sibling::*[number(@rowNumber)>=number($currentRowNumber)][string(*[@groupByColumn='true']/@value)!=string(current()/*[@groupByColumn='true']/@value)])]" mode="formView.table.tbody.row.Template"/>
		<!-- <xsl:apply-templates select="." mode="formView.table.tableGroup.Footer"><xsl:with-param name="tableGroup" select="msxsl:node-set($tableGroup)/*"/></xsl:apply-templates> -->
		</xsl:element>
</xsl:template>


<xsl:template match="*" mode="formView.fieldSet.headerRow.Template">
	<tr class="fieldSetHeader"><xsl:apply-templates select="." mode="formView.fieldSet.headerRow.Wrapper" /></tr>
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.fieldSet.headerRow.header.Template">
	<th colspan="{count(.|./following-sibling::*[key('visibleFields',@fieldId)][not(@Column_Name=ancestor-or-self::*[@dataType='foreignTable'][1]/@foreignReference)][string(@fieldSet)=string(current()/@fieldSet)][not(preceding-sibling::*[number(@ordinalPosition)>number(current()/@ordinalPosition)][string(@fieldSet)!=string(current()/@fieldSet)])])}" style="border:1pt white solid;"><xsl:apply-templates select="." mode="formView.fieldSet.headerRow.header.Wrapper" /></th>
</xsl:template>

<xsl:template match="*" mode="formView.fieldSet.headerRow.header.text.Template" >
<xsl:value-of select="$nbsp"/>
</xsl:template>

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
<xsl:template name="formView.fieldSet.footerRow">
	<xsl:param name="context" select="*"/>
	<tr class="fieldSetFooter"><xsl:apply-templates select="." mode="formView.rowNumber"><xsl:with-param name="rowType">headerRow</xsl:with-param></xsl:apply-templates><xsl:apply-templates select="$context" mode="formView.fieldSet.footerRow.footer"/></tr>
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.fieldSet.footerRow.footer">
	<th style="border:1pt white solid;"><xsl:attribute name="colspan"><xsl:call-template name="formView.fieldSet.colspan"/></xsl:attribute><xsl:apply-templates select="." mode="formView.fieldSet.footerRow.footer.Wrapper" /></th>
</xsl:template>

<xsl:template name="formView.fieldSet.colspan"><xsl:value-of select="count(.|./following-sibling::*[key('visibleFields',@fieldId)][not(@Column_Name=ancestor-or-self::*[@dataType='foreignTable'][1]/@foreignReference)][string(@fieldSet)=string(current()/@fieldSet)][not(preceding-sibling::*[number(@ordinalPosition)>number(current()/@ordinalPosition)][string(@fieldSet)!=string(current()/@fieldSet)])])"/></xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.fieldSet.footerRow.footer.Wrapper">
	<xsl:value-of select="$nbsp"/>
</xsl:template>

<xsl:template name="formView.fieldSet.fieldFooterRow">
	<xsl:param name="context" select="*"/>
	<tr><xsl:apply-templates select="$context" mode="formView.fieldSet.fieldFooterRow.footer"/></tr>
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.fieldSet.fieldFooterRow.footer"><!-- Footer (<xsl:value-of select="position()"/> vs <xsl:value-of select="count(preceding-sibling::*[@mode!='hidden' and not(@controlType='tab') and not(@Column_Name=ancestor-or-self::*[@dataType='foreignTable'][1]/@foreignReference)])"/>):  -->
	<th style="border:1pt white solid;"><xsl:apply-templates select="." mode="formView.fieldSet.field.footer.Wrapper"/></th>
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.fieldSet.field.footer.Wrapper">
	<xsl:value-of select="$nbsp"/>
</xsl:template>
<!-- Footer -->
<xsl:template match="*[@dataType='table']" mode="formView.table.thead.header.Template">
	<xsl:element name="tr">
		<xsl:apply-templates select="." mode="formView.table.thead.header.Wrapper" />
	</xsl:element>
</xsl:template>

<xsl:template match="*[@dataType='table']" mode="formView.table.tfoot.Template">
	<xsl:if test="@showFooter=1 or @showFooter='true'">
		<xsl:element name="tfoot">
			<xsl:apply-templates select="." mode="formView.table.tfoot.Wrapper" />
		</xsl:element>
	</xsl:if>
</xsl:template>

<xsl:template match="*[@dataType='table']" mode="formView.table.tfoot.footer.Template">
	<xsl:element name="tr">
		<xsl:apply-templates select="." mode="formView.table.tfoot.footer.Wrapper" />
	</xsl:element>
</xsl:template>

<xsl:template match="*[@dataType='table']/px:data/px:dataRow" mode="formView.table.tbody.row.Template">
	<xsl:element name="tr" use-attribute-sets="gridView.datatable.tr"> 
		<xsl:apply-templates select="." mode="formView.table.tbody.row.Wrapper" />
	</xsl:element>
</xsl:template>

<xsl:template match="*" mode="formView.table.thead.header.fields.Template">
	<xsl:element name="th">
		<xsl:attribute name="class">
			<xsl:text> dataColumn </xsl:text>
			<xsl:choose>
				<xsl:when test="position() mod 2 = 1"> alt</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="position()=1"> first</xsl:when>
				<xsl:when test="position()=last()"> last</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="colspan"><xsl:value-of select="container/@colspan" /></xsl:attribute>
		<xsl:apply-templates select="." mode="headerText"></xsl:apply-templates><!-- 
		(<xsl:value-of select="position()"/>) -->
	</xsl:element>
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="formView.table.tbody.row.fields.Template">
	<xsl:element name="td">
		<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="position() mod 2 = 1">dataColumn</xsl:when>
					<xsl:otherwise>dataColumn alt</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<!-- following: <xsl:value-of select="count(../following-sibling::*/*[name(.)=name(current()) and @mode!='hidden']|current()[@mode!='hidden'])"/> -->
			<xsl:apply-templates select="." mode="fieldContainer" />
	</xsl:element>
</xsl:template>
				
<xsl:template match="*[@dataType='table']/px:data/px:dataRow/*" mode="formView.table.tfoot.footer.fields.Template">
	<xsl:element name="th">
		<xsl:apply-templates select="." mode="formView.table.tfoot.footer.fields.Wrapper" />
	</xsl:element>
</xsl:template>

<xsl:template match="*[@dataType='table']/px:data/px:dataRow/*" mode="formView.table.tfoot.footer.fields.field.Template">
<xsl:choose>
	<xsl:when test="@dataType='money'"><xsl:call-template name="formatCurrency"><xsl:with-param name="currency" select="sum(../following-sibling::*/*[name(.)=name(current())][@value!='']/@value | ../*[name(.)=name(current())][@value!='']/@value)"/></xsl:call-template></xsl:when>	
	<xsl:otherwise></xsl:otherwise>
</xsl:choose>
</xsl:template>

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
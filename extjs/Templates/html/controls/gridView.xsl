<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns="http://www.w3.org/TR/xhtml1/strict"
	xmlns:extjs="urn:extjs"
	xmlns:px="urn:panax"
>
<xsl:output omit-xml-declaration="yes"/>
<xsl:strip-space elements="*"/>

<xsl:template match="*" mode="gridView.group.Header">Grupo: {name}</xsl:template>

<xsl:template match="*[@dataType='table']" mode="gridView.table.Template">
Ext.define('Px.<xsl:value-of select="@dbId"/>.<xsl:value-of select="@xml:lang"/>.<xsl:value-of select="@Table_Schema"/>.<xsl:value-of select="@Table_Name"/>.<xsl:value-of select="@mode"/>.<xsl:value-of select="@controlType"/>', { 
extend: 'Ext.container.Container'
<!-- 	onDestroy: function() {
		alert('destroyed grid');
	}, -->
, filters: "<xsl:value-of select="@filters" />"
, showDockPanel: true
, showDetailsButton: true
, showAddButton: true
, showDeleteButton: true
, showPagingToolbar: true
, pageSize: <xsl:choose><xsl:when test="@pageSize"><xsl:value-of select="@pageSize" /></xsl:when><xsl:otherwise>undefined</xsl:otherwise></xsl:choose>
, initComponent: function() { 
	var me = this; 
	
	<xsl:apply-templates select="." mode="Model"/>

<!-- <xsl:call-template name="localData" /> -->
<!--     Ext.ux.ajax.SimManager.init({
        delay: 300,
        defaultSimlet: null
    }).register({
        'myData': {
            data: [
                ['small', 'small'],
                ['medium', 'medium'],
                ['large', 'large'],
                ['extra large', 'extra large']
            ],
            stype: 'json'
        }
    }); -->
	var win;
    var url = {
        local:  'localData',//'temp_data.js',  // static data file
        remote: '../templates/request.asp'
    };

    // configure whether filter query is encoded or not (initially)
    var encode = false;
    
    // configure whether filtering is performed locally or remotely (initially)
    var local = false;
	showSummary = false;

	var editAction = Ext.create('Ext.Action', {
        icon: '../../../../resources/extjs/extjs-current/examples/simple-tasks/resources/images/edit_task.png'
        , text: 'Editar registro'
        , disabled: false
        , handler: function(widget, event) {
            var record = grid.normalGrid.getView().getSelectionModel().getSelection()[0]
            if (record) {
                var win = Ext.create('widget.window', {
					title: 'Editar registro'
					, itemId: 'modalWindow'
					, modal: true
					, closable: true
					//, closeAction: 'hide'
					, width: 800
					, minWidth: 350
					, height: 600
					, layout: {
						type: 'fit'
						, padding: 5
					}
				});
				var container=win;
				//win.animateTarget=widget.getEl();
        
				win.show();
				//var myMask = new Ext.LoadMask(container, {msg:"Cargando..."});
				//myMask.show();
				var instance={
					catalogName: '<xsl:value-of select="@Table_Schema" />.<xsl:value-of select="@Table_Name" />',
					mode:'edit'
				}
		
				var content = Panax.getInstance(instance, {identity: record.getId()});
				if (content) {
<xsl:text disable-output-escaping="yes"><![CDATA[ 
					if (container.items.length>0) { 
						container.remove(0);
					}
]]></xsl:text>
					container.add(content);
				}
				//content.loadRecord(record.getId());
				//myMask.hide();

<!-- 				container=win;
				
				Ext.Ajax.request({
					url: '../Templates/request.asp'
					, method: 'GET'
					, params: {
						catalogName: "<xsl:value-of select="@Table_Schema" />.<xsl:value-of select="@Table_Name" />"
						, filters: "<xsl:value-of select="@identityKey" />="+record.getId()
						, mode: "edit"
						, output: 'extjs'
					}
					, success: function(xhr) {
						container.remove(0);
						eval(xhr.responseText); // see discussion below
						//myMask.hide();
					}
					, failure: function() {
						//myMask.hide();
						Ext.Msg.alert("Error de comunicación", "La conexión con el servidor falló, favor de intentarlo nuevamente en unos segundos.");
					}
				});	

				win.show(); -->
            }
        }
    });

	var detailsAction = Ext.create('Ext.Action', {
        icon: '../../../../resources/extjs/extjs-current/examples/simple-tasks/resources/images/edit_task.png'
        , text: 'Ver registro'
        , disabled: false
        , handler: function(widget, event) {
            var record = grid.normalGrid.getView().getSelectionModel().getSelection()[0]
            if (record) {
                var win = Ext.create('widget.window', {
					title: 'Ficha'
					, itemId: 'modalWindow'
					, modal: true
					, closable: true
					//, closeAction: 'hide'
					, width: 800
					, minWidth: 350
					, height: 600
					, layout: {
						type: 'fit'
						, padding: 5
					}
				});
				var container=win;
				//win.animateTarget=widget.getEl();
        
				win.show();
				//var myMask = new Ext.LoadMask(container, {msg:"Cargando..."});
				//myMask.show();
				var instance={
					catalogName: '<xsl:value-of select="@Table_Schema" />.<xsl:value-of select="@Table_Name" />',
					mode:'readonly',
					controlType: 'formView'
				}
		
				var content = Panax.getInstance(instance, {identity: record.getId()});
				if (content) {
<xsl:text disable-output-escaping="yes"><![CDATA[ 
					if (container.items.length>0) { 
						container.remove(0);
					}
]]></xsl:text>
					container.add(content);
				}
				//content.loadRecord(record.getId());
				//myMask.hide();

<!-- 				container=win;
				
				Ext.Ajax.request({
					url: '../Templates/request.asp'
					, method: 'GET'
					, params: {
						catalogName: "<xsl:value-of select="@Table_Schema" />.<xsl:value-of select="@Table_Name" />"
						, filters: "<xsl:value-of select="@identityKey" />="+record.getId()
						, mode: "edit"
						, output: 'extjs'
					}
					, success: function(xhr) {
						container.remove(0);
						eval(xhr.responseText); // see discussion below
						//myMask.hide();
					}
					, failure: function() {
						//myMask.hide();
						Ext.Msg.alert("Error de comunicación", "La conexión con el servidor falló, favor de intentarlo nuevamente en unos segundos.");
					}
				});	

				win.show(); -->
            }
        }
    });

    var contextMenu = Ext.create('Ext.menu.Menu', {
        items: [detailsAction, editAction]
    });
	
    var ajaxStore = Ext.create('Panax.custom.AjaxStore', {
        autoLoad: true
        , autoSync: true
        , autoDestroy: true
        , pageSize: me.pageSize
        , defaultPageSize: <xsl:choose><xsl:when test="@pageSize"><xsl:value-of select="@pageSize" /></xsl:when><xsl:otherwise>null</xsl:otherwise></xsl:choose>
        , remoteSort: true
        , model: "<xsl:apply-templates select="." mode="modelName"/>"
		<xsl:if test="*[@groupByColumn='true'] or 1=0">, groupField: 'IdVendedor',//'<xsl:value-of select="*[@groupByColumn='true'][1]/@Column_Name"/>'</xsl:if>
        , settings: {
			catalogName: "<xsl:value-of select="@Table_Schema" />.<xsl:value-of select="@Table_Name" />"
			//, filters: !me.identity?"0=0":"[<xsl:value-of select="@identityKey" />]="+me.identity<!-- "<xsl:value-of select="@filters" />" -->
			, identityKey: "<xsl:value-of select="@identityKey" />"
			, primaryKey: "<xsl:value-of select="@primaryKey" />"
			, mode: "<xsl:value-of select="@mode" />"
			, filters: this.filters
			, lang: "<xsl:value-of select="@xml:lang" />"
		}
		, listeners: {
<xsl:text disable-output-escaping="yes"><![CDATA[ 
			beforeload: function(store, operation, eOpts){
				var view = grid.normalGrid;
/* 				if (view && !view.waitingMessage) {
					view.waitingMessage = new Ext.LoadMask(view, {msg:"Cargando..."});
					view.waitingMessage.show();
				}*/
				if (grid.lockedGrid) grid.lockedGrid.mask()
			}
			, remove: function(store, record, index, eOpts){
				var view = grid.normalGrid;
				/*if (view && !view.waitingMessage) {
					view.waitingMessage = new Ext.LoadMask(view, {msg:"Eliminando..."});
					view.waitingMessage.show();
				}*/
				if (grid.lockedGrid) grid.lockedGrid.mask()
			}
			, load: function(store, records, successful, eOpts){
				var view = grid.normalGrid;
				if (grid.lockedGrid) grid.lockedGrid.unmask()
				/*if (view && view.waitingMessage) { view.waitingMessage.hide(); view.waitingMessage = undefined;}*/
			}
			, refresh: function(store, eOpts){
				var view = grid.normalGrid;
				if (grid.lockedGrid) grid.lockedGrid.unmask()
				/*if (view && view.waitingMessage) { view.waitingMessage.hide(); view.waitingMessage = undefined;}*/
			}
			, datachanged: function(store, eOpts) {
				var disableInsert = Boolean(store.proxy.reader.metaData.disableInsert);
				disableInsert = (disableInsert===false?false:(disableInsert || true));
				if (me.showAddButton && store.proxy.reader.metaData.supportsInsert!==undefined && !disableInsert) {
					grid.down('#insertButton').show();
				}
				grid.down('#insertButton').setDisabled(disableInsert);
			}
]]></xsl:text>
		}
    });

	
<!--     var store = Ext.create('Ext.data.Store', {
        autoLoad: true
        , autoSync: true
        , autoDestroy: true
        , pageSize: <xsl:value-of select="@pageSize" />
        , defaultPageSize: <xsl:value-of select="@pageSize" />
        , remoteSort: true
        , model: "<xsl:value-of select="@Table_Schema" />.<xsl:value-of select="@Table_Name" />"
		<xsl:if test="*[@groupByColumn='true'] or 1=0">, groupField: 'IdVendedor',//'<xsl:value-of select="*[@groupByColumn='true'][1]/@Column_Name"/>'</xsl:if>
        , proxy: {
            type: 'ajax'
			, api: {
				read: (local ? url.local : url.remote)
				, create: "../Scripts/update.asp"
				, update: "../Scripts/update.asp"
				, destroy: "../Scripts/update.asp"
			}
            , reader: {
                type: 'json'
                , root: 'data'
                , successProperty: 'success'
                , messageProperty: 'message'
                , totalProperty: 'total'
            }
			, writer: {
				type: 'xml'
                , writeAllFields: false
                , root: 'data'				
            }
			, pageParam: 'pageIndex'
			, limitParam: 'pageSize'
			, sortParam: 'sorters'
			, extraParams: {
				catalogName: "<xsl:value-of select="@Table_Schema" />.<xsl:value-of select="@Table_Name" />"
				, filters: "<xsl:value-of select="@filters" />"
				, identityKey: "<xsl:value-of select="@identityKey" />"
				, primaryKey: "<xsl:value-of select="@primaryKey" />"
				, mode: 'readonly'
				, output: 'json'
			}
			, listeners: {
				write: function(proxy, operation){
					if (operation.action == 'destroy') {
						main.child('#form').setActiveRecord(null);
					}
					Ext.example.msg(operation.action, operation.resultSet.message);
				}
				, exception: function(proxy, response, operation){
					//alert(response.responseText)
                    Ext.MessageBox.show({
                        title: 'RESPUESTA DEL SERVIDOR'
                        , msg: operation.getError()
                        , icon: Ext.MessageBox.ERROR
                        , buttons: Ext.Msg.OK
                    });
					var view = grid.normalGrid;
					if (view.waitingMessage) view.waitingMessage.hide();
					if (grid.lockedGrid) grid.lockedGrid.unmask()
                }
            }
        }
		, listeners: {
<xsl:text disable-output-escaping="yes"><![CDATA[ 
			beforeload: function(){
				var view = grid.normalGrid;
				if (view && !view.waitingMessage) {
					view.waitingMessage = new Ext.LoadMask(view, {msg:"Cargando..."});
					view.waitingMessage.show();
				}
				if (grid.lockedGrid) grid.lockedGrid.mask()
			}
			, remove: function(store, record, index, eOpts){
				var view = grid.normalGrid;
				if (view && !view.waitingMessage) {
					view.waitingMessage = new Ext.LoadMask(view, {msg:"Eliminando..."});
					view.waitingMessage.show();
				}
				if (grid.lockedGrid) grid.lockedGrid.mask()
			}
			, load: function(){
				var view = grid.normalGrid;
				if (grid.lockedGrid) grid.lockedGrid.unmask()
				if (view && view.waitingMessage) { view.waitingMessage.hide(); view.waitingMessage = undefined;}
			}
			, refresh: function(){
				var view = grid.normalGrid;
				if (grid.lockedGrid) grid.lockedGrid.unmask()
				if (view && view.waitingMessage) { view.waitingMessage.hide(); view.waitingMessage = undefined;}
			}
]]></xsl:text>
		}
    }); -->

    var filters = {
        ftype: 'filters'
        // encode and local configuration options defined previously for easier reuse
        , encode: encode // json encode the filter query
        , local: local   // defaults to false (remote filtering)
		, menuFilterText: "Filtros"
    };

<xsl:text disable-output-escaping="yes"><![CDATA[ 
   //The following functions are used to get the sorting data from the toolbar and apply it to the store
    /**
     * Tells the store to sort itself according to our sort data
     */
    function doSort() {
        ajaxStore.sort(getSorters());
    }

    /**
     * Callback handler used when a sorter button is clicked or reordered
     * @param {Ext.Button} button The button that was clicked
     * @param {Boolean} changeDirection True to change direction (default). Set to false for reorder
     * operations as we wish to preserve ordering there
     */
    function changeSortDirection(button, changeDirection) {
        var sortData = button.sortData
		, iconCls  = button.iconCls;
        
        if (sortData) {
            if (changeDirection !== false) {
                button.sortData.direction = Ext.String.toggle(button.sortData.direction, "ASC", "DESC");
                button.setIconCls(Ext.String.toggle(iconCls, "sort-asc", "sort-desc"));
            }
            ajaxStore.clearFilter();
            doSort();
        }
    }

    /**
     * Returns an array of sortData from the sorter buttons
     * @return {Array} Ordered sort data from each of the sorter buttons
     */
    function getSorters() {
        var sorters = [];
 
        Ext.each(tbar.query('button'), function(button) {
            sorters.push(button.sortData);
        }, this);

        return sorters;
    }

    /**
     * Convenience function for creating Toolbar Buttons that are tied to sorters
     * @param {Object} config Optional config object
     * @return {Object} The new Button configuration
     */
    function createSorterButtonConfig(config) {
        config = config || {};
        Ext.applyIf(config, {
            xtype: 'button'
            , listeners: {
                click: function(button, e) {
                    changeSortDirection(button, true);
                }
            }
            , iconCls: 'sort-' + config.sortData.direction.toLowerCase()
            , reorderable: true
        });
        return config;
    }

    var reorderer = Ext.create('Ext.ux.BoxReorderer', {
        listeners: {
            scope: this
            , Drop: function(r, c, button) { //update sort direction when button is dropped
                changeSortDirection(button, false);
            }
        }
    });

    var droppable = Ext.create('Ext.ux.ToolbarDroppable', {
        /**
         * Creates the new toolbar item from the drop event
         */
        createItem: function(data) {
            var header = data.header
			, headerCt = header.ownerCt
			, reorderer = headerCt.reorderer;
            
            // Hide the drop indicators of the standard HeaderDropZone
            // in case user had a pending valid drop in 
            if (reorderer) {
                reorderer.dropZone.invalidateDrop();
            }

            return createSorterButtonConfig({
                text: header.text
                , sortData: {
                    property: header.dataIndex
                    , direction: "ASC"
                }
            });
        }
		
        /**
         * Custom canDrop implementation which returns true if a column can be added to the toolbar
         * @param {Object} data Arbitrary data from the drag source. For a HeaderContainer, it will
         * contain a header property which is the Header being dragged.
         * @return {Boolean} True if the drop is allowed
         */
        , canDrop: function(dragSource, event, data) {
            var sorters = getSorters()
			, header  = data.header
			, length = sorters.length
			, entryIndex = this.calculateEntryIndex(event)
			, targetItem = this.toolbar.getComponent(entryIndex)
			, i;

            // Group columns have no dataIndex and therefore cannot be sorted
            // If target isn't reorderable it could not be replaced
            if (!header.dataIndex || (targetItem && targetItem.reorderable === false)) {
                return false;
            }

            for (i = 0; i < length; i++) {
                if (sorters[i].property == header.dataIndex) {
                    return false;
                }
            }
            return true;
        }
		
        , afterLayout: doSort
    });

]]></xsl:text>

    // use a factory method to reduce code while demonstrating
    // that the GridFilter plugin may be configured with or without
    // the filter types (the filters may be specified on the column model
    var createColumns = function (finish, start) {
        var columns = [<!--, {header:'image'renderer:<xsl:call-template name="logo" />},--><!-- <xsl:call-template name="gridView.columns.rowNumber"/>, --><xsl:if test="@identityKey">{
            xtype: 'actioncolumn'
            , text: ''
            , width: 40
            <!-- , menuDisabled: true -->
			, tooltip: 'Editar'
            , align: 'center'
			, locked: false
			, hideable: false
			, hidden: !me.showDetailsButton
            , icon: '../../../../resources/extjs/extjs-current/examples/simple-tasks/resources/images/edit_task.png'
            , handler: function(grid, rowIndex, colIndex, actionItem, event, record, row) {
				var win = Ext.create('widget.window', {
					title: 'Editar registro'
					, itemId: 'modalWindow'
					, modal: true
					, closable: true
					//, closeAction: 'hide'
					, width: 1000
					, minWidth: 350
					, height: 600
					, opener: record
					, layout: {
						type: 'fit'
						, padding: 5
					}
				});
				var instance={
					dbId: '<xsl:value-of select="@dbId" />'
					,catalogName: '<xsl:value-of select="@Table_Schema" />.<xsl:value-of select="@Table_Name" />'
					,lang: '<xsl:value-of select="@xml:lang" />'
					,mode:'edit'
				}
		
				var content = Panax.getInstance(instance, {identity: record.getId()});
				if (content) {
					var container=win;
<xsl:text disable-output-escaping="yes"><![CDATA[ 
					if (container.items.length>0) { 
						container.remove(0);
					}
]]></xsl:text>
					container.add(content);
					container.show();
					container.animateTarget=row; // La animación tiene que hacerse después de que se abre, de lo contrario la máscara de "cargando" no se muestra correctamente. TODO: Corregir
					//var myMask = new Ext.LoadMask(container, {msg:"Cargando..."});
					//myMask.show();
					//myMask.hide();
				}
				else {
					//Ext.Msg.alert("Mensaje del servidor", "No se pudo recuperar el módulo");
				}

            }
        },</xsl:if> <xsl:apply-templates select="px:fields/*[1=1 or not(@dataType='junctionTable' or @dataType='foreignTable')][not(@dataType='identity')]" mode="gridView.columns.column"/>
<!--/*grid/array-grid.html*/ <xsl:text disable-output-escaping="yes"><![CDATA[ 
            {
                menuDisabled: true
                , sortable: false
                , xtype: 'actioncolumn'
                , width: 50
                , items: [{
                    icon   : '../../../../resources/extjs/extjs-current/examples/shared/icons/fam/delete.gif' // Use a URL in the icon config
                    , tooltip: 'Sell stock'
                    , handler: function(grid, rowIndex, colIndex) {
                        var rec = ajaxStore.getAt(rowIndex);
                        alert("Sell " + rec.get('company'));
                    }
                }, {
                    getClass: function(v, meta, rec) {          // Or return a class from a function
                        if (rec.get('change') < 0) {
                            this.items[1].tooltip = 'Hold stock';
                            return 'alert-col';
                        } else {
                            this.items[1].tooltip = 'Buy stock';
                            return 'buy-col';
                        }
                    }
                    , handler: function(grid, rowIndex, colIndex) {
                        var rec = ajaxStore.getAt(rowIndex);
                        alert((rec.get('change') < 0 ? "Hold " : "Buy ") + rec.get('company'));
                    }
                }]
            } 
]]></xsl:text> -->
		];
        return columns.slice(start || 0, finish);
    };
    
    //create the toolbar with the 2 plugins
    var tbar = Ext.create('Ext.toolbar.Toolbar', {
        hidden:!me.showDockPanel
        , items  : [{
			xtype: 'tbtext'
            , text: 'Ordenar por:'
            , reorderable: false
        } <!-- createSorterButtonConfig({
            text: 'Nombre Prospecto'
            , sortData: {
                property: 'NombreProspecto'
                , direction: 'ASC'
            }
        }), createSorterButtonConfig({
            text: 'Apellido Paterno'
            , sortData: {
                property: 'ApellidoPaterno'
                , direction: 'ASC'
            }
        })-->]
        , plugins: [reorderer, droppable]
    });

    var grid = Ext.create('Ext.grid.Panel', {
		tbar: tbar
        , border: false
        , store: ajaxStore
        , columns: createColumns()<!--[{columns: createColumns(2)}, { text: "Grouped", columns: createColumns(6,3)}, {columns: createColumns(20,7)}]-->
        , loadMask: true
        , columnLines: true
        , loadMask: true
        , emptyText: 'No Matching Records'
	    , selModel: Ext.create('Ext.selection.<xsl:choose>
	<xsl:when test="@enableCheckboxModel='true'">CheckboxModel</xsl:when>
	<xsl:otherwise>RowModel</xsl:otherwise>
</xsl:choose>', {
	        listeners: {
	            selectionchange: function(sm, selections) {
	                grid.down('#removeButton').setDisabled(selections.length == 0);
	            }
	        }
	    })
        , viewConfig: { 
			stripeRows: true, 
			listeners: {
				itemcontextmenu: function(view, rec, node, index, e) {
					e.stopEvent();
					contextMenu.showAt(e.getXY());
					return false;
				}
			}
		}
		<!-- plugins: [Ext.create('Ext.grid.plugin.CellEditing', {
        		clicksToEdit: 2
    		})], -->
        , features: [filters, {
            id: 'group'
            , ftype: 'groupingsummary'
            , groupHeaderTpl: "<xsl:apply-templates select="." mode="gridView.group.Header" />" 
            , hideGroupedHeader: false
            , enableGroupingMenu: false
			, showSummaryRow: showSummary
        }]
        , listeners: {
            scope: this
            // wait for the first layout to access the headerCt (we only want this once):
            , single: true
            // tell the toolbar's droppable plugin that it accepts items from the columns' dragdrop group
            , afterlayout: function(grid) {
                <!-- var headerCt = grid.normalGrid.child("headercontainer");
                droppable.addDDGroup(headerCt.reorderer.dragZone.ddGroup);
                doSort(); -->
            } 
			, beforeedit: function (e) { 
				alert("disabled?")
				if (e.record.get('disabled')) { return false; }
			}
        }
        , dockedItems: [
		{
            xtype: 'toolbar'
			, hidden: !me.showDockPanel
            , items: [{
                itemId: 'insertButton'
				, hidden: true
				, disabled: true
                , text:'Nuevo Registro'
                , tooltip:'Agregar nuevo registro'
                , iconCls:'add'
                , handler: function() {
					var win = Ext.create('widget.window', {
						title: 'Nuevo registro'
						, itemId: 'modalWindow'
						, modal: true
						, closable: true
						//, closeAction: 'hide'
						, width: 800
						, minWidth: 350
						, height: 600
						, opener: grid
						, layout: {
							type: 'fit'
							, padding: 5
						}
					});
					
					var instance={
						catalogName: '<xsl:value-of select="@Table_Schema" />.<xsl:value-of select="@Table_Name" />',
						mode:'insert'
					}
					var content = Panax.getInstance(instance);
					if (content) {
						win.animateTarget=this.getEl();
						var container=win;
<xsl:text disable-output-escaping="yes"><![CDATA[ 
						if (container.items.length>0) { 
							container.remove(0);
						}
]]></xsl:text>
						container.add(content);
						win.show();	
						//content.loadRecord(null);
					} else {
						//Ext.Msg.alert('Mensaje del sistema', 'No se pudo abrir')
					}
<!-- 					container=win;
					//myMask.show();
					//var myMask = new Ext.LoadMask(container, {msg:"Cargando..."}); -->
					<!-- Ext.Ajax.request({
						url: '../Templates/request.asp'
						, method: 'GET'
						, params: {
							catalogName: "<xsl:value-of select="@Table_Schema" />.<xsl:value-of select="@Table_Name" />"
							, mode: "insert"
							, output: 'extjs'
						}
						, success: function(xhr) {
							container.remove(0);
							eval(xhr.responseText); // see discussion below
							//myMask.hide();
						}
						, failure: function() {
							//myMask.hide();
							Ext.Msg.alert("Error de comunicación", "La conexión con el servidor falló, favor de intentarlo nuevamente en unos segundos.");
						}
					});	 -->

				}
            }, '-', {
                text:'Opciones'
                , tooltip:'Escoger otras opciones'
                , iconCls:'option'
                <!-- disabled: true, -->
				, menu: {
					items: [{
							text: 'Limpiar filtros'
							, handler: function () {
								grid.normalGrid.filters.clearFilters();
							} 
						}
					]
				}
            },'-',{
                itemId: 'removeButton'
				, hidden: !me.showDeleteButton
                , text:'Eliminar'
                , tooltip:'Eliminar elementos seleccionados'
                , iconCls:'remove'
                , disabled: true
                , handler: function() { 
					grid.onDeleteClick() 
				}
            }<!-- ,'-',{
                tooltip: 'Activar/Desactivar resumen'
                , text: 'Resumen'
                , handler: function(){
                    showSummary = !showSummary;
                    var view = grid.lockedGrid.getView();
                    view.getFeature('group').toggleSummaryRow(showSummary);
                    view.refresh();
                    view = grid.normalGrid.getView();
                    view.getFeature('group').toggleSummaryRow(showSummary);
                    view.refresh();
                }
			} -->]
        }, 
		Ext.create('Ext.PagingToolbar', {
            dock: 'bottom'
            , store: ajaxStore
			, displayInfo: true
            , plugins: Ext.create('Ext.ux.ProgressBarPager', {})
			, hidden: !this.showPagingToolbar
        })]
        , emptyText: 'No se encontraron coincidencias'
		
		, onSync: function(){
			this.store.sync();
		}
		
		, onDeleteClick: function(){
			var selection = this.normalGrid.getView().getSelectionModel().getSelection()[0];
			var store = this.store;
			if (selection) {
				Ext.MessageBox.confirm('BORRAR FORMULARIO', 'Confirma que desea borrar el registro?', function(result){
					if (result=="yes") store.remove(selection);
					//selection.set('forDeletion', true);
				});
			}
		}
		
		, onAddClick: function(){
			alert('add')
			<!-- var rec = new Writer.Person({
				first: ''
				, last: ''
				, email: ''
			}), edit = this.editing;

			edit.cancelEdit();
			this.store.insert(0, rec);
			edit.startEditByPosition({
				row: 0
				, column: 1
			}); -->
		}
    });

    <!-- grid.child('pagingtoolbar').add([
        <xsl:text disable-output-escaping="yes"><![CDATA['->']]> </xsl:text>
        , {
            text: 'Encode: ' + (encode ? 'On' : 'Off')
            , tooltip: 'Toggle Filter encoding on/off'
            , enableToggle: true
            , handler: function (button, state) {
                var encode = (grid.normalGrid.filters.encode !== true);
                var text = 'Encode: ' + (encode ? 'On' : 'Off'); 
                grid.normalGrid.filters.encode = encode;
                grid.normalGrid.filters.reload();
                button.setText(text);
            } 
        }
        , {
            text: 'Local Filtering: ' + (local ? 'On' : 'Off')
            , tooltip: 'Toggle Filtering between remote/local'
            , enableToggle: true
            , handler: function (button, state) {
                var local = (grid.normalGrid.filters.local !== true)
				, text = 'Local Filtering: ' + (local ? 'On' : 'Off')
				, newUrl = local ? url.local : url.remote
				, store = grid.normalGrid.getView().getStore();
                 
                // update the GridFilter setting
                grid.normalGrid.filters.local = local;
                // bind the store again so GridFilters is listening to appropriate store event
                grid.normalGrid.filters.bindStore(store);
                // update the url for the proxy
                store.proxy.url = newUrl;

                button.setText(text);
                store.load();
            } 
        }
        , {
            text: 'All Filter Data'
            , tooltip: 'Get Filter Data for Grid'
            , handler: function () {
                var data = Ext.encode(grid.normalGrid.filters.getFilterData());
                Ext.Msg.alert('All Filter Data',data);
            } 
        },{
            text: 'Clear Filter Data'
            , handler: function () {
                grid.normalGrid.filters.clearFilters();
            } 
        },{
            text: 'Add Columns'
			<xsl:text disable-output-escaping="yes"><![CDATA[ 
            , handler: function () {
                if (grid.normalGrid.headerCt.items.length < 6) {
                    grid.normalGrid.headerCt.add(createColumns(6, 4));
                    grid.normalGrid.view.refresh();
                    this.disable();
                }
            }
]]> 
</xsl:text>
        }
    ]); -->
		Ext.apply(me, { 
			layout: 'fit',
			items: [grid]
		});
		me.grid = grid;
		me.callParent(arguments); 
	}
})

</xsl:template>

<xsl:template match="*[@dataType='table']" mode="Data">data</xsl:template>

<xsl:template match="px:fields/*|px:fields/*[@dataType='foreignKey']//*[@primaryKey][not(name(.)='px:data')]" mode="Model.fields">
<xsl:variable name="parentAssociation" select="ancestor::*[@dataType='junctionTable' or @dataType='foreignTable'][1]"/>
<xsl:if test="position()&gt;1">, </xsl:if>{name:'<xsl:if test="$parentAssociation"><xsl:value-of select="$parentAssociation/@Column_Name"/>.</xsl:if><xsl:value-of select="ancestor-or-self::*[@Column_Name][1]/@Column_Name"/><xsl:if test="not(@Column_Name)">_<xsl:value-of select="count(ancestor::*[@Column_Name][1]/descendant::*[not(name(.)='px:data')])-1"/></xsl:if>',fieldName:'<xsl:value-of select="@Column_Name"/>', <xsl:if test="@mode='readonly'">persist:false,</xsl:if> mapping:'<xsl:value-of select="ancestor-or-self::*[@Column_Name][1]/@Column_Name"/><xsl:choose><xsl:when test="@dataType='identity'"></xsl:when><xsl:when test="not(@Column_Name)"><xsl:for-each select="ancestor::*[@Column_Name][1]/descendant::*[not(name(.)='px:data')][not(@Column_Name) and not(../@Column_Name)]">.parent</xsl:for-each></xsl:when><xsl:when test="@dataType='junctionTable' or @dataType='foreignTable'">["data"]</xsl:when><xsl:otherwise>["value"]</xsl:otherwise></xsl:choose>'<!-- convert: convertField, --><xsl:choose>
	<xsl:when test="@dataType='bit'">, type: 'boolean'</xsl:when>
	<xsl:when test="@dataType='date' or @dataType='datetime' or @dataType='smalldatetime'">, type: 'date', dateFormat: 'd/m/Y'</xsl:when>
	<xsl:when test="@dataType='float' or @dataType='money' or @dataType='smallmoney' or @dataType='float' or @dataType='decimal'">, type: 'float', minValue: 0</xsl:when>
	<xsl:when test="@controlType"></xsl:when>
	<xsl:when test="@dataType='identity' or @dataType='int' or @dataType='smallint' or @dataType='tinyint'">, type: 'int', minValue: 0 /*no esta funcionando*/</xsl:when>
	<xsl:otherwise>/*<xsl:value-of select="@dataType"/>*/</xsl:otherwise>
</xsl:choose>
<xsl:if test="@isPrimaryKey=1">, isAlwaysSubmitable: true</xsl:if>
, useNull: true
}<!-- <xsl:if test="*[not(name(.)='px:data')]/*"><xsl:apply-templates select="*[not(name(.)='px:data')]" mode="Model.fields"/></xsl:if> -->
</xsl:template>

<xsl:template name="gridView.columns.rowNumber">
{
header: "#" 
, width: 30
, minWidth: 30 
, maxWidth: 40
, field: {xtype: 'displayfield'}
, locked:true
, menuDisabled: true
, hideable: false
, sortable: false 
, draggable: false
, groupable: false
, dataIndex: "rowNumber"
}
</xsl:template>

<xsl:template match="px:fields/*" mode="fieldFilters" priority="-1">"<xsl:value-of select="*/@filters"/>"</xsl:template>

<xsl:template match="px:fields/*" mode="gridView.columns.column">
<xsl:variable name="parentAssociation" select="ancestor::*[@dataType='junctionTable' or @dataType='foreignTable'][1]"/>
<xsl:if test="position()&gt;1">,</xsl:if>function () { 
var me = Ext.create('Ext.grid.column.Column', {
header: "<xsl:apply-templates select="." mode="headerText"/>"
, displayField: "text"
, displayValue: "value"
<xsl:if test="position()=last()">, flex:1</xsl:if>
<xsl:choose>
<xsl:when test="@dataType='foreignKey'">
, editor: new Ext.form.field.ComboBox({
	typeAhead: true
	, valueField: 'id'
	, displayField: 'text'
	, triggerAction: 'all'
	, forceSelection: true
	, selectOnTab: true
	, <xsl:apply-templates select="." mode="field.config"/>
	, store: Ext.create('Ext.data.Store', {
        fields: ['id', 'text']
		, autoLoad: false
        , proxy: {
            type: 'ajax'
            , url: '../Scripts/xmlCatalogOptions.asp'
            , reader: {
                type: 'json'
                , root: 'data'
                , successProperty: 'success'
                , messageProperty: 'message'
                , totalProperty: 'total'
                , idProperty: '<xsl:value-of select="@identityKey"/>'
            }
			, pageParam: 'pageIndex'
			, limitParam: 'pageSize'
			, sortParam: 'sorters'
			, extraParams: {
				catalogName: "<xsl:value-of select="*/@Table_Schema" />.<xsl:value-of select="*/@Table_Name" />"
				, filters: <xsl:apply-templates mode="fieldFilters" select="."/>
				, dataValue: "<xsl:value-of select="*/@dataValue" />"
				, dataText: "<xsl:value-of select="*/@dataText" />"
				<xsl:if test="*/@orderBy">, orderBy: "<xsl:value-of select="*/@orderBy" />"</xsl:if>
				, output: 'json'
			}
            , listeners: {
                exception: function(proxy, response, operation){
					var message = operation.getError();
					message = Ext.isObject(message)?message["error"]:message;
					Ext.MessageBox.show({
						title: 'ERROR!',
						msg: message,
						icon: Ext.MessageBox.ERROR,
						buttons: Ext.Msg.OK
					});
                }
            }
        }
    })
	, lazyRender: false
	, listClass: 'x-combo-list-small'
	})
</xsl:when>
<xsl:otherwise>
, field: {
	xtype: '<xsl:apply-templates select="." mode="controlType"/>'
	<xsl:if test="@dataType='date' or @dataType='datetime' or @dataType='smalldatetime'"> , format: 'd/m/Y' <!--  disabled: true, submitValue: false, suspendCheckChange: 1, --></xsl:if>
	<!-- <xsl:if test="@dataType='time'">,
              maskRe: '\d\d:\d\d Hrs.'</xsl:if> -->
	<!-- , editor: function(value) {
			return Ext.isObject(value)?value[this.displayField]:value;
		} -->
	<xsl:apply-templates mode="templates.field.allConfigs" select="."/>
	, <xsl:apply-templates select="." mode="field.config"/>
    }
</xsl:otherwise>
</xsl:choose>
<!-- width: 120,  -->
<xsl:if test="@lockColumn='true' or position()&lt;=1">
	<xsl:if test="not($parentAssociation)">, locked:false </xsl:if>
	, hideable: false
</xsl:if>
, filter: {updateBuffer: 1500, <xsl:choose><xsl:when test="@dataType='foreignKey'">type: 'list', dataIndex: "<xsl:value-of select="@Column_Name"/>", store: Ext.create('Ext.data.Store', {
        fields: ['id', 'text']
        , proxy: {
            type: 'ajax'
            , url: '../Scripts/xmlCatalogOptions.asp'
            , reader: {
                type: 'json'
                , root: 'data'
                , successProperty: 'success'
                , messageProperty: 'message'
                , totalProperty: 'total'
                , idProperty: '<xsl:value-of select="@identityKey"/>'
            }
			, pageParam: 'pageIndex'
			, limitParam: 'pageSize'
			, sortParam: 'sorters'
			, extraParams: {
				catalogName: "<xsl:value-of select="*/@Table_Schema" />.<xsl:value-of select="*/@Table_Name" />"
				, filters: "<xsl:value-of select="@filters" />"
				, dataValue: "<xsl:value-of select="*/@dataValue" />"
				, dataText: "<xsl:value-of select="*/@dataText" />"
				, output: 'json'
			<!-- "@param1": 'test', 
			"param2": 'test2' -->
			}
            , listeners: {
                exception: function(proxy, response, operation){
					var message = operation.getError();
					message = Ext.isObject(message)?message["error"]:message;
					Ext.MessageBox.show({
						title: 'ERROR!',
						msg: message,
						icon: Ext.MessageBox.ERROR,
						buttons: Ext.Msg.OK
					});
                }
            }
        }
    })
</xsl:when><xsl:when test="@dataType='date' or @dataType='datetime' or @dataType='smalldatetime'">menuItems : ['after', 'before', '-', 'on'], dateFormat: 'd/m/Y', beforeText: 'Antes de', afterText: 'Despues de', onText: 'Dia especifico'</xsl:when><xsl:otherwise>undefined:undefined</xsl:otherwise></xsl:choose>}
, sortable: true
, dataIndex: "<xsl:if test="$parentAssociation"><xsl:value-of select="$parentAssociation/@Column_Name"/>.</xsl:if><xsl:value-of select="@Column_Name"/>"
, renderer: <xsl:apply-templates select="." mode="gridView.column.renderer"/>
, <xsl:apply-templates select="." mode="gridView.columns.summary"/>
<xsl:apply-templates select="@extjs:*" mode="copyConfig"/>
})
return me;
}()
</xsl:template>

<xsl:template match="*" mode="gridView.column.renderer">function (value, metaData, record, row, col, store, gridView) { 
return Ext.isObject(value)?value[this.displayField]:value 
}</xsl:template>

<xsl:template match="*[@dataType='junctionTable' or @dataType='foreignTable']/*/px:fields/*" mode="gridView.foreignTable.tr.items">'+function(){var field=obj.<xsl:value-of select="@fieldName"/>; field=Ext.isObject(field)?(Ext.isObject(field.value)?field.value.text:field.value):field;return  Ext.isDate(field)? Ext.util.Format.date(field):field; }()+' - </xsl:template>

<xsl:template match="*[@dataType='junctionTable' or @dataType='foreignTable']" mode="gridView.column.renderer">function (value, metaData, record, row, col, store, gridView) { 
<xsl:text disable-output-escaping="yes"><![CDATA[ 
var html=''
Ext.Array.each(value, function(obj, index, thisArray) {
	html += '<li>]]></xsl:text><xsl:apply-templates select="*/px:fields/*[key('visibleFields',@fieldId)]" mode="gridView.foreignTable.tr.items"/><xsl:text disable-output-escaping="yes"><![CDATA[ </li>'
 });
if (html) html='<ol>'+html+'</ol>'
return html
}
]]></xsl:text></xsl:template>

<xsl:template match="*[@dataType='time']" mode="gridView.column.renderer">function (value, metaData, record, row, col, store, gridView) { 
return (Ext.isObject(value)? value["text"]:
		value?Panax.util.lPad(value.split(':')[0], 2, '0')+':'+Panax.util.lPad(value.split(':')[1], 2, '0')+' Hrs.':
		''
		)
}</xsl:template>

<xsl:template match="*[@dataType='bit']" mode="gridView.column.renderer">function (value, metaData, record, row, col, store, gridView) { 
return (value==true? 'Sí' : '')
}</xsl:template>

<xsl:template match="*[@dataType='date' or @dataType='datetime' or @dataType='smalldatetime']" mode="gridView.column.renderer">Ext.util.Format.dateRenderer('<xsl:apply-templates select="." mode="gridView.column.renderer.format"/>')</xsl:template>

<xsl:template match="*[@dataType='foreignKey']" mode="gridView.column.renderer">function(value, metaData, record, rowIndex, colIndex, store, view) {
	//editorStore
	value=Ext.isArray(value)?value[0]:value;
	return Ext.isObject(value)?value["text"]:value;
}</xsl:template>

<xsl:template match="*[@dataType='date' or @dataType='datetime' or @dataType='smalldatetime']" mode="gridView.column.renderer.format">d/m/Y</xsl:template>

<xsl:template match="*[@dataType='float' or @dataType='money' or @dataType='smallmoney' or (@dataType='float' or @dataType='decimal') and (@format='Money' or @format='money')]" mode="gridView.column.renderer">
function(value) {return value!=null? Ext.util.Format.usMoney(value) : null;}
</xsl:template>

<xsl:template name="logo" match="*[@controlType='image']" mode="gridView.column.renderer">
function(value) {
    return Ext.DomHelper.markup({
        tag : "img",
        src: "../../../../"+value,<!-- + (value == 4 ? 'tick' : 'cross') + '.png'-->
		width: 100
    })
}
</xsl:template>
	
<xsl:template match="*[@allowNegatives='true'][@controlType='numericField' or @controlType='default' and (
@dataType='int' or @dataType='tinyint' or (@dataType='float' or @dataType='decimal') and not(@format) or @dataType='real')]" mode="gridView.column.renderer">
<xsl:text disable-output-escaping="yes"><![CDATA[ 
function(val) {
	if (val > 0) {
		return '<span style="color:green;">' + val + '</span>';
	} else if (val < 0) {
		return '<span style="color:red;">' + val + '</span>';
	}
	return val;
}
]]></xsl:text></xsl:template>


<xsl:template match="*[@controlType='rangeSelector' or @controlType='RangeSelector']" mode="gridView.column.renderer"><xsl:text disable-output-escaping="yes"><![CDATA[ 
	function(rating){
		return Array(Math.ceil(rating) + 1).join('&#x272D;');
    }
]]></xsl:text></xsl:template>

<xsl:template match="px:fields/*" mode="gridView.columns.summary">
<xsl:choose>
	<xsl:when test="@summaryType='sum'">
        summaryType: 'sum'
       , renderer: function(value, metaData, record, rowIdx, colIdx, store, view){
           return value + ' hours';
       }
       , summaryRenderer: function(value, summaryData, dataIndex) {
           return value + ' hours';
       }
	</xsl:when>
	<xsl:otherwise>
		summaryType: 'count'
		, summaryRenderer: function(value, summaryData, dataIndex) {
		   <xsl:text disable-output-escaping="yes"> <![CDATA[ return ((value === 0 || value > 1) ? '(' + value + ' elementos)' : '(1 elemento)'); ]]> </xsl:text>
	    }
	</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="px:fields/*" mode="controlType">textfield</xsl:template>

<xsl:template match="px:fields/*[@dataType='date' or @dataType='datetime' or @dataType='smalldatetime']" mode="controlType">datefield</xsl:template>

<xsl:template match="px:fields/*[@dataType='time']" mode="controlType">timepicker</xsl:template>
<xsl:template match="px:fields/*[@dataType='bit']" mode="controlType">checkbox</xsl:template>

<xsl:template match="*[@dataType='table']" mode="gridView.table.thead.Template">
	<xsl:if test="not(@showHeader=0 or @showHeader='false')">
		<xsl:element name="thead">
			<xsl:apply-templates select="." mode="gridView.table.thead.tableHeader.Template" />
			<xsl:apply-templates select="." mode="gridView.table.thead.Wrapper" />
		</xsl:element>
	</xsl:if>
</xsl:template>

<xsl:template match="*[@dataType='table'][not(../@controlType='embeddedTable')]" mode="gridView.table.thead.tableHeader.Template">
	<xsl:call-template name="gridView.table.thead.tableHeader.Template.default"/>
</xsl:template>

<xsl:template name="gridView.table.thead.tableHeader.Template.default">
	<tr>
	<xsl:attribute name="class">tableHeader</xsl:attribute>
	<xsl:apply-templates select="fields[1]" mode="gridView.rowNumber"><xsl:with-param name="rowType" select="'footerRow'"/></xsl:apply-templates>
	<xsl:apply-templates select="data/dataRow[1]" mode="gridView.commandButtons"><xsl:with-param name="rowType" select="'footerRow'"/></xsl:apply-templates>
	<xsl:apply-templates select="fields[1]" mode="gridView.hiddenFields"><xsl:with-param name="rowType" select="'footerRow'"/></xsl:apply-templates>
	<th colspan="100" style="text-align:'left'; padding-left:15pt; padding-bottom:0pt;"><strong class="h2"><xsl:apply-templates select="." mode="headerText"/></strong></th></tr>
</xsl:template>

<xsl:template match="*[@dataType='table']/data/dataRow" mode="gridView.table.tbody.row.attributes">
</xsl:template>

<xsl:template match="*[@dataType='table']" mode="gridView.table.tbody.tableGroup.Template">
	<xsl:param name="tableGroup"/>
	<xsl:element name="tbody" use-attribute-sets="gridView.datatable.table.tbodyGroup">
		<xsl:apply-templates select="$tableGroup" mode="gridView.table.tbody.row.Template"><xsl:sort select="@rowNumber" data-type="number"/></xsl:apply-templates>
	</xsl:element>
</xsl:template>

<xsl:template match="*[@dataType='table']/data/dataRow" mode="gridView.table.tbody.columnGroup.Template">
		<xsl:variable name="currentRowNumber" select="@rowNumber"/>
		<xsl:variable name="tableGroup"><xsl:apply-templates select="*[@groupByColumn='true'][1]" mode="gridView.tableGroup"><xsl:with-param name="position" select="'first'"/></xsl:apply-templates>
</xsl:variable>
		<xsl:apply-templates select="." mode="gridView.table.tableGroup.Header"><xsl:with-param name="tableGroup" select="msxsl:node-set($tableGroup)/*"/></xsl:apply-templates>
		<xsl:element name="tbody" use-attribute-sets="gridView.datatable.table.tbodyGroup">
			<xsl:apply-templates select=".|following-sibling::*[string(*[@groupByColumn='true']/@value)=string(current()/*[@groupByColumn='true']/@value) and not(preceding-sibling::*[number(@rowNumber)>=number($currentRowNumber)][string(*[@groupByColumn='true']/@value)!=string(current()/*[@groupByColumn='true']/@value)])]" mode="gridView.table.tbody.row.Template"><xsl:sort select="@rowNumber" data-type="number"/></xsl:apply-templates>
		</xsl:element>
		<xsl:apply-templates select="." mode="gridView.table.tableGroup.Footer"><xsl:with-param name="tableGroup" select="msxsl:node-set($tableGroup)/*"/></xsl:apply-templates>
</xsl:template>

<xsl:template match="*[@dataType='table']/data/dataRow" mode="gridView.table.tbody.groupByHeader.Template">
	<xsl:variable name="currentRowNumber" select="@rowNumber"/>
		<xsl:variable name="tableGroup"><xsl:apply-templates select="." mode="gridView.tableGroup"><xsl:with-param name="position" select="'first'"/></xsl:apply-templates>
</xsl:variable>
		<xsl:apply-templates select="." mode="gridView.table.tableGroup.Header"><xsl:with-param name="tableGroup" select="msxsl:node-set($tableGroup)/*"/></xsl:apply-templates>
		<xsl:element name="tbody" use-attribute-sets="gridView.datatable.table.tbodyGroup">
			<xsl:apply-templates select=".|following-sibling::*[string(*[@groupByColumn='true']/@value)=string(current()/*[@groupByColumn='true']/@value) and not(preceding-sibling::*[number(@rowNumber)>=number($currentRowNumber)][string(*[@groupByColumn='true']/@value)!=string(current()/*[@groupByColumn='true']/@value)])]" mode="gridView.table.tbody.row.Template"><xsl:sort select="@rowNumber" data-type="number"/></xsl:apply-templates>
		<!-- <xsl:apply-templates select="." mode="gridView.table.tableGroup.Footer"><xsl:with-param name="tableGroup" select="msxsl:node-set($tableGroup)/*"/></xsl:apply-templates> -->
		</xsl:element>
</xsl:template>


<xsl:template match="*" mode="gridView.fieldSet.headerRow.Template">
	<tr class="fieldSetHeader"><xsl:apply-templates select="." mode="gridView.fieldSet.headerRow.Wrapper" /></tr>
</xsl:template>

<xsl:template match="data/dataRow/*" mode="gridView.fieldSet.headerRow.header.Template">
	<th colspan="{count(.|./following-sibling::*[@mode!='hidden' and not(@controlType='tab') and not(@Column_Name=ancestor-or-self::*[@dataType='foreignTable'][1]/@foreignReference)][string(@fieldSet)=string(current()/@fieldSet)][not(preceding-sibling::*[number(@ordinalPosition)>number(current()/@ordinalPosition)][string(@fieldSet)!=string(current()/@fieldSet)])])}" style="border:1pt white solid;"><xsl:apply-templates select="." mode="gridView.fieldSet.headerRow.header.Wrapper" /></th>
</xsl:template>

<xsl:template match="*" mode="gridView.fieldSet.headerRow.header.text.Template" >
<xsl:value-of select="$nbsp"/>
</xsl:template>

<xsl:template name="gridView.fieldSet.fieldHeaderRow">
	<xsl:param name="context" select="*"/>
	<tr><xsl:apply-templates select="." mode="gridView.rowNumber"><xsl:with-param name="rowType">headerRow</xsl:with-param></xsl:apply-templates><xsl:apply-templates select="$context" mode="gridView.fieldSet.fieldHeaderRow.header"/></tr>
</xsl:template>

<xsl:template match="data/dataRow/*" mode="gridView.fieldSet.fieldHeaderRow.header"><!-- Header (<xsl:value-of select="position()"/> vs <xsl:value-of select="count(preceding-sibling::*[@mode!='hidden' and not(@controlType='tab') and not(@Column_Name=ancestor-or-self::*[@dataType='foreignTable'][1]/@foreignReference)])"/>):  -->
	<th style="border:1pt white solid;"><xsl:apply-templates select="." mode="gridView.fieldSet.field.header.Wrapper"/></th>
</xsl:template>

<xsl:template match="data/dataRow/*" mode="gridView.fieldSet.field.header.Wrapper">
	<xsl:value-of select="@headerText"/>
</xsl:template>

<!-- Header - -->

<!-- Footer -->
<xsl:template name="gridView.fieldSet.footerRow">
	<xsl:param name="context" select="*"/>
	<tr class="fieldSetFooter"><xsl:apply-templates select="." mode="gridView.rowNumber"><xsl:with-param name="rowType">headerRow</xsl:with-param></xsl:apply-templates><xsl:apply-templates select="$context" mode="gridView.fieldSet.footerRow.footer"/></tr>
</xsl:template>

<xsl:template match="data/dataRow/*" mode="gridView.fieldSet.footerRow.footer">
	<th style="border:1pt white solid;"><xsl:attribute name="colspan"><xsl:call-template name="gridView.fieldSet.colspan"/></xsl:attribute><xsl:apply-templates select="." mode="gridView.fieldSet.footerRow.footer.Wrapper" /></th>
</xsl:template>

<xsl:template name="gridView.fieldSet.colspan"><xsl:value-of select="count(.|./following-sibling::*[@mode!='hidden' and not(@controlType='tab') and not(@Column_Name=ancestor-or-self::*[@dataType='foreignTable'][1]/@foreignReference)][string(@fieldSet)=string(current()/@fieldSet)][not(preceding-sibling::*[number(@ordinalPosition)>number(current()/@ordinalPosition)][string(@fieldSet)!=string(current()/@fieldSet)])])"/></xsl:template>

<xsl:template match="data/dataRow/*" mode="gridView.fieldSet.footerRow.footer.Wrapper">
	<xsl:value-of select="$nbsp"/>
</xsl:template>

<xsl:template name="gridView.fieldSet.fieldFooterRow">
	<xsl:param name="context" select="*"/>
	<tr><xsl:apply-templates select="$context" mode="gridView.fieldSet.fieldFooterRow.footer"/></tr>
</xsl:template>

<xsl:template match="data/dataRow/*" mode="gridView.fieldSet.fieldFooterRow.footer"><!-- Footer (<xsl:value-of select="position()"/> vs <xsl:value-of select="count(preceding-sibling::*[@mode!='hidden' and not(@controlType='tab') and not(@Column_Name=ancestor-or-self::*[@dataType='foreignTable'][1]/@foreignReference)])"/>):  -->
	<th style="border:1pt white solid;"><xsl:apply-templates select="." mode="gridView.fieldSet.field.footer.Wrapper"/></th>
</xsl:template>

<xsl:template match="data/dataRow/*" mode="gridView.fieldSet.field.footer.Wrapper">
	<xsl:value-of select="$nbsp"/>
</xsl:template>
<!-- Footer -->
<xsl:template match="*[@dataType='table']" mode="gridView.table.thead.columnsHeader.Template">
	<xsl:element name="tr">
		<xsl:attribute name="class">columnsHeader</xsl:attribute>
		<xsl:apply-templates select="." mode="gridView.table.thead.header.Wrapper" />
	</xsl:element>
</xsl:template>

<xsl:template match="*[@dataType='table']" mode="gridView.table.tfoot.Template">
	<xsl:if test="@showFooter=1 or @showFooter='true'">
		<xsl:element name="tfoot">
			<xsl:apply-templates select="." mode="gridView.table.tfoot.Wrapper" />
		</xsl:element>
	</xsl:if>
</xsl:template>

<xsl:template match="*[@dataType='table']" mode="gridView.table.tfoot.footer.Template">
	<xsl:element name="tr">
		<xsl:apply-templates select="." mode="gridView.table.tfoot.footer.Wrapper" />
	</xsl:element>
</xsl:template>

<xsl:template match="*[@dataType='table']/data/dataRow" mode="gridView.table.tbody.row.Template">
	<xsl:element name="tr" use-attribute-sets="gridView.datatable.tr"> 
		<xsl:apply-templates select="." mode="gridView.table.tbody.row.Wrapper" />
	</xsl:element>
</xsl:template>

<xsl:template match="*" mode="gridView.table.thead.header.fields.Template">
	<xsl:element name="th">
		<xsl:attribute name="class">
			<xsl:text> dataColumn </xsl:text>
			<xsl:choose>
				<xsl:when test="count(preceding-sibling::*)+1 mod 2 = 1"> alt</xsl:when><!-- <xsl:when test="position() mod 2 = 1"> alt</xsl:when> -->
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="count(preceding-sibling::*[not(@Column_Name=ancestor::*[@dataType='table'][1]/@identityKey) and not(@mode='hidden' or @controlType='hiddenField') and not(@controlType='tab') and not(@Column_Name=ancestor-or-self::*[@dataType='foreignTable' or @foreignReference][1]/@foreignReference)])=0"> first</xsl:when><!-- <xsl:when test="position()=1"> first</xsl:when> -->
				<xsl:when test="count(following-sibling::*[not(@Column_Name=ancestor::*[@dataType='table'][1]/@identityKey) and not(@mode='hidden' or @controlType='hiddenField') and not(@controlType='tab') and not(@Column_Name=ancestor-or-self::*[@dataType='foreignTable' or @foreignReference][1]/@foreignReference)])=0"> last</xsl:when><!-- position()=last() -->
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
			<xsl:text> FieldContainer_</xsl:text><xsl:value-of select="@Column_Name"/>
		</xsl:attribute>
		<xsl:attribute name="colspan"><xsl:value-of select="container/@colspan" /></xsl:attribute>
		<xsl:apply-templates select="." mode="headerText"></xsl:apply-templates><!-- 
		(<xsl:value-of select="position()"/>) -->
	</xsl:element>
</xsl:template>

<xsl:template match="data/dataRow/*" mode="gridView.table.tbody.row.fields.Template">
	<xsl:element name="td">
		<xsl:apply-templates select="." mode="table.cell.attributeSet" />
		<xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2 = 1">dataColumn</xsl:when><xsl:otherwise>dataColumn alt</xsl:otherwise></xsl:choose>  FieldContainer_<xsl:value-of select="@Column_Name"/></xsl:attribute>
			<!-- following: <xsl:value-of select="count(../following-sibling::*/*[name(.)=name(current()) and @mode!='hidden']|current()[@mode!='hidden'])"/> -->
			<xsl:apply-templates select="." mode="dataField" />
	</xsl:element>
</xsl:template>
				
<xsl:template match="*[@dataType='table']/data/dataRow/*" mode="gridView.table.tfoot.footer.fields.Template">
	<xsl:element name="th">
		<xsl:apply-templates select="." mode="gridView.table.tfoot.footer.fields.Wrapper" />
	</xsl:element>
</xsl:template>

<xsl:template match="*[@dataType='table']/data/dataRow/*" mode="gridView.table.tfoot.footer.fields.field.Template">
<xsl:variable name="autoSum" select="sum(../following-sibling::*/*[name(.)=name(current())][@value!='']/@value | ../*[name(.)=name(current())][@value!='']/@value)"/>
<!-- <xsl:variable name="autoSum">
<xsl:if test="boolean(number(@enableAutoSum)) = false() or @enableAutoSum='false'"><xsl:value-of select="sum(../following-sibling::*/*[name(.)=name(current())][@value!='']/@value | ../*[name(.)=name(current())][@value!='']/@value)"></xsl:if>
</xsl:variable> -->
<xsl:choose>
	<xsl:when test="@dataType='money'"><xsl:call-template name="formatCurrency"><xsl:with-param name="currency" select="$autoSum"/></xsl:call-template></xsl:when>	
	<xsl:when test="$autoSum"><xsl:value-of select="$autoSum"/></xsl:when>	
	<xsl:otherwise></xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="*" mode="gridView.hiddenFields">
	<xsl:param name="rowType" />
	<th class="hiddenFields" style="display:'none';"><xsl:if test="$rowType='dataRow'"><xsl:for-each select="*[@mode='hidden']"><xsl:apply-templates select="." mode="dataField" /></xsl:for-each></xsl:if></th>
</xsl:template>

<xsl:template match="*" mode="gridView.rowNumber.Template">
<xsl:param name="rowType" />
	<th class="rowNumberCell" nowrap="nowrap"><xsl:apply-templates select="." mode="gridView.rowNumber.Wrapper"><xsl:with-param name="rowType" select="$rowType"/></xsl:apply-templates></th>
</xsl:template>

<xsl:template match="*" mode="gridView.rowNumber.text.Template">
<xsl:param name="rowType" />
	<xsl:choose>
		<xsl:when test="$rowType='headerRow'">#</xsl:when>
		<xsl:when test="$rowType='dataRow'"># <span class="rowNumber"><xsl:value-of select="@rowNumber" /></span></xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="data/dataRow" mode="gridView.table.tableGroup.Header.Template">
	<xsl:param name="tableGroup"/>
	<tr class="tableGroupHeader"><xsl:apply-templates select="." mode="gridView.table.tableGroup.Header.Wrapper"><xsl:with-param name="tableGroup" select="$tableGroup"/></xsl:apply-templates></tr>
</xsl:template>

<xsl:template match="*[@dataType='table'][@controlType='gridView']/data/dataRow/*" mode="gridView.table.tableGroup.Header.fields.Template">
	<xsl:param name="tableGroup"/>
	<th colspan="{count(following-sibling::*)}"><xsl:apply-templates select="."  mode="gridView.table.tableGroup.Header.fields.Wrapper"><xsl:with-param name="tableGroup" select="$tableGroup"/></xsl:apply-templates></th>
</xsl:template>

<xsl:template match="data/dataRow/*" mode="gridView.table.tableGroup.Header.commands.Template">
	<xsl:param name="tableGroup"/>
	<th><xsl:value-of select="$nbsp"/></th>
</xsl:template>

<xsl:template match="data/dataRow/*" mode="gridView.table.tableGroup.Header.rowNumber.Template">
	<xsl:param name="tableGroup"/>
	<th><xsl:value-of select="$nbsp"/></th>
</xsl:template>

<xsl:template match="data/dataRow" mode="gridView.table.footer.commandButtons.Template">
	<th class="CommandButtons"><xsl:value-of select="$nbsp"/></th>
</xsl:template>

<xsl:template match="data/dataRow|fields" mode="gridView.table.header.commandButtons.Template">
<xsl:param name="disableInsert"/>
<xsl:param name="disableDetails"/>
<xsl:param name="disableDelete"/>
<th class="CommandButtons" style="color:black;"><!-- <xsl:value-of select="$disableDetails"/> and <xsl:value-of select="$disableDelete"/> and <xsl:value-of select="$disableInsert"/> --><!-- <b style="color:black">@disableInsert: <xsl:value-of select="@disableInsert"/></b> -->
	<xsl:value-of select="$nbsp"/><xsl:if test="number($disableInsert)=0"><xsl:apply-templates select="." mode="insertButton" /></xsl:if>
</th>
</xsl:template>

<xsl:template match="data/dataRow" mode="gridView.table.body.commandButtons.Template">
<xsl:param name="disableInsert"/>
<xsl:param name="disableDetails"/>
<xsl:param name="disableDelete"/>
	<th class="CommandButtons"><!-- <xsl:value-of select="$disableDetails"/> and <xsl:value-of select="$disableDelete"/> and <xsl:value-of select="$disableInsert"/> -->
		<xsl:if test="$disableDetails=0"><xsl:apply-templates select="." mode="editButton" /></xsl:if><xsl:value-of select="$nbsp"/><xsl:if test="$disableDelete=0"><xsl:apply-templates select="." mode="deleteButton" /></xsl:if>
	</th>
</xsl:template>


<!-- <xsl:template match="*[@dataType='table'][@controlType='gridView']" mode="gridView.table.thead.columnsHeader.Template">
	<tr class="tableHeader"><xsl:apply-templates select="*" mode="gridView.table.thead.header.fields" /></tr>
</xsl:template> -->
 
<!-- <xsl:template match="*[@dataType='table'][@controlType='gridView']/data/dataRow/*" mode="gridView.table.tableGroup.Header.Content.Template">
	<xsl:param name="tableGroup"/>
	<th colspan="{count(following-sibling::*)}"><xsl:choose>
	<xsl:when test="../@headerText"><xsl:value-of select="../@headerText"/></xsl:when>	
	<xsl:when test="$tableGroup/*/@groupByColumn"><xsl:value-of select="$tableGroup/*[@groupByColumn='true']/@text"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="$nbsp"/></xsl:otherwise></xsl:choose></th>
</xsl:template> -->

<!-- <xsl:template match="*[@dataType='table'][@controlType='gridView']/data/dataRow/*" mode="gridView.table.thead.header.fields.Template">
<th colspan="{count(.|following-sibling::*)}"><xsl:apply-templates select="." mode="gridView.table.thead.header.fields.Wrapper"/></th>
</xsl:template> -->


<xsl:template match="data/dataRow" mode="gridView.table.tableGroup.Footer.Default">
	<xsl:param name="tableGroup"/>
	<tr class="tableGroupFooter"><xsl:apply-templates select="." mode="gridView.rowNumber"><xsl:with-param name="rowType">footerRow</xsl:with-param></xsl:apply-templates>
	<xsl:apply-templates select="*[1]" mode="gridView.table.tableGroup.Footer.Wrapper"><xsl:with-param name="tableGroup" select="$tableGroup"/></xsl:apply-templates></tr>
</xsl:template>

<xsl:template match="data/dataRow/*" mode="gridView.table.tableGroup.Footer.Content.Default">
	<xsl:param name="tableGroup"/>
	<th colspan="{count(following-sibling::*)}"><xsl:choose>
	<xsl:when test="../@footerText"><xsl:value-of select="../@footerText"/></xsl:when>	
	<xsl:when test="$tableGroup/*/@groupByColumn"><xsl:value-of select="$tableGroup/*[@groupByColumn='true']/@text"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="$nbsp"/></xsl:otherwise>
</xsl:choose></th>
</xsl:template>

<xsl:template name="localData">
    Ext.ux.ajax.SimManager.register({
        'localData' : {
            stype: 'json',
			"total": "<xsl:value-of select="@totalRecords"/>",
			"data": [
				  <xsl:apply-templates select="px:data/px:dataRow" mode="json" />
				]
        }
    });
</xsl:template>


<xsl:template match="px:data/px:dataRow" mode="json">
{
"<xsl:value-of select="ancestor::*[@dataType='table']/@identityKey"/>": "<xsl:value-of select="@identity"/>",
<xsl:apply-templates select="*" mode="json"/>
},
</xsl:template>

<xsl:template match="px:data/px:dataRow/*" mode="json">
"<xsl:value-of select="key('fields', @fieldId)/@Column_Name" disable-output-escaping="yes"/>": "<xsl:value-of select="@text" disable-output-escaping="yes"/>",
</xsl:template>

	
</xsl:stylesheet>
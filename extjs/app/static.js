Ext.define('Panax.view.base.Archivo', { 
    extend: 'Ext.container.Container', 
    alias: 'widget.archivo', 
	initComponent: function() { 
        var me = this; 
		var store;

		Ext.define('Panax.Form', {
			extend: 'Ext.form.Panel'
			, alias: 'widget.panaxform'
			, requires: ['Ext.form.field.Text']
			, initComponent: function(){
				this.addEvents('create');
				
				this.on({
						create: function(form, data){
							store.insert(0, data);
						}
					});
					
				Ext.apply(this, {
					title: 'Archivo'
					, activeRecord: null
					, width: 600
					, autoScroll: true
					, 
		layout: {
			type: 'border',
			padding: 5
		}
		, defaults: {
			split: true
		}

					, items: [
		{
			title: 'Historial'
			, region: 'west'
			, width:80
			, minWidth: 80

			, split: true
			, collapsible: true
			, collapsed: true
		}, {
			title: 'Archivo Actual'
			, region: 'center'
			, collapsible: false
			, split: true
			, minWidth: 80
			, items: [
			
		{
			fieldLabel: 'Archivo'
			, itemId: "field_Archivo_IDAKGKO"
			, afterLabelTextTpl: ''
			
					, width: 300
					, maxLength: 255
			, 
		xtype: "fieldcontainer"
		, width: 350
		, height: 130
		, layout: {
			type: 'vbox'
			, align : 'stretch'
			, pack  : 'start'
		}
		, items: [{
			xtype: 'filemanager'
			, id: 'fileImage'
			, name: 'Archivo'

		}]

			, "":null
		},

		{
			fieldLabel: 'Descripcion'
			, itemId: "field_Descripcion_IDAIVKO"
			, afterLabelTextTpl: ''
			
					, width: 300
					, maxLength: 1000
			, 
		xtype: 'textareafield'
		, grow: true
		, width: 400
		, name: 'Descripcion'
		, value: ''

			, "":null
		},
		]
		}, {
			title: 'Archivos'
			, region: 'south'
			, minHeight: 120
			, layout: {
				type: 'hbox'
				, align: 'top'
				}
			, items: [{
				xtype: 'image'
				, height: 70
				, style: { display: 'block', margin: 'auto' }
				, src: '../../../../Images/FileSystem/dwg.png'
			}]
		}, {
			title: 'Estatus actual'
			, region: 'east'
			, flex: 0
			, width: 200
			, minWidth: 80
			, items: {
				xtype: 'form'
				, defaults: {
					labelWidth: 40
				}
				, defaultType: 'textfield'
				, labelWidth: 30
				, items: [{
					xtype: 'checkboxgroup'
					, fieldLabel: 'Vo.Bo'
					, columns: 1
					, vertical: true
					, items: [{ 
						boxLabel: 'Proyecto', name: 'rb', inputValue: '1' 
						}, { 
							boxLabel: 'Plaza', name: 'rb', inputValue: '2', checked: true 
						}, { 
							boxLabel: 'Obra', name: 'rb', inputValue: '3' 
						}
					]
				}, 
		{
			fieldLabel: 'Status'
			, itemId: "field_Status_IDAURKO"
			, afterLabelTextTpl: ''
			
			, 
		xtype: 'radiogroup'
		, id: 'input_Status_IDAURKO'
		, defaults: {name: 'Status'}
		, columns: 1
		, vertical: true
		, items: [/*selector.option no está definido*/,{ boxLabel: 'Autorizado', inputValue: 'Autorizado' },{ boxLabel: 'Información', inputValue: 'Informacion' },{ boxLabel: 'Trabajo', inputValue: 'Trabajo' },{ boxLabel: 'Trámite', inputValue: 'Tramite' }
		]

			, "":null
		},
		]
			}
			, split: true
			, collapsible: true
		}
		]
					, dockedItems: [{
						xtype: 'toolbar'
						, dock: 'top'
						, ui: 'header'
						, ignoreParentFrame: true
						, ignoreBorderManagement: true
						, items: [{
							iconCls: 'icon-save'
							, itemId: 'save'
							, text: 'Guardar'
							//, formBind: true
							//, disabled: true
							, scope: this
							, handler: this.onSave
						}, {
							text   : 'Reset'
							, handler: function() {
								var form = this.up('form').getForm();
								Ext.MessageBox.confirm('BORRAR FORMULARIO', 'Confirma que desea borrar el formulario?', function(result){
									if (result=="yes") form.reset();
								});
							}
						}]
					}]
				});
				this.callParent();
			}

			, setActiveRecord: function(record){
				this.activeRecord = record;
				if (record) {
					this.down('#save').enable();
					this.getForm().loadRecord(record);
				} else {
					this.down('#save').disable();
					this.getForm().reset();
				}
			}

			, onSave: function(){
					
				var form = this.getForm(); // get the basic form
				var saveMask = new Ext.LoadMask(this, {msg:"Guardando..."});
				saveMask.show();
					record = form.getRecord();
				
					form.updateRecord(record);
					var me = this;
					record.save({
						success: function(record, args) {
							Ext.Msg.alert('Éxito', 'Datos guardados con éxito');
							var modalWindow = me.up('#modalWindow')
							if (modalWindow) modalWindow.close();
							saveMask.hide();
						},
						failure: function(record, args) {
							Ext.Msg.alert('Falló', args.error);
							saveMask.hide();
						}
					});
				
			}

			, onCreate: function(){
				var form = this.getForm();

				if (form.isValid()) {
					this.fireEvent('create', this, form.getValues());
					this.onReset();
				}

			}

			, onReset: function(){
				this.setActiveRecord(null);
				this.getForm().reset();
			}
		});


		var url = {
			local:  'localData',//'temp_data.js',  // static data file
			remote: 'request.asp'
		};

		// configure whether filter query is encoded or not (initially)
		var encode = false;

		// configure whether filtering is performed locally or remotely (initially)
		var local = false;
		var showSummary = false;



		Ext.define("dbo.Archivo", {
			extend: 'Ext.data.Model'
			, idProperty: 'IdArchivo'
			, primaryKeys: 'IdArchivo'
			, fields: [{name:'IdArchivo',fieldName:'IdArchivo',mapping:'IdArchivo', type: 'int', minValue: 0 /*no esta funcionando*/, isAlwaysSubmitable: true
		, useNull: true
		}, {name:'Folder',fieldName:'Folder',mapping:'Folder'/*foreignKey*/
		, useNull: true
		}, {name:'TituloArchivo',fieldName:'TituloArchivo',mapping:'TituloArchivo'/*nchar*/
		, useNull: true
		}, {name:'Archivo',fieldName:'Archivo',mapping:'Archivo'/*nvarchar*/
		, useNull: true
		}, {name:'TipoArchivo',fieldName:'TipoArchivo',mapping:'TipoArchivo'/*foreignKey*/
		, useNull: true
		}, {name:'Fecha',fieldName:'Fecha',mapping:'Fecha', type: 'date', dateFormat: 'd/m/Y'
		, useNull: true
		}, {name:'Status',fieldName:'Status',mapping:'Status'/*foreignKey*/
		, useNull: true
		}, {name:'Descripcion',fieldName:'Descripcion',mapping:'Descripcion'/*nvarchar*/
		, useNull: true
		}]
			, validations: []
			,
			
			proxy: {
				type: 'ajax'
				, api: {
					read: "../Templates/request.asp"
					, create: "../Scripts/update.asp"
					, update: "../Scripts/update.asp"
					, destroy: "../Scripts/update.asp"
				}
				, reader: {
					type: 'json'
					, root: 'Archivo'
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
					catalogName: "dbo.Archivo"
					, filters: "(IdArchivo=9)"
					, identityKey: "IdArchivo"
					, primaryKey: "IdArchivo"
					, mode: 'edit'
					, output: 'json'
				
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
				}
			}
		});

		// Ext.onReady(function() {
			
			store = Ext.create('Ext.data.Store', {
				autoLoad: false
				, autoSync: true
				, autoDestroy: true
				, pageSize: 0
				, remoteSort: true
				, model: "dbo.Archivo"
				
				, listeners: {
					write: function(proxy, operation){
						
						Ext.example.msg(operation.action, operation.resultSet.message);
					}
				}
			});

			me.formView = Ext.create('Panax.Form');
			
			Ext.apply(me, { 
				layout: 'fit',
				items: [me.formView]
			})
			me.callParent(arguments); 
			// me.container.add(formView)
			// if (me.currentRecord) {
				// var view = formView;
				// view.mask = new Ext.LoadMask(view, {msg:"Cargando..."});
				// view.mask.show();
				// var newRecord = dbo.Archivo.load(me.currentRecord
				// , {
					// success: function(record) {
						// view.loadRecord(record);
						// view.mask.hide();
					// }
					// , failure: function() {
						// view.mask.hide();
					// }
				// });
			// }
			//formView.loadRecord(newRecord);
			//formView.setActiveRecord(store.getAt(0));
		// });
    },
	loadRecord : function(currentRecord) {
		var me = this;
		if (currentRecord) {
			var view = me.formView;
			view.mask = new Ext.LoadMask(view, {msg:"Cargando..."});
			view.mask.show();
			var newRecord = dbo.Archivo.load(currentRecord
			, {
				success: function(record) {
					view.loadRecord(record);
					view.mask.hide();
				}
				, failure: function() {
					view.mask.hide();
				}
			});
		}
		// me.formView.loadRecord(newRecord);
		// me.formView.setActiveRecord(store.getAt(0));
	}
});
var container;
Ext.onReady(function(){
 
    Ext.tip.QuickTipManager.init();

    var detailEl;
    
    var contentPanel = {
        id: 'content-panel',
        region: 'center', // this is what makes this panel into a region within the containing layout
		layout: 'fit',
        defaults: {
            split: true
        },
        margins: '2 5 5 0',
        border: false
    };
     
    var store = Ext.create('Ext.data.TreeStore', {
        root: {
            expanded: true
        },
        proxy: {
            type: 'ajax',
            //url: '../app/tree-data.js'
			url: '../templates/menu.asp', 
			extraParams: {
				output: 'json'
			}
			, listeners: {
				exception: function(proxy, response, operation){
					var result = Ext.JSON.decode(response.responseText)
					if (result.callback) {
						result.callback();
					}					
					else {
						Ext.MessageBox.show({
							title: 'ERROR!'
							, msg: result.message
							, icon: Ext.MessageBox.ERROR
							, buttons: Ext.Msg.OK
						});
					}
				}
			}
        }
    });
    
    // Go ahead and create the TreePanel now so that we can use it below
     var treePanel = Ext.create('Ext.tree.Panel', {
        id: 'tree-panel',
        region:'north',
        split: true,
        height: 360,
        minSize: 150,
        rootVisible: false,
        autoScroll: true,
        store: store,
		onSelect: function(view, record, item, index, e, eOpts) {
			if (record.raw.catalogName) {
				if (record.get('leaf')) {
					var container=Ext.getCmp('content-panel');
					var myMask = new Ext.LoadMask(container, {msg:"Cargando..."});
					myMask.show();
					var instance = record.raw
					var content = Panax.getInstance(instance)
					if (!content) {
						// Ext.MessageBox.show({
							// title: 'Error',
							// msg: "No se pudo recuperar el módulo",
							// icon: Ext.MessageBox.ERROR,
							// buttons: Ext.Msg.OK
						// });
						myMask.hide();
						return false;
					}
					if (container.items.length>0) { 
						container.remove(0);
					}
					container.add(content);
					myMask.hide();
					if (!detailEl) {
						var bd = Ext.getCmp('details-panel').body;
						bd.update('').setStyle('background','#fff');
						detailEl = bd.createChild(); //create default empty div
					}
					detailEl.hide().update("<b>Listo!</b>").slideIn('l', {stopAnimation:true,duration: 200});
					
					// Ext.Ajax.request({
						// url: '../Templates/request.asp',
						// method: 'GET',
						// params: {
							// catalogName: record.raw.catalogName,
							// mode: record.raw.mode,
							// pageSize: 20,
							// output: 'extjs'
						// },
						// success: function(xhr) {
							//eval("var newComponent={xtype: 'grid',title: 'Invoice Report'}"); 
							// container.remove(0);
							// eval(xhr.responseText); // see discussion below
							// myMask.hide();
							// /*myTabPanel.add(newComponent); // add the component to the TabPanel
							// myTabPanel.setActiveTab(newComponent);*/
							// if (!detailEl) {
								// var bd = Ext.getCmp('details-panel').body;
								// bd.update('').setStyle('background','#fff');
								// detailEl = bd.createChild(); //create default empty div
							// }
							// detailEl.hide().update("<b>Listo!</b>").slideIn('l', {stopAnimation:true,duration: 200});
						// },
						// failure: function() {
							// myMask.hide();
							// Ext.Msg.alert("Error de comunicación", "La conexión con el servidor falló, favor de intentarlo nuevamente en unos segundos.");
						// }
					// });	
				}
			}
		},
		listeners: {
			render: function() { 
				 Ext.getBody().on("contextmenu", Ext.emptyFn, null, {preventDefault: true}); 
			}, 
			itemcontextmenu : function( view, record, item, index, event, eOpts){ 
				// x = event.browserEvent.clientX; 
				// y = event.browserEvent.clientY; 
	 
				// menu1.showAt([x, y]); 
				// alert('context menu')
				//record.raw["rebuild"]=1;
				treePanel.onSelect(view, record, item, index, event, eOpts)
				event.stopEvent();
			},
			itemclick: function( view, record, item, index, event, eOpts){
				treePanel.onSelect(view, record, item, index, event, eOpts)
			}
		}
		
    });
    
	
    // // Assign the changeLayout function to be called on tree node click.
    // treePanel.getSelectionModel().on({
		// select: treePanel.onSelect
	// });
    // This is the Details panel that contains the description for each example layout.
    var detailsPanel = {
        id: 'details-panel',
        title: 'Información:',
        region: 'center',
        bodyStyle: 'padding-bottom:15px;background:#eee;',
        autoScroll: true,
        html: '<p class="details-info">Bienvenido al sistema de información</p>'
    };
	
    //login.show();

    // Finally, build the main layout once all the pieces are ready.  This is also a good
    // example of putting together a full-screen BorderLayout within a Viewport.
    Ext.create('Ext.Viewport', {
        layout: 'border',
        title: 'Ext Layout Browser',
        items: [{
            id: 'app-header',
            height: app.config.header.height,
			region: 'north',
			border:false,
			tbar: {
				cls: 'headerTB',
				items: app.config.header.content
			}
        },{
            layout: 'border',
            id: 'layout-browser',
			title: 'Menú',
            region:'west',
			collapsible: true,
			split: true,
            margins: '2 0 5 5',
            width: 200,
            minSize: 100,
            maxSize: 500,
            items: [treePanel, detailsPanel]
        }, 
            contentPanel
        ],
        renderTo: Ext.getBody()
    });
});

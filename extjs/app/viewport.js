Ext.onReady(function() {
result = function() {
    var viewport = Ext.create('Ext.Viewport', {
        layout: {
            type: 'border',
            padding: 5
        },
        defaults: {
            split: true
        },
        items: [{
            id: 'app-header',
			xtype: 'container',
			region: 'north',
            height: 50,
            minHeight: 50,
			items: [{
				xtype: 'button',
				text: 'Mostrar diagrama',
				handler: function() {
					Ext.Ajax.request({
						url: '../Templates/request.asp',//url: '../Templates/diagrama.js',
						method: 'GET',
						params: {
							catalogName: 'Folder',
							pageSize: 100,
							output: 'extjs'
						},
						// process the response object to add it to the TabPanel:
						success: function(xhr) {
							//eval("var newComponent={xtype: 'grid',title: 'Invoice Report'}"); // see discussion below
							var container=Ext.getCmp('app-workarea');
							container.remove(0);
							eval(xhr.responseText); // see discussion below
							//if (result) updateWorkarea(Ext.apply(result), 'Diagrama');
							/*myTabPanel.add(newComponent); // add the component to the TabPanel
							myTabPanel.setActiveTab(newComponent);*/
						},
						failure: function() {
							Ext.Msg.alert("Grid create failed", "Server communication failure");
						}
					});				
				}
			}, {
				xtype: 'button',
				text: 'Mostrar Prospectos',
				handler: function() {
					Ext.Ajax.request({
						url: '../Templates/request.asp',
						method: 'GET',
						params: {
							catalogName: 'Prospecto',
							pageSize: 20,
							output: 'extjs'
						},
						// process the response object to add it to the TabPanel:
						success: function(xhr) {
							//eval("var newComponent={xtype: 'grid',title: 'Invoice Report'}"); // see discussion below
							var container=Ext.getCmp('app-workarea');
							container.remove(0);
							eval(xhr.responseText); // see discussion below
							/*myTabPanel.add(newComponent); // add the component to the TabPanel
							myTabPanel.setActiveTab(newComponent);*/
						},
						failure: function() {
							Ext.Msg.alert("Grid create failed", "Server communication failure");
						}
					});				
				}
			}]
        },{
            region: 'center',
			id: 'app-workarea',
            title: 'Center',
            minHeight: 80,
			layout: 'fit',
		}, {
                region: 'west',
                stateId: 'navigation-panel',
                id: 'west-panel', // see Ext.getCmp() below
                title: 'Menú',
                split: true,
                width: 200,
                minWidth: 175,
                maxWidth: 400,
                collapsible: true,
                animCollapse: true,
                margins: '0 0 0 5',
                layout: 'accordion',
                items: [{
                    title: 'Prospectos',
					html: '<p>No hay elementos</p>',
                    iconCls: 'nav' // see the HEAD section for style used
                }, {
                    title: 'Administración',
                    html: '<p>No hay elementos</p>',
                    iconCls: 'settings'
                }]
            },{
            region: 'south',
            collapsible: true,
			animCollapse: true,
            collapsed: true,
			collapseMode: 'mini',
            split: true,
            height: 200,
            minHeight: 120,
            title: 'Información',
            iconCls: 'info',
			layout: {
                type: 'border',
                padding: 5
            },
            html: '<p>No hay elementos</p>',
        }]
    });
	
	return viewport;
}()
});
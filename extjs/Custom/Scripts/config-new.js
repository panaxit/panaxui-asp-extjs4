app.config = {
	filesRepositoryPath: "FilesRepository",
	logo: {
		src: "../../../../Images/logos/Panax.jpg"
	},
	header: {
		height: 70,
		content: [{
			xtype: 'image',
			src: "../../../../Images/logos/Panax.jpg",
			height:60
			},'->',
			{
			text:'Ingresar',
			id: 'loginButton',
			height: 30,
			handler: function() {
				app.login.onSuccess = function() {
					location.href=location.href
				}
				app.login.show();
				app.login.down('#loginForm').getForm().findField('username').focus(true,200);
				}
			},'-',
			{
			text:'Salir',
			id: 'logoutButton',
			height: 30,
			handler: function() {
				Ext.MessageBox.confirm('Salir del sistema', '¿Confirma que desea salir del sistema?', function(result){
							if (result=="yes") {
								Ext.Ajax.request({
									url: '../Scripts/logout.asp',
									async:false,
									success: function(xhr, r) {
										var result = Ext.JSON.decode(xhr.responseText)
											if (result.success) {
												location.href=location.href;
										} else {
											Ext.MessageBox.show({
												title: 'Error',
												msg: "No se pudo salir del sistema en este momento, inténtelo nuevamente",
												icon: Ext.MessageBox.ERROR,
												buttons: Ext.Msg.OK
											});
										}
										// if (task && result.percent>=100) Ext.TaskManager.stop(task);
										// progressBar.down('[itemId=progressBar_bar]').updateProgress(result.percent/100, Math.round(result.percent)+'% completado...');
									},
									failure: function() {
										//myMask.hide();
										Ext.MessageBox.show({
											title: 'Error de comunicación',
											msg: "La conexión con el servidor falló, favor de intentarlo nuevamente en unos segundos.",
											icon: Ext.MessageBox.ERROR,
											buttons: Ext.Msg.OK
										});
									}
								});
							}
						})
				}
			}
		]
	}
}

app.login = Ext.create('Panax.Login', {
	id: 'login',
	height:100,
	width:350,
	logo: app.config.logo,
	items: [
		{
			region: 'center',
			items: [{
				xtype:'form',
				id: 'loginForm',
				border: false,
				defaultType: 'textfield',
				bodyPadding: 5,
				defaults: {
					labelPosition: 'left',
					labelAlign: 'right',
					labelWidth: 200
				},
				items: [{
					fieldLabel: 'Identificador del usuario',
					labelPosition: 'left',
					labelAlign: 'right',
					labelWidth: 200,
					itemId: 'username',
					name: 'username',
					cls: 'required',
					allowBlank: false,
					blankText: 'EL IDENTIFICADOR DEL USUARIO NO DEBE SER NULO',
					msgTarget: 'side',
					anchor: '100%'  // anchor width by percentage
				}, {
					fieldLabel: 'Clave de acceso',
					labelPosition: 'left',
					labelAlign: 'right',
					labelWidth: 200,
					inputType: 'password',
					itemId: 'password',
					name: 'password',
					cls: 'required',
					allowBlank: false,
					blankText: 'LA CLAVE DE ACCESO NO DEBE SER NULA',
					msgTarget: 'side',
					anchor: '100%'
				}]
			}]
		}]
})

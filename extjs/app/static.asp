<html xmlns="http://www.w3.org/TR/xhtml1/strict"><head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /><title>Sistema</title><link rel="stylesheet" type="text/css" href="../../../../resources/extjs/extjs-current/resources/css/ext-all.css" /><link rel="stylesheet" type="text/css" href="../styles/layout-browser.css" /><link rel="stylesheet" type="text/css" href="../../../../resources/extjs/extjs-current/ux/starrating/starrating.css" /><link rel="stylesheet" type="text/css" href="../../../../resources/extjs/extjs-current/examples/ux/grid/css/GridFilters.css" /><link rel="stylesheet" type="text/css" href="../../../../resources/extjs/extjs-current/examples/ux/grid/css/RangeMenu.css" /><link type="text/css" rel="stylesheet" href="../../../../resources/css/diagram.css" /><link rel="stylesheet" type="text/css" href="../../../../resources/extjs/extjs-current/examples/ux/css/GroupTabPanel.css" /><link rel="stylesheet" type="text/css" href="../../../../resources/extjs/extjs-current/examples/ux/css/CheckHeader.css" /><SCRIPT src="../../../../resources/extjs/custom/draw2d/wz_jsgraphics.js"></SCRIPT><SCRIPT src="../../../../resources/extjs/custom/draw2d/draw2d.js"></SCRIPT><SCRIPT src="../../../../resources/extjs/custom/draw2d/PanaxXmlSerializer.js"></SCRIPT><SCRIPT src="../../../../resources/extjs/custom/draw2d/DiagramImage.js"></SCRIPT><script type="text/javascript" src="../../../../resources/extjs/extjs-current/ext-all.js"></script><script type="text/javascript" src="../app/overrides.js"></script><script type="text/javascript" src="../../../../resources/extjs/extjs-current/locale/ext-lang-es.js"></script><script type="text/javascript" src="../app/app.js"></script><script type="text/javascript" src="../app/static.js"></script><style type="text/css">
	.sort-desc {
	background-image: url("../../../../resources/extjs/extjs-current/resources/themes/images/default/grid/sort_desc.gif") !important;
	background-position: 4px 7px !important;
	}
	.sort-asc {
	background-image: url("../../../../resources/extjs/extjs-current/resources/themes/images/default/grid/sort_asc.gif") !important;
	background-position: 4px 7px !important;
	}
	.x-grid-row-summary .x-grid-cell-inner {
	font-weight: bold;
	font-size: 11px;
	}
	body .x-panel {
	margin-bottom:20px;
	}
	.icon-grid {
	background-image:url(../../../../resources/extjs/extjs-current/examples/shared/icons/fam/grid.png) !important;
	}
	.no-icon {
		display : none !important;
	}
    .upload-icon {
	background: url('../../../../resources/extjs/extjs-current/examples/shared/icons/fam/image_add.png') no-repeat 0 0 !important;
    }
	.add {
	background-image:url(../../../../resources/extjs/extjs-current/examples/shared/icons/fam/add.gif) !important;
	}
	.option {
	background-image:url(../../../../resources/extjs/extjs-current/examples/shared/icons/fam/plugin.gif) !important;
	}
	.remove {
	background-image:url(../../../../resources/extjs/extjs-current/examples/shared/icons/fam/delete.gif) !important;
	}
	
	.save {
	background-image:url(../../../../resources/extjs/extjs-current/examples/shared/icons/save.gif) !important;
	}
	p {
		margin:5px;
	}
	.settings {
		background-image:url(../../../../resources/extjs/extjs-current/examples/shared/icons/fam/folder_wrench.png);
	}
	.nav {
		background-image:url(../../../../resources/extjs/extjs-current/examples/shared/icons/fam/folder_go.png);
	}
	.info {
		background-image:url(../../../../resources/extjs/extjs-current/examples/shared/icons/fam/information.png);
	}
    </style></head><body class="edit"><script language="javascript">
Ext.onReady(function(){
	var container = Ext.create('Ext.Window', {
        title: "Archivo",
        height: 600,
        width: 800,
        layout: 'fit'
    }).show();
	var content = Ext.create('Panax.view.base.Archivo', {container:container/*, currentRecord: 9*/});
	container.add(content);
	content.loadRecord(9);
	

	
});

</script></body></html>
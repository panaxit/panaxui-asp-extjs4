<!--#include file="../Scripts/IncludesAll.asp"-->
<% DIM sLang: sLang = request.querystring("Lang")
IF sLang<>"" AND NOT(sLang="DEFAULT") THEN sLang=sLang ELSE IF RTRIM(SESSION("lang"))<>"" THEN sLang=SESSION("lang") ELSE sLang="es" END IF %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Sistema</title>
    <link rel="stylesheet" type="text/css" href="../../../../resources/extjs/extjs-current/resources/css/ext-all.css"/>
	<link rel="stylesheet" type="text/css" href="../../../../resources/extjs/extjs-current/examples/shared/example.css" />
    <link rel="stylesheet" type="text/css" href="../styles/layout-browser.css"/>
    <link rel="stylesheet" type="text/css" href="../../../../resources/extjs/custom/starrating/starrating.css"/>
	<link rel="stylesheet" type="text/css" href="../../../../resources/extjs/extjs-current/examples/ux/grid/css/GridFilters.css" />
    <link rel="stylesheet" type="text/css" href="../../../../resources/extjs/extjs-current/examples/ux/grid/css/RangeMenu.css" />    
    <link rel="stylesheet" type="text/css" href="../../../../resources/css/diagram.css" />
	<link rel="stylesheet" type="text/css" href="../../../../resources/extjs/extjs-current/examples/ux/css/GroupTabPanel.css" />
	<link rel="stylesheet" type="text/css" href="../../../../resources/extjs/extjs-current/examples/ux/css/CheckHeader.css" />
	<link rel="stylesheet" type="text/css" href="../styles/styles.css" />
	<link rel="stylesheet" type="text/css" href="../custom/styles/custom.css" />
	<link rel="stylesheet" type="text/css" href="../custom/styles/login.css" />

    <!-- common, all times required, imports -->        
	<SCRIPT src='../../../../resources/extjs/custom/draw2d/wz_jsgraphics.js'></SCRIPT>      
	<SCRIPT src='../../../../resources/extjs/custom/draw2d/draw2d.js'></SCRIPT>

	<SCRIPT src="../../../../resources/extjs/custom/draw2d/PanaxXmlSerializer.js"></SCRIPT>
	<SCRIPT src="../../../../resources/extjs/custom/draw2d/DiagramImage.js"></SCRIPT>
	<script type="text/javascript" src="../../../../resources/extjs/extjs-current/ext-all.js"></script>
<!-- 	<script type="text/javascript" src="../../../../resources/extjs/extjs-current/ext-debug.js"></script> -->
    <script type="text/javascript" src="../../../../resources/extjs/extjs-current/examples/grouptabs/all-classes.js"></script>
    <script type="text/javascript" src="../../../../resources/extjs/extjs-current/locale/ext-lang-<%= sLang %>.js"></script> 
	<script type="text/javascript" src="../Scripts/overrides.js"></script>
    <script type="text/javascript" src="../Scripts/app.js"></script>
	<script type="text/javascript" src="../Scripts/md5.js"></script>

	<script type="text/javascript" src="../../../../resources/extjs/custom/starrating/starrating.js"></script>
	<!-- <script type="text/javascript" src="../../../../resources/extjs/extjs-current/examples/shared/examples.js"></script> -->
    <style type="text/css">
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
	<!-- .edit {
	background-image:url(../../../../resources/extjs/extjs-current/examples/simple-tasks/resources/images/edit_task.png);
	} -->
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
	/* Styling of global error indicator */
	.form-error-state {
		font-size: 11px;
		padding-left: 20px;
		height: 16px;
		line-height: 18px;
		background: no-repeat 0 0;
		cursor: default;
	}
	.form-error-state-invalid {
		color: #C30;
		background-image: url(../../../../resources/extjs/extjs-current/resources/themes/images/default/form/exclamation.gif);
	}
	.form-error-state-valid {
		color: #090;
		background-image: url(../../../../resources/extjs/extjs-current/resources/themes/images/default/dd/drop-yes.gif);
	}

	/* Error details tooltip */
	.errors-tip .error {
		font-style: italic;
	}
    </style>
    <script type="text/javascript" src="../app/layout.js"></script>
</head>
<body><div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/es_LA/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script></body>
</html>

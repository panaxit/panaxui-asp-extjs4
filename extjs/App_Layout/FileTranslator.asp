<!--#include file="../Scripts/Includes.asp"-->
<% SERVER.SCRIPTTIMEOUT = 4800 %>
<html>
<head>
<!--#include file="../Scripts/librerias_js.asp"-->
<!--#include file="../Scripts/estilos.asp"-->
</head>
<body>
<% 
'DIM oXMLDataSource:	SET oXMLDataSource=XMLReader(server.MapPath("..\..\..\..\Documentos\source.xml")) 
DIM oXMLDataSource:	SET oXMLDataSource=XMLReader(server.MapPath("..\..\..\..\Documentos\PurchaseOrder.xml")) 
DIM Document:	Set Document=new FileTranslator
'Document.FileName=server.MapPath("..\..\..\..\Documentos\Orden Compra.htm")
'Document.FileName=server.MapPath("..\..\..\..\Documentos\Orden Compra_archivos/sheet001.htm")
Document.FileName=server.MapPath("..\..\..\..\Documentos\PurchaseOrder.htm")
Document.DataSource=oXMLDataSource
Document.WriteCode()
 %>
</body>
</html>

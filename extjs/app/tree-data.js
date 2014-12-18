{ 
text: '.',
children: [[
	{
		text: "Prospectos",
		children: [
	{
		text: "Nuevo Prospecto",
		catalogName:"Prospecto",mode:"insert",leaf: true,
	},

	{
		text: "Prospectos",
		catalogName:"Prospecto",mode:"readonly",filters:""+getFilters('Prospecto');+"",leaf: true,
	},
]
	},{
    text:'Catálogos',
    children:[{
        text:'Inmobiliarias',
        catalogName:'Inmobiliarias',
        leaf:true
    }]
},{
    text:'Administración',
    children:[{
        text:'Catálogo de Perfiles',
        catalogName:'Puesto',
        leaf:true
    },{
        text:'Otros catálogos',
		children:[{
        text:'Estado Civil',
        catalogName:'EstadoCivil',
        leaf:true
		},{
        text:'Medios de publicidad',
        catalogName:'Medios',
        leaf:true
		}]
    }]
}]
}
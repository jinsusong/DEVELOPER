<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!-- Chart code -->
<script>
am4core.ready(function() {

// Themes begin
// Themes end

var chart = am4core.create("chartdiv", am4plugins_forceDirected.ForceDirectedTree);

var networkSeries = chart.series.push(new am4plugins_forceDirected.ForceDirectedSeries())
networkSeries.dataFields.linkWith = "linkWith";
networkSeries.dataFields.name = "name";
networkSeries.dataFields.id = "name";
networkSeries.dataFields.value = "value";
networkSeries.dataFields.children = "children";

networkSeries.nodes.template.label.text = "{name}"
networkSeries.fontSize = 8;
networkSeries.linkWithStrength = 0;

var nodeTemplate = networkSeries.nodes.template;
nodeTemplate.tooltipText = "{name}";
nodeTemplate.fillOpacity = 1;
nodeTemplate.label.hideOversized = true;
nodeTemplate.label.truncate = true;

var linkTemplate = networkSeries.links.template;
linkTemplate.strokeWidth = 1;
var linkHoverState = linkTemplate.states.create("hover");
linkHoverState.properties.strokeOpacity = 1;
linkHoverState.properties.strokeWidth = 2;

nodeTemplate.events.on("over", function (event) {
    var dataItem = event.target.dataItem;
    dataItem.childLinks.each(function (link) {
        link.isHover = true;
    })
})

nodeTemplate.events.on("out", function (event) {
    var dataItem = event.target.dataItem;
    dataItem.childLinks.each(function (link) {
        link.isHover = false;
    })
})

networkSeries.data = [  
   {  
      "name":"Hash4",
      "value":102,
      "linkWith":[  
         "Gunther"
      ],
      "children":[  
         {  
            "name":"David",
            "value":14
         },
         {  
            "name":"Roger",
            "value":1
         },
         {  
            "name":"Duncan",
            "value":1
         },
         {  
            "name":"Rob Dohnen",
            "value":2
         }
         
      ]
   },
   {  
      "name":"Hash3",
      "value":204,
      "linkWith":[  
         "Hash5"
      ],
      "children":[  
         {  
            "name":"Paul the wine guy",
            "value":1
         },
         {  
            "name":"Mr Geller",
            "value":8
         },
         {  
            "name":"Mrs Geller",
            "value":14
         },
         {  
            "name":"Aunt Lilian",
            "value":2
         }
      ]
   },
   {  
      "name":"Hash1",
      "value":216,
      "linkWith":[  
         "Hash2"
      ],
      "children":[  
         {  
            "name":"Carol",
            "value":10
         },
         {  
            "name":"Celia",
            "value":2
         },
         {  
            "name":"Julie",
            "value":6
         },
         {  
            "name":"Chloe",
            "value":1
         }
      ]
   },
   {  
      "name":"Hash6",
      "value":167,
      "linkWith":[  
         "Hash2"
      ],
      "children":[  
         {  
            "name":"Aurora",
            "value":2
         },
         {  
            "name":"Jill Goodacre",
            "value":1
         },
         {  
            "name":"Janice",
            "value":12
         },
         {  
            "name":"Mrs Bing",
            "value":6
         }
      ]
   },
   {  
      "name":"Hash5",
      "value":158,
      "linkWith":[  
         "Hash6"
      ],
      "children":[  
         {  
            "name":"Paolo",
            "value":5
         },
         {  
            "name":"Barry",
            "value":1
         },
         {  
            "name":"Dr Green",
            "value":3
         },
         {  
            "name":"Mark3",
            "value":1
         }
      ]
   },
   {  
      "name":"Hash2",
      "value":88,
      "linkWith":[  
         "Hash4"
      ],
      "children":[  
         {  
            "name":"Lorraine",
            "value":2
         },
         {  
            "name":"Melanie",
            "value":2
         },
         {  
            "name":"Erica",
            "value":2
         },
         {  
            "name":"Kate",
            "value":4
         },
         {  
            "name":"Lauren",
            "value":2
         }
      ]
   },
   {  
      "name":"Hash7",
      "value":88,
      "linkWith":[  
         "Hash4"
      ],
      "children":[  
         {  
            "name":"Lorraine",
            "value":2
         },
         {  
            "name":"Lorraine",
            "value":2
         },
         {  
            "name":"Lorraine",
            "value":2
         },
         {  
            "name":"Lorraine",
            "value":2
         }
      ]
   },
   {  
      "name":"Hash8",
      "value":88,
      "linkWith":[  
         "Hash4"
      ],
      "children":[  
         {  
            "name":"Lorraine",
            "value":2
         },
         {  
            "name":"Lorraine",
            "value":2
         },
         {  
            "name":"Lorraine",
            "value":2
         },
         {  
            "name":"Lorraine",
            "value":2
         }
      ]
   }
];


}); // end am4core.ready()
</script>
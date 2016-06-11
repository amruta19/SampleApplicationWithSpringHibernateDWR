var cellFuncs = [
function(data) { return data; },
function(data) { return data.toUpperCase(); },
function(data) { return "<input type='button' value='Test' onclick='alert(\"Hi\");'/>";  },
function(data) { return count++; }
];


function update() {
var name = dwr.util.getValue("demoName");
Demo.sayHello(name, function(data) {    dwr.util.setValue("demoReply", data);   } );
var count = 1;
dwr.util.addRows( "tabs",[ 'Africa', 'America', 'Asia', 'Australasia', 'Europe' ], cellFuncs);
alert("hai");


}
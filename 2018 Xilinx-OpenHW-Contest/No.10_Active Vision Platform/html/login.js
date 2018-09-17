$(document).ready(function(){
$.backstretch('public/img/1.jpg');

$('#testBtn').click(function(){

console.log("testBtn pressed");
//let dataToBackStr = JSON.stringify("123456");
var dataToBackStr = ("1");
// $.post('/cgi-bin/controller/v4l_capture/login', dataToBackStr, function(result){
$.post('/cgi-bin/controller/hello', dataToBackStr, function(result){
    if(result){
        var newAddr = "/_Image/vputest.jpg" + "?" + result;
        console.log(newAddr);
        $("#3Dimage").attr("src", newAddr);
    }
}, 'text');

})



$('#calibBtn').click(function(){

console.log("calibBtn pressed");
//let dataToBackStr = JSON.stringify("123456");
var dataToBackStr = ("2");
// $.post('/cgi-bin/controller/v4l_capture/login', dataToBackStr, function(result){
$.post('/cgi-bin/controller/hello', dataToBackStr, function(result){
if(result){
        var newAddr = "/_Image/vputest.jpg" + "?" + result;
        console.log(newAddr);
        $("#3Dimage").attr("src", newAddr);
    }
}, 'text');

})

$('#3DVHBtn').click(function(){

console.log("3DVHBtn pressed");
//let dataToBackStr = JSON.stringify("123456");
var dataToBackStr = ("3");
// $.post('/cgi-bin/controller/v4l_capture/login', dataToBackStr, function(result){
$.post('/cgi-bin/controller/hello', dataToBackStr, function(result){

console.log(result);
}, 'text');

})

$('#3DVBtn').click(function(){

console.log("3DVBtn pressed");
//let dataToBackStr = JSON.stringify("123456");
var dataToBackStr = ("4");
// $.post('/cgi-bin/controller/v4l_capture/login', dataToBackStr, function(result){
$.post('/cgi-bin/controller/hello', dataToBackStr, function(result){

console.log(result);
}, 'text');

})

$('#3DHBtn').click(function(){

console.log("3DHBtn pressed");
//let dataToBackStr = JSON.stringify("123456");
var dataToBackStr = ("5");
// $.post('/cgi-bin/controller/v4l_capture/login', dataToBackStr, function(result){
$.post('/cgi-bin/controller/hello', dataToBackStr, function(result){

console.log(result);
}, 'text');

})

$('#3DSBtn').click(function(){

console.log("3DSBtn pressed");
//let dataToBackStr = JSON.stringify("123456");
var dataToBackStr = ("6");
// $.post('/cgi-bin/controller/v4l_capture/login', dataToBackStr, function(result){
$.post('/cgi-bin/controller/hello', dataToBackStr, function(result){
if(result){
        var newAddr = "/_Image/vputest.jpg" + "?" + result;
        console.log(newAddr);
        $("#3Dimage").attr("src", newAddr);
    }
}, 'text');

})

$('#STOPBtn').click(function(){

console.log("STOPBtn pressed");
//let dataToBackStr = JSON.stringify("123456");
var dataToBackStr = ("7");
// $.post('/cgi-bin/controller/v4l_capture/login', dataToBackStr, function(result){
$.post('/cgi-bin/controller/hello', dataToBackStr, function(result){

console.log(result);
}, 'text');

})

$('#a1920').click(function(){

console.log("a1920 pressed");
document.getElementById("CAMERA").innerHTML="1920x1080";


})
$('#a1280').click(function(){

console.log("a1280 pressed");
document.getElementById("CAMERA").innerHTML="1280x720";


})
$('#a640').click(function(){

console.log("a640 pressed");
document.getElementById("CAMERA").innerHTML="640x480";


})
            

// $('#objBtn').click(function(){

// console.log("objBtn pressed");
// //let dataToBackStr = JSON.stringify("123456");
// var dataToBackStr = ("3");
// // $.post('/cgi-bin/controller/v4l_capture/login', dataToBackStr, function(result){
// $.get('/cgi-bin/controller/hello/hello', dataToBackStr, function(result){
// console.log(result);
// var Obj = JSON.parse(result);
// console.log(Obj[0]);
// var myChart = echarts.init(document.getElementById('main'));

// // 指定图表的配置项和数据
// var option = {
//         tooltip: {},
//         backgroundColor: '#fff',
//         visualMap: {
//             show: false,
//             dimension: 2,
//             min: 0,
//             max: 5,
//             inRange: {
//                 color: ['#313695', '#4575b4', '#74add1', '#abd9e9', '#e0f3f8', '#ffffbf', '#fee090', '#fdae61', '#f46d43', '#d73027', '#a50026']
//             }
//         },
//         xAxis3D: {
//             type: 'value',
//             splitNumber: 2
//         },
//         yAxis3D: {
//             type: 'value',
//             splitNumber: 2
//         },
//         zAxis3D: {
//             type: 'value',
//             max: 10,
//             splitNumber: 2
//         },
//         grid3D: {
//             viewControl: {
//                 // projection: 'orthographic'
//             }
//         },
//         series: [{
//             type: 'surface',
//             wireframe: {
//                 show: false
//             },
//             data:



//     }]
    
//     };

// // 使用刚指定的配置项和数据显示图表。
// myChart.setOption(option);



// }, 'text');

// // 基于准备好的dom，初始化echarts实例

// })

            

})
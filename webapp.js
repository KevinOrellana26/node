var http = require('http');
var url= require('url');


http.createServer(onRequest).listen(8888);
console.log('Server has started'); // muestra una salida por consola.

function onRequest(request, response){
  var pathName = url.parse(request.url).pathname //ver que tipo de ruta ha solicitado el usuario.
  console.log('pathname' + pathName); //mostrar la ruta en la consola
  showPage(response, pathName)
}

function showPage(response, pathName){
    if (pathName === '/'){
        response.writeHead(200), {'Content-Type': 'text/html'};
        response.write(contentMap['/']);
        response.end();
    }else {
        response.writeHead(200), {'Content-Type': 'text/html'};
        response.write(contentMap['/contact']);
        response.end();
    }
}

var contentMap = {
    '/' : '<h1>Welcome to the site from Node</h1>',
    '/contact' : '<h1>Contact Page</h1>\
    <h3>Soy Kevin Orellana!</h3>'
}
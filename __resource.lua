client_script('client/client.lua')

server_script('server/server.lua')
server_script('@mysql-async/lib/MySQL.lua')

ui_page('client/html/index.html')

files({
    'client/html/index.html',
    'client/html/script.js',
    'client/html/style.css',
    'client/html/images/cursor.png',
	'client/html/images/pointer.png'
})
extends "res://Controllers/net_constants.gd"
const port = 3560
var ip = "localhost"
var connection
var peer
var connected = false
signal data_recieved_signal
signal not_connected_signal
var timeout = 5

func clientConnect():
	
  print("Connected t "+ip+ ":"+str(port))
  connected = true
  write([PLAYER_CONNECT])
  

  
func clientConnecting():
	pass
	#print( "Trying to connect "+ip+" :"+str(port) )
	#print( "Timeout in: ",timeout," seconds")
	
func clientConnectFailed():
	print( "Couldn't connect to "+ip+" :"+str(port) )
	#_ready()
	connection.disconnect()
	connection.connect(ip, port)
	#set_process(false)
	#TODO GotoMenu
	
func TryConnection(connection):
	var status = connection.get_status()
	var is_connected = status == connection.STATUS_CONNECTED
	var is_connecting = status == connection.STATUS_CONNECTING
	var is_unable_to_connect = (status == connection.STATUS_NONE 
								or status == connection.STATUS_ERROR)
	
	if is_connected:
		clientConnect()
	elif is_connecting:
		clientConnecting()
	elif is_unable_to_connect:
		clientConnectFailed()
	emit_signal("not_connected_signal", [ip, port])
	
func _ready():
	var config = ConfigFile.new()
	var err = config.load("res://settings.cfg")
	if err == OK: # if not, something went wrong with the file loading
	    ip = config.get_value("networking", "serverip", "localhost")
	    #print("setting ip to ", ip)
	connection = StreamPeerTCP.new()
	connection.connect(ip , port)
	peer = PacketPeerStream.new()
	peer.set_stream_peer(connection)
	set_process(true)

	print(connection.get_status())

func write(command):
	if connected:
		#print("Writing ", command)
		if (peer.put_var(command) != OK):
			connected=false
	else:
		print("command failed not connected")

func _process(delta):
	if !connected:
		TryConnection(connection)
		if timeout > 0:
			timeout -= delta

			
		
	for i in range (peer.get_available_packet_count() ):
		emit_signal("data_recieved_signal", peer.get_var())
		 
		

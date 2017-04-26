extends "res://Controllers/net_constants.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var port = 3560
var server
var connections = {}

signal data_recieved_signal

class client_data:
	var peer = PacketPeerStream.new()

func _ready():
	server = TCP_Server.new()
	if server.listen(port) == 0:
		print("Server started at port "+str(port))
		set_process(true)
	else:
		print( "Failed to start server on port "+str(port) )
		#TODO signal failed connections
func removeDisconnected():
	for client in connections:
		if !client.is_connected():
			print("client is disconnected" + str(client.get_status()))
			connections.erase(client)

func publishReceivedData():
	for client in connections:
		if connections[client].peer.get_available_packet_count() > 0:
			for i in range( connections[client].peer.get_available_packet_count() ):
				var data = connections[client].peer.get_var()
				emit_signal("data_recieved_signal", data)
				BroadCastData(client, data)				

func _process(delta):
	if server.is_connection_available(): # check if someone's trying to connect
		var client = server.take_connection() # accept connections
		connections[client] = client_data.new()
		connections[client].peer.set_stream_peer( client )
		print( "Client has connected!" )
		
	removeDisconnected()
	publishReceivedData()
	
func BroadCastData(FromClient, data):
	for client in connections:

		if client == FromClient:
			continue
			
		connections[client].peer.put_var(data)
		
	
	


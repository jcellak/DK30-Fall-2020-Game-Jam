// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum EventType {
	goto_room,
	player_update,
	player_damaged,
	player_pickup,
	instance_destroyed,
	player_death,
	blast_created
}

function network_received_packet(buffer) {
	var message_id = buffer_read(buffer, buffer_u8); //Reads our Unsigned 8Bit Integer from our buffer. [What our buffer will look like: mouse_x,mouse_y] We remove the 1 because when a buffer reads information, it removes that id from the buffer.
	var otherPlayerObjectId = global.my_player_num == 0 ? o_player_2 : o_player_1;

	//You set which buffer ID you want to send information with. Maybe buffer id 1 sends mouse_x and mouse_y, id 2 sends Damage, id 3 sends health, etc.
	switch(message_id) {
		case EventType.goto_room:
			var roomId = buffer_read(buffer, buffer_u32);
			room_goto(roomId);
			break;
		case EventType.player_update:
			var pNum = buffer_read(buffer, buffer_u8);
			var pState = buffer_read(buffer, buffer_u8);
			var pX = buffer_read(buffer, buffer_s16);
			var pY = buffer_read(buffer, buffer_s16);
			var pXSpeed = buffer_read(buffer, buffer_s16);
			var pYSpeed = buffer_read(buffer, buffer_s16);
			var pAcceleration = buffer_read(buffer, buffer_s16);
			var pHp = buffer_read(buffer, buffer_u8);
			var pCharge = buffer_read(buffer, buffer_u8);
			var pRight = buffer_read(buffer, buffer_bool);
			var pLeft = buffer_read(buffer, buffer_bool);
			var pUp = buffer_read(buffer, buffer_bool);
			var pDown = buffer_read(buffer, buffer_bool);
			var pUpRelease = buffer_read(buffer, buffer_bool);
			var pPushed = buffer_read(buffer, buffer_bool);
			var pBlastHeld = buffer_read(buffer, buffer_bool);
			var pBlastReleased = buffer_read(buffer, buffer_bool);
			var pBlastCharge = buffer_read(buffer, buffer_s16);
			
			if (pNum != global.my_player_num) {
				with (otherPlayerObjectId) {
					network_update = {
						state: pState,
						x: round(pX),
						y: round(pY),
						xspeed: pXSpeed,
						yspeed: pYSpeed,
						acceleration: pAcceleration,
						right: pRight,
						left: pLeft,
						up: pUp,
						down: pDown,
						up_release: pUpRelease,
						pushed: pPushed,
						hp: pHp,
						charge: pCharge,
						blast_held: pBlastHeld,
						blast_released: pBlastReleased,
						blast_charge: pBlastCharge
					};
				}
			}
		
			break;
		case EventType.player_damaged:
			var pNum = buffer_read(buffer, buffer_u8);
			var damage = buffer_read(buffer, buffer_s16);
			
			with(pNum == 0 ? o_player_1 : o_player_2) {
				handle_player_take_damage(damage);
			}
			
			break;
		case EventType.player_pickup:
			var pNum = buffer_read(buffer, buffer_u8);
			var objectIndex = buffer_read(buffer, buffer_u32);
			
			switch(objectIndex) {
				case o_battery.object_index:
					global.player_charge[pNum] += 20;
					break;
			}
			
			break;
		case EventType.instance_destroyed:
			var instanceId = buffer_read(buffer, buffer_u32);
			
			// TODO: I suspect this might not work because we'll end up creating instances separately
			// and they won't necessarily have the same ID.  Maybe keep them in a separate data structure?
			if (instance_exists(instanceId)) {
				instance_destroy(instanceId);
			}
			
			break;
		case EventType.player_death:
			var pNum = buffer_read(buffer, buffer_u8);
			
			with(pNum == 0 ? o_player_1 : o_player_2) {
				handle_player_state_death();
			}
			
			break;
		case EventType.blast_created:
			var oNum = buffer_read(buffer, buffer_u8);
			var blastX = buffer_read(buffer, buffer_s16);
			var blastY = buffer_read(buffer, buffer_s16);
			var blastVal = buffer_read(buffer, buffer_s16);
			var blastXScale = buffer_read(buffer, buffer_s8);
			var pX = buffer_read(buffer, buffer_s16);
			var pY = buffer_read(buffer, buffer_s16);
			
			var newShove = instance_create_layer(blastX, blastY, "Particles", o_blast_hitbox);
			newShove.owner_num = oNum;
			newShove.blast_value = blastVal;
			newShove.image_xscale = blastXScale;
			newShove.playerX = pX;
			newShove.playerY = pY;
			break;
	}
}

function send_event_goto_room(roomId) {
	if (global.local_play) {
		return;
	}
	
	buffer_seek(global.buffer, buffer_seek_start, 0); //Checks the beginning of the buffer
	buffer_write(global.buffer, buffer_u8, EventType.goto_room); //Writes our ID to an unsigned positive 8-Bit integer (0-256) to our buffer.
	buffer_write(global.buffer, buffer_u32, roomId);
	
	network_send_packet(global.socket, global.buffer, buffer_tell(global.buffer)) //Buffer_tell is going to return the size of the buffer.
}

// Only call this from a player context.
function send_event_player_state() {
	if (global.local_play) {
		return;
	}
	
	// Send a player update to the other player.
	buffer_seek(global.buffer, buffer_seek_start, 0); //Checks the beginning of the buffer
	buffer_write(global.buffer, buffer_u8, EventType.player_update); //Writes our ID to an unsigned positive 8-Bit integer (0-256) to our buffer.
	buffer_write(global.buffer, buffer_u8, global.my_player_num);
	buffer_write(global.buffer, buffer_u8, state);
	buffer_write(global.buffer, buffer_s16, x);
	buffer_write(global.buffer, buffer_s16, y);
	buffer_write(global.buffer, buffer_s16, xspeed);
	buffer_write(global.buffer, buffer_s16, yspeed);
	buffer_write(global.buffer, buffer_s16, acceleration);
	buffer_write(global.buffer, buffer_u8, global.player_hp[global.my_player_num]);
	buffer_write(global.buffer, buffer_u8, global.player_charge[global.my_player_num]);
	buffer_write(global.buffer, buffer_bool, right);
	buffer_write(global.buffer, buffer_bool, left);
	buffer_write(global.buffer, buffer_bool, up);
	buffer_write(global.buffer, buffer_bool, down);
	buffer_write(global.buffer, buffer_bool, up_release);
	buffer_write(global.buffer, buffer_bool, pushed);
	buffer_write(global.buffer, buffer_bool, blast_held);
	buffer_write(global.buffer, buffer_bool, blast_released);
	buffer_write(global.buffer, buffer_s16, blast_charge);

	//Send the buffer to the server
	//We need to tell it which socket to connect to, which buffer to use, and what buffer size we are using.
	network_send_packet(global.socket, global.buffer, buffer_tell(global.buffer)) //Buffer_tell is going to return the size of the buffer.
}

function send_event_player_damaged(damage) {
	if (global.local_play) {
		return;
	}
	
	buffer_seek(global.buffer, buffer_seek_start, 0); //Checks the beginning of the buffer
	buffer_write(global.buffer, buffer_u8, EventType.player_damaged); //Writes our ID to an unsigned positive 8-Bit integer (0-256) to our buffer.
	buffer_write(global.buffer, buffer_u8, global.my_player_num);
	buffer_write(global.buffer, buffer_s16, damage);
	
	network_send_packet(global.socket, global.buffer, buffer_tell(global.buffer)) //Buffer_tell is going to return the size of the buffer.
}

function send_event_player_pickup(objectIndex) {
	if (global.local_play) {
		return;
	}
	
	buffer_seek(global.buffer, buffer_seek_start, 0); //Checks the beginning of the buffer
	buffer_write(global.buffer, buffer_u8, EventType.player_pickup); //Writes our ID to an unsigned positive 8-Bit integer (0-256) to our buffer.
	buffer_write(global.buffer, buffer_u8, global.my_player_num);
	buffer_write(global.buffer, buffer_u32, objectIndex);
	
	network_send_packet(global.socket, global.buffer, buffer_tell(global.buffer)) //Buffer_tell is going to return the size of the buffer.
}

function send_event_instance_destroyed() {
	if (global.local_play) {
		return;
	}
	
	buffer_seek(global.buffer, buffer_seek_start, 0); //Checks the beginning of the buffer
	buffer_write(global.buffer, buffer_u8, EventType.instance_destroyed); //Writes our ID to an unsigned positive 8-Bit integer (0-256) to our buffer.
	buffer_write(global.buffer, buffer_u32, id);
	
	network_send_packet(global.socket, global.buffer, buffer_tell(global.buffer)) //Buffer_tell is going to return the size of the buffer.
}

function send_event_player_death() {
	if (global.local_play) {
		return;
	}
	
	buffer_seek(global.buffer, buffer_seek_start, 0); //Checks the beginning of the buffer
	buffer_write(global.buffer, buffer_u8, EventType.player_death); //Writes our ID to an unsigned positive 8-Bit integer (0-256) to our buffer.
	buffer_write(global.buffer, buffer_u8, global.my_player_num);
	
	network_send_packet(global.socket, global.buffer, buffer_tell(global.buffer)) //Buffer_tell is going to return the size of the buffer.
}

function send_event_blast_created(instanceId) {
	if (global.local_play) {
		return;
	}
	
	buffer_seek(global.buffer, buffer_seek_start, 0); //Checks the beginning of the buffer
	buffer_write(global.buffer, buffer_u8, EventType.blast_created); //Writes our ID to an unsigned positive 8-Bit integer (0-256) to our buffer.
	buffer_write(global.buffer, buffer_u8, instanceId.owner_num);
	buffer_write(global.buffer, buffer_s16, instanceId.x);
	buffer_write(global.buffer, buffer_s16, instanceId.y);
	buffer_write(global.buffer, buffer_s16, instanceId.blast_value);
	buffer_write(global.buffer, buffer_s8, instanceId.image_xscale);
	buffer_write(global.buffer, buffer_s16, instanceId.playerX);
	buffer_write(global.buffer, buffer_s16, instanceId.playerY);
	
	network_send_packet(global.socket, global.buffer, buffer_tell(global.buffer)) //Buffer_tell is going to return the size of the buffer.
}

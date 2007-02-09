/*
 * Copyright the original author or authors.
 * 
 * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.mozilla.org/MPL/MPL-1.1.html
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 /**
 * 
 *	@author	Benomar Younes  
 *	@version	0.1
 * 
 * 	@usage 
 */
 
package com.fleo.irc.core
{
	import flash.events.*;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	public class IRCSocket extends Socket
	{
		public var onSockRead: Function;
		public var onSockOpen: Function;
		public var onSockError: Function;
		public var onSockClose: Function;
		public var onSockWrite: Function;
		
		private var input: String;
		
		public function IRCSocket( host: String = null, port: uint = 0 )
		{		
			super( host, port );
			
			addEventListener( Event.CONNECT, onConnect );
			addEventListener( ProgressEvent.SOCKET_DATA, onRead );
			addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
			addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			
			input = '';
		}
		
		private function onConnect( event: Event ): void
		{
			onSockOpen( event );

		}
		
		private function onRead( event: ProgressEvent ): void
		{
			while ( bytesAvailable > 0 )
			{
				var byte: uint = readUnsignedByte();
				var next: uint;
				
				if ( byte == 13 )
				{
					if ( bytesAvailable >= 1 )
					{
						next = readUnsignedByte();
						
						if ( next == 10 )
						{
							onSockRead( input );
							input = '';
						}
						else
						{
							input += String.fromCharCode( byte );
							input += String.fromCharCode( next );
						}
					}
					else
						input += String.fromCharCode( byte );
				}
				else
					input += String.fromCharCode( byte );
			}
		}
		
		private function onSecurityError( event: SecurityError ): void
		{
			onSockError( event.message );
		}
		
		private function onIOError( event: IOErrorEvent ): void
		{
			onSockError( event.text );
		}
		
		public function sendString( output: String ): void
		{
			var array: ByteArray = new ByteArray();
			var i: int = 0;
			var j: int = output.length;
		
			while ( i < j )
				array.writeByte( output.charCodeAt( i++ ) );
						
			array.writeByte( 0x0D );
			array.writeByte( 0x0A );
			
			writeBytes( array, 0, array.length );
			flush();
		}
	}
}
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
package com.fleo.irc
{
	import flash.events.*;
	import com.fleo.irc.core.*;
	import com.fleo.irc.events.*
	
	public class IRC extends EventDispatcher
	{	
		//-- socket events
		static public const EVENT_SOCKCLOSE: String = 'onSockClose';
		static public const EVENT_SOCKOPEN:  String = 'onSockOpen';
		static public const EVENT_SOCKERROR: String = 'onSockError';
		
		//-- msg events
		static public const EVENT_STATUSMESSAGE: String = 'onStatusMessage';
		static public const EVENT_ACTIVEMESSAGE: String = 'onActiveMessage';

		//-- irc events
		static public const EVENT_PING: String = 'onPing';		
		static public const EVENT_ERROR: String = 'onIRCError';
		static public const EVENT_MOTD: String = 'onMotd';
		static public const EVENT_NOTICE: String = 'onNotice';
		static public const EVENT_JOIN: String = 'onJoin';
		static public const EVENT_PART: String = 'onPart';
		static public const EVENT_PRIVMSG: String = 'onText';
		static public const EVENT_TOPIC: String = 'onTopic';
		static public const EVENT_MODE: String = 'onRawMode';
		static public const EVENT_NICK: String = 'onNick';
		static public const EVENT_KICK: String = 'onKick';
		static public const EVENT_QUIT: String = 'onQuit';
		
		private var sock: IRCSocket;
		private var nickName: String;		
		private var registered: Boolean;
		
		private var lastErrorMessage: String;
		private var lastStatusMessage: String;
		private var lastActiveMessage: String;
		
		//-- construtor
		public function IRC()
		{
			sock = new IRCSocket();

			sock.onSockClose = onSockClose;
			sock.onSockError = onSockError;
			sock.onSockOpen  = onSockOpen;
			sock.onSockRead  = onSockRead;
		}
			
		
		public function connect( server: String, port: uint, nick: String ): void
		{
			sock.connect( server, port );
			nickName = nick;
			registered = false;
		}
		
		public function disconnect(): void
		{
			sock.sendString('QUIT : AS3IRC Actionscript 3.0 IRC client - http://virtual-industry.com');
			sock.close();
		}
		
		public function isConnected(): Boolean
		{
			return sock.connected;
		}
		
		private function onSockClose( e: Event ): void
		{
			dispatchEvent( new Event( EVENT_SOCKCLOSE ) );
		}
		
		private function onSockError( err: String ): void
		{
			lastErrorMessage = err;
			dispatchEvent( new Event( EVENT_SOCKERROR ) );
		}
		
		private function onSockOpen( e: Event ): void
		{
			dispatchEvent( new Event( EVENT_SOCKOPEN ) );
			
			//-- irc logon
			var ident: String = 'this@is.just.something.for.us';
			sock.sendString( 'NICK ' + nickName );
			sock.sendString( 'USER ' + ident + ' "AS3IRC by virtual-industry.com" "127.0.0.1" :' + ident );
		}
		
		/*
		*  	Méthode qui traite les données renvoyées par le serveur 
		* 	@param input
		*/ 
		private function onSockRead( input: String ): void
		{
			if ( input == '' ) return;
			
			//-- séparer la commande en tokens
			var tokens: Array = input.split( ' ' );
			
			var cmd:String = String( tokens[ 0 ] ).toLowerCase();
			if ( cmd == Commands.PING )
			{
				registered = true;	
				sock.sendString( 'PONG ' + tokens[ 1 ] );
				dispatchEvent( new Event( EVENT_PING ) );
				return;
			}
			else if ( cmd == Commands.ERROR )
			{
				sock.close();
				lastErrorMessage = ((tokens.slice( 1, tokens.length )).join( ' ' )).substring( 1 );
				dispatchEvent( new Event( EVENT_SOCKERROR ) );
				return;
			}				
			
			// Extraire le message depuis :nick!ident@host event params :message
			var m: Array = input.match( /\:(.+?)\:(.+)/ );
			var message: String = ( m != null ) ? m[ 2 ] : '';
			
			//-- traduction en evenement
			var event: String = String( tokens[ 1 ] ).toLowerCase();
			
			var topic: TopicEvent
			
			switch ( event )
			{
				case Commands.RPL_WELCOME:
				case Commands.RPL_YOURHOST:
				case Commands.RPL_CREATED:
				case Commands.RPL_MYINFO:
				case Commands.RPL_BOUNCE:
				case Commands.RPL_LUSERCLIENT:
				case Commands.RPL_LUSEROP:
				case Commands.RPL_LUSERUNKNOWN:
				case Commands.RPL_LUSERCHANNELS:
				case Commands.RPL_LUSERME:{
					var tokens_: Array = input.split( ':' ); 
					lastStatusMessage = tokens_[2];
					dispatchEvent( new Event( EVENT_STATUSMESSAGE ) );
				}
				break;

				//-- Les erreurs suivants sont affichés dans la fenêtre principale
				case Commands.ERR_NOSUCHNICK:
				case Commands.ERR_NOSUCHSERVER:
				case Commands.ERR_NOSUCHCHANNEL:
				case Commands.ERR_TOOMANYCHANNELS:
				case Commands.ERR_TOOMANYTARGETS:
				case Commands.ERR_NOSUCHSERVICE:
				case Commands.ERR_NOORIGIN:
				case Commands.ERR_NORECIPIENT:
				case Commands.ERR_NOTEXTTOSEND:
				case Commands.ERR_NOTOPLEVEL:
				case Commands.ERR_WILDTOPLEVEL:
				case Commands.ERR_BADMASK:
				case Commands.ERR_UNAVAILRESOURCE:
				case Commands.ERR_NOTONCHANNEL:
				case Commands.ERR_USERONCHANNEL:
				case Commands.ERR_NOLOGIN:
				case Commands.ERR_NOTREGISTERED:
				case Commands.ERR_NEEDMOREPARAMS:
				case Commands.ERR_ALREADYREGISTRED:
				case Commands.ERR_PASSWDMISMATCH:
				case Commands.ERR_YOUREBANNEDCREEP:
				case Commands.ERR_YOUWILLBEBANNED:
				case Commands.ERR_KEYSET:
				case Commands.ERR_NOPRIVILEGES:
				case Commands.ERR_CHANOPRIVSNEEDED:
				case Commands.ERR_UMODEUNKNOWNFLAG:
				case Commands.ERR_USERSDONTMATCH:
				case Commands.ERR_ERRONEUSNICKNAME:
				case Commands.ERR_NICKNAMEINUSE:
				case Commands.ERR_NOADMININFO:
				case Commands.ERR_NOMOTD:
				case Commands.ERR_NONICKNAMEGIVEN:
				case Commands.ERR_UNKNOWNCOMMAND:
				case Commands.ERR_WASNOSUCHNICK:
				case Commands.ERR_USERNOTINCHANNEL: {
					var err: IRCErrorEvent = new IRCErrorEvent( EVENT_ERROR );
					err.message = message;
					
					//-- afficher l'attribut de l'erreur si la format est :ADDRESS DATA NICK (ATTRIBUTE) :MESSAGE
					var attr: String = tokens[ 3 ];
					if ( attr.substr( 0, 1 ) != ':' )
						err.message += ' "' + attr + '"';
						
					dispatchEvent( err );
				}
				break;
				
				//-- Messages d'erreurs
				case Commands.ERR_CANNOTSENDTOCHAN:
				case Commands.ERR_CHANNELISFULL:
				case Commands.ERR_UNKNOWNMODE:
				case Commands.ERR_INVITEONLYCHAN:
				case Commands.ERR_BANNEDFROMCHAN:
				case Commands.ERR_BADCHANNELKEY:
				case Commands.ERR_BADCHANMASK:
				case Commands.ERR_NOCHANMODES:
				case Commands.ERR_BANLISTFULL:{
					lastActiveMessage = message;
					dispatchEvent( new Event( EVENT_ACTIVEMESSAGE ) );
				}
				break;

				case Commands.RPL_MOTDSTART:
				case Commands.RPL_MOTD:
				case Commands.RPL_ENDOFMOTD: {
					var motd: MotdEvent = new MotdEvent( EVENT_MOTD );
					motd.msg = message;
					
					if ( event == Commands.RPL_ENDOFMOTD )
						processInput( '/join #irc' );
						
					dispatchEvent( motd );
				}
				break;
				
				case Commands.RPL_NAMREPLY: {
					lastStatusMessage = message;
					
					var list: Array = message.split( ' ' );
					var target: String = tokens[ 4 ];					
					var i: int = list.length;
					
					while ( --i > -1 )
					{
						if ( list[ i ] == '' || list[ i ] == ' ' || list[ i ] == null )
							continue;
							
						var name: JoinEvent = new JoinEvent( EVENT_JOIN );
						var user: User = new User();
						user.nick = list[ i ];
						
						name.user = user;
						name.chan = target;
						name.onJoin = false;
						
						dispatchEvent( name );
					}

					dispatchEvent( new Event( EVENT_STATUSMESSAGE ) );
				}
				break;
				
				case Commands.RPL_ENDOFNAMES: {
					lastStatusMessage = message;
					dispatchEvent( new Event( EVENT_STATUSMESSAGE ) );					
				}
				break;
				
				
				case Commands.RPL_TOPIC: {
					topic = new TopicEvent( EVENT_TOPIC );
					topic.mode = TopicEvent.MODE_TOPIC;
					topic.win = tokens[ 3 ];
					topic.msg = message;
					
					dispatchEvent( topic );
				}
				break;
				
				case Commands.RPL_TOPICSETBY: {
					topic = new TopicEvent( EVENT_TOPIC );
					topic.mode = TopicEvent.MODE_SETBY;
					topic.win = tokens[ 3 ];
					topic.msg = tokens[ 4 ] + ' ' + tokens[ 5 ];
					
					dispatchEvent( topic );
				}
				break;
							
				case Commands.RPL_NOTOPIC: {
					topic = new TopicEvent( EVENT_TOPIC );
					topic.mode = TopicEvent.MODE_NOTOPIC;
					topic.win = tokens[ 3 ];
					topic.msg = message;
					
					dispatchEvent( topic );
				}
				break;
				
				case Commands.NOTICE: {
					var notice: NoticeEvent = new NoticeEvent( EVENT_NOTICE );
					notice.text = message;
					notice.user = User.getUserFromAddress( tokens[ 0 ].substring( 1 ) );
					
					dispatchEvent( notice );
				}
				break;
				
				case Commands.RPL_CHANNELCREATED: {
					// TODO: ajouter le code pour récupéré le token timestamp
					// irc.server.com 329 nick #chan 113975236
				}
				break;
				
				case Commands.RPL_CHANNELMODES: {
					var mode: ModeEvent = new ModeEvent( EVENT_MODE );
					mode.chan = tokens[ 3 ];
					mode.mode = tokens[ 4 ]
					
					for ( var ii: int = 5; ii < tokens.length; ii++ )
						mode.mode += ' ' + tokens[ ii ];
					
					dispatchEvent( mode );
				}
				break;
				
				case Commands.JOIN: {
					var join: JoinEvent = new JoinEvent( EVENT_JOIN );
					join.user = User.getUserFromAddress( tokens[ 0 ].substring( 1 ) );
											
					join.chan = tokens[ 2 ];
										
					if ( join.user.nick == nickName )
						sock.sendString( 'MODE ' + join.chan );
					
					dispatchEvent( join );
				}
				break;
				
				case Commands.PART: {
					var part: PartEvent = new PartEvent( EVENT_PART );
					part.user = User.getUserFromAddress( tokens[ 0 ].substring( 1 ) );
					part.chan = tokens[ 2 ];
					part.msg = message;
					
					dispatchEvent( part );
				}
				break;
				
				case Commands.INVITE: {
					// On peut gérer cette commande avec un événement puisque l'utiliser peut joindre un channel automatiquement
					var user_: User = User.getUserFromAddress( tokens[ 0 ].substring( 1 ) );
					lastStatusMessage = user_.nick + ' invited you to join ' + tokens[ 3 ].substring( 1 );
					
					dispatchEvent( new Event( EVENT_STATUSMESSAGE ) );
				}
				break;
				
				case Commands.TOPIC: {
					var u: User = User.getUserFromAddress( tokens[ 0 ].substring( 1 ) );			
					var t: TopicEvent = new TopicEvent( EVENT_TOPIC );
					var topicBy: TopicEvent = new TopicEvent( EVENT_TOPIC );
					var time: Date = new Date();
					
					t.mode = TopicEvent.MODE_TOPIC;
					topicBy.mode = TopicEvent.MODE_SETBY;					
					
					t.win = topicBy.win = tokens[ 2 ];
					
					t.msg = message;
					topicBy.msg = u.nick + ' ' + ( ( time.getTime() / 1000 ) | 0 );
					
					dispatchEvent( t );
					dispatchEvent( topicBy );
				}
				break;
				
				// Message privé
				case Commands.PRIVMSG: {
					var pmsg: PrivmsgEvent = new PrivmsgEvent( EVENT_PRIVMSG );
					pmsg.win = tokens[ 2 ];
					pmsg.user = User.getUserFromAddress( tokens[ 0 ].substring( 1 ) );
					pmsg.msg = message;
					
					dispatchEvent( pmsg );
				}
				break;
				
				//Changement de nick
				case Commands.NICK: {
					var oldUser: User = User.getUserFromAddress( tokens[ 0 ].substring( 1 ) );

					if ( oldUser.nick == nickName )
						nickName = message;

					var nick: NickEvent = new NickEvent( EVENT_NICK );
					
					nick.oldUser = oldUser;
					nick.newUser = new User();
					
					nick.newUser.nick = message;
					nick.newUser.host = oldUser.host;
					nick.newUser.ident = oldUser.ident;
					
					dispatchEvent( nick );
				}
				break;
				
				case Commands.MODE: {
					var mode: ModeEvent = new ModeEvent( EVENT_MODE );
					mode.chan = tokens[ 2 ];
					mode.mode = tokens[ 3 ]
					mode.user = User.getUserFromAddress( tokens[ 0 ].substring( 1 ) );
					
					for ( var i: int = 4; i < tokens.length; i++ )
						mode.mode += ' ' + tokens[ i ];
					
					dispatchEvent( mode );
				}
				break;
				
				case Commands.KICK: {
					var kick: KickEvent = new KickEvent( EVENT_KICK );
					kick.agressor = User.getUserFromAddress( tokens[ 0 ].substring( 1 ) );
					kick.channel = tokens[ 2 ];
					kick.victim = new User();
					kick.victim.nick = tokens[ 3 ];
					kick.reason = ( message == tokens[ 3 ] ) ? '' : message;
					
					dispatchEvent( kick );
				}
				break;
				
				case Commands.QUIT: {
					var quit: QuitEvent = new QuitEvent( EVENT_QUIT );
					quit.user = User.getUserFromAddress( tokens[ 0 ].substring( 1 ) );
					quit.msg = message;
					
					dispatchEvent( quit );
				}
				break;
				
				default: {
					lastStatusMessage = input;
					dispatchEvent( new Event( EVENT_STATUSMESSAGE ) );
				}
			}
			
		}
		
		public function onInput( event: PrivmsgEvent ): void {
			if ( !registered ) 
				return;
				
			var n: int = event.msg.indexOf( '/' );
			var n2: int = event.msg.indexOf( 'me', 0 ); //no action?
			
			if ( n == 0 && n2 != 1 ) // this is a little hack because /me is not handled like a command
			{
				try
				{
					processInput( event.msg );
				}
				catch ( e: Error )
				{
					lastActiveMessage = e.message;
					dispatchEvent( new Event( EVENT_ACTIVEMESSAGE ) );
				}
			}
			else
			{
				var e: PrivmsgEvent = new PrivmsgEvent( EVENT_PRIVMSG );
				var str: String; 
				
				if ( n2 != 1 )
				{ // message
					str = 'PRIVMSG ' + event.win + ' :' + event.msg;
					e.msg = event.msg;				
				}
				else
				{ // action
					str = 'PRIVMSG ' + event.win + ' :' + String.fromCharCode( 1 ) + 'ACTION ' + event.msg.substring( 4 ) + String.fromCharCode( 1 );
					e.msg = String.fromCharCode( 1 ) + 'ACTION ' + event.msg.substring( 4 ) + String.fromCharCode( 1 );
				}
				
				sock.sendString( str );
				
				e.win = event.win;
				
				e.user = new User();				
				e.user.nick = nickName;
				e.user.ident = e.user.host = '';
				
				dispatchEvent( e );
			}
		}
		
		/*
		* 
		* 
		* 
		*/ 
		public function processInput( str: String ): void {
			// supprimer le slash et spliter la commande en tokens
			var tokens: Array = ( str.substring( 1 ) ).split( ' ' );
			var cmd: String = tokens[ 0 ].toLowerCase();
			
			switch ( cmd ){
				case 'quit':
				case 'notice':
				case 'join':
					sock.sendString( str.substring( 1 ) );
				break;
				
				//-- commande désactivée
				case 'list':
					throw new Error( '"/' + cmd + '" has been disabled.' );
				break;
				
				case 'nick':
					sock.sendString( 'NICK :' + tokens[ 1 ] );
				break;
				
				default:
					sock.sendString( str.substring( 1 ) );
				break;
			}		
		}
		
		public function getLastError(): String{			
			return lastErrorMessage;
		}
		
		// @TODO Stocker le dernier message dans l'evement ONSTATUS
		public function getLastStatusMessage(): String {
			return lastStatusMessage;
		}
		
		// @TODO Stocker le dernier message dans l'evement ONACTIVE
		public function getLastActiveMessage(): String {
			return lastActiveMessage;
		}
		

	}
}
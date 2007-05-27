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
 * 	@TODO implémenter les commandes 
 * 	@TODO implémenter le Hashtable de Vegas
 * 	
 */
package fleo.net.irc;
{
	import fleo.net.irc.InCommand;
	
	/**
	 * CommandRegister is basically a big hashMap that maps IRC
	 * identifiers to command objects that can be used as factories to
	 * do self-parsing.  CommandRegister is also the central list of
	 * commands.
	 */
	public class CommandRegister
	{

		private var commands:Hashtable;
		
		public function CommandRegister()
		{
			commands = new Hashtable();

			// Note that currently, we only have to register commands that
			// can be received from the server.
			new InviteCommand().selfRegister( this );
			new JoinCommand().selfRegister( this );
			new KickCommand().selfRegister( this );
			new MessageCommand().selfRegister( this );
			new ModeCommand().selfRegister( this );
			new NickCommand().selfRegister( this );
			new NoticeCommand().selfRegister( this );
			new PartCommand().selfRegister( this );
			new PingCommand().selfRegister( this );
			new QuitCommand().selfRegister( this );
			new TopicCommand().selfRegister( this );
			new WelcomeCommand().selfRegister( this );

			// Register errors
			new ChannelBannedError().selfRegister( this );
			new ChannelInviteOnlyError().selfRegister( this );
			new ChannelLimitError().selfRegister( this );
			new ChannelWrongKeyError().selfRegister( this );
			new NickInUseError().selfRegister( this );

			// Register replies
			new ChannelCreationReply().selfRegister( this );
			new LUserClientReply().selfRegister( this );
			new LUserMeReply().selfRegister( this );
			new LUserOpReply().selfRegister( this );
			new ModeReply().selfRegister( this );
			new NamesEndReply().selfRegister( this );
			new NamesReply().selfRegister( this );
			new TopicInfoReply().selfRegister( this );
			new WhoisChannelsReply().selfRegister( this );
			new WhoisEndReply().selfRegister( this );
			new WhoisIdleReply().selfRegister( this );
			new WhoisServerReply().selfRegister( this );
			new WhoisUserReply().selfRegister( this );
		}

		public function addCommand( ident:String,command:InCommand ):void
		{
			commands.put( ident, command );
		}

		public function getCommand( ident:String ):InCommand
		{
			return (InCommand)commands.get( ident );
		}		

	}
}

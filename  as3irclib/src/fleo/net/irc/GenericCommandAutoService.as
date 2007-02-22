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
 * 	@TODO implémenter Observable de Vegas
 * 	
 */
package fleo.net.irc;
{
	import fleo.net.irc.InCommand;
	
	/**
	 * Provides a framework for an auto service that operates with
	 * InCommands.  Does enable by default.  Splits the 'update' method
	 * into two, 'updateState' and 'updateCommand'.  Also provides thread
	 * safety on all methods.
	 */
	public class GenericCommandAutoService implements Observer
	{

		public enabled:boolean = false;
		public connection:IRCConnection;

		public function GenericCommandAutoService( connection:IRCConnection )
		{
			this.connection = connection;
			enable();
		}

		public function enable():void
		{
			if( enabled )
				return;
			
			connection.addCommandObserver( this );
			enabled = true;
		}

		public function disable():void
		{
			if( !enabled )
				return;
				
			connection.removeCommandObserver( this );
			enabled = false;
		}

		public function update( observer:Observable , updated:* ):void 
		{
			if( !enabled )
				//throw new IllegalStateException("This observer is not enabled." );
			if( updated instanceof State )
			{
				//throw new IllegalArgumentException("This is not a state observer." );
			}
			else if( updated instanceof InCommand )
			{
				updateCommand( (InCommand)updated );
			}
			else
			{
				//throw new IllegalArgumentException("Unknown object given to update.");
			}
		}

		public function getConnection():IRCConnection
		{
			return connection;
		}

		public function isEnabled():boolean
		{
			return enabled;
		}

		public function updateCommand( command:InCommand ):void
		{
			
		}


	}
		
}


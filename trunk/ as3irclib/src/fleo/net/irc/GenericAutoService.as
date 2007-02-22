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
	 * CommandRegister is basically a big hashtable that maps IRC
	 * identifiers to command objects that can be used as factories to
	 * do self-parsing.  CommandRegister is also the central list of
	 * commands.
	 */
	public class GenericAutoService extends GenericCommandAutoService
	{

		public function GenericAutoService(connection:IRCConnection)
		{
			super( connection );
		}

		public function enable():void
		{
			if( enabled )
				return;

			connection.addStateObserver( this );

			super.enable();
		}

		public function disable():void
		{
			if( !enabled )
				return;
				
			connection.removeStateObserver( this );

			super.disable();
		}

		public function update(observer:Observable, updated:* ):void
		{
			if( !enabled )
				//throw new IllegalStateException("This observer is not enabled." );
			if( updated instanceof State )
				updateState( (State)updated );
			else 
				super.update( observer, updated );
		}

		public function updateState( state:State ):void
		{
		
		}

	}
		
}


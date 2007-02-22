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
package fleo.net.irc;
{
	/**
	 * Defines an outgoing command.  Outgoing commands are very simple
	 * because all they need to do is be rendered.  Outgoing commands do
	 * not change our state.
	 *
	 * @see fleo.net.irc.commands.GenericCommand
	 */
	public interface OutCommand extends Command
	{
		/**
		 * Forms a string appropriate to send to the server, if required.
		 * Some commands will have no such string, as they are received and not
		 * sent.  The string returned is sent to the server verbatim.
		 */
		render():String;
	}
}

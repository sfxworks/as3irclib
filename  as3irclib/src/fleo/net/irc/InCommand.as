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
 * 	@TODO implémenter L'iterator de Vegas
 */
package fleo.net.irc;
{
	import fleo.net.irc.CommandRegister;
	import fleo.net.irc.clientstate.ClientState;
	import fleo.net.irc.State;
	/**
	 * Defines commands that come from the server.  Errors and replies are
	 * incoming commands.
	 *
	 * @see fleo.net.irc.commands.GenericCommand
	 * @see fleo.net.irc.errors.GenericError
	 * @see fleo.net.irc.replies.GenericReply
	 */
	public interface InCommand extends Command
	{
		/**
		 * Some commands, when received by the server, can only occur in one
		 * state.  Thus, when this command is received, the protocol should
		 * assume that it is in that state, and a state change may be
		 * triggered.  A command can use the 'unknown' state to indicate it
		 * can be received in any state (for example, ping).
		 */
		getState():State ;

		/**
		 * Every incoming command should know how to register itself with the
		 * command register.
		 */
		selfRegister(commandRegister:CommandRegister):void;

		/**
		 * Parses a string and produces a formed command object, if it can.
		 * Should return null if it cannot form the command object.  The
		 * identifier is usually ignored, except in the special case where
		 * commands can be identified by multiple identifiers.  In that case,
		 * the behaviour of the command may change in sublte ways.
		 */
		parse(prefix:String, identifier:String, params:String ):InCommand;

		/**
		 * Gives the command a copy of the raw string from the server.  Called
		 * by IRCConnection after the command is parsed.
		 */
		setSourceString(str:String):void;

		/**
		 * Allows a third party to receive a copy of the raw string.
		 */
		getSourceString():String;

		/**
		 * Asks the command to ensure that information it knows about the
		 * state the server thinks the client is in matches what we have.
		 * Returns true if state changes were made.
		 */
		updateClientState(state:ClientState):boolean ;


		/**
		 * Returns an iterator of String objects over the attribute names
		 * for this command.  Warning: Still new, support for this is not
		 * yet widespread.  Should return all possible attribute keys, not just
		 * those that have a value in the current context.
		 */
		getAttributeKeys():Iterator;

		/**
		 * Returns the attribute, or null if the attribute does not exist,
		 * or is not defined.
		 */
		getAttribute(key:String):String;

	}
}

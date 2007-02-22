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
	 * A simple container for state constants.  The state constants here
	 * are used to specify what state the protocol is in.  The State
	 * object is both the state representitive and the state container.
	 * This was done so that state could be typesafe and valuesafe.
	 *
	 */
	 
	public class State
	{
		public static var UNCONNECTED:State = new State("unconnected");
		public static var UNREGISTERED:State = new State("unregistered");
		public static var REGISTERED:State = new State("registered");
		public static var  UNKNOWN:State = new State("unknown/any");

		private var stateName:String;

		private function State( str:String )
		{
			stateName = str;
		}

		public toString():String
		{
			return stateName;
		}
	}
}

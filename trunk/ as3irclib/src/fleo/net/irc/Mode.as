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
	 * Any class which is to represent a mode must implement this
	 * interface.  They must also implement equals(...) so that if the
	 * parameter for either mode is null they are equal based on the
	 * character, and if both parameters are not null, base the equal
	 * on the character and the parameters being equal.
	 */
	public interface Mode
	{
		/**
		 * A Mode can be constructed and asked to make copies of itself.
		 */
		newInstance():Mode;
		
		/**
		 * The character that represents this mode (ie o for operator)
		 */
		getChar():char;
		
		/**
		 * Should return true if this mode requires a parameter.
		 */
		requiresParam():boolean ;

		/**
		 * This mode should be recorded in the list of channel modes.  This
		 * would NOT include such things as operator status, as it is recored
		 * with the Member object.
		 */
		recordInChannel():boolean ;
		
		/**
		 * Determines if there can be multiple versions of this mode in
		 * the channel.
		 */
		onePerChannel():boolean ;
		
		/**
		 * Returns the parameter that was set with setParam(...)
		 */
		getParam():String ;
		
		/**
		 * Sets the parameter that can be retrieved with getParam()
		 */
		setParam(str:String ):void;
		
		/**
		 * Sets the sign of the operation.  Must be positive (granting),
		 * negative (revoking) or nosign (neutral operation).
		 */
		setSign(sign:Sign):void;
		
		/**
		 * @return the sign of this mode.
		 */
		getSign():Sign;
	}
}

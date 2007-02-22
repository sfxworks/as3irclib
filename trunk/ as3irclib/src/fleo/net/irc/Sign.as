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
	public class Sign
	{
		public static var POSITIVE:Sign = new Sign( "positive" );
		public static var NEGATIVE:Sign = new Sign( "negative" );
		public static var NOSIGN:Sign = new Sign( "nosign" );
	
		private var  name:String;
		
		private function Sign( name:String )
		{
			this.name = name;
		}
	
		public function toString():String
		{
			return name;
		}
	}
}

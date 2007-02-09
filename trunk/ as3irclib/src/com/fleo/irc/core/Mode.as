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

	
	public class Mode
	{
		public var onlyOpsSetTopic: Boolean;
		public var noExternalMessages: Boolean;
		public var inviteOnly: Boolean;
		public var moderated: Boolean;
		public var key: Boolean;
		public var keyValue: String;
		public var limit: Boolean;
		public var limitValue: int;
		public var priv: Boolean;//private
		public var secret: Boolean;
		
		private var modeSet: Boolean;
		
		public var op: Array;
		public var voice: Array;
		
		public var deOp: Array;
		public var deVoice: Array;
		
		public function Mode()
		{
			onlyOpsSetTopic = false;
			noExternalMessages = false;
			inviteOnly = false;
			moderated = false;
			key = false;
			keyValue = '';
			limit = false;
			limitValue = 0;
			priv = false;
			secret = false;
			modeSet = false;
		}
		
		public function processString( mode: String ): void
		{
			modeSet = true;
			
			op = new Array;
			deOp = new Array;
			voice = new Array;
			deVoice = new Array;
						
			var tokens: Array = mode.split( ' ' );
			var tokenId: int = 1;
			var addMode: Boolean;
			var chr: String;
			
			var i: int = 0;
			var j: int = tokens[ 0 ].length;
			
			while ( i < j )
			{
				chr = tokens[ 0 ].charAt( i );
				
				if ( chr == '+' )
					addMode = true;
				else if ( chr == '-' )
					addMode = false;			
				else if ( chr == 't' )
					onlyOpsSetTopic = addMode;
				else if ( chr == 'n' )
					noExternalMessages = addMode;
				else if ( chr == 'i' )
					inviteOnly = addMode;
				else if ( chr == 'm' )
					moderated = addMode;
				else if ( chr == 'k' )
				{
					if ( addMode )
					{
						key = true;
						keyValue = tokens[ tokenId ];
						
						tokenId++;
					}
					else
					{
						key = false;
						keyValue = '';
					}
				}
				else if ( chr == 'l' )
				{
					if ( addMode )
					{
						limit = true;
						limitValue = uint( tokens[ tokenId ] );
						
						tokenId++;
					}
					else
					{
						limit = false;
						limitValue = 0;
					}
				}
				else if ( chr == 'p' )
					priv = addMode;
				else if ( chr == 's' )
					secret = addMode;
				else if ( chr == 'o' )
				{
					if ( addMode )
						op.push( tokens[ tokenId ] );
					else
						deOp.push( tokens[ tokenId ] );
						
					tokenId++;
				}
				else if ( chr == 'v' )
				{
					if ( addMode )
						voice.push( tokens[ tokenId ] );
					else
						deVoice.push( tokens[ tokenId ] );
				}
								
				i++;
			}
		}
		
		public function toString(): String
		{
			if ( !modeSet )
				return '+?';
				
			var modeString: String = '';
			
			if ( onlyOpsSetTopic )
				modeString += 't';
			
			if ( noExternalMessages )
				modeString += 'n';
			
			if ( inviteOnly )
				modeString += 'i';
			
			if ( moderated )
				modeString += 'm';
			
			if ( key )
				modeString += 'k';
			
			if ( limit )
				modeString += 'l';
			
			if ( priv )
				modeString += 'p';
			
			if ( secret ) 
				modeString += 's';
				
			//-- attributes are automatic in correct order, because we check key first and then the limit
			if ( keyValue != '' )
				modeString += ' ' + keyValue;
				
			if ( limitValue != 0 )
				modeString += ' ' + limitValue;

			
			return '+' + modeString;
		}
		
		public function isEmpty(): Boolean
		{
			return modeSet;
		}
	}
}
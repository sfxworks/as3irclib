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
	public class User
	{
		public var nick: String;
		public var ident: String;
		public var host: String;

		private var mail:String;
		private var altnick:String;
		private var description:String;
		private var pass:String;
	
		public function User()
		{
			nick = ident = host = '';
		}
		
		public function getMask(): String
		{
			return (nick + '!' + ident + '@' + host);
		}
		
		 /**
		 * retourne la description.
		 **/
		public function getDescription():String {
			return description;
		}

		/**
		 * Definit une nouvelle description pour User.
		 **/
		public function setDescription(description:String ):void {
			this.description = description;
		}

		/**
		 * Retounre l'adresse email.
		 **/
		public function getMail():String {
			return mail;
		}

		/**
		 * Definit une nouvelle adresse email pour l'utilisateur User
		 **/
		public function setMail(mail:String):void {
			this.mail = mail;
		}

		/**
		 * Renvois le nick de l'utilisateur
		 **/
		public function getNick():String {
			return nick;
		}
		/**
		 * Definit le password de l'utilisateur
		 **/
		public function setPass(pass:String):void {
			this.pass = pass;
		}

		/**
		 * Renvois le nick de l'utilisateur
		 **/
		public function  getPass():String {
			return pass;
		}

		/**
		 * Definit un nouveau nick.
		 **/
		public function setNick(nick:String ):void {
			this.nick = nick;
		}

		/**
		 * Renvois le nick alternatif de l'utilisateur
		 **/
		public function getAltnick():String {
			return altnick;
		}

		/**
		 * Definit un nouveau altnick.
		 **/
		public function setAltnick(altnick:String):void {
			this.altnick = altnick;
		}

	
		/*
		* 	Convertir la chaine d'adrese en objet User
		* 	@param address
		*/ 
		static public function getUserFromAddress( address: String ): User {
			var user: User = new User();
			var exp: Array = address.match( /(.+?)\!(.+?)\@(.+)/ );
			
			if ( exp == null )
			{
				user.nick = address;
				user.ident = user.host = '';
			}
			else
			{
				user.nick  = exp[ 1 ];
				user.ident = exp[ 2 ];
				user.host  = exp[ 3 ];
			}
			
			return user;
		}		
	}
}
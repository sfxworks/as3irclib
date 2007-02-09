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
	/*
	*	http://www.iprelax.fr/irc/irc_rfcfr4.php
	*/
	public class Commands
	{
		//-- Listes des erreurs renvoyés par le serveur 
		static public const ERR_UNKNOWNCOMMAND: String = '421';
		static public const ERR_NOMOTD: String = '422';
		static public const ERR_NOADMININFO: String = '423';
		static public const ERR_NONICKNAMEGIVEN: String = '431';
       	static public const ERR_ERRONEUSNICKNAME: String = '432';
		static public const ERR_NICKNAMEINUSE: String = '433';
		static public const ERR_NOSUCHNICK: String = '401';
		static public const ERR_NOSUCHSERVER: String = '402';
		static public const ERR_NOSUCHCHANNEL: String = '403';
		static public const ERR_TOOMANYCHANNELS: String = '405';
		static public const ERR_TOOMANYTARGETS: String = '407';
		static public const ERR_NOSUCHSERVICE: String = '408';
		static public const ERR_NOORIGIN: String = '409';
		static public const ERR_NORECIPIENT: String = '411';
		static public const ERR_NOTEXTTOSEND: String = '412';
		static public const ERR_NOTOPLEVEL: String = '413';
		static public const ERR_WILDTOPLEVEL: String = '414';
		static public const ERR_BADMASK: String = '415';
		static public const ERR_UNAVAILRESOURCE: String = '437';
		static public const ERR_NOTONCHANNEL: String = '442';
		static public const ERR_USERONCHANNEL: String = '443';
		static public const ERR_NOLOGIN: String = '444';
		static public const ERR_NOTREGISTERED: String = '451';
		static public const ERR_NEEDMOREPARAMS: String = '461';
		static public const ERR_ALREADYREGISTRED: String = '462';
		static public const ERR_PASSWDMISMATCH: String = '464';
		static public const ERR_YOUREBANNEDCREEP: String = '465';
		static public const ERR_YOUWILLBEBANNED: String = '466';
		static public const ERR_KEYSET: String = '467';
		static public const ERR_NOPRIVILEGES: String = '481';
		static public const ERR_CHANOPRIVSNEEDED: String = '482';
		static public const ERR_UMODEUNKNOWNFLAG: String = '501';
		static public const ERR_USERSDONTMATCH: String = '502';
		static public const ERR_WASNOSUCHNICK: String = '406';
		static public const ERR_USERNOTINCHANNEL: String = '441';
		static public const ERR_CANNOTSENDTOCHAN: String = '404';
		static public const ERR_CHANNELISFULL: String = '471';
		static public const ERR_UNKNOWNMODE: String = '472';
		static public const ERR_INVITEONLYCHAN: String = '473';
		static public const ERR_BANNEDFROMCHAN: String = '474';
		static public const ERR_BADCHANNELKEY: String = '475';
		static public const ERR_BADCHANMASK: String = '476';
		static public const ERR_NOCHANMODES: String = '477';
		static public const ERR_BANLISTFULL: String = '478';
		
		//-- Echange client-server
		static public const RPL_WELCOME: String = '001';
		static public const RPL_YOURHOST: String = '002';
		static public const RPL_CREATED: String = '003';
		static public const RPL_MYINFO: String = '004';
		static public const RPL_BOUNCE: String = '005';
		static public const RPL_LUSERCLIENT: String = '251';
		static public const RPL_LUSEROP: String = '252';
		static public const RPL_LUSERUNKNOWN: String = '253';
		static public const RPL_LUSERCHANNELS: String = '254';
		static public const RPL_LUSERME: String = '255';
		
		//-- Message of the day
		/*
		Lorsque le serveur répond à un message MOTD et que le fichier MOTD 
		est trouvé, le fichier est affiché ligne par ligne, 
		chaque ligne ne devant pas dépasser 80 caractères, 
		en utilisant des réponses au format RPL_MOTD. 
		Celles-ci doivent être encadrées par un RPL_MOTDSTART 
		(avant les RPL_MOTDs) et un RPL_ENDOFMOTD (après).
		*/
		static public const RPL_MOTDSTART: String = '375';
		static public const RPL_MOTD: String = '372';
		static public const RPL_ENDOFMOTD: String = '376';
		
		//-- NAME
		/*
		En réponse à un message NAMES, une paire consistant de RPL_NAMREPLY et RPL_ENDOFNAMES
		 est renvoyée par le serveur au client. 
		 S'il n'y a pas de canal résultant de la requête, 
		 seul RPL_ENDOFNAMES est retourné. 
		 L'exception à cela est lorsqu'un message NAMES est envoyé sans 
		 paramètre et que tous les canaux et contenus visibles sont renvoyés 
		 en une suite de message RPL_NAMEREPLY avec un RPL_ENDOFNAMES indiquant la fin.
		*/
		static public const RPL_NAMREPLY: String = '353';
		static public const RPL_ENDOFNAMES: String = '366';
                            
		//-- TOPIC
		/*
		Lors de l'envoi d'un message TOPIC pour déterminer le sujet d'un canal, 
		une de ces deux réponses est envoyée. Si le sujet est défini, 
		RPL_TOPIC est renvoyée, sinon c'est RPL_NOTOPIC.
		*/
		static public const RPL_NOTOPIC: String = '331';
		static public const RPL_TOPIC: String = '332';
		static public const RPL_TOPICSETBY: String = '333';

		//-- MODE
		static public const RPL_CHANNELCREATED: String = '329';
		static public const RPL_CHANNELMODES: String = '324';

		//-- data event
		static public const NOTICE: String = 'notice';
		static public const MODE: String = 'mode';
		static public const JOIN: String = 'join';
		static public const PART: String = 'part';
		static public const PRIVMSG: String = 'privmsg';
		static public const PING: String = 'ping';
		static public const ERROR: String = 'error';
		static public const INVITE: String = 'invite';
		static public const TOPIC: String = 'topic';
		static public const NICK: String = 'nick';
		static public const KICK: String = 'kick';
		static public const QUIT: String = 'quit';
	}
}
package com.fleo.irc.core
{

	public class ChannelItem
	{
		private var name:String;
		private var size:uint ;
		private var topic:String;

		public function ChannelItem(name:String, size:uint, topic:String)
		{
			this.name = name;
			this.size = size;
			this.topic = topic;
		}

		public function getName():String
		{
			return(name);
		}

		public function getUsersCount():uint
		{
			return(size);
		}

		public function getTopic():String
		{
			return(topic);
		}
	}
}
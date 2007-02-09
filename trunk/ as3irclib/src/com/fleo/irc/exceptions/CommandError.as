package com.fleo.irc.exceptions
{
	class CommandError extends Error
	{
		function CommandError(message:String, errorID:int)
		{
			super(message, errorID);
		}

	}
}
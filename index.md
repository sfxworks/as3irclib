# Introduction #

The purpose of this framework is :

  * To provide a medium-level interface into the IRC protocol, for use by any kind of Flash program .
  * make sending and receiving IRC commands as painless as possible by providing Actionscript 3 objects to manipulate the commands.
  * Maintain information regarding the state of the client. This includes:

  1. Information for each channel that the client is in (mode, users, topic)
  1. The client's nick
  1. The client's registration/connection status
  1. The client's mode
  1. misc. statistics

  * Change the client's state as a result of commands from the server.  The client's state does not change as a result of commands sent by the application.
  * Make automatic responses to some commands, such as PING.  The command should still be passed to the application, but should be marked as processed.

# IRC Command #
Commands are the critical link between the application and the framework.
Commands enter into the framework and are consumed in two ways:

1) A command is created by the application and passed off to the framework for
sending.  The framework will ask the command for a string representation and discard the command.

2) A command is received by the framework from the server.  It must be parsed into an object, and then processed by the framework and passed on to the application.

# Design (futur) #

This framework is designed to be flexible and extendable. Information from the server is stored in the ClientState and Commands are parsed and sent out from the IRCConnection class as events.
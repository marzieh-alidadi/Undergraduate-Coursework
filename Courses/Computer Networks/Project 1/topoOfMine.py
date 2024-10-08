#Marzieh Alidadi 9631983

from mininet.topo import Topo
 
class TopoOfMine( Topo ):

	def __init__ ( self ):


		Topo.__init__(self)

		Host1 = self.addHost( 'h1' )
		Host2 = self.addHost( 'h2' )
		Host3 = self.addHost( 'h3' )
		Host4 = self.addHost( 'h4' )
		Host5 = self.addHost( 'h5' )
		Host6 = self.addHost( 'h6' )
		Host7 = self.addHost( 'h7' )
		Host8 = self.addHost( 'h8' )
		Host9 = self.addHost( 'h9' )
		Host10 = self.addHost( 'h10' )
		Host11 = self.addHost( 'h11' )
		Host12 = self.addHost( 'h12' )

		Switch1 = self.addSwitch( 's1' )
		Switch2 = self.addSwitch( 's2' )
		Switch3 = self.addSwitch( 's3' )
		Switch4 = self.addSwitch( 's4' )
		Switch5 = self.addSwitch( 's5' )
		Switch6 = self.addSwitch( 's6' )
		Switch7 = self.addSwitch( 's7' )
		Switch8 = self.addSwitch( 's8' )
		Switch9 = self.addSwitch( 's9' )
		Switch10 = self.addSwitch( 's10' )
		Switch11 = self.addSwitch( 's11' )
		Switch12 = self.addSwitch( 's12' )
		Switch13 = self.addSwitch( 's13' )
		Switch14 = self.addSwitch( 's14' )
		Switch15 = self.addSwitch( 's15' )
		Switch16 = self.addSwitch( 's16' )
		Switch17 = self.addSwitch( 's17' )

		self.addLink( Switch1, Switch2 )
		self.addLink( Switch1, Switch3 )
		self.addLink( Switch1, Switch4 )
		self.addLink( Switch1, Switch5 )
		self.addLink( Switch2, Switch6 )
		self.addLink( Switch2, Switch7 )
		self.addLink( Switch2, Switch8 )
		self.addLink( Switch3, Switch9 )
		self.addLink( Switch3, Switch10 )
		self.addLink( Switch3, Switch11 )
		self.addLink( Switch4, Switch12 )
		self.addLink( Switch4, Switch13 )
		self.addLink( Switch4, Switch14 )
		self.addLink( Switch5, Switch15 )
		self.addLink( Switch5, Switch16 )
		self.addLink( Switch5, Switch17 )
		self.addLink( Switch6, Host1 )
		self.addLink( Switch7, Host2 )
		self.addLink( Switch8, Host3 )
		self.addLink( Switch9, Host4 )
		self.addLink( Switch10, Host5 )
		self.addLink( Switch11, Host6 )
		self.addLink( Switch12, Host7 )
		self.addLink( Switch13, Host8 )
		self.addLink( Switch14, Host9 )
		self.addLink( Switch15, Host10 )
		self.addLink( Switch16, Host11 )
		self.addLink( Switch17, Host12 )
		

topos = { 'topoofmine': ( lambda: TopoOfMine() ) }


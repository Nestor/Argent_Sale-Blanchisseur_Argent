AS_not = {
	"Va jouer ailleur",
	"Shut up",
	"Bouge de la"
};

AS_not_sond = {
	"vo/npc/male01/busy02.wav",
	"vo/npc/male01/hi01.wav",
	"vo/npc/male01/hi02.wav",
	"vo/npc/male01/answer17.wav"	
};

AS_yes = {
	"Merci",
	"Bon travail"
};

AS_yes_sond = {
	"vo/npc/male01/fantastic01.wav", 
	"vo/npc/male01/fantastic02.wav",
	"vo/npc/male01/gotone01.wav",
	"vo/npc/male01/gotone01.wav",
	"vo/npc/male01/finally.wav",
	"vo/npc/male01/oneforme.wav",
	};

-- Captain Obvious
AS_Name = "Blanchisseur d'argent";
-- Captain Obvious 2
AS_Model = "models/gman_high.mdl";

AS_Taxe = 0.10 -- le npc va prendre 25% de l'argent sale du joueur !

AS_MoneyMax = 50000 -- si le joueur a 20000 € sur lui alors il va commencer a faire tomber des sous (argent sale) par terre
AS_DropAmout = 0.25 -- si le joueur a trop de sous sur lui il va faire tomber 25% de son argent

AS_TimeDrop = 60 -- toute les 120 seconde le joueur va faire tomber des sous si il a trop d'argent sale sur lui

-- la peur du pnj (chaque dégat = 1 donc si AS_Scary = 10 il faut 10 coups pour  que le npc donne les noms de ses clients)
AS_Scary = 10

-- le nom de tout les flics !
Cops_Job = {"Directeur de la prison","Psycologue de la prison","Garde du corps du directeur","*PREMIUM* Pilote d'hélicopteur","*VIP*Chef des gardiens de prison","Gardien de prison corrompu","Gardien des serveurs","Gardien de la cour","Gardien de l'exterieur","Gardien de l'interieur","Gardien Polyvalent","Chef du GIGN","GIGN","Mirador","Maitre chien de la prison","Chien de garde","*VIP+* Chef des miradors","*VIP* Pilote de drone","Brigade anti-émeute","*VIP+* Chef Unitée anti-émeute"}

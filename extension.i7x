Version 1.0.200001 of BRP by Daniel Maxson begins here.
"Implements the ORC-Licensed Basic Roleplaying SRD from Chaosium Games"
[The version numbering is a little strange because it's intended to follow the version numbering of the SRD that is implemented, with an additional level to allow for iteration of Inform implementation. But Inform versioning only allows for three levels of depth, so we pack the Inform implementation semantic version of the implementation into the "debug" level: 1 digit for major version, 2 digits for minor version, 2 digits for bugfix version. Ergo a 0.0.1 implementation of the 1.0.2 SRD is 1.0.2.0.0.1 -> 1.0.200001]


[ VTC enables us to simulate the time different skill uses and combat take per the BRP rules]
Include Variable Time Control by Eric Eve.

BRP Verbosity is initially true. [ This controls whether BRP rolls are shown while playing ]

Chapter 0 - Preamble

Section 1 - Acknowledgements

[ Thanks to Chaosium for the BRP SRD that allows this project to exist ]
[ Thanks to Andrew Plotkin for helping work around a bug in table traversal ]

Chapter 1 - Introduction

Section 1 - Legal Licensing Stuff

[
This product is licensed under the ORC License held in the License of Congress at TX-307-067 and available online at various locations including www.chaosium.com/orclicense, www.azoralaw.com/orclicense, www.gencon.com/orclicense and others. All warranties are disclaimed as set forth therein.

Attribution: 
	BRP: Universal Engine
	Chaosium
	With a very few exceptions (trademarked terms), the text of BASIC ROLEPLAYING: UNIVERSAL GAME ENGINE is available for personal and commercial use under the ORC license. The reproduction of artwork, illustrations, graphic design, and trade dress from this book for the purposes of personal or corporate profit, by photographic, optical, electronic, or other media or methods of storage and retrieval, is prohibited.
	
Reserved Material: No original content of this extension is reserved.

Expressly Designated Licensed Material: Any original content of this extension not licensed from Chaosium is expressly licensed under the ORC License.
]

[Figure of the BRP ORC Logo is the file "brplogo.png" ("The logo of Chaosium's Basic Roleplaying System Reference Document").
When play begins:
	display the Figure of the BRP ORC Logo.]

Section 2 - Dice

A die roll is a kind of value. -3d100 specifies a die roll with parts amount and sides.

To decide which number is the result of (the roll - a die roll):
	let dice rolled be 0;
	let sum be 0;
	while dice rolled is less than the amount part of the roll:
		let rolled val be a random number from 1 to the sides part of the roll;
		let sum be sum + rolled val;
		let dice rolled be dice rolled + 1;
	decide on sum.

Chapter 2 - Character Creation

Section 1 - The Character Sheet

Section 2 - Identity

A person has a text called name. The name of a person is usually "Unnamed".
A person has a text called race. The race of a person is usually "Unidentifiable". [This could be more formally implemented, e.g. with a table, if it was relevant for a particular game]
[Gender is natively implemented by Inform]
A person can be right-handed or left-handed. A person is usually right-handed.
Height is a kind of value. 1 cm specifies a height. 1cm specifies a height. 
A person has a height. The height of a person is usually 171cm. [ Average human height - override as needed for your game ]
Weight is a kind of value. 1 kg specifies a weight. 1kg specifies a weight. 
A person has a weight. The weight of a person is usually 62kg. [ Average human weight - overide as needed for your game ]
[Descriptions are natively implemented by Inform]
A person has a number called age. The age of a person is usually 35. [ Approximate median age in some parts of the UK - override as needed for your game ]
[Distinctive features are varied enough to warrant implementation in individual games]
[TODO: Implement professions]

Section 3 - Characteristics

[TODO: Replace this representation of characteristics because when we roll against them we want to roll against Characteristics as a distinct kind of value, not just numbers generally]
[Characteristic is a kind of value. 

A person has a number called strength. The strength of a person is usually 10.
A person has a number called constitution. The constitution of a person is usually 10.
A person has a number called size. The size of a person is usually 10.
A person has a number called intelligence. The intelligence of a person is usually 10.
A person has a number called power. The power of a person is usually 10.
A person has a number called dexterity. The dexterity of a person is usually 10.
A person has a number called appearance. The appearance of a person is usually 10.

To roll the characteristics of (P - person):
	now the strength of P is the result of 3d6;
	now the constitution of P is the result of 3d6;
	now the size of P is the result of 3d6;
	now the intelligence of P is the result of 3d6;
	now the power of P is the result of 3d6;
	now the dexterity of P is the result of 3d6;
	now the appearance of P is the result of 3d6.
	
When play begins:
	roll the characteristics of yourself.]

Section 4 - Characteristic Rolls

[The reason to have a table of characteristics instead of tracking them as raw numbers is so we can roll against Characteristics as a specific type which is more ergonomic]
Characteristic is a kind of value. The characteristics are defined by the Table of Characteristics.

Table of Characteristics
Characteristic	Abbreviation	Default
strength	"STR"	10
constitution	"CON"	10
size	"SIZ"	10
intelligence	"INT"	10
power	"POW"	10
dexterity	"DEX"	10
appearance	"APP"	10

Table of Character Characteristics
CharacterCharacteristic (text)	Points (number)
--	--

A characteristic roll is a kind of value. The characteristic rolls are defined by the Table of Characteristic Rolls.

Table of Characteristic Rolls
Roll		Characteristic (characteristic)
effort		strength
stamina		constitution
idea		intelligence
luck		power
agility		dexterity
charisma		appearance

To decide which number is the (C - characteristic) value of (P - a person):
	Let LP be "[P]-[C]";
	Let T be the Table of Character Characteristics;
	If LP is a CharacterCharacteristic listed in T:
		choose the row with a CharacterCharacteristic of LP in the Table of Character Characteristics;
		decide on the Points entry;
	otherwise:
		decide on the Default of C.
		
To set the (C - characteristic) value of (P - a person) to (N - number):
	Let LP be "[P]-[C]";
	If LP is a CharacterCharacteristic listed in Table of Character Characteristics:
		choose the row with a CharacterCharacteristic of LP in the Table of Character Characteristics;
		Now the Points entry is N;
	Otherwise:
		say "Oh dear, something tried to set the [C] characteristic of [P] to [N], but that character and characteristic pairing was not authored. Please contact your friendly local game developer and notify them of this bug."
		
To set (P - a person)'s (C - characteristic) value to (N - number): [ A natural alias of the above command ]
	set the C value of P to N.

To decide which result is the (R - characteristic roll) roll for (P - a person) - (D - skill roll difficulty) :
	let rolled val be a random number from 1 to 100;
	let C be the Characteristic of R;
	let effective value be the C value of P * 5;
	if D is easy:
		let effective value be effective value times 2;
	otherwise if D is difficult:
		let effective value be effective value divided by 2;
	if BRP Verbosity is true:
		say "[The printed name of P] rolled [rolled val] against an effective [R] value of [effective value] (Difficulty: [D]).[paragraph break]" in sentence case;
	if rolled val <= 0.2 times effective value:
		decide on special;
	otherwise if rolled val <= effective value:
		decide on success;
	otherwise if effective value <= 10 and rolled val >= 96:
		decide on fumble;
	otherwise if effective value <= 30 and rolled val >= 97:
		decide on fumble;
	otherwise if effective value <= 50 and rolled val >= 98:
		decide on fumble;
	otherwise if effective value <= 70 and rolled val >= 99:
		decide on fumble;
	otherwise if rolled val is 100:
		decide on fumble;
	otherwise:
		decide on failure.
		
To decide which result is the (R - characteristic roll) roll for (P - a person):
	decide on the R roll for P - normal.

Section 5 - Derived Characteristics

A person has a number called move. The move of a person is usually 10. [The default for humans]
To decide what number is the hit points of (P - person):
	decide on the size value of P + the constitution value of P / 2.
To decide what number is the maximum power points of (P - person):
	decide on the power value of P.
To decide what number is the damage bonus of (P - person):
	let i be the strength value of P + the size value of P;
	decide on the result of the damage modifier corresponding to a STRSIZ of i in Table 2.5.1.

Table 2.5.1 - Damage Bonus
STRSIZ	Damage Modifier
2	-1d6
3	-1d6
4	-1d6
5	-1d6
6	-1d6
7	-1d6
8	-1d6
9	-1d6
10	-1d6
11	-1d6
12	-1d6
13	-1d4
14	-1d4
15	-1d4
16	-1d4
17	0d6
18	0d6
19	0d6
20	0d6
21	0d6
22	0d6
23	0d6
24	0d6
25	1d4
26	1d4
27	1d4
28	1d4
29	1d4
30	1d4
31	1d4
32	1d4
33	1d6
34	1d6
35	1d6
36	1d6
37	1d6
38	1d6
39	1d6
40	1d6
41	2d6
42	2d6
43	2d6
44	2d6
45	2d6
46	2d6
47	2d6
48	2d6
49	2d6
50	2d6
51	2d6
52	2d6
53	2d6
54	2d6
55	2d6
56	2d6

Section 6 - Skills

Skill is a kind of value. The skills are defined by the Table of Skills.

[TODO: Figure out what makes sense for skills based on characteristics]
[The reason for the table rather than making skill a number is that we want to perform many operations involving skills (making skill rolls, contests, and so on), and we need to be able to reference skills by name, especially to enable games to extend the skill list and have all the skill mechanics work seamlessly with their new skills]
Table of Skills	
Skill	Skill Base Chance
Appraise	15
Art	5
Bargain	5
Brawl	25
Climb	40
Command	5
Craft	5
Demolition	1
Disguise	1
Drive	20
Etiquette	5
Fast Talk	5
Fine Manipulation	5
First Aid	30
Grapple	25
Heavy Machine	1
Hide	10
Insight	5
Jump	25
Knowledge	5
Listen	25
Martial Arts	1
Medicine	5
Navigate	10
Perform	5
Persuade	15
Pilot	1
Psychotherapy	1
Repair	15
Research	25
Ride	5
Science	1
Sense	10
Sleight of Hand	5
Spot	25
Status	15
Stealth	10
Strategy	1
Swim	25
Teach	10
Technical Skill	0
Throw	25
Track	10


Table of Character Skills
CharacterSkill (text)	Points (number)
--	--


To set the (S - skill) rating of (P - a person) to (N - number):
	Let LP be "[P]-[S]";
	If LP is a CharacterSkill listed in Table of Character Skills:
		choose the row with a CharacterSkill of LP in the Table of Character Skills;
		Now the Points entry is N;
	Otherwise:
		say "Oh dear, something tried to set the skill points of [P] in [S] to [N], but that character and skill pairing was not authored. Please contact your friendly local game developer and notify them of this bug."

To decide which number is the (S - skill) level of (T - a thing):
	say "<ERROR: You cannot get the skill level of a non-person.>";
	decide on 0.

To decide which number is the (S - skill) rating of (P - a person):
	Let LP be "[P]-[S]";
	Let T be the Table of Character Skills;
	If LP is a CharacterSkill listed in T:
		choose the row with a CharacterSkill of LP in the Table of Character Skills;
		decide on the Points entry;
	otherwise:
		decide on the skill base chance of S. [If the skill's not authored for the person, it's untrained]

To increment the (S - skill) rating of (P - a person):
	set the S rating of P to the S level of P + 1.

Section 7 - Professions and Professional Skills

[TODO: This is basically character creation stuff - first, pick a profession, then assign 300 skill points to its professional skills]

Section 8 - Personal Skills

To decide which number is the maximum personal skill points of (P - person):
	decide on the intelligence value of P * 10.
	
[TODO: Assign personal skill points during character creation]

Section 9 - Equipment

[Everything in this section is game-specific, so not implemented here]

Section 10 - Final Touches

[Also game-specific, but consider mechanics involving origin, family, education, religion, past actions, or goals]

Chapter 3 - System

Section 1 - Success or Failure?

A result is a kind of value. The results are special, success, failure, and fumble.

To decide which result is the (S - skill) result for (P - person) - (D - skill roll difficulty):
	let rolled val be a random number from 1 to 100;
	let effective skill be the S rating of P;
	if D is easy:
		let effective skill be effective skill times 2;
	otherwise if D is difficult:
		let effective skill be effective skill divided by 2;
	if BRP Verbosity is true:
		say "[The printed name of P] rolled [rolled val] against an effective [S] value of [effective skill] (Difficulty: [D]).[paragraph break]"  in sentence case;
	if rolled val <= 0.2 times effective skill:
		decide on special;
	otherwise if rolled val <= effective skill:
		decide on success;
	otherwise if effective skill <= 10 and rolled val >= 96:
		decide on fumble;
	otherwise if effective skill <= 30 and rolled val >= 97:
		decide on fumble;
	otherwise if effective skill <= 50 and rolled val >= 98:
		decide on fumble;
	otherwise if effective skill <= 70 and rolled val >= 99:
		decide on fumble;
	otherwise if rolled val is 100:
		decide on fumble;
	otherwise:
		decide on failure.
		
To decide which result is the (S - skill) result for (P - person):
	decide on the S result for P - normal.

Section 2 - Skill Rolls

A skill roll difficulty is a kind of value. The skill roll difficulties are easy, normal, and difficult.

Section 3 - Skill vs Skill

[A stalemate is when both parties fail. A tie is when both parties achieve an equal degree of success.]
[In the event of a tie, the person with the highest rating in the skill wins.]
[Defeat is when A loses to B, or in other words is a victory for B.]
A contest result is a kind of value. The contest results are contest stalemate, contest tied, contest won, and contest lost.

Table of Contest Results
Actor Result	Special	Success	Failure
special	contest tied	contest won	contest won
success	contest lost	contest tied	contest won
failure	contest lost	contest lost	contest stalemate

To decide which contest result is the result of a contest between (A - person) using (SA - skill) and (B - person) using (SB - skill):
	let AR be the SA result for A;
	let BR be the SB result for B;
	if AR is special:
		if BR is special:
			if the SA rating of A is greater than the SB rating of B:
				decide on contest won;
			else if the SB rating of B is greater than the SA rating of A:
				decide on contest lost;
			else:
				decide on contest tied;
		else:
			if BRP Verbosity is true:
				say "[no-time][The printed name of A] won the contest using [SA] against [the printed name of B] using [SB].";
			decide on contest won;
	if AR is success:
		if BR is special:
			say "[no-time][The printed name of A] lost the contest using [SA] against [the printed name of B] using [SB].";
			decide on contest lost;
		else if BR is failure or BR is fumble:
			say "[no-time][The printed name of A] won the contest using [SA] against [the printed name of B] using [SB].";
			decide on contest won;
		else:
			if the SA rating of A is greater than the SB rating of B:
				say "[no-time][The printed name of A] won the contest using [SA] against [the printed name of B] using [SB].";
				decide on contest won;
			else if the SB rating of B is greater than the SA rating of A:
				say "[no-time][The printed name of A] lost the contest using [SA] against [the printed name of B] using [SB].";
				decide on contest lost;
			else:
				say "[no-time][The printed name of A] tied in the contest using [SA] against [the printed name of B] using [SB].";
				decide on contest tied;
	if AR is failure or AR is fumble:
		if BR is failure or BR is fumble:
			say "[no-time][The printed name of A] stalemated in the contest using [SA] against [the printed name of B] using [SB].";
			decide on contest stalemate;
		else:
			say "[no-time][The printed name of A] lost the contest using [SA] against [the printed name of B] using [SB].";
			decide on contest lost.
			

Section 4 - The Resistance Table

A resistance result is a kind of value. The resistance results are resistance overcome, resistance held, and impossible resistance.

To decide which resistance result is the resistance result for (attacker - a number) against (defender - a number):
	let D be defender - attacker;
	let target be 50;
	if D >= 10:
		if BRP Verbosity is true:
			say "[no-time]Resistance check is impossible. Defender: [defender] >= 10 + Attacker: [attacker].";
		decide on impossible resistance;
	else:
		if attacker > defender:
			now target is 50 + (attacker - defender) times 5;
		else if defender > attacker:
			now target is 50 - (defender - attacker) times 5;
	let DR be the result of 1d100;
	if DR <= target:
		if BRP Verbosity is true:
			say "[no-time]Resistance overcome by Attacker: [attacker] vs Defender: [defender] - Roll of [DR] against [target].";
		decide on resistance overcome;
	else:
		if BRP Verbosity is true:
			say "[no-time]Resistance held by Defender: [defender] vs Attacker: [attacker] - Roll of [DR] against [target].";
		decide on resistance held.

Section 5 - Experience

[Because in the TTRPG implementation this is given at the end of an adventure rather than every time the skill is used, this is left for the game designer to trigger at the time they deem appropriate for their game.]

To give (P - a person) experience in (S - a skill):
	if BRP verbosity is true:
		say "[line break]Rolling for [the printed name of P] to gain experience in [S]." in sentence case;
	let DR be the result of 1d100;
	if DR > the S rating of P:
		let points be the result of 1d6;
		set the S rating of P to the S rating of P + points;
		if BRP verbosity is true:
			say "[line break][The printed name of P] gained [points] in [S], which is now in [the S rating of P].[line break]";
	else:
		if BRP verbosity is true:
			say "[line break][The printed name of P] failed the d100 roll to increase experience in [S]: [DR] <= [the S rating of P].[line break]".

Chapter 4 - Time

Section 1 - Narrative Time

[Narrative time is the time it takes a player to read and consider what the game has presented - this is 'implemented' in the real world, not in Inform.]

Section 2 - The Turn

[A turn in BRP is five minutes]
[Some actions, mostly combat-related, take less time (see 'The Combat Round')]
[Other actions may take longer (see 'Skill Time')]

Section 3 - The Combat Round

[A game designer can toggle combat mode to enable combat pacing]
Combat mode is initially false.
When play begins: disable combat mode.
To enable combat mode:
	now combat mode is true;
	[ Combat rounds in BRP are 12 seconds long ]
	now seconds_per_turn is 12.
	
To disable combat mode:
	now combat mode is false;
	[ Turns in BRP take 5 minutes by default, though this can vary contextually ]
	now seconds_per_turn is 300.

Section 4 - Skill Time

[There is no uniform time that using a particular skill takes, necessarily (e.g. using the art skill can take anywhere from 5 minutes to many days depending on what exactly is happening in the narrative) - as a game author, use Variable Time Control extension to progress time an appropriate amount when performing skill checks]

Chapter 5 - Combat

Section 1 - The Combat Round

[ A combat round takes 12 seconds as implemented in section 4.3. ]
[ It consists of the following steps:
	1. Statement of Intent
	2. Movement
	3. Actions
	4. Resolution
These steps are implemented in the following sections. ]

Section 2 - Statement of Intent

[ All actors act within a boxed combat round in the following order:
	1. The actor with the highest DEX
	2. Ranged -> long weapons -> medium weapons -> short weapons / unarmed
	3. The actor with the highest skill in the weapon they'll be using
	4. Any ties at this point are resolved simultaneously ]

Section 3 - Movement

Section 4 - Actions

Section 5 - Attacking

Section 6 - Parrying

Section 7 - Dodging

Section 8 - Combat Summary

Section 9 - Weapons and Damage

Section 10 - Armor

Section 11 - Shields

Section 12 - Damage and Injury

Section 13 - Special Successes

Section 14 - Healing

Chapter 6 - Spot Rules

Section 1 - Ambush

Section 2 - Backstab

Section 3 - Cover

Section 4 - Darkness

Section 5 - Disease

Section 6 - Drawing a Weapon

Section 7 - Falling

Section 8 - Firing into Combat

Section 9 - Knockout Attacks

Section 10 - Poison

Chapter 7 - Sample Foe

BRP ends here.

---- DOCUMENTATION ----

The structure of the extension deliberately follows the structure of the SRD so implementation of features should be easy to find, but here's a summary of what is currently supported:

Assigning skill ratings to a person:
	set the (skill) rating of (person) to (number)`
	(skill) must be a member of the Table of Skills. If you want custom skills in your game, just extend the table and your new skill will work automatically like every other skill.
	An entry must already exist in the Table of Character Skills of the form "[printed name of person]-[skill][tab][number]"
	
Assigning characteristic values to a person:
	`set the (characteristic) value of (person) to (number)`
	(characteristic) must be a member of the Table of Characteristics. Theoretically you can also extend this table, but supporting that use case is out of scope for this extension, so do so at your own risk.
	An entry must already exist in the Table of Character Characteristics of the form "[printed name of person]-[characteristic][tab][number]"
	
Skill advancement:
	`give (person) experience in (skill)`
	(skill) must be a member of the Table of Skills.
	Unlike some d100 systems, advancement is not automatic. As the game designer, you must choose when to perform skill advancement for the player (or other characters!).
	
Skill rolls:
	(result): `the (skill) result for (person) - (difficulty)`
	(skill) must be a member of the Table of Skills.
	(difficulty) must be one of easy, normal, difficult.
	(result) will be one of fumble, failure, success, special.
	
Characteristic rolls:
	(result): `the (characteristic roll) roll for (person) - (difficulty)`
	(characteristic roll) must be a member of the Table of Characteristic Rolls.
	(difficulty) must be one of easy, normal, difficult.
	(result) will be one of fumble, failure, success, special.
	
Skill contests:
	(result): `the result of a contest between (person A) using (Skill A) and (person B) using (Skill B)`
	(skill X) must be a member of the Table of Skills.
	(result) will be one of contest stalemate, contest tied, contest won, and contest lost. These are from person A's perspective, so `contest won` for example means that person A won the contest.
	
Resistance rolls:
	(result): `the resistance result for (attacker) against (defender)`
	(attacker) and (defender) are both numbers. Typically you would use characteristic values, but you could also for example use skills, though you would probably want to divide by five in that case.
	(result) will be one of resistance overcome, resistance held, and impossible resistance.
	
Time tracking:
	Turns by default take five minutes per SRD specification.
	Actions can be given variable time requirements using Eric Eve's Variable Time Control which is imported by this extension.
	
Dice:
	(number): `the result of (die roll)`
	(die roll) must be of the form XdY
	
Measurements:
	Characters have the following physical properties which are not leveraged in this extension but you could leverage in your game:
		Height: must be of the form Xkg
		Weight: must be of the form Xcm
		Age: it's just a number
		
A note on version control:
	This extension aims to follow the BRP SRD as faithfully as possible, and that extends to reflecting the version of the SRD in version control. The way this extension follows that goal while also tracking its own version is by embedding its own version in the debug level of the SRD version. For example, this is an implementation of SRD version 1.0.2 and it is version 0.0.1. So we start by adding some space on the end. One digit for major version, two digits for minor and debug versions. So 1.0.2.0.0.1 becomes 1.0.200001. Yes, that means a 0.0.1 implementation of 1.0.20 would be 1.0.2000001.
	
Acknowledgements:
	Thank you to Chaosium Games for permissively licensing the Basic Roleplaying SRD so we could have an open generic roleplay system.
	Thank you to Climbingstars and Andrew Plotkin for helping work around an I7 bug in table traversal: https://intfiction.org/t/internal-error-when-using-dynamic-tables/77760/5
	Thank you to the interactive fiction community past and present for providing the inspiration for this project.
		

Example: **** Train Station - Demonstrate use of skills and characteristic rolls in a demo scene.

This tiny demo game demonstrates the supported features of the SRD.

In packing all of these into a tiny demo, it also shows how even with just four options available, these mechanics naturally lend themselves to a replayable "immersive sim"-like experience for the player that plays out a bit differently every time rather than classic text adventures that can be "solved".

	*: "Train Station"

	Include BRP by Daniel Maxson
	
	When play begins:
		now the printed name of yourself is "You". [Makes the BRP Verbosity messages read more naturally, but I'm not sure this belongs in the extension]
	
	The Platform is a room. "You emerge on a crowded platform wherein a steam locomotive's conductor makes preparations to depart. You arrived an hour early, but all the ticket stations are closed. Where will you find a ticket to board?"
	
	The great train station clock is here. "The clock overlooking the train station shows it to be [time of day]." It is fixed in place.

	A train ticket is a kind of thing.
	The creased train ticket is a train ticket.
	The pristine train ticket is a train ticket.
	
	The dapper gentleman is here. He is a man. "A dapper gentleman stands out from the crowd wearing a tuxedo, a top hat, and a monocle. All in all, exceptionally dapper. He is being worn by an even more dapper mustache![if the dapper gentleman is holding the creased train ticket] A creased train ticket sticks temptingly out of the tuxedo's left breast pocket. Perhaps you could PERSUADE him to give it to you. Or you could try to STEAL it.[else if the dapper gentleman is bereft] He is frantically scouring the platform for his ticket.[else if the dapper gentleman is annoyed] He paces the platform agitatedly.[end if]". The dapper gentleman can be calm or bereft. The dapper gentleman is calm.
	Understand "man" as the dapper gentleman.
	The dapper gentleman is holding the creased train ticket.
	
	Instead of giving something (called t) to the dapper gentleman:
		if Chicanery is happening:
			say "[5 secs]He thanks you for the ticket and wishes you a good day.";
		if Dubious Charity is happening:
			if t is the creased train ticket:
				say "[5 secs]He is amazed that you had already 'found' his ticket and thanks you profusely for its return. You probably think you're a real good samaritan, don't you?";
			else:
				say "[5 secs]He thanks you profusely for the use of 'your' ticket. You probably think you're a real good samaritan, don't you?";
		else:
			say "[no-time]He looks like he can take care of himself."
	
	The conductor is here. He is a man. "A well-dressed conductor tends to the locomotive and collects train tickets from passengers as they board the locomotive."
	
	[The win condition]
	[Some fun conditional differences to the ending depending on how the player won]
	Instead of giving a train ticket to the conductor:
		say "[no-time]You hand the conductor your newly acquired ticket. [if the ticket vending machine is smashed]He mutters something about hooligans and vandals, but accepts it and waves you on board with unconcealed contempt. [otherwise]He smiles and welcomes you on board. [end if][if Dubious Charity is happening]The dapper gentleman offers you a seat at his booth. You take it, but you'll have to live with the theft on your conscience. [otherwise if the dapper gentleman is bereft]Out the window you spy the dapper gentleman sobbing with despair on the platform as the train pulls out and you settle into your comfortable seat. [otherwise if the dapper gentleman is persuaded and the ticket vending machine is broken]The dapper gentleman boards moments before the doors close, muttering something about infernal machines. [otherwise]The dapper gentleman tips his hat as you pass by to find your seat. [end if]You made it!";
		end the story.
	
	The ticket vending machine is here. "A ticket vending machine is set up nearby. They've been replacing human station attendants for years.[if the pristine train ticket is inside the ticket vending machine and the ticket vending machine is broken] You can see a single remaining ticket behind the glass display case. You could try to REPAIR the machine to get it to dispense the ticket, or with enough brute force you could SMASH the glass.[otherwise if the ticket vending machine is repaired] It seems out of tickets, so it's a good thing you got the last one![otherwise if the pristine train ticket is inside the vending machine] A ticket flutters in the light breeze within the shattered display case.[end if]". It is a container. It is closed. It is fixed in place. The ticket vending machine can be broken, repaired, or smashed. The ticket vending machine is broken.
	Instead of opening the ticket vending machine:
		say "Try as you might, you can't seem to pry it open. You'd probably need to REPAIR the machine or SMASH the glass."
	Instead of closing the ticket vending machine:
		say "[no-time]The damage you've inflicted on the poor defenseless machine is irreparable."
	The pristine train ticket is inside the ticket vending machine.
	
	Instead of attacking a ticket vending machine:
		if the ticket vending machine is smashed:
			say "[no-time]You've already gained access to the ticket. Leave the poor machine alone!";
		if the ticket vending machine is repaired:
			say "[no-time]Really now, you would undo all your hard work?";
		if the strength value of yourself is 10:
			say "[no-time]You would need superhuman strength to even attempt to SMASH the machine with your bare hands.";
		else:
			[ Instead of a skill check, attempting to brute-force the machine is a raw characteristic roll ]
			let r be the effort roll for yourself - difficult;
			if r is failure:
				say "[5 secs]You strike the glass, but to no effect. Maybe another hit will do it.";
			else if r is fumble:
				say "[5 secs]@%&$! That HURT! You accidentally punched a rivet.";
			else if r is special:
				say "[5 secs]Pop! The glass shatters with the greatest of ease, exposing the ticket within to your herculean grasp.";
				now the ticket vending machine is open;
				now the ticket vending machine is smashed;
			else:
				say "[5 secs]With a great crash, the glass face of the vending machine shatters, exposing the ticket to your muscly grasp.";
				now the ticket vending machine is smashed;
				now the ticket vending machine is open.
				
	Instead of repairing a ticket vending machine:
		if the ticket vending machine is smashed:
			say "[no-time]It's far too late for that.";
		if the ticket vending machine is repaired:
			say "[no-time]It's probably as fixed up as you're going to get it.";
		else:
			let r be the repair result for yourself - difficult;
			if r is success:
				say "[900 secs]With enough time and elbow grease, you manage to get the machine operational again. It's so grateful that it dispenses the ticket immediately and you retrieve it from the dispenser.";
				now the player is holding the pristine train ticket;
				now the ticket vending machine is repaired;
			else if r is special:
				say "[300 secs]You see exactly what's wrong and get the machine operational in just a few minutes. It's so grateful that it dispenses the ticket immediately and you retrieve it from the dispenser.";
				now the player is holding the pristine train ticket;
				now the ticket vending machine is repaired;
			else:
				say "[900 secs]You don't quite manage to repair the machine this time, but you think you're on the right track."
			
	[ Let's define a couple custom actions for the skill checks we want to make ]
	[ Repairing ]
	Repairing is an action applying to one visible thing.
	Understand "repair [something]" as repairing.
	Check repairing:
		If the thing is not the ticket vending machine:
			say "[no-time]You can't fix everything. Try to focus on the one thing you can fix: that ticket vending machine."
	[ Stealing ]
	Stealing it from is an action applying to two things.
	Understand "steal [something] from [someone]" as stealing it from.
			
	Check stealing something (called t) from someone (called s):
		If s is yourself:
			say "[no-time]They say all theft is theft from oneself, but there's no need to take that quite so literally.";
			rule fails;
		If s is not carrying t:
			say "[no-time][s] is not in possession of [t].";
			rule fails;
		If the telekenesis rating of the player is 0:
			say "[60 secs]He looks pretty alert. You wouldn't have a chance by conventional means. Maybe if you had a way of pilfering the ticket from afar, though...";
			rule fails;
	
	Does the player mean stealing the creased ticket from someone: it is very likely.
	Does the player mean stealing the creased ticket from the dapper gentleman: it is very likely.
	Does the player mean stealing the ticket vending machine from someone: it is very unlikely.
	
	Carry out stealing the creased ticket from the dapper gentleman:
		let r be the result of a contest between the player using telekenesis and the dapper gentleman using spot;
		if r is contest won:
			say "[300 secs]You summon your mental energy to clandestinely lift [the creased ticket] from [the dapper gentleman]'s pocket and slip it into yours. Smooth!";
			now the player is holding the creased train ticket;
			now the dapper gentleman is bereft;
		otherwise:
			say "[300 secs]You summon your mental energy to try to lift [the creased ticket] from [the dapper gentleman]'s pocket, but he notices what's happening and quickly grabs it, looking about with a startled expression.";
			repeat with i running from 1 to 2:
				give the dapper gentleman experience in Spot. [simulate heightened alertness]
	[ Persuading ]
	[ Usually in BRP persuasion would make use of the Persuasion skill, but for the purpose of illustrating resistance rolls, we're making this a POW v POW resistance roll ]
	Persuading is an action applying to one thing.
	Understand "persuade [someone]" as persuading.
	
	Carry out persuading the conductor:
		say "He's heard it all. You won't get past him without a ticket."
		
	The dapper gentleman can be unasked, asked, annoyed, or persuaded. The dapper gentleman is unasked.
	Carry out persuading the dapper gentleman:
		If the ticket vending machine is not broken:
			say "[300 secs]The dapper gentleman bemusedly points out you seem to already have a ticket.";
		Otherwise if the dapper gentleman is persuaded:
			say "[no-time]You have nothing else to persuade him of.";
		Otherwise if the dapper gentleman is annoyed:
			say "[600 secs]Despite your continued pleading, he turns his back on you and pointedly ignores your pestering.";
		Otherwise if the dapper gentleman is asked:
			Now the dapper gentleman is annoyed;
			Set the power value of the dapper gentleman to 11; [Simulates his annoyance with repeated asking]
			Let r be the resistance result for the power value of the player against the power value of the dapper gentleman;
			if r is resistance overcome:
				say "[600 secs]Your insistence and continued pleading finally wins him over. He reluctantly hands you his ticket before making his way to the machine for a replacement.";
				Now the dapper gentleman is persuaded;
				Now the player has the creased ticket;
			Otherwise if r is resistance held:
				say "[600 secs]He stands his ground, visibly frustrated with your consistent pestering, and tells you not to bother him again.";
		Otherwise:
			Now the dapper gentleman is asked;
			Let r be the resistance result for the power value of the player against the power value of the dapper gentleman;
			If r is resistance overcome:
				say "[600 secs]You explain the urgency of your trip and after some initial resistance he is finally persuaded that you need the ticket more than he does. He hands you his ticket and makes his way over to the machine to try to get a new one.";
				Now the dapper gentleman is persuaded;
				Now the player has the creased ticket;
			Otherwise if r is resistance held:
				say "[600 secs]You make your case as convincingly as you can, but he directs you over to the ticket vending machine. He doesn't seem willing to give his ticket up."
		
		
	A pill is a kind of thing.
	
	A strawberry strength pill is here. It is a pill.
	Instead of eating a strength pill:
		Set the strength value of yourself to 18;
		[ Note the use of the Variable Time Control extension - eating a pill surely doesn't take 5 minutes!]
		say "[5 secs]You feel your muscles bulge. You're super-strong now!"
	A peridot personality pill is here. It is a pill.
	Instead of eating a personality pill:
		[ Setting skill ratings uses the following syntax: Set the <skill> rating of <person> to <number> ]
		Set the power value of yourself to 12;
		say "[5 secs]You feel incredibly suave and persuasive."
	A teal telekenesis pill is here. It is a pill.
	Instead of eating a telekenesis pill:
		[ You can use the skill syntax for your custom skills, too ]
		repeat with i running from 1 to 10:
			give yourself experience in telekenesis;
		Now the telekenesis pill is nowhere;
		say "[5 secs]Years of experience flash before your eyes and you feel you can now move objects with your mind."
	A red repair pill is here. It is a pill.
	Instead of eating a repair pill:
		repeat with i running from 1 to 10:
			give yourself experience in repair;
		Now the repair pill is nowhere;
		say "[5 secs]Years of experience flash before your eyes and you feel you understand the inner workings of every mechanical contraption."
		
	Instead of giving a pill to someone:
		say "[no-time]The rail authority takes a dim view of pill-pushing on company property."
		
	
	Chicanery is a scene. Chicanery begins when the gentleman is persuaded and the player is carrying the pristine train ticket. "The dapper gentleman blinks owlishly at you. He points out had he known you were capable of acquiring your own ticket in such a fashion, you needn't have asked him to part with his."
	 Dubious Charity is a scene. Dubious Charity begins when the gentleman is bereft and the player is carrying the pristine train ticket.
	When Dubious Charity begins:
		say "The dapper gentleman notices your success with the machine and approaches to ask your aid in locating his ticket."
	[The lose condition]
	At 10 AM:
		say "As the clock strikes 10, the conductor calls, 'All aboard!' Alas, you have run out of time to acquire a ticket and can only watch, defeated, as the train chugs slowly out of the station.";
		end the story.
	[Warnings of time passing]
	At 9:15 AM:
		say "The clock strikes 9:15."
	At 9:30 AM:
		say "The clock strikes 9:30."
	At 9:45 AM:
		say "The clock strikes 9:45. Only 15 minutes remain!"
		
		
	[ Note that you can define new skills to suit your game - this can also be used to simulate spells or powers where you want a percentile chance of success ]
	Table of Skills (continued)
	Skill	Skill Base Chance
	Telekenesis	0

	[ You must explicitly define the skills any character in your story has, including the player character ]
	[ You do this by extending the Table of Character Skills ]
	[ Failure to do this will display an error message when you attempt to reference a skill you have not given a character ]
	Table of Character Skills (continued)
	Characterskill				Points
	"yourself-Telekenesis"		0
	"yourself-Persuade"		15
	"yourself-Repair"			15
	"dapper gentleman-Spot" 	25
	
	[ Since this demo alters a character's strength from the default, we need to author that characteristic so we can manipulate it ]
	Table of Character Characteristics (continued)
	CharacterCharacteristic (text)	Points (number)
	"yourself-strength"			10
	"yourself-power"				10
	"dapper gentleman-power"	10
	

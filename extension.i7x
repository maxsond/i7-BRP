Version 1.0.200001 of BRP by Daniel Maxson begins here.
"Implements the ORC-Licensed Basic Roleplaying SRD from Chaosium Games."
[The version numbering is a little strange because it's intended to follow the version numbering of the SRD that is implemented, with an additional level to allow for iteration of Inform implementation. But Inform versioning only allows for three levels of depth, so we pack the Inform implementation semantic version of the implementation into the "debug" level: 1 digit for major version, 2 digits for minor version, 2 digits for bugfix version. Ergo a 0.0.1 implementation of the 1.0.2 SRD is 1.0.2.0.0.1 -> 1.0.200001]


[ VTC enables us to simulate the time different skill uses and combat take per the BRP rules]
Include Variable Time Control by Eric Eve.

[ Makes working with skills and characteristics of characters easier ]
Include Collections by Dannii Willis.

BRP Verbosity is initially true. [ This controls whether BRP rolls are shown while playing ]

Chapter 0 - Preamble

Section 1 - Acknowledgements

[ Thanks to Chaosium for the BRP SRD that allows this project to exist ]
[ Thanks to Andrew Plotkin for helping work around a bug in table traversal ]

Section 2 - Utilities

To say subject (P - a person):
	if P is the player, say "You";
	otherwise say "[The P]".

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

To decide which number is the maximum of (DR - a die roll):
	decide on (the amount part of DR) * (the sides part of DR).

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
	if R is agility:
		repeat with A running through armor pieces worn by P:
			let T be the armor type of A;
			choose the row with an armor type of T in the Table of Armor Types;
			now effective value is effective value + the physical penalty entry;
		if effective value < 0:
			now effective value is 0;
	if D is easy:
		let effective value be effective value times 2;
	otherwise if D is difficult:
		let effective value be effective value divided by 2;
	if BRP Verbosity is true:
		say "[subject P] rolled [rolled val] against an effective [R] value of [effective value] (Difficulty: [D]).[paragraph break]" in sentence case;
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
To decide what number is the maximum hit points of (P - person):
	decide on the size value of P + the constitution value of P / 2.
To decide what number is the maximum power points of (P - person):
	decide on the power value of P.
To decide what number is the damage bonus of (P - person):
	let i be the strength value of P + the size value of P;
	decide on the result of the damage modifier corresponding to a STRSIZ of i in Table 2.5.1.

A person has a number called current hit points.

When play begins:
	repeat with P running through people:
		now the current hit points of P is the maximum hit points of P.

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
A skillcategory is a kind of value. The skillcategories are physical, perception, and general.

[The reason for the table rather than making skill a number is that we want to perform many operations involving skills (making skill rolls, contests, and so on), and we need to be able to reference skills by name, especially to enable games to extend the skill list and have all the skill mechanics work seamlessly with their new skills]
Table of Skills
Skill	Skill Base Chance	Skill Category
Appraise	15	general
Art	5	general
Bargain	5	general
Brawl	25	general
Climb	40	physical
Command	5	general
Craft	5	general
Demolition	1	general
Disguise	1	general
Dodge	0	physical
Drive	20	general
Etiquette	5	general
Fast Talk	5	general
Fine Manipulation	5	physical
First Aid	30	general
Fly	0	general
Gaming	0	general
Grapple	25	general
Heavy Machine	1	general
Hide	10	physical
Insight	5	general
Jump	25	physical
Knowledge	5	general
Language Own	0	general
Language Other	0	general
Listen	25	perception
Literacy	0	general
Martial Arts	1	general
Medicine	5	general
Navigate	10	general
Perform	5	general
Persuade	15	general
Pilot	1	general
Projection	0	general
Psychotherapy	1	general
Repair	15	general
Research	25	general
Ride	5	general
Science	1	general
Sense	10	general
Sleight of Hand	5	physical
Spot	25	perception
Status	15	general
Stealth	10	physical
Strategy	1	general
Swim	25	physical
Teach	10	general
Technical Skill	0	general
Throw	25	physical
Track	10	general


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

A person can be naturally flying or technologically flying. A person is usually technologically flying.

To decide which number is the base chance of (S - skill) for (P - a person):
	if S is dodge: 
		decide on the dexterity value of P * 2;
	if S is gaming: 
		decide on (the intelligence value of P) + (the power value of P);
	if S is language own: 
		decide on the intelligence value of P * 5;
	if S is language other: 
		decide on 0;
	if S is literacy: 
		decide on the intelligence value of P * 5;
	if S is projection: 
		decide on the dexterity value of P * 2;
	if S is fly:
		if P is naturally flying: 
			decide on the dexterity value of P * 4;
		decide on the dexterity value of P / 2;
	decide on the skill base chance of S.

To decide which number is the (S - skill) rating of (P - a person):
	Let LP be "[P]-[S]";
	Let T be the Table of Character Skills;
	If LP is a CharacterSkill listed in T:
		choose the row with a CharacterSkill of LP in the Table of Character Skills;
		decide on the Points entry;
	otherwise:
		decide on the base chance of S for P. [If the skill's not authored for the person, it's untrained]

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

To decide which result is a BRP roll of (N - number) labeled (L - text) for (P - person) - (D - skill roll difficulty):
	if D is impossible:
		decide on failure;
	let rating be N;
	if D is easy:
		let rating be rating * 2;
	otherwise if D is very difficult:
		let rating be rating / 4;
	otherwise if D is difficult:
		let rating be rating / 2;
	let rolled val be a random number from 1 to 100;
	if BRP Verbosity is true:
		say "[subject P] rolled [rolled val] against an effective [L] value of [rating] (Difficulty: [D]).[paragraph break]" in sentence case;
	if rolled val <= rating / 5:
		decide on special;
	otherwise if rolled val <= rating:
		decide on success;
	otherwise if rating <= 10 and rolled val >= 96:
		decide on fumble;
	otherwise if rating <= 30 and rolled val >= 97:
		decide on fumble;
	otherwise if rating <= 50 and rolled val >= 98:
		decide on fumble;
	otherwise if rating <= 70 and rolled val >= 99:
		decide on fumble;
	otherwise if rolled val is 100:
		decide on fumble;
	otherwise:
		decide on failure.

To decide which result is the (S - skill) result for (P - person) - (D - skill roll difficulty):
	decide on a BRP roll of (the effective S rating of P) labeled "[S] skill" for P - D.

To decide which result is the (S - skill) result for (P - person):
	decide on the S result for P - normal.

Section 2 - Skill Rolls

A skill roll difficulty is a kind of value. The skill roll difficulties are easy, normal, difficult, very difficult, and impossible.

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

To decide which number is a BRP experience roll for (P - person) at (current - number) labeled (L - text):
	if BRP verbosity is true:
		say "[line break]Rolling for [the printed name of P] to gain experience in [L]." in sentence case;
	let DR be the result of 1d100;
	if DR > current:
		let points be the result of 1d6;
		if BRP verbosity is true:
			say "[line break][subject P] gained [points] in [L], which is now [current + points].[line break]";
		decide on points;
	if BRP verbosity is true:
		say "[line break][subject P] failed the d100 roll to increase experience in [L]: [DR] <= [current].[line break]";
	decide on 0.

To give (P - a person) experience in (S - a skill):
	let gain be a BRP experience roll for P at (the S rating of P) labeled "[S] skill";
	if gain > 0:
		set the S rating of P to the S rating of P + gain.

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

Using basic combat is initially true. [ This toggles whether to enable the actions in this chapter, so games or other extensions can provide their own combat actions that hook into this system. ]

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

The list of combatants is a list of people which varies.

To add (P - a person) to the combat order:
	let insertion point be 0;
	repeat with I running from 1 to the number of entries in the list of combatants:
		if insertion point is 0 and the dexterity value of P > the dexterity value of entry I of the list of combatants:
			now insertion point is I;
	if insertion point is 0:
		add P to the list of combatants;
	otherwise:
		add P at entry insertion point in the list of combatants.

The distance query source is a thing that varies.
The distance query target is a thing that varies.

The get combat distance rules is a rulebook producing a number.

Last get combat distance rule (this is the default combat distance rule):
	rule succeeds with result 3.

To decide which number is the combat distance between (A - a thing) and (B - a thing):
	now the distance query source is A;
	now the distance query target is B;
	decide on the number produced by the get combat distance rules.

[ Set by carry-out rules before resolving the combat round.
  nothing = the player is attacking unarmed this round. ]
The current round player weapon is an object that varies.

[ Set by the npc combat intent rulebook immediately before each NPC executes.
  nothing = no target in range; the NPC skips their action this round. ]
The npc action target is a thing that varies.
The npc action weapon is an object that varies.

The npc combat intent rules is a rulebook operating on a person.

Last npc combat intent rule for a person (called the NPC) when using basic combat is true
	(this is the default npc attack intent rule):
	let D be the combat distance between the NPC and the player;
	if D <= 3:
		let best melee be nothing;
		let best melee damage be 0;
		repeat with W running through things carried by the NPC:
			if W is a melee weapon (called MW):
				if the melee weapon type of MW is not nil melee weapon:
					let MWT be the melee weapon type of MW;
					choose the row with a melee weapon type of MWT in Table of Melee Weapon Types;
					let DMG be the maximum of the Damage Die entry + the Flat Bonus entry;
					if DMG > best melee damage:
						now best melee damage is DMG;
						now best melee is W;
		if best melee is not nothing:
			now the npc action target is the player;
			now the npc action weapon is best melee;
			rule succeeds;
		now the npc action target is the player;
		now the npc action weapon is nothing;
		rule succeeds;
	let best missile be nothing;
	let best missile damage be 0;
	repeat with W running through things carried by the NPC:
		if W is a missile weapon (called MSW):
			let MWT be the missile weapon type of MSW;
			if MWT is not nil missile weapon:
				let R be the range of MWT;
				if D <= 3 * R:
					choose the row with a missile weapon type of MWT in Table of Missile Weapon Types;
					let DMG be the maximum of the Damage Die entry + the Flat Bonus entry;
					if DMG > best missile damage:
						now best missile damage is DMG;
						now best missile is W;
	if best missile is not nothing:
		now the npc action target is the player;
		now the npc action weapon is best missile;
		rule succeeds;
	now the npc action target is nothing;
	now the npc action weapon is nothing.

Instead of attacking someone when using basic combat is true:
	say "Specify a weapon: try 'attack [the noun] with [italic type]weapon[roman type]' or 'attack [the noun] unarmed'."


Section 3 - Movement

Section 4 - Actions

Section 5 - Attacking

Attacking it with is an action applying to one visible thing and one carried thing.
Understand "attack [someone] with [something]" as attacking it with.

Check attacking it with (this is the weapon type check rule):
	if the second noun is not a melee weapon and the second noun is not a missile weapon:
		say "[The second noun] is not a weapon." instead;
	if the second noun is a melee weapon and the melee weapon type of the second noun is nil melee weapon:
		say "[The second noun] has no weapon type assigned." instead;
	if the second noun is a missile weapon and the missile weapon type of the second noun is nil missile weapon:
		say "[The second noun] has no weapon type assigned." instead.

Check attacking it with (this is the melee range check rule):
	if the second noun is a melee weapon:
		if the combat distance between the player and the noun > 3:
			say "[The noun] is too far away to reach with [the second noun]." instead.

Reporting an attack result is an activity.
The attack report attacker is a person that varies.
The attack report target is a thing that varies.
The attack report weapon is an object that varies.
The attack report result is a result that varies.
The attack report raw damage is a number that varies.

Last for reporting an attack result:
	if the attack report result is special:
		say "You strike [the attack report target] with an exceptional blow! ";
	otherwise if the attack report result is success:
		say "You hit [the attack report target]. ";
	otherwise if the attack report result is failure:
		say "Your attack misses [the attack report target].";
	otherwise:
		say "You fumble your attack!".

Carry out attacking it with (this is the weapon attack rule):
	if the player is not listed in the list of combatants:
		if the noun is a person (called the target):
			add the target to the combat order;
		add the player to the combat order;
		enable combat mode;
	let WS be nil specialty;
	if the second noun is a melee weapon (called MW):
		now WS is the weapon type specialty of MW;
	otherwise if the second noun is a missile weapon (called MSW):
		now WS is the weapon type specialty of MSW;
	let R be the WS weapon specialty result for the player;
	now the attack report attacker is the player;
	now the attack report target is the noun;
	now the attack report weapon is the second noun;
	now the attack report result is R;
	if R is special:
		let SD be the special attack damage of the second noun by the player;
		now the attack report raw damage is SD;
		carry out the reporting an attack result activity;
		apply SD points of damage to the noun;
	otherwise if R is success:
		let ND be the attack damage of the second noun by the player;
		now the attack report raw damage is ND;
		carry out the reporting an attack result activity;
		apply ND points of damage to the noun;
	otherwise if R is failure:
		now the attack report raw damage is 0;
		carry out the reporting an attack result activity;
	otherwise:
		now the attack report raw damage is 0;
		carry out the reporting an attack result activity;
		now the fumble context weapon is the second noun;
		now the fumble context attacker is the player;
		follow the attacking fumble rules.

Unarmed attacking is an action applying to one visible thing.
Understand "attack [someone] unarmed" as unarmed attacking.

Carry out unarmed attacking (this is the unarmed attack rule):
	if the player is not listed in the list of combatants:
		if the noun is a person (called the target):
			add the target to the combat order;
		add the player to the combat order;
		enable combat mode;
	let R be the Brawl result for the player;
	now the attack report attacker is the player;
	now the attack report target is the noun;
	now the attack report weapon is nothing;
	now the attack report result is R;
	if R is special:
		let SD be the special unarmed damage of the player;
		now the attack report raw damage is SD;
		carry out the reporting an attack result activity;
		apply SD points of damage to the noun;
	otherwise if R is success:
		let ND be the unarmed damage of the player;
		now the attack report raw damage is ND;
		carry out the reporting an attack result activity;
		apply ND points of damage to the noun;
	otherwise if R is failure:
		now the attack report raw damage is 0;
		carry out the reporting an attack result activity;
	otherwise:
		now the attack report raw damage is 0;
		carry out the reporting an attack result activity;
		now the fumble context weapon is nothing;
		now the fumble context attacker is the player;
		follow the attacking fumble rules.

[ Fumble hook: set fumble context weapon and fumble context attacker before the rules fire. ]
The attacking fumble rules is a rulebook.
The fumble context weapon is an object that varies.
The fumble context attacker is a person that varies.

To decide which weapon specialty is the weapon type specialty of (W - a melee weapon):
	choose the row with a melee weapon type of (melee weapon type of W) in Table of Melee Weapon Types;
	decide on the Specialty entry.

To decide which weapon specialty is the weapon type specialty of (W - a missile weapon):
	choose the row with a missile weapon type of (missile weapon type of W) in Table of Missile Weapon Types;
	decide on the Specialty entry.

Section 6 - Parrying

Section 7 - Dodging

Section 8 - Combat Summary

Section 9 - Weapons and Damage

A weapon specialty is a kind of value. The weapon specialties are defined by the Table of Weapon Specialties.

Table of Weapon Specialties
Weapon Specialty	Base Chance
nil specialty	0
axe specialty	15
club specialty	25
dagger specialty	25
hammer specialty	25
mace specialty	25
polearm specialty	15
spear specialty	15
staff specialty	25
sword specialty	15
bow specialty	5
crossbow specialty	25
sling specialty	5
throwing axe specialty	10
throwing dagger specialty	15
pistol specialty	20
rifle specialty	25
laser pistol specialty	20
laser rifle specialty	15

A weapon bonus type is a kind of value. The weapon bonus types are no weapon bonus, half weapon bonus, and full weapon bonus.

A melee weapon type is a kind of value. The melee weapon types are defined by the Table of Melee Weapon Types.

Table of Melee Weapon Types
Melee Weapon Type	Specialty	Base	Damage Die	Flat Bonus	Hands	HP
nil melee weapon	nil specialty	0	0d6	0	1	0
battle axe	axe specialty	15	1d8	2	1	15
great axe	axe specialty	15	2d6	2	2	15
hand axe	axe specialty	15	1d6	1	1	12
heavy club	club specialty	25	1d8	0	2	22
light club	club specialty	25	1d6	0	1	15
dagger	dagger specialty	25	1d4	0	1	15
halberd	polearm specialty	15	3d6	0	2	25
hammer	hammer specialty	25	1d6	0	1	15
great hammer	hammer specialty	25	1d10	3	2	15
knife	dagger specialty	25	1d3	1	1	15
heavy mace	mace specialty	25	1d8	2	2	10
light mace	mace specialty	25	1d6	2	1	6
pike	polearm specialty	15	1d10	2	2	12
quarter staff	staff specialty	25	1d8	0	2	8
long spear	spear specialty	15	1d10	0	2	10
broad sword	sword specialty	15	1d8	1	1	12
great sword	sword specialty	5	2d8	0	2	12
short sword	sword specialty	15	1d6	1	1	12

A missile weapon type is a kind of value. The missile weapon types are defined by the Table of Missile Weapon Types.

Table of Missile Weapon Types
Missile Weapon Type	Specialty	Base	Damage Die	Flat Bonus	Bonus Type	Hands	HP	Range
nil missile weapon	nil specialty	0	0d6	0	no weapon bonus	1	0	0
thrown hand axe	throwing axe specialty	10	1d6	0	half weapon bonus	1	12	20
long bow	bow specialty	5	1d8	1	half weapon bonus	2	10	90
heavy crossbow	crossbow specialty	25	2d6	2	no weapon bonus	2	18	55
light crossbow	crossbow specialty	25	1d6	2	no weapon bonus	2	10	40
thrown dagger	throwing dagger specialty	15	1d4	0	half weapon bonus	1	15	10
thrown knife	throwing dagger specialty	15	1d3	1	half weapon bonus	1	10	10
pistol	pistol specialty	20	1d8	0	no weapon bonus	1	8	20
laser pistol	laser pistol specialty	20	1d8	0	no weapon bonus	1	14	20
rifle	rifle specialty	25	2d6	0	no weapon bonus	2	12	80
laser rifle	laser rifle specialty	15	2d8	0	no weapon bonus	2	20	100
sling	sling specialty	5	1d8	0	half weapon bonus	2	2	80
thrown rock	nil specialty	0	1d2	0	half weapon bonus	1	0	20

A melee weapon is a kind of thing.
A melee weapon has a melee weapon type. The melee weapon type of a melee weapon is usually nil melee weapon.

A missile weapon is a kind of thing.
A missile weapon has a missile weapon type. The missile weapon type of a missile weapon is usually nil missile weapon.

[ Character weapon specialties duplicate a lot of skill logic to enable game authors
to extend the table and have their new weapon specialties "just work" ]
Table of Character Weapon Specialties
CharacterWeapon (text)	Points (number)
--	--

To decide which number is the (WS - weapon specialty) weapon specialty rating of (P - a person):
	let LP be "[P]-[WS]";
	if LP is a CharacterWeapon listed in Table of Character Weapon Specialties:
		choose the row with a CharacterWeapon of LP in Table of Character Weapon Specialties;
		decide on the Points entry;
	otherwise:
		choose the row with a weapon specialty of WS in Table of Weapon Specialties;
		decide on the Base Chance entry.

To set the (WS - weapon specialty) weapon specialty rating of (P - a person) to (N - number):
	let LP be "[P]-[WS]";
	if LP is a CharacterWeapon listed in Table of Character Weapon Specialties:
		choose the row with a CharacterWeapon of LP in Table of Character Weapon Specialties;
		now the Points entry is N;
	otherwise:
		say "Oh dear, something tried to set the [WS] of [P] to [N], but that character and weapon specialty pairing was not authored. Please contact your friendly local game developer and notify them of this bug."

To give (P - a person) experience in (WS - weapon specialty) weapon specialty:
	let gain be a BRP experience roll for P at (the WS weapon specialty rating of P) labeled "[WS]";
	if gain > 0:
		set the WS weapon specialty rating of P to the WS weapon specialty rating of P + gain.

To decide which result is the (WS - weapon specialty) weapon specialty result for (P - person) - (D - skill roll difficulty):
	decide on a BRP roll of (the WS weapon specialty rating of P) labeled "[WS]" for P - D.

To decide which result is the (WS - weapon specialty) weapon specialty result for (P - person):
	decide on the WS weapon specialty result for P - normal.

To decide which number is the melee damage of (MWT - melee weapon type) for (P - a person):
	choose the row with a melee weapon type of MWT in Table of Melee Weapon Types;
	let base be the result of the Damage Die entry;
	let total be base + the Flat Bonus entry + the damage bonus of P;
	if total < 0:
		decide on 0;
	decide on total.

To decide which number is the missile damage of (MWT - missile weapon type) for (P - a person):
	choose the row with a missile weapon type of MWT in Table of Missile Weapon Types;
	let base be the result of the Damage Die entry;
	let total be base + the Flat Bonus entry;
	if the Bonus Type entry is half weapon bonus:
		now total is total + the damage bonus of P / 2;
	otherwise if the Bonus Type entry is full weapon bonus:
		now total is total + the damage bonus of P;
	if total < 0:
		decide on 0;
	decide on total.

To decide which skill roll difficulty is the range difficulty for (MWT - missile weapon type) at (D - number) meters:
	choose the row with a missile weapon type of MWT in Table of Missile Weapon Types;
	let R be the Range entry;
	if D > R * 3:
		decide on impossible;
	if D > R * 2:
		decide on very difficult;
	if D > R:
		decide on difficult;
	decide on normal.

To decide which number is the range of (MWT - missile weapon type):
	choose the row with a missile weapon type of MWT in Table of Missile Weapon Types;
	decide on the Range entry.

To decide which number is the special success melee damage of (MWT - melee weapon type) for (A - a person):
	choose the row with a melee weapon type of MWT in Table of Melee Weapon Types;
	let DD be the Damage Die entry;
	decide on the maximum of DD + the Flat Bonus entry + the melee damage of MWT for A.

To decide which number is the special success missile damage of (MWT - missile weapon type) for (A - a person):
	choose the row with a missile weapon type of MWT in Table of Missile Weapon Types;
	let DD be the Damage Die entry;
	decide on the maximum of DD + the Flat Bonus entry + the missile damage of MWT for A.

To decide which number is the attack damage of (W - a thing) by (A - a person):
	if W is a melee weapon (called MW):
		decide on the melee damage of (melee weapon type of MW) for A;
	if W is a missile weapon (called MSW):
		decide on the missile damage of (missile weapon type of MSW) for A;
	decide on 0.

To decide which number is the special attack damage of (W - a thing) by (A - a person):
	if W is a melee weapon (called MW):
		decide on the special success melee damage of (melee weapon type of MW) for A;
	if W is a missile weapon (called MSW):
		decide on the special success missile damage of (missile weapon type of MSW) for A;
	decide on 0.

To decide which number is the unarmed damage of (A - a person):
	let total be the result of 1d3 + the damage bonus of A;
	if total < 0:
		decide on 0;
	decide on total.

To decide which number is the special unarmed damage of (A - a person):
	let total be 3 + the damage bonus of A;
	if total < 0:
		decide on 0;
	decide on total.

Reporting damage applied is an activity.
The damage report target is a thing that varies.
The damage report raw damage is a number that varies.
The damage report net damage is a number that varies.

A person can be conscious, unconscious, or dead. A person is usually conscious.

Last for reporting damage applied:
	let N be the damage report raw damage;
	let net be the damage report net damage;
	let T be the damage report target;
	if net is 0 and N > 0:
		say "[N] damage, fully absorbed by armor. ";
	otherwise if net < N:
		say "[N] damage, reduced to [net] after armor. ";
	otherwise:
		say "[N] damage. ";
	if T is a person (called P):
		if the current hit points of P <= 0:
			now P is dead;
			say "[The P] is dead.";
		otherwise if the current hit points of P <= 2:
			now p is unconscious;
			say "[The P] falls unconscious."

To apply (N - number) points of damage to (T - a thing):
	if T is a person (called the target):
		let absorbed be the effective armor points of target;
		let net be N - absorbed;
		if net < 0:
			now net is 0;
		now the current hit points of target is the current hit points of target - net;
		now the damage report target is T;
		now the damage report raw damage is N;
		now the damage report net damage is net;
		carry out the reporting damage applied activity.
	[ TODO: handle applying damage to shields and weapons ]

Section 10 - Armor

An armor type is a kind of value. The armor types are defined by the Table of Armor Types.

Table of Armor Types
Armor Type	AP	Physical Penalty	Perception Penalty
no armor	0	0	0
bulletproof vest	8	-5	0
chain	7	-20	0
flak jacket	4	-10	0
heavy clothing	1	0	0
heavy helmet	2	0	-50
light helmet	1	0	-15
hoplite panoply	6	-20	0
soft leather	1	0	0
hard leather	2	-10	0
full plate	8	-25	0
quilted	2	-5	0
riot gear	12	-10	0	[ SRD lists armor points as 12/6; 12 used here ]

An armor piece is a kind of thing. An armor piece is wearable.
An armor piece has an armor type. The armor type of an armor piece is usually no armor.

To decide which number is the effective armor points of (P - a person):
	let total be 0;
	repeat with A running through armor pieces worn by P:
		let T be the armor type of A;
		choose the row with an armor type of T in the Table of Armor Types;
		now total is total + the AP entry;
	decide on total.

To decide which number is the effective (S - skill) rating of (P - a person):
	let base be the S rating of P;
	let modifier be 0;
	let cat be the skill category of S;
	repeat with A running through armor pieces worn by P:
		let T be the armor type of A;
		choose the row with an armor type of T in the Table of Armor Types;
		if cat is physical:
			now modifier is modifier + the physical penalty entry;
		otherwise if cat is perception:
			now modifier is modifier + the perception penalty entry;
	let total be base + modifier;
	if total < 0:
		decide on 0;
	decide on total.

Section 11 - Shields

A shield type is a kind of value. The shield types are defined by the Table of Shield Types.

Table of Shield Types
Shield Type	HP	Shield Die	Missile Parry Chance	Base Rating
no shield	0	0d6	0	0
heater	12	1d3	30	15
hoplite	16	1d4	60	15
kite	16	1d4	30	15
riot	16	1d3	60	15
round	12	1d3	30	15
target	12	1d2	15	15

A shield is a kind of thing. A shield is wearable.
A shield has a shield type. The shield type of a shield is usually no shield.

Check wearing when the noun is a shield:
	if a shield (called current shield) is worn by the actor:
		say "[The actor] is already using [the current shield] as a shield.";
		stop the action.

[ Character shield specialties duplicate a lot of skill logic to enable game authors
to extend the table and have their new shield types "just work" ]
Table of Character Shield Specialties
CharacterShield (text)	Points (number)
--	--

To decide which number is the (ST - shield type) shield specialty rating of (P - a person):
	let LP be "[P]-[ST]";
	if LP is a CharacterShield listed in Table of Character Shield Specialties:
		choose the row with a CharacterShield of LP in the Table of Character Shield Specialties;
		decide on the Points entry;
	otherwise:
		choose the row with a shield type of ST in the Table of Shield Types;
		decide on the base rating entry.

To set the (ST - shield type) shield specialty rating of (P - a person) to (N - number):
	let LP be "[P]-[ST]";
	if LP is a CharacterShield listed in Table of Character Shield Specialties:
		choose the row with a CharacterShield of LP in the Table of Character Shield Specialties;
		now the Points entry is N;
	otherwise:
		say "Oh dear, something tried to set the [ST] shield specialty of [P] to [N], but that character and shield specialty pairing was not authored. Please contact your friendly local game developer and notify them of this bug."

To give (P - a person) experience in (ST - shield type) shield specialty:
	let gain be a BRP experience roll for P at (the ST shield specialty rating of P) labeled "[ST] shield specialty";
	if gain > 0:
		set the ST shield specialty rating of P to the ST shield specialty rating of P + gain.

To decide which result is the (ST - shield type) shield specialty result for (P - person) - (D - skill roll difficulty):
	decide on a BRP roll of (the ST shield specialty rating of P) labeled "[ST] shield specialty" for P - D.

To decide which result is the (ST - shield type) shield specialty result for (P - person):
	decide on the ST shield specialty result for P - normal.

To decide which number is the missile parry chance of (P - a person):
	if a shield (called S) is worn by P:
		let ST be the shield type of S;
		choose the row with a shield type of ST in the Table of Shield Types;
		decide on the missile parry chance entry;
	decide on 0.

To decide which number is the shield damage of (P - a person):
	if a shield (called S) is worn by P:
		let ST be the shield type of S;
		choose the row with a shield type of ST in the Table of Shield Types;
		let base damage be the result of the shield die entry;
		decide on base damage + the damage bonus of P;
	decide on 0.

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

Armor:
	Armor is represented as wearable things of kind `armor piece`. Each piece has one property:
		`armor type` - a value of kind `armor type` (default: no armor)
	`armor type` is a kind of value defined by the Table of Armor Types, which lists all SRD armor
	along with their AP and skill penalties. Set the armor type like so:
		`The chain hauberk is an armor piece. The armor type of the chain hauberk is chain.`
	For custom armor, add a row to the Table of Armor Types. The SRD armor types are:
		no armor, bulletproof vest, chain, flak jacket, heavy clothing, heavy helmet, light helmet,
		hoplite panoply, soft leather, hard leather, full plate, quilted, riot gear
	To get a person's effective armor points (summed across all worn pieces, looked up from the table):
		`the effective armor points of (person)`
	Skill rolls automatically apply armor modifiers. Physical skills (Climb, Dodge, Hide, etc.)
	and the Agility characteristic roll are penalized by the physical penalty; perception skills
	(Listen, Spot) are penalized by the perception penalty. All lookups are done at roll time.
	To get the effective skill rating of a person (base rating plus worn armor modifiers, floored at 0):
		`the effective (skill) rating of (person)`

Shields:
	Shields are represented as wearable things of kind `shield`. Each shield has one property:
		`shield type` - a value of kind `shield type` (default: no shield)
	`shield type` is a kind of value defined by the Table of Shield Types, which lists all SRD
	shields along with their HP, damage die, missile parry chance, and base specialty rating.
	A person can wear at most one shield; attempting to wear a second will fail with a message.
	To create a shield:
		`The heater shield is a shield. The shield type of the heater shield is heater.`
	For custom shields, add a row to the Table of Shield Types. Shield specialty mechanics
	automatically apply to any shield type in the table.
	The SRD shield types are:
		no shield, heater, hoplite, kite, riot, round, target

	Each shield type has its own specialty rating, tracked in the Table of Character Shield
	Specialties (not in the Table of Skills). To author a character's specialty, add an entry:
		Table of Character Shield Specialties (continued)
		CharacterShield          Points
		"Brunhilde-heater"       15
	Shield specialty rolls use the same result kind (special, success, failure, fumble) and
	difficulty kind (easy, normal, difficult) as skill rolls.
	To set a specialty rating:
		`set the (shield type) shield specialty rating of (person) to (number)`
	To make a specialty roll:
		`the (shield type) shield specialty result for (person) - (difficulty)`
	To give specialty experience (same 1d6 advancement mechanic as skills):
		`give (person) experience in (shield type) shield specialty`
	To get a person's missile parry chance (0 if no shield is worn):
		`the missile parry chance of (person)`
	To get a person's shield damage (shield die from table plus damage bonus, 0 if no shield worn):
		`the shield damage of (person)`

Melee Weapons:
	Melee weapons are things of kind `melee weapon`. Each has one property:
		`melee weapon type` - a value of kind `melee weapon type` (default: nil melee weapon)
	`melee weapon type` is defined by the Table of Melee Weapon Types, which lists every SRD melee weapon
	along with its specialty, base chance, damage die, flat bonus, hands required, and HP. To create one:
		`A goblin spear is a melee weapon. The melee weapon type of the goblin spear is long spear.`
	Weapons with a nil type will print an error if the player tries to attack with them, so always set
	the weapon type when authoring a weapon. For custom melee weapon types, add a row to the table.
	The SRD melee weapon types are:
		battle axe, great axe, hand axe, heavy club, light club, dagger, halberd, hammer, great hammer,
		knife, heavy mace, light mace, pike, quarter staff, long spear, broad sword, great sword, short sword

Missile Weapons:
	Missile weapons are things of kind `missile weapon`. Each has one property:
		`missile weapon type` - a value of kind `missile weapon type` (default: nil missile weapon)
	`missile weapon type` is defined by the Table of Missile Weapon Types, which lists every SRD missile
	weapon along with its specialty, base chance, damage die, flat bonus, damage bonus type, hands
	required, HP, and range (in meters). To create one:
		`An old shortbow is a missile weapon. The missile weapon type of the old shortbow is long bow.`
	As with melee weapons, a nil type will produce an error on use. For custom missile weapon types,
	add a row to the table. The SRD missile weapon types are:
		thrown hand axe, long bow, heavy crossbow, light crossbow, thrown dagger, thrown knife, pistol,
		laser pistol, rifle, laser rifle, sling, thrown rock
	To get the range-based difficulty for a missile weapon at a given distance (in meters):
		`the range difficulty for (missile weapon type) at (number) meters`
		Returns easy/normal/difficult/very difficult/impossible per SRD range bands.

Weapon Specialties:
	Each weapon type belongs to a weapon specialty (e.g. long spear uses spear specialty, long bow uses
	bow specialty). Specialty ratings are tracked in the Table of Character Weapon Specialties. To author
	a character's specialty, add an entry:
		Table of Character Weapon Specialties (continued)
		CharacterWeapon          Points
		"Brunhilde-sword specialty"   30
	Weapon specialty mechanics work identically to shield specialties. The SRD weapon specialties are:
		nil specialty, axe specialty, club specialty, dagger specialty, hammer specialty, mace specialty,
		polearm specialty, spear specialty, staff specialty, sword specialty, bow specialty,
		crossbow specialty, sling specialty, throwing axe specialty, throwing dagger specialty,
		pistol specialty, rifle specialty, laser pistol specialty, laser rifle specialty
	To get a specialty rating:
		`the (weapon specialty) weapon specialty rating of (person)`
	To set a specialty rating:
		`set the (weapon specialty) weapon specialty rating of (person) to (number)`
	To make a specialty roll:
		`the (weapon specialty) weapon specialty result for (person) - (difficulty)`
	To give specialty experience (same 1d6 advancement mechanic as skills):
		`give (person) experience in (weapon specialty) weapon specialty`
	To get the normal or special-success damage dealt by a weapon:
		`the attack damage of (weapon) by (person)`
		`the special attack damage of (weapon) by (person)`

Attacking:
	When `using basic combat is true` (the default), the following player commands are available:
		`attack [someone] with [weapon]` - attack using a carried melee or missile weapon
		`attack [someone] unarmed` - attack bare-handed using the Brawl skill
	Set `using basic combat is false` to disable these and supply your own combat actions.

	Weapon attacks roll the weapon's specialty. Unarmed attacks roll Brawl. Results:
		special  - maximum damage dealt (weapon: max die roll + bonuses; unarmed: 3 + damage bonus)
		success  - normal damage dealt (weapon: rolled die + bonuses; unarmed: 1d3 + damage bonus)
		failure  - miss, no damage
		fumble   - fires the `attacking fumble rules` rulebook (see below)
	All damage is reduced by the target's worn armor before being applied to current hit points.

	Attack result messages are produced by the `reporting an attack result` activity. Before it
	fires, five variables are set:
		`attack report attacker` - the person attacking
		`attack report target` - the thing being attacked
		`attack report weapon` - the weapon used (or `nothing` for unarmed)
		`attack report result` - the result (special, success, failure, or fumble)
		`attack report raw damage` - the damage rolled (0 for failure/fumble)
	Override the default messages by adding a `for reporting an attack result` rule:
		For reporting an attack result:
			if the attack report result is failure:
				say "The blow misses [the attack report target] entirely.";
			otherwise if the attack report result is success:
				say "[The attack report attacker] strikes for [attack report raw damage] damage!";
			[etc.]

	The attacking fumble rules rulebook fires on any fumble. Before it fires, two variables are set:
		`fumble context weapon` - the weapon used (or `nothing` for unarmed)
		`fumble context attacker` - the person who fumbled
	Add rules to this rulebook in your game to implement fumble consequences:
		An attacking fumble rule (this is the drop weapon on fumble rule):
			if the fumble context weapon is not nothing:
				say "[The fumble context attacker] drops [the fumble context weapon]!";
				now the fumble context attacker does not have the fumble context weapon.

	To apply damage directly (e.g. from traps, spells, or custom combat actions):
		`apply (number) points of damage to (thing)`
		Armor is subtracted automatically; damage is floored at 0. Current HP is tracked in the
		`current hit points` property; maximum HP (SIZ+CON/2) is read via:
		`the maximum hit points of (person)`
	Damage messages are produced by the `reporting damage applied` activity. Before it fires,
	three variables are set:
		`damage report target` - the thing damaged
		`damage report raw damage` - damage before armor reduction
		`damage report net damage` - damage after armor reduction (0 if fully absorbed)
	Override the default messages by adding a `for reporting damage applied` rule:
		For reporting damage applied:
			say "[damage report net damage] point[s] of damage to [the damage report target]."

Combat Distance:
	The extension determines how far apart two combatants are via the `get combat distance rules` rulebook,
	which produces a number in meters. To query the distance between any two things:
		`the combat distance between (thing A) and (thing B)`

	By default the rulebook returns 3 meters, placing all combatants within melee range. This is the
	correct assumption for most text adventure encounters, where everyone is in the same room.

	To model real distances in your game, add an earlier rule to the rulebook. For example, to place
	one NPC at a fixed distance:
		A get combat distance rule when the distance query target is the distant archer:
			rule succeeds with result 50.

	The context variables `distance query source` and `distance query target` are set immediately
	before the rulebook fires, so your rules can read them to compute distance however suits your
	game: room adjacency, a coordinate table, a relation, or any other mechanism. Rules that do not
	fire fall through to the default 3-meter result.

NPC Combat Intent:
	Each round, before an NPC acts, the extension follows the `npc combat intent rules` rulebook for
	that NPC. Rules in this rulebook set two variables that control what the NPC does:
		`npc action target` - the thing the NPC will attack (set to `nothing` to skip the action)
		`npc action weapon` - the weapon used (`nothing` for an unarmed attack)

	The default last rule scans the NPC's inventory. If the target is within melee range (3 m) it
	picks the melee weapon with the highest base damage (max die roll + flat bonus), or falls back to
	unarmed. Beyond melee range it tries missile weapons within 3× their range, again selecting the
	highest base damage. If nothing reaches the target, the NPC skips their action.

	To give a character custom combat AI, add a rule earlier in the rulebook:
		First npc combat intent rule for the goblin chief:
			now the npc action target is the player;
			now the npc action weapon is the goblin chief's great axe;
			rule succeeds.

	The `rule succeeds` call stops the rulebook, so the default rule never fires for that NPC. Custom
	rules can read `the combat distance between (A) and (B)` to make range-aware decisions, and can
	set `npc action target` to any thing — including other NPCs or objects — not just the player.

Attribute-derived skill base chances:
	Several skills have base chances derived from character attributes rather than fixed values: Dodge (DEX×2), Gaming (INT+POW), Language Own (INT×5), Literacy (INT×5), Projection (DEX×2), Language Other (always 0). These are computed automatically from the character's attributes when no authored skill rating exists.
	The Fly skill base depends on whether the character has natural flight (wings, etc.) or technological flight (jet pack, etc.). Use `now (person) is naturally flying` or `now (person) is technologically flying` to set this. The default is technological (DEX÷2). Natural flight uses DEX×4.
	
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
		
Example: **** The Arena - Demonstrate basic combat

	*: "The Arena"
	
	Include BRP by Daniel Maxson
	
	The Arena is a room. "You enter the arena, facing down a variety of combatants. The audience waits with bated breath for you to choose your adversary." 
	
	Bob the Goblin is here. He is a man. 
	A goblin spear is a melee weapon.  The melee weapon type of a goblin spear is long spear.
	A goblin breastplate is an armor piece. The armor type of a goblin breastplate is hoplite panoply.
	Bob the Goblin is wearing a goblin breastplate.
	Bob the Goblin is holding a goblin spear.
	Archie the Archer is here. He is a man.
	An old shortbow is a missile weapon. The missile weapon type of an old shortbow is long bow.
	An archer's leather tunic is an armor piece. The armor type of an archer's leather tunic is soft leather.
	An archer's leather boots is an armor piece. The armor type of an archer's leather boots is soft leather.
	Archie the Archer is wearing a worn shortbow, an archer's leather tunic, and an archer's leather boots.
	Marge the Mage is here. She is a woman.
	A lumberjack axe is a melee weapon. The melee weapon type of a lumberjack axe is hand axe. A lumberjack axe is here.
	
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
	
	The dapper gentleman is here. He is a man. "A dapper gentleman stands out from the crowd wearing a tuxedo, a top hat, and a monocle. All in all, exceptionally dapper. He is being worn by an even more dapper mustache![if the dapper gentleman is holding the creased train ticket] A creased train ticket sticks temptingly out of the tuxedo's left breast pocket. Perhaps you could PERSUADE him to give it to you, try to STEAL it, or challenge him to a GAMBLE.[else if the dapper gentleman is bereft] He is frantically scouring the platform for his ticket.[else if the dapper gentleman is annoyed] He paces the platform agitatedly.[end if]". The dapper gentleman can be calm or bereft. The dapper gentleman is calm.
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
		
		
	[ Gambling ]
	Gambling with is an action applying to one thing.
	Understand "gamble with [someone]" as gambling with.
	Understand "play cards with [someone]" as gambling with.

	Check gambling with:
		if the noun is not the dapper gentleman:
			say "[no-time][The noun] has no interest in a wager.";
			rule fails;
		if the dapper gentleman is not carrying the creased train ticket:
			say "[no-time]The dapper gentleman has nothing left to wager.";
			rule fails.

	Carry out gambling with the dapper gentleman:
		let r be the result of a contest between the player using gaming and the dapper gentleman using gaming;
		if r is contest won:
			say "[300 secs]You propose a hand of cards and the dapper gentleman accepts with a sporting smile. After a tense exchange, fortune favors you and you win his train ticket fair and square!";
			now the player is carrying the creased train ticket;
			now the dapper gentleman is bereft;
		otherwise if r is contest lost:
			say "[300 secs]You propose a hand of cards. He accepts graciously, but outplays you with practiced ease, pocketing your ante with an apologetic tip of his hat.";
		otherwise if r is contest tied:
			say "[300 secs]After a long and tense hand, neither of you can claim victory. He returns your stake with a shrug. You could try again.";
		otherwise:
			say "[60 secs]You and the dapper gentleman cannot agree on which game to play. The proposal goes nowhere.".

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
	"dapper gentleman-Gaming"	45
	
	[ Since this demo alters a character's strength from the default, we need to author that characteristic so we can manipulate it ]
	Table of Character Characteristics (continued)
	CharacterCharacteristic (text)	Points (number)
	"yourself-strength"			10
	"yourself-power"				10
	"dapper gentleman-power"	10
	

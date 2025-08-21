extends Node

@export var playerActor : Actor
@export var segretariaActor : Actor
@export var playerBar : ProgressBar
@export var segretariaBar : ProgressBar
#var dlog : Resource = load("res://Dialogues/Battle/battle.dialogue")
@export var combat_GUI : CanvasLayer

func start_battle():
	UI.hide()
	SceneLoader.player.can_move = false
	combat_GUI.show()
	var movepool := $CanvasLayer/Control/HSplitContainer/MovePool
	var i := 0
	for c in movepool.get_children():
		if c is Button:
			c.text = playerActor.mosse[i].name
			c.pressed.connect(func():
				var winner: Actor = await turno.bind(playerActor.mosse[i]).call()
				# nascondi i pulsanti
				if winner:
					print(winner.name, " ha vinto!")
				)
			i += 1
	playerActor.damaged.connect(displayDamage.bind(playerActor, playerBar))
	segretariaActor.damaged.connect(displayDamage.bind(segretariaActor, segretariaBar))


func turno(playerMossa : Mossa):
	var playerPriority = false
	var segretariaMossa : Mossa = segretariaActor.mosse.pick_random()
	playerMossa.agent = playerActor
	playerMossa.target = segretariaActor
	segretariaMossa.agent = segretariaActor
	segretariaMossa.target = playerActor
	print("eseguo ", playerMossa.name, segretariaMossa.name)

	if segretariaMossa.name == 'filecorrotto':
		playerPriority = false
	elif playerActor.temp_priority:
		playerPriority = true
		playerActor.temp_priority = false
	else:
		playerPriority = bool(randi_range(0,1))
	
	var iniziativa = [1,0] if playerPriority else [0,1]
	for i in iniziativa:
		var winner = await [segretariaMossa, playerMossa][i].do()
		if winner:
			end_combat(winner)

func end_combat(winner) : 
	combat_GUI.hide()

 
func _ready() -> void:
	combat_GUI.hide()
	#UI.hide()
	#SceneLoader.player.can_move = false
	#var movepool := $CanvasLayer/Control/HSplitContainer/MovePool
	#var i := 0
	#for c in movepool.get_children():
		#if c is Button:
			#c.text = playerActor.mosse[i].name
			#c.pressed.connect(func():
				#var winner: Actor = turno.bind(playerActor.mosse[i]).call()
				## nascondi i pulsanti
				#if winner:
					#print(winner.name, " ha vinto!")
				#)
			#i += 1
	#playerActor.damaged.connect(displayDamage.bind(playerActor, playerBar))
	#segretariaActor.damaged.connect(displayDamage.bind(segretariaActor, segretariaBar))

func displayDamage(damage, actor : Actor, bar : ProgressBar):
	actor.blink()
	var tween = create_tween()
	tween.tween_property(bar, "value", actor.hp, 0.5)
	await tween.finished
	
	# costruisci scena
		# crea i pulsanti delle mosse
		# posiziona barre della vita
	# avvia dialogo iniziale
	# avvia musichetta
	
	# mostra mosse
	# se premi un pulsante -> avvia mossa
		# nascondi interfaccia
	
	


#STUDENTE 
# mail confusa   : CONFUSIONE(segretaria) + 10 DANNI(segretaria)
  # confondi la segretaria con parole poco argute
# allega JPEG    : 15 DANNI(segretaria)
  # sai benissimo che devi mettere un pdf
# Bevi caffè     : -30 DANNI(player) & COLPISCI PER PRIMO
  # curati e affronta la giornata
# Compila modulo : MINIGIOCO [5-30] DANNI(segretaria)
  # prova a centrare ogni risposta

#SEGRETARIA
# modulo mancante : 15 DANNI(player) + 5 DANNI(player) DOPO
# indovinello : CONFUSIONE(segretaria) | 20 DANNI(player)
# file corrotto : PROTEZIONE(segretaria) + caratteri corrotti
# monologo incomprensibile : 20 DANNI(player) + CONFUSIONE(player)

extends Node

@export var player_actor : Actor
@export var segretaria_actor : Actor
@export var player_mosse : Dictionary[String,Mossa]
@export var segretaria_mosse : Dictionary[String,Mossa]

@export var move_picker : VBoxContainer

func do_round(player_mossa):
	player_mossa.agent = player_actor
	player_mossa.target = segretaria_actor
	var segretaria_mossa = segretaria_mosse.values().pick_random()
	segretaria_mossa.agent = segretaria_actor
	segretaria_mossa.target = player_actor
	var starts_player
	if segretaria_mossa == segretaria_mosse['protezione']:
		starts_player = false
	elif player_actor.temp_priority: 
		starts_player = true
	else: 
		starts_player = bool(randi_range(0,1))

	var initiative : = [0,1] if starts_player else [1,0] 

	for i in initiative:
		[player_mossa, segretaria_mossa][i].do()


func _ready() -> void:
	pick_move()
	

func pick_move() -> void:
	move_picker.show()
	move_picker.mouse_filter = Control.MOUSE_FILTER_STOP
	for c in move_picker.get_children():
		c.queue_free()
	for mossa in player_mosse:
		var mossa_button := Button.new()
		mossa_button.text = mossa
		mossa_button.pressed.connect( func():
			move_picker.hide()
			move_picker.mouse_filter = Control.MOUSE_FILTER_IGNORE
			do_round(player_mosse[mossa])
		)
		move_picker.add_child(mossa_button)
	


# turno : 
# scelta mossa
# scelta iniziativa
	# la segretaria ha fatto PROTEZIONE?
	# il giocatore ha preso del caffè?
	# altrimenti 50%
# agisce actor 1
	# è confuso? -> 50% che si colpisce e poi si leva da sola
	# ci sono dei buff sui danni?
	# applica i danni e gli effetti
	# ha sconfitto actor 2?
# agisce actor 2 
	# è confuso? -> 50% che si colpisce e poi si leva da sola
	# ci sono dei buff sui danni?
	# applica i danni e gli effetti
	# ha sconfitto actor 1?
	



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

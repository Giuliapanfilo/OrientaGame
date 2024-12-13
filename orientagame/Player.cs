using Godot;
using System;

public partial class Player : Area2D
{
	// How fast the player will move (pixels/sec).
	[Export] public int Speed = 200;
	private string lastDirection = "down";
	private Vector2 ScreenSize;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		ScreenSize = GetViewportRect().Size;
		GD.Print($"ScreenSize: {ScreenSize}");
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		var velocity = new Vector2(); // The player's movement vector

		if(Input.IsActionPressed("move_right"))
		{
			velocity.X += 1;
			lastDirection = "right";
		}
		if(Input.IsActionPressed("move_left"))
		{
			velocity.X -= 1;
			lastDirection = "left";
		}
		if(Input.IsActionPressed("move_down"))
		{
			velocity.Y += 1;
			lastDirection = "down";
		}
		if(Input.IsActionPressed("move_up"))
		{
			velocity.Y -= 1;
			lastDirection = "up";
		}

		var animatedSprite2D = GetNode<AnimatedSprite2D>("AnimatedSprite2D");

	if (velocity.Length() > 0)
		{
			velocity = velocity.Normalized() * Speed;

			// Gioca l'animazione di movimento in base alla direzione
			animatedSprite2D.Play("move_" + lastDirection);
		}
		else
		{
			// Gioca l'animazione "idle" basata sull'ultima direzione
			animatedSprite2D.Play("idel_" + lastDirection);
		}

		// Aggiorna la posizione del personaggio
		Position += velocity * (float)delta;

		// Limita il personaggio all'interno dello schermo (non funziona, a destra e in basso comunque esce)
		/*Position = new Vector2(
			
			x: Mathf.Clamp(Position.X, 0, ScreenSize.X),
			y: Mathf.Clamp(Position.Y, 0, ScreenSize.Y)	

		);*/

	}
}

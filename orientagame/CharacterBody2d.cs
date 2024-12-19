using Godot;
using System;

public partial class CharacterBody2d : CharacterBody2D
{
	public const float Speed = 300.0f;
	private string lastDirection = "down";
	private Vector2 ScreenSize;
	

	public override void _PhysicsProcess(double delta)
	{
		Vector2 velocity = Velocity;
		MoveAndCollide(velocity);
	}

	public override void _Ready()
	{
		ScreenSize = GetViewportRect().Size;
		GD.Print($"ScreenSize: {ScreenSize}");
	}

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
	}
}

using Godot;
using System;
using System.Diagnostics.Metrics;

public partial class NpcAdam : StaticBody2D
{
	private int counter = 0;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		var animatedSprite2D = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
		counter++;

		if(counter < 600)
		{
			animatedSprite2D.Play("idle_down");
		} else {
			animatedSprite2D.Play("idle_phone");
			if (counter > 660)
			{
				counter=0;
			}
		}
	}
	
}

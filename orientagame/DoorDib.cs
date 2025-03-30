using Godot;
using System;

public partial class DoorDib : Area2D
{
	public override void _Ready()
	{
		Connect("body_entered", new Callable(this, nameof(OnBodyEntered)));
	}

	private void OnBodyEntered(Node body)
	{
		if (body is CharacterBody2D)
		{
			GD.Print("Player is at the door");
			// Differisci il cambio di scena
			CallDeferred(nameof(ChangeScene));
		}
	}

	private void ChangeScene()
	{
		GetTree().ChangeSceneToFile("res://InsideDib.tscn");
	}
}

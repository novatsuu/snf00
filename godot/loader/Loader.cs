using Godot;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Snf00.Loader;

public partial class Loader : Node
{
	public string[] GetProgramsInDir(string dir)
	{
		var rslt = Directory.GetFiles(dir);
		List<string> selected = [];

		foreach (var item in rslt)
		{
			if (item.EndsWith(".gd") || item.EndsWith(".snfsh"))
			{
				_ = selected.Append(item);
			}
		}

		return [.. selected];
	}

	public void LoadProgramFile(GDScript script, string program)
	{
		StreamReader reader = new(program);
		while (!reader.EndOfStream) 
		{
			script.SourceCode += reader.ReadLine();
		}
		reader.Close();
	}
}

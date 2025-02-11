using Godot;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Snf00.Loader;

public partial class Loader : Node
{
	public string[] GetProgramsInDir(string dir)
	{
		return Directory.GetFiles(dir);
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

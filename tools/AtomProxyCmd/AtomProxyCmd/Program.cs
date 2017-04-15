namespace AtomProxyCmd
{
    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.Linq;
    using System.Net;
    using System.Text.RegularExpressions;

    class Program
    {
        static void Main(string[] args)
        {
            var options = new Options();
            if (CommandLine.Parser.Default.ParseArguments(args, options))
            {
                if (options.UserName == null)
                    throw new ArgumentNullException(nameof(options.UserName));
                if (options.Password == null)
                    throw new ArgumentNullException(nameof(options.Password));

                var list = new List<string>();
                foreach (var fileName in options.FilePaths)
                {
                    var reg = new Regex(@"^/mnt/(\w+)/(.*)", RegexOptions.IgnoreCase);
                    var matches = reg.Matches(fileName);
                    if (matches.Count == 1)
                    {
                        var groups = matches[0].Groups;
                        var text = groups[1].Value + ":\\" + groups[2].Value;
                        list.Add(text);
                    }
                    else
                    {
                        list.Add(fileName);
                    }
                }

                ProcessStartInfo startInfo = new ProcessStartInfo("atom.cmd");
                startInfo.Arguments = list.Count == 0 ? "" : list.Aggregate((x, y) => x + " " + y).Replace("/", "\\");
                startInfo.UseShellExecute = false;
                startInfo.UserName = options.UserName;
                startInfo.Password = new NetworkCredential("", options.Password).SecurePassword;
                Process.Start(startInfo);
            }
        }
    }
}

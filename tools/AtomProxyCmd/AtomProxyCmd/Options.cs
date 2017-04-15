using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CommandLine;
using CommandLine.Text;

namespace AtomProxyCmd
{
    class Options
    {
        [Option('p', "password", Required = true, HelpText = "current user password that should run the proxy.")]
        public string Password { get; set; }

        [Option('u', "username", Required = true, HelpText = "current user name that should run the proxy.")]
        public string UserName { get; set; }

        //[Option('f', "filepaths", HelpText = "current files or paths that should be opened in atom.")]
        [OptionList('f', "filepaths", Separator = ';', HelpText = "current files or paths that should be opened in atom, they should be separated with space.")]
        public IList<string> FilePaths { get; set; } 

        [ParserState]
        public IParserState LastParserState { get; set; }

        [HelpOption]
        public string GetUsage()
        {
            return HelpText.AutoBuild(this,
              (HelpText current) => HelpText.DefaultParsingErrorsHandler(this, current));
        }
    }
}

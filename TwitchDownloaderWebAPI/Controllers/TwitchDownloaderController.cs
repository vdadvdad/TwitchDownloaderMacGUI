using System.Net;
using CommandLine;
using Microsoft.AspNetCore.Mvc;
using TwitchDownloaderCLI.Tools;
namespace TwitchDownloaderWebAPI.Controllers;

[ApiController]
[Route("[controller]")]
public class TwitchDownloaderController : ControllerBase
{

    private readonly ILogger<TwitchDownloaderController> _logger;

    public TwitchDownloaderController(ILogger<TwitchDownloaderController> logger)
    {
        _logger = logger;
    }

    [HttpPost]
    public int Downloader([FromBody] string args)
    {
        Console.WriteLine(args.Split()[0]);
        Console.WriteLine(@"Executing..." + args);
        Console.WriteLine(Directory.GetCurrentDirectory());
        try
        {
            TwitchDownloaderCLI.Program.CallCore(args.Split());
            Console.WriteLine(@"Executed");
            return StatusCodes.Status201Created;
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            Console.WriteLine(@"Help something is wrong");
            return StatusCodes.Status406NotAcceptable;
        }
    }
}
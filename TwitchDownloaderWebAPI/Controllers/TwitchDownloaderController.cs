using System.Net;
using Microsoft.AspNetCore.Mvc;
using TwitchDownloaderCLI.Tools;
namespace TwitchDownloaderWebAPI.Controllers;

[ApiController]
[Route("[controller]")]
public class WeatherForecastController : ControllerBase
{

    private readonly ILogger<WeatherForecastController> _logger;

    public WeatherForecastController(ILogger<WeatherForecastController> logger)
    {
        _logger = logger;
    }

    [HttpPost]
    public int Downloader(string args)
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
        catch
        {
            return StatusCodes.Status400BadRequest;
        }
    }
}
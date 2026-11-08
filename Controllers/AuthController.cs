using System.Security.Cryptography;
using System.Text;
using DakLakAIGuide.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.RateLimiting;

namespace DakLakAIGuide.API.Controllers;

public record LoginRequest(string Username, string Password);

[Route("api/auth")]
[ApiController]
public class AuthController : ControllerBase
{
    private readonly IConfiguration _config;
    private readonly JwtTokenService _jwt;

    public AuthController(IConfiguration config, JwtTokenService jwt)
    {
        _config = config;
        _jwt = jwt;
    }

    [HttpPost("login")]
    [EnableRateLimiting("login")]
    public IActionResult Login(LoginRequest request)
    {
        var adminUser = _config["Admin:Username"];
        var adminPass = _config["Admin:Password"];

        if (string.IsNullOrEmpty(adminUser) || string.IsNullOrEmpty(adminPass))
            return StatusCode(503, new { message = "Chưa cấu hình tài khoản quản trị (Admin__Username, Admin__Password)" });

        if (!FixedEquals(request.Username ?? "", adminUser) || !FixedEquals(request.Password ?? "", adminPass))
            return Unauthorized(new { message = "Sai tên đăng nhập hoặc mật khẩu" });

        var (token, expiresAt) = _jwt.CreateToken(adminUser);
        return Ok(new { token, expiresAt, username = adminUser, role = "Admin" });
    }

    [HttpGet("me")]
    [Authorize]
    public IActionResult Me()
    {
        return Ok(new { username = User.Identity?.Name, role = "Admin" });
    }

    // So sánh thời gian cố định để tránh tấn công dò theo thời gian phản hồi
    private static bool FixedEquals(string a, string b)
    {
        var ha = SHA256.HashData(Encoding.UTF8.GetBytes(a));
        var hb = SHA256.HashData(Encoding.UTF8.GetBytes(b));
        return CryptographicOperations.FixedTimeEquals(ha, hb);
    }
}

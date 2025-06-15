using Aplicacion_Web_Hospedaje.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Aplicacion_Web_Hospedaje.Controllers
{
    public class AccountController : Controller
    {
        private readonly AppDbContext _context;

        public AccountController(AppDbContext context)
        {
            _context = context;
        }

        // GET: Account/Login
        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        // POST: Account/Login
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(LoginViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            // Buscar usuario por correo
            var user = await _context.PersonalDelHospedajes
                .FirstOrDefaultAsync(u => u.CorreoElectronico == model.CorreoElectronico);

            if (user == null || user.Contrasena != model.Contrasena)
            {
                ModelState.AddModelError("", "Correo o contraseña incorrectos.");
                return View(model);
            }

            // Aquí puedes manejar la sesión o claims para el usuario
            return RedirectToAction("Index", "Home");
        }

        // GET: Account/About
        [HttpGet]
        public IActionResult About()
        {
            return View();
        }
    }
}

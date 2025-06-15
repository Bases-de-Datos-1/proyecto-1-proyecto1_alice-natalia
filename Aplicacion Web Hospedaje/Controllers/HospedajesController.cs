using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Aplicacion_Web_Hospedaje.Models;

namespace Aplicacion_Web_Hospedaje.Controllers
{
    public class HospedajesController : Controller
    {
        private readonly AppDbContext _context;

        public HospedajesController(AppDbContext context)
        {
            _context = context;
        }

        // GET: Hospedajes
        public async Task<IActionResult> Index()
        {
            var appDbContext = _context.Hospedajes.Include(h => h.TipoHospedajeNavigation);
            return View(await appDbContext.ToListAsync());
        }

        // GET: Hospedajes/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var hospedaje = await _context.Hospedajes
                .Include(h => h.TipoHospedajeNavigation)
                .FirstOrDefaultAsync(m => m.IdHospedaje == id);
            if (hospedaje == null)
            {
                return NotFound();
            }

            return View(hospedaje);
        }

        // GET: Hospedajes/Create
        public IActionResult Create()
        {
            ViewData["TipoHospedaje"] = new SelectList(_context.TipoHospedajes, "IdTipoHospedaje", "IdTipoHospedaje");
            return View();
        }

        // POST: Hospedajes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("IdHospedaje,CedulaJuridica,NombreHospedaje,TipoHospedaje,UrlSitioWeb,CorreoElectronico,ReferenciasGps")] Hospedaje hospedaje)
        {
            if (ModelState.IsValid)
            {
                _context.Add(hospedaje);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["TipoHospedaje"] = new SelectList(_context.TipoHospedajes, "IdTipoHospedaje", "IdTipoHospedaje", hospedaje.TipoHospedaje);
            return View(hospedaje);
        }

        // GET: Hospedajes/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var hospedaje = await _context.Hospedajes.FindAsync(id);
            if (hospedaje == null)
            {
                return NotFound();
            }
            ViewData["TipoHospedaje"] = new SelectList(_context.TipoHospedajes, "IdTipoHospedaje", "IdTipoHospedaje", hospedaje.TipoHospedaje);
            return View(hospedaje);
        }

        // POST: Hospedajes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("IdHospedaje,CedulaJuridica,NombreHospedaje,TipoHospedaje,UrlSitioWeb,CorreoElectronico,ReferenciasGps")] Hospedaje hospedaje)
        {
            if (id != hospedaje.IdHospedaje)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(hospedaje);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!HospedajeExists(hospedaje.IdHospedaje))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["TipoHospedaje"] = new SelectList(_context.TipoHospedajes, "IdTipoHospedaje", "IdTipoHospedaje", hospedaje.TipoHospedaje);
            return View(hospedaje);
        }

        // GET: Hospedajes/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var hospedaje = await _context.Hospedajes
                .Include(h => h.TipoHospedajeNavigation)
                .FirstOrDefaultAsync(m => m.IdHospedaje == id);
            if (hospedaje == null)
            {
                return NotFound();
            }

            return View(hospedaje);
        }

        // POST: Hospedajes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var hospedaje = await _context.Hospedajes.FindAsync(id);
            if (hospedaje != null)
            {
                _context.Hospedajes.Remove(hospedaje);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool HospedajeExists(int id)
        {
            return _context.Hospedajes.Any(e => e.IdHospedaje == id);
        }
    }
}

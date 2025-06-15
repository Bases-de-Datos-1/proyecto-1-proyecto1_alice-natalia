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
    public class HabitacionsController : Controller
    {
        private readonly AppDbContext _context;

        public HabitacionsController(AppDbContext context)
        {
            _context = context;
        }

        // GET: Habitacions
        public async Task<IActionResult> Index()
        {
            var appDbContext = _context.Habitacions.Include(h => h.IdHospedajeNavigation).Include(h => h.IdTipoHabitacionNavigation);
            return View(await appDbContext.ToListAsync());
        }

        // GET: Habitacions/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var habitacion = await _context.Habitacions
                .Include(h => h.IdHospedajeNavigation)
                .Include(h => h.IdTipoHabitacionNavigation)
                .FirstOrDefaultAsync(m => m.IdHabitacion == id);
            if (habitacion == null)
            {
                return NotFound();
            }

            return View(habitacion);
        }

        // GET: Habitacions/Create
        public IActionResult Create()
        {
            ViewData["IdHospedaje"] = new SelectList(_context.Hospedajes, "IdHospedaje", "IdHospedaje");
            ViewData["IdTipoHabitacion"] = new SelectList(_context.TipoHabitacions, "IdTipoHabitacion", "IdTipoHabitacion");
            return View();
        }

        // POST: Habitacions/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("IdHabitacion,NumeroHabitacion,IdTipoHabitacion,IdHospedaje,CantidadPersonas")] Habitacion habitacion)
        {
            if (ModelState.IsValid)
            {
                _context.Add(habitacion);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["IdHospedaje"] = new SelectList(_context.Hospedajes, "IdHospedaje", "IdHospedaje", habitacion.IdHospedaje);
            ViewData["IdTipoHabitacion"] = new SelectList(_context.TipoHabitacions, "IdTipoHabitacion", "IdTipoHabitacion", habitacion.IdTipoHabitacion);
            return View(habitacion);
        }

        // GET: Habitacions/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var habitacion = await _context.Habitacions.FindAsync(id);
            if (habitacion == null)
            {
                return NotFound();
            }
            ViewData["IdHospedaje"] = new SelectList(_context.Hospedajes, "IdHospedaje", "IdHospedaje", habitacion.IdHospedaje);
            ViewData["IdTipoHabitacion"] = new SelectList(_context.TipoHabitacions, "IdTipoHabitacion", "IdTipoHabitacion", habitacion.IdTipoHabitacion);
            return View(habitacion);
        }

        // POST: Habitacions/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("IdHabitacion,NumeroHabitacion,IdTipoHabitacion,IdHospedaje,CantidadPersonas")] Habitacion habitacion)
        {
            if (id != habitacion.IdHabitacion)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(habitacion);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!HabitacionExists(habitacion.IdHabitacion))
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
            ViewData["IdHospedaje"] = new SelectList(_context.Hospedajes, "IdHospedaje", "IdHospedaje", habitacion.IdHospedaje);
            ViewData["IdTipoHabitacion"] = new SelectList(_context.TipoHabitacions, "IdTipoHabitacion", "IdTipoHabitacion", habitacion.IdTipoHabitacion);
            return View(habitacion);
        }

        // GET: Habitacions/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var habitacion = await _context.Habitacions
                .Include(h => h.IdHospedajeNavigation)
                .Include(h => h.IdTipoHabitacionNavigation)
                .FirstOrDefaultAsync(m => m.IdHabitacion == id);
            if (habitacion == null)
            {
                return NotFound();
            }

            return View(habitacion);
        }

        // POST: Habitacions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var habitacion = await _context.Habitacions.FindAsync(id);
            if (habitacion != null)
            {
                _context.Habitacions.Remove(habitacion);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool HabitacionExists(int id)
        {
            return _context.Habitacions.Any(e => e.IdHabitacion == id);
        }
    }
}
